# 🛡️ Bastion Host Project – AWS Infrastructure Scaffolding

![Infrastructure](https://img.shields.io/badge/AWS-VPC-orange)
![Region](https://img.shields.io/badge/Region-ap--south--1-blue)
![Terraform](https://img.shields.io/badge/Provisioned%20With-Terraform-5C4EE5.svg?&logo=terraform)

## 🚀 Overview

This project scaffolds a secure and scalable **AWS VPC** infrastructure with:

- 🏗️ Custom **VPC** in `ap-south-1`
- 🌐 One **Public** & 🔒 One **Private Subnet**
- 💻 Two EC2 Instances: one **Public (Bastion Host)** and one **Private**
- 🌍 Elastic IP attached to the **Bastion Host**
- 🛡️ Secure connectivity using **SSH via Bastion**

---
![Bastion](https://excalidraw.com/?element=w0Hes-9eTHQDEmwcQMGqb)

## 📐 Architecture Diagram

```text
                      +-----------------------+
                      |    Internet Gateway   |
                      +----------+------------+
                                 |
                      +----------v-----------+
                      |     Public Subnet     |
                      |     (CIDR: x.x.x.x)   |
                      |                       |
                 +----+----+             +----+-----+
                 | Bastion |             |  EIP     |
                 |  Host   |<-- SSH ---> | Elastic  |
                 +---------+             +----------+
                      |
           +----------+-----------+
           |                      |
+----------v---------+  +---------v----------+
|   NAT Gateway      |  |      Route Table   |
+--------------------+  +--------------------+

                      |
             +--------v---------+
             |   Private Subnet  |
             |   (CIDR: x.x.x.x) |
             |                  |
             |  Private EC2     |
             +------------------+
