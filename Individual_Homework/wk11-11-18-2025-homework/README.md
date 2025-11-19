
used code from https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/101825
and https://github.com/malgus-waf/class5

terraform apply will build a VPC with 3 private and public subnets, a load balancer, and an auto scaling group.  
The instances (at least 3) will be in the private subnets.  The output will be the URL to the load balancer.
