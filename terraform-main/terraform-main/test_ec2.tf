# Define the security group for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and outbound traffic to RDS"
  vpc_id      = module.vpc.main_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from any IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

# Define the EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "ami-04b6019d38ea93034"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  # key_name      = "your-key-pair-name"  # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
    subnet_id     = module.vpc.public_subnet_ids[0]  # Use the first public subnet

  tags = {
    Name = "test-ss-ec2"
  }
}