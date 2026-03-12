# WSO2 API Manager Architectural Reference (Updated March 2026)

## 1. Extended Version Matrix (Modern Era)

| APIM Version | Release Date | Carbon Kernel | Java Version | Config Model | Key Focus |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **4.6.0** | Nov 2025 | 4.9.33 (Dijkstra)| **21** | TOML | AI Agents & MCP Proxy |
| **4.5.0** | Mar 2025 | 4.9.28 (Dijkstra)| 17 | TOML | Unified Control Plane |
| **4.4.0** | Nov 2024 | 4.9.27 (Dijkstra)| 17 | TOML | AI Egress Gateway |
| **4.3.0** | Apr 2024 | 4.9.26 (Dijkstra)| 17 | TOML | APK Integration |

---

## 2. Critical Architectural Shifts (4.4.0 - 4.6.0)

### The AI & Agentic Pivot (APIM 4.6.0)
* **MCP Support**: APIM 4.6.0 introduces native **Model Context Protocol (MCP)** support. It can auto-generate MCP servers from REST APIs.
* **Porting Tip**: If porting a custom connector or handler to 4.6.0, check if it can be exposed as an "AI Tool." Use the new `mcp-proxy` feature to bridge existing APIs to AI agents.

### Analytics Acquisition (Moesif Integration)
* **Legacy**: Choreo-based analytics is officially **deprecated** in 4.5.0.
* **Modern**: WSO2 acquired **Moesif**, which is now the default analytics engine for 4.5.0 and 4.6.0.
* **Porting Tip**: Do NOT port old analytics publisher configurations to 4.5+. You must configure the Moesif-based publisher in `deployment.toml`.

### Unified Control Plane (ACP)
* **APIM 4.5.0+**: Introduced the **API Control Plane (ACP)** which manages multiple gateway types (Synapse, APK, and Third-party) from one place.
* **Porting Tip**: Gateway-specific policies (like custom sequences) might need to be verified against "Universal Gateway" standards to ensure they work across federated environments (AWS/Azure/Kong).

---

## 3. Java & Environment Baseline

| Component | 4.4.0 / 4.5.0 | 4.6.0 (Latest) |
| :--- | :--- | :--- |
| **Primary JDK** | JDK 17 (LTS) | **JDK 21 (LTS)** |
| **Identity Server** | IS 7.0.0 / 7.1.0 | IS 7.2.0 |
| **Maven** | 3.6.3+ | 3.9.x+ |

---

## 4. Senior Porting Red-Flags (New Versions)

1. **Bot Detection**: Removed in 4.4.0. If you are porting a fix that relies on the internal `org.wso2.carbon.apimgt.gateway.handlers.security.botDetection` handler, you must replace it with an external WAF or third-party tool logic.
2. **Universal Gateway Transition**: The "Synapse Gateway" is now often referred to as the **Universal Gateway**. Ensure the `edit` tool looks for the updated naming conventions in logs and configuration comments.
3. **Database Dependency**: Universal Gateway (4.6.0) has removed the DB dependency for certain multi-tenant scenarios. Verify if your fix assumes a persistent DB connection at the gateway level.
4. **Subscription Requirement**: 4.4.0 introduced the ability to disable subscriptions. If porting security fixes to 4.4+, verify if the logic still holds when `disableSubscription` is set to true in the API metadata.
