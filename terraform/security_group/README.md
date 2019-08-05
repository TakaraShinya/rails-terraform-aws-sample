# Terraform AWS Security Group

## Description(説明)

AWS EC2,RDS,LBに設定するセキュリティグループを作成します。

## 修正箇所

`variable.tf`ファイルに`vpc_id`とアプリケーション名を記載して下さい。  
事前準備で用意したバケット名とprofileを`main.tf`に変換記載して下さい。  
(profileをdefaultに指定している場合はprofileの行ごと消してください。)

## Terraform Command(実行コマンド)

- `terraform init`
- `terraform plan`
- `terraform apply`
- `terraform destroy`
