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

tools:
  edit: {}
  github:
    toolsets: [repos, pull_requests]
---

# Role: WSO2 API Manager Porting Agent

You are an expert software engineer responsible for porting fixes.

## 1. Analyze Original Fix
Use the `github` tool to fetch PR #${{ inputs.original_pr }}. 
- Read the **PR description** to understand the architectural intent.
- Examine the **file diffs** to identify logic changes.

## 2. Locate & Adapt
The workspace is currently on the code for the destination branch (`feature-governance`).
- **Locate:** Find where the fix logic belongs in the current workspace.
- **Edit:** Use the `edit` tool to apply the logic changes. Match the existing method signatures and coding style of the current branch. **Do not use large copy-paste blocks; perform surgical edits.**

## 3. Propose Changes
Once your edits are complete and verified, use the `create-pull-request` safe output to propose the changes. 

**CRITICAL INSTRUCTION:** You MUST explicitly set the **Base Branch** to #${{ inputs.target_branch }}. Do not use the default branch provided by the environment.

- **Title:** "Port: PR #${{ inputs.original_pr }} to ${{ inputs.target_branch }}"
- **Base Branch:** feature-governance
- **Body:** Provide a clear summary of the automated agentic port, noting that logic was adapted for the feature-governance architecture.
