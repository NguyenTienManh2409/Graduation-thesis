# 🎓 Graduation Thesis Project

**Title**: TienManhMobile

**Demo**: [http://174.129.57.156/](http://174.129.57.156/) *(Hiện không còn hoạt động do giới hạn chi phí khi triển khai trên AWS)*

- 🛠️ Admin account: `ADMIN / admin`  
- 🙋‍♂️ User login: Google Authentication or create account with Gmail.

---

## 🔧 Technologies Used

### Backend:
- Java Spring Boot
- MySQL

### Frontend:
- HTML, CSS, JavaScript

### DevOps & Tools:
- Docker
- AWS (EC2, ECS, ECR, RDS, VPC)
- Terraform

### Others:
- Linux (Ubuntu)
- Postman (for API testing)
- JMeter (for load/performance testing)

---

## 📄 Documentation
- [📘 Full Report (PDF)](https://github.com/user-attachments/files/19986648/KLTN_21020777.pdf)


---

## 📊 Key Features
- Google OAuth 2.0 login for users
- Admin dashboard for managing products and orders
- RESTful API architecture
- Mobile-responsive frontend interface
- Dockerized microservices architecture
- Infrastructure as Code with Terraform
- Performance testing using JMeter

---

## ☁️ AWS Infrastructure (Provisioned with Terraform)

The project infrastructure was fully deployed on AWS using **Terraform**, with the following components:

- **VPC (Virtual Private Cloud)**
  - 2 Public Subnets
  - 2 Private Subnets

- **RDS (Relational Database Service)**
  - Stores the MySQL database for the application
  - Hosted in private subnets for enhanced security

- **ECR (Elastic Container Registry)**
  - Used to store Docker images of the application

- **ECS (Elastic Container Service)**
  - Runs a task to deploy the backend application

- **EC2 Instance**
  - Used for SSH access and connecting to the RDS instance

- **Terraform Remote Backend**
  - **S3**: Stores Terraform state files
  - **DynamoDB**: Manages lock states to prevent concurrent deployments

---

## 🚀 Deployment
1. Build Docker images and push to ECR
2. Use Terraform to provision infrastructure
3. ECS pulls the image and deploys the app
4. EC2 instance used for maintenance and connection to private RDS

---

## 🙏 Acknowledgements
Thanks to my instructors, teammates, and reviewers for their support during the development of this project.
