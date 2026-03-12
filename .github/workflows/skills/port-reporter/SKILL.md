---
name: port-reporter
description: Generates high-quality PR descriptions for WSO2 backports.
---
# Instructions
When proposing a PR for a port:
1. **Title Pattern**: "[Port][TARGET_BRANCH] Fix for PR #ORIGINAL_PR"
2. **Body Structure**:
   - **Original Context**: Link to the original PR.
   - **Architectural Changes**: Explain *why* you changed certain lines (e.g., "Adapted for Carbon 4.x OSGi changes").
   - **Verification**: List the Maven commands you ran to verify the build.
