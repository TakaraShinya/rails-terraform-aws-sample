# はじめに

TerraformでAWS上に基本的なWebアプリケーション構成のインフラを構築するテンプレートです。  

## 環境

Terraform Version: 0.12.0
AWS CLI Version: 1.15.50

### インストール手順

- terraform install(mac)  
`brew install terraform`

- awscli install  
`brew install awscli`

## インフラ構成

(terraform実行順に紹介)

1. セキュリティグループ(terraform/security_group)
2. RDS(terraform/rds)
3. EC2(terraform/ec2)
4. LB(terraform/lb)

## 事前準備

terraform実行後の状態管理ファイル`***.tfstate`を管理するためにS3にバケットを作成して下さい。  
S3のバージョニング管理は有効にして下さい。[参考記事](https://www.terraform.io/docs/backends/types/s3.html)

AWS CLIを実行するために必要なcredential情報を`~/.aws/credentials`に任意のprofileで登録して下さい。
