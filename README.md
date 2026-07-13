 ServiceHub - Local Service Provider Platform

[![Java Version](https://img.shields.io/badge/Java-11%2B-blue.svg)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-9-orange.svg)](https://jakarta.ee/)
[![Build](https://img.shields.io/badge/Build-Maven-red.svg)](https://maven.apache.org/)
[![Database](https://img.shields.io/badge/Database-MySQL%208.x-cyan.svg)](https://www.mysql.com/)

ServiceHub is a robust, dynamic Java web application designed to connect local customers with independent service professionals (such as plumbers, electricians, carpenters, and technicians). This project is built as a learning exercise to master core enterprise Java development concepts.

---

 Architecture & Tech Stack

This project follows the **MVC (Model-View-Controller)** design pattern and implements strict separation of concerns using Data Access Objects (DAOs).

* **Backend Framework:** Jakarta Servlets (Java EE 9+)
* **Frontend UI:** JSP (JavaServer Pages), JSTL, Bootstrap 5, HTML5, CSS3
* **Data Access Layer:** JDBC (Java Database Connectivity) with PreparedStatements
* **Database:** MySQL 8.x
* **Dependency & Build Management:** Apache Maven
* **Development IDE:** NetBeans / IntelliJ IDEA

---

Project Directory Structure

```text
ServiceHub/
│
├── .gitignore                        # Git ignore rules for Maven/IDEs
├── pom.xml                           # Maven project configuration and dependencies
├── README.md                         # Project documentation
│
├── database/
│   └── schema.sql                    # Production MySQL schema scripts
│
└── src/
    └── main/
        ├── java/
        │   └── com/mycompany/servicehub/
        │       ├── config/           # Database connections and configurations
        │       ├── dao/              # Database access layer (SQL operations)
        │       ├── model/            # Plain Old Java Objects (POJO / Entities)
        │       └── servlet/          # Controller layer handling HTTP requests
        │
        └── webapp/
            ├── WEB-INF/              # Protected web configuration files
            ├── css/                  # Compiled styles and custom stylesheets
            ├── js/                   # Custom client-side scripting
            └── views/                # Modular JSP views (Dashboard, Profiles, Auth)
