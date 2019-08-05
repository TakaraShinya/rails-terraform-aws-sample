#!bin/bash -eu

echo "セキュリティグループを作成します。"
cd ./security_group
terraform init
terraform plan
terraform apply

echo "EC2を作成します。"
cd ./ec2
terraform init
terraform plan
terraform apply

echo "LBを作成します。"
cd ./lb
terraform init
terraform plan
terraform apply

echo "RDSを作成します。"
cd ./rds
terraform init
terraform plan
terraform apply