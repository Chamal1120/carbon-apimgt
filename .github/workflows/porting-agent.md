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

You are currently running natively on an older maintenance branch of the WSO2 Carbon API Management repository.

## 1. Analyze Original Fix
Use the `github` tool to read the original merged pull request (PR #${{ inputs.original_pr }}). Understand the core logic, the problem being solved, and exactly which files were changed for the fix.

## 2. Locate & Adapt
Search your current workspace for the corresponding files. Use the `edit` tool to carefully adapt and apply the fix. Remember that this older version might have slightly different package structures or method signatures. Adjust the code to fit this branch's architecture perfectly.

## 3. Propose Changes
Once your edits are complete and verified, use the `create-pull-request` safe output to propose the changes. 
**Title:** "Port: PR #${{ inputs.original_pr }} to ${{ inputs.target_branch }}"
* **Body:** Provide a clear summary of the automated agentic backport, noting any specific adaptations made for this version's architecture.
