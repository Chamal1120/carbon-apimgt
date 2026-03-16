---
on:
  workflow_dispatch:
    inputs:
      original_pr:
        description: 'The original PR number to port'
        required: true
        type: string
      target_branch:
        description: 'The branch being ported to'
        required: true

engine: copilot
steps:
  - uses: actions/checkout@v6
    with:
      ref: ${{ inputs.target_branch }}
      persist-credentials: false

  - name: Copy Maven cache to tmp
    run: |
      if [ -d "/home/runner/.m2/repository" ]; then
        mkdir -p /tmp/gh-aw/agent/m2repo
        cp -r /home/runner/.m2/repository /tmp/gh-aw/agent/m2repo/
        echo "Maven cache copied successfully"
      else
        echo "No cache found"
      fi
cache:
  key: maven-${{ runner.os }}-${{ hashFiles('**/pom.xml') }}
  path: /home/runner/.m2/repository
  restore-keys: |
    maven-${{ runner.os }}-
network:
  allowed:
    - defaults
    - github
    - containers
    - java

permissions:
  contents: read
  pull-requests: read

safe-outputs:
  create-pull-request:
    base-branch: "feature-governance"

tools:
  edit: {}
  github:
    toolsets: [repos, pull_requests]
---

# Role: WSO2 API Manager Porting Agent

You are a senior engineer at wso2 API Manager Team. Your task is to port changes from the given PR to `base-branch`.

## 1. Analyze Original Fix
Use the `github` tool to fetch PR #${{ inputs.original_pr }}. 
- Study the PR description and the file diffs.

## 2. Locate & Adapt
You are currently running in a workspace based on the code for `${{ inputs.target_branch }}`.
- Locate the corresponding logic in the current workspace.
- Use the `edit` tool to surgically apply the fix. 
- **Important:** Adapt the code to the current branch's architecture.

## 3. Use the restored Maven cache
The cache has been restored to `/tmp/gh-aw/agent/m2repo/repository`.

## 4. Compile and Verify (Self-Healing Loop)
You must ensure the code compiles before proposing changes. You have a **maximum of 3 attempts** to fix compilation errors.

1. **Run Build:** Execute `mvn clean install -Dmaven.test.skip=true --no-transfer-progress -Dmaven.repo.local=/tmp/gh-aw/agent/m2repo/repository` using `bash` tool.
2. **Evaluate:**
   - **If Success:** Proceed to Step 4.
   - **If Failure:** - Capture the error logs.
     - Analyze the error (e.g., missing imports, incompatible method signatures in the target branch).
     - Use the `edit` tool to apply a fix.
     - **Increment attempt counter.**
3. **Loop/Halt:**
   - Repeat the build-fix cycle up to 3 times.
   - **Critical:** If the **4th attempt** still results in a compilation error, **STOP immediately**. Do not call `create-pull-request`. Provide a brief summary of the failure in the logs and exit.

## 5. Propose Changes
If and only if the build succeeded, propose the changes using the `create-pull-request` safe output. The propsed PR **MUST** merge into the `base-brnch` without any merge conflicts.

**Technical Constraint:** You must set the `base-branch` argument to `${{ inputs.target_branch }}`.

- **Title:** "Port: PR #${{ inputs.original_pr }} to ${{ inputs.target_branch }}"
- **base-branch:** ${{ inputs.target_branch }}
- **Body:** Summarize the architectural adaptations made.
