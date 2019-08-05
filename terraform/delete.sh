#!bin/bash -eu

echo "LBを削除します。"
cd ./lb
terraform init
terraform destroy

echo "EC2を削除します。"
cd ./ec2
terraform init
terraform destroy

echo "セキュリティグループを削除します。"
cd ./security_group
terraform init
terraform destroy

echo "RDSを削除します。"
cd ./rds
terraform init
terraform destroy