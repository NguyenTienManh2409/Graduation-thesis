The infras AWS include:
1 vpc: 2 public subnet, 2 private subnet
1 rds: store database of app
1 ecr: store repo image
1 ecs: 1 task to deploy
1 ec2: to connect with rds
remote backend in S3, lock state with dynamoDB.