<<<<<<< HEAD
# ServiceHub - Java Web Application

ServiceHub is a Java-based web application built using Jakarta Servlets, JSP, MySQL, and Maven.

## Tech Stack
* **Backend:** Java 11+ / Jakarta EE (Servlets & JSP)
* **Database:** MySQL
* **Build Tool:** Apache Maven
* **Server:** Apache Tomcat 9+ or GlassFish

## Setup Instructions

### 1. Database Configuration
1. Create a MySQL database named `servicehub_db`.
2. Execute the database schema scripts found in `/database/schema.sql` (If available).
3. Copy `src/main/resources/config.properties.example` to `src/main/resources/config.properties`.
4. Update the DB credentials in `config.properties`.

### 2. How to Build and Run
```bash
mvn clean install
=======
# ServiceHub
Java Web Application (Jakarta Servlets + JSP + MySQL)
>>>>>>> db94169513c38ead6629f77e9ba2e9ee31fe4bcc
