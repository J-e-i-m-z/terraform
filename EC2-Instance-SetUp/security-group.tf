# Define a security group named "dove-sg" in AWS
resource "aws_security_group" "dove-sg" {
  name        = "dove-sg"               # Name of the security group
  description = "dove-sg"               # Description (should ideally describe its purpose)
  #vpc_id      = aws_vpc.main.id        # Uncomment & set if deploying in a custom VPC (defaults to default VPC if omitted)

  tags = {
    Name = "dove-sg"                    # Tag for easier identification in AWS console
  }
}

# Inbound rule: Allow SSH access (port 22) ONLY from a specific IP (MY IP)
resource "aws_vpc_security_group_ingress_rule" "ssh-allow-from-my-ip" {
  security_group_id = aws_security_group.dove-sg.id  # Reference to the security group above
  cidr_ipv4         = "MY-IP/32"                     # Restrict SSH to this IPv4 address (MY IP)
  from_port         = 22                             # Start port range (SSH)
  ip_protocol       = "tcp"                          # TCP protocol for SSH
  to_port           = 22                             # End port range (same as from_port for single port)
}

# Inbound rule: Allow HTTP access (port 80) from ANY IPv4 address
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.dove-sg.id  
  cidr_ipv4         = "0.0.0.0/0"                   # Allow all IPv4 addresses (public web traffic)
  from_port         = 80                            # HTTP port
  ip_protocol       = "tcp"                         # TCP protocol for HTTP
  to_port           = 80                            
}

# Outbound rule: Allow ALL outbound IPv4 traffic (any port, any protocol)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.dove-sg.id  
  cidr_ipv4         = "0.0.0.0/0"                   # Allow all outbound IPv4 traffic
  ip_protocol       = "-1"                          # "-1" means ALL protocols (TCP, UDP, ICMP, etc.)
}

# Outbound rule: Allow ALL outbound IPv6 traffic (any port, any protocol)
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.dove-sg.id  
  cidr_ipv6         = "::/0"                        # Allow all outbound IPv6 traffic
  ip_protocol       = "-1"                          # ALL protocols
}
