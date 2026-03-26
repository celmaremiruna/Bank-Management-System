# Bank Management System - Database Project

## Project Description
This project focuses on the design and implementation of a relational database for managing the operations of a banking institution. The system allows for centralized tracking of clients, their accounts, and attached cards, monitoring of current transactions, as well as the management of granted credits and related payments. Additionally, the database facilitates the administration of the internal structure by keeping records of branches and employees.

## Database Structure
The database schema is complex and consists of 9 interconnected tables:
* **CLIENTI_BANCA**: Stores client identification data (CNP/ID, first name, last name, contact info, and client type).
* **CONTURI_BANCA**: Holds information about opened accounts, such as account type, current balance, and opening date.
* **CARDURI_BANCA**: Tracks cards issued for each account, including security details (CVV, expiration date) and currency.
* **TRANZACTII_BANCA**: Records the history of financial movements on accounts (amount, transaction type, description).
* **CREDITE_BANCA**: Manages loans granted to clients, detailing the interest rate, duration, and remaining balance.
* **PLATI_CREDITE_BANCA**: Monitors payments made to clear credits/loans.
* **SUCURSALE_BANCA**: Defines the bank's territorial branches.
* **ANGAJATI_BANCA**: Contains bank personnel data, their roles, salaries, and assigned branch.
* **CURS_VALUTAR**: Serves as a reference table for currency exchange rates relative to RON.

## Architecture and SQL Concepts Used
The system utilizes integrity constraints (Primary Keys, Foreign Keys, CHECK constraints, and NOT NULL) to ensure data accuracy. The relationships between tables are exclusively one-to-many.

Throughout the project, the following advanced functionalities were implemented:
* **Complex Queries**: Over 35 query scenarios using JOINs, aggregation functions, subqueries, and set operators.
* **Object Management**: Creation of `Views` for quick access to the financial profiles of clients.
* **Optimization**: Use of `Indexes` to speed up name-based searches.
* **Automation**: Implementation of `Sequences` for auto-generating primary keys for payments.
* **Security & Maintenance**: Use of `Flashback` commands for recovering accidentally dropped tables.

