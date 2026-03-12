---
name: wso2-porting-expert
description: Porting fixes across WSO2 APIM versions (3.x, 4.x) with architectural awareness.
---

# Senior WSO2 Engineering Guidelines

## 1. Architectural Adaptation
- **Config Migration**: If porting from 4.x (toml-based) to 3.x (xml-based), do NOT simply copy files. Update the corresponding `repository/conf/deployment.toml` or `api-manager.xml`.
- **Carbon Kernel**: Verify the `carbon.kernel.version` in the root `pom.xml`. Ensure the fix is compatible with the OSGi version of the target branch.

## 2. Porting Procedure
1.  **Context Check**: Read `./references/version-mapping.md` to understand the differences between the source and target branches.
2.  **Cherry-pick**: Attempt to cherry-pick the merge commit. 
3.  **Conflict Resolution**: 
    - Priority: Preserve the target branch's security configurations.
    - If a class has been refactored (e.g., moved from `org.wso2.carbon.apimgt.impl` to `org.wso2.carbon.apimgt.gateway`), manually re-locate the fix.

## 3. Verification
- Always run `mvn clean compile -Dmaven.test.skip=true` on the affected module before claiming success.
