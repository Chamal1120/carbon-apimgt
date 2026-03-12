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
        type: string

permissions:
  contents: read
  pull-requests: read

safe-outputs:
  create-pull-request:
    # We define the default base-branch here to help the compiler
    base-branch: "feature-governance"

tools:
  edit: {}
  github:
    toolsets: [repos, pull_requests]
---

# Role: WSO2 API Manager Porting Agent

You are an expert engineer. Your task is to port changes from a maintenance branch to a feature branch.

## 1. Analyze Original Fix
Use the `github` tool to fetch PR #${{ inputs.original_pr }}. 
- Study the PR description and the file diffs.

## 2. Locate & Adapt
You are currently running in a workspace based on the code for `${{ inputs.target_branch }}`.
- Locate the corresponding logic in the current workspace.
- Use the `edit` tool to surgically apply the fix. 
- **Important:** Adapt the code to the current branch's architecture.

## 3. Propose Changes
Propose the changes using the `create-pull-request` safe output.

**Technical Constraint:** You must set the `base-branch` argument to `${{ inputs.target_branch }}`.

- **Title:** "Port: PR #${{ inputs.original_pr }} to ${{ inputs.target_branch }}"
- **base-branch:** ${{ inputs.target_branch }}
- **Body:** Summarize the architectural adaptations made.
