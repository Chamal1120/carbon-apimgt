---
name: maven-dependency-fixer
description: Fixes Maven POM conflicts and dependency mismatches during branch porting.
---

# Instructions
1.  Identify `pom.xml` conflict markers (`<<<<<<<`).
2.  **Senior Rule**: If the conflict is in a version tag, keep the version defined in the *target branch* unless the fix explicitly requires a library upgrade.
3.  Execute `./scripts/validate_pom.sh` to ensure the XML is well-formed after your changes.
