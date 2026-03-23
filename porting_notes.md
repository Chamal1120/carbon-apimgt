# Porting Notes: PR #67 - Fix Ordering Issue in Resources

## Summary
This PR fixes an issue where the resource ordering changes when multiple resources define an OPTIONS method. The fix ensures that resources with only OPTIONS method are processed first, maintaining consistent ordering.

## Files Modified

### 1. APIKeyValidator.java
- **Location**: `components/apimgt/org.wso2.carbon.apimgt.gateway/src/main/java/org/wso2/carbon/apimgt/gateway/handlers/security/APIKeyValidator.java`
- **Changes**:
  - Added import for `LinkedList`
  - Modified the `findMatchingVerb` method to separate OPTIONS-only resources from other acceptable resources
  - Resources with only OPTIONS method are now collected in a separate list and added first to maintain ordering

### 2. CORSRequestHandler.java
- **Location**: `components/apimgt/org.wso2.carbon.apimgt.gateway/src/main/java/org/wso2/carbon/apimgt/gateway/handlers/security/CORSRequestHandler.java`
- **Changes**:
  - Added import for `LinkedList`
  - Modified the resource selection logic in `handleRequest` method
  - Separated OPTIONS-only resources from other acceptable resources to maintain proper ordering

### 3. Utils.java
- **Location**: `components/apimgt/org.wso2.carbon.apimgt.gateway/src/main/java/org/wso2/carbon/apimgt/gateway/handlers/Utils.java`
- **Changes**:
  - Modified the `getAcceptableResources` method to fix the ordering issue
  - Resources with only OPTIONS method are now collected separately and added first

## Technical Details

The fix addresses an issue where when multiple resources define an OPTIONS method, the resource ordering was not deterministic. The solution:

1. Separates resources into two lists:
   - `optionsResourcesList`: Resources that have ONLY the OPTIONS method
   - `acceptableResourcesList`: All other acceptable resources

2. Adds OPTIONS-only resources first to the final set, ensuring they take precedence

3. This maintains consistent ordering and prevents resource matching issues when multiple OPTIONS resources exist

## Build Status
- The gateway module compiles successfully
- The full build had an unrelated failure in `org.wso2.carbon.apimgt.jms.listener.feature` module

## Manual Steps Required
None. All changes have been ported automatically.
