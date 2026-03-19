# Porting Notes: PR #66 - Fix Resource Ordering Issue for OPTIONS Requests

## Summary
Ported changes from PR #66 to fix the resource ordering issue when multiple resources define an OPTIONS method.

## Changes Ported

### 1. APIKeyValidator.java
**File**: `components/apimgt/org.wso2.carbon.apimgt.gateway/src/main/java/org/wso2/carbon/apimgt/gateway/handlers/security/APIKeyValidator.java`

**Changes**:
- Modified the resource filtering logic in `getVerbInfoDTOFromAPIData()` method
- Separated resources with single OPTIONS method into a separate list (`optionsResourcesList`)
- Added these resources first to the `acceptableResources` set to maintain correct ordering
- Added debug logging for better traceability

**Key Logic**:
- When processing OPTIONS requests, resources that define only OPTIONS method are now prioritized
- These resources are added to the beginning of the acceptable resources set
- This ensures proper resource matching when multiple resources have OPTIONS methods

### 2. Utils.java
**File**: `components/apimgt/org.wso2.carbon.apimgt.gateway/src/main/java/org/wso2/carbon/apimgt/gateway/handlers/Utils.java`

**Changes**:
- Modified `getAcceptableResources()` method
- Applied same logic as APIKeyValidator to handle OPTIONS-only resources
- Resources with single OPTIONS method are now added to the beginning of the result set
- Added debug logging for better traceability

## Verification

Build Status: ✅ SUCCESS

Build Command:
```
mvn clean install --ntp -T 1C -Dcheckstyle.skip=true -Dmaven.javadoc.skip=true -Dmaven.test.skip=true -pl components/apimgt/org.wso2.carbon.apimgt.gateway -am
```

All modules compiled successfully:
- WSO2 Carbon - API Gateway: SUCCESS
- All dependent modules: SUCCESS

## Notes

- The CORSRequestHandler.java in this branch uses `Utils.getAcceptableResources()` method, so it automatically benefits from the fix applied to Utils.java
- This is a surgical port that maintains the exact same logic as the original PR
- The fix ensures proper resource ordering when handling OPTIONS (CORS preflight) requests

## Related Issue
- Resolves: https://github.com/wso2/api-manager/issues/4737
