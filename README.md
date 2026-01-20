# 🌍 NOMÁLIA - Database System Implementation

> **"Travel, Record, Live"** — A robust relational database system designed to manage travel experiences, user interactions, and social memories.

---

## 📖 Overview
This project was developed for the **Database Systems** course at the **University of Minho**. The goal was to design and implement a complete SQL-based solution for **NOMÁLIA**, a digital platform dedicated to world travelers.

The system handles everything from user registration and trip logging to social interactions like comments and a localized "points" reward system.

## 🛠️ Tech Stack & Features
- **Database:** MySQL
- **Modeling:** EER (Enhanced Entity-Relationship) Modeling
- **Business Logic:** Stored Procedures, Triggers, and Functions
- **Security:** Role-Based Access Control (RBAC) and SHA-256 Password Encryption
- **Automation:** Shell Scripting for maintenance (Backups)

## 📂 Project Structure
- **/model**: EER Diagrams and relational schemas.
- **/scripts**: Core SQL scripts (DDL, Logic, Roles).
- **/data**: Seed data for testing and environment setup.
- **/queries**: Functional requirement tests and interaction examples.
- **/automation**: Bash scripts for database management.
- **/docs**: Technical documentation and final report.

### 👤 Access Control (RBAC)
Implemented three distinct access levels:
- **admistrador:** Full system control.
- **utilizador:** Standard interaction permissions.

## 🚀 How to Run
1. **Schema:** Run `scripts/creation.sql` to build the tables and constraints.
2. **Business Logic:** Run `scripts/procedures_trigger.sql` to load procedures and triggers.
3. **Security:** Run `scripts/roles.sql` to set up user roles and access permissions (RBAC).
4. **Data:** Run `data/povoamento.sql` to populate the database with sample data.
5. **Testing:** Run the examples in `queries/queries.sql` to verify the system.
*(Optional) To perform a manual backup, execute `bash automation/backup_nomalia.sh` in your terminal.*
