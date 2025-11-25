# get vpc id
aws ec2 describe-vpcs

"VpcId": "vpc-68855803"

# get subnet id from az A (us-east-2a)
aws ec2 describe-subnets --filters "Name=availability-zone,Values=us-east-2a"

"SubnetId": "subnet-00cdb0d3ebdc5e2db"

# create or use existing security group
aws ec2 describe-security-groups

 "GroupId": "sg-05e1f10b3643534c1"

# Get key pair name
aws ec2 describe-key-pairs

kireeti


# Create an ec2 instance
aws ec2 run-instances \
    --instance-type "t3.micro" \
    --key-name "kireeti" \
    --security-group-ids "sg-05e1f10b3643534c1" \
    --subnet-id "subnet-00cdb0d3ebdc5e2db" \
    --image-id "ami-0325e1499e14d1d8f"










aws ec2 describe-security-groups --filters "Name=group-name,Values=openssh"

aws ec2 describe-security-groups --filters "Name=group-name,Values=openhttp"
