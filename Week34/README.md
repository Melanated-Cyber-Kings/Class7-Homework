🛡️ WAF Lab: Protecting API Gateway (ClickOps & Terraform)
🎯 Objective
The goal of this lab was to implement an AWS Web Application Firewall (WAF) to secure a REST API. By filtering traffic at the edge, we protect our backend Lambdas from common vulnerabilities and unauthorized access.

🛠️ Part 1: Practice (ClickOps)
I manually deployed a Web ACL named chewbacca_waf in the Ohio region and associated it with the API Gateway.

Managed Rule Groups Added:
Core Rule Set (AWSManagedRulesCommonRuleSet): Protection against OWASP Top 10 vulnerabilities.

Known Bad Inputs (AWSManagedRulesKnownBadInputsRuleSet): Blocks patterns associated with exploit discovery.

Anonymous IP List (AWSManagedRulesAnonymousIpList): Blocks VPNs, proxies, and Tor nodes.

Custom Rate Limit: A custom rule chewbacca-api-waf set to block traffic exceeding established thresholds.

📸 ClickOps Evidence
Rules Configuration:

Traffic Overview (Allowed):

Traffic Overview (Blocked):

API Success (CLI):

💻 Part 2: Practice (Terraform)
I codified the security stack by adding a waf.tf file to the existing API Gateway infrastructure.

Infrastructure as Code Highlights:
Managed aws_wafv2_web_acl and aws_wafv2_web_acl_association via Terraform.

Codified the GeoBlock (blocking specific countries) and RateLimit rules alongside the Managed Rule Sets.

📸 Terraform Evidence
State List Verification:

Codified Rules in Console:

Allowed Traffic Metrics:

🧪 Security Testing (Task 6)
To verify the WAF was actually protecting the endpoints, I attempted an XSS injection (<script>alert(1)</script>) on both endpoints.

📸 Block Evidence
Node Blocked:

Python Blocked:

🧠 Conclusion
The lab successfully demonstrates that "Security is a process, not a product." By utilizing both ClickOps for initial discovery and Terraform for scale, I ensured that the chewbacca-rest-api is defended against common web attacks.

🏁 Final Cleanup
Disassociated WAF from the API Stage.

Deleted manual Web ACL resources.

Executed terraform destroy to clean up the environment.