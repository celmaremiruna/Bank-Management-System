# Bank-Management-System

## Project Description
[cite_start]This project focuses on the design and implementation of a relational database for managing the operations of a banking institution[cite: 7]. [cite_start]The system allows for centralized tracking of clients, their accounts, and attached cards, monitoring of current transactions, as well as the management of granted credits and related payments[cite: 8]. [cite_start]Additionally, the database facilitates the administration of the internal structure by keeping records of branches and employees[cite: 8].

## Database Structure
[cite_start]The database schema is complex and consists of 9 interconnected tables[cite: 10]:
* [cite_start]**CLIENTI_BANCA**: Stores client identification data (CNP/ID, first name, last name, contact info, and client type)[cite: 11].
* **CONTURI_BANCA**: Holds information about opened accounts, such as account type, current balance, and opening date[cite: 12].
* **CARDURI_BANCA**: Tracks cards issued for each account, including security details (CVV, expiration date) and currency[cite: 13].
* **TRANZACTII_BANCA**: Records the history of financial movements on accounts (amount, transaction type, description)[cite: 14].
* **CREDITE_BANCA**: Manages loans granted to clients, detailing the interest rate, duration, and remaining balance[cite: 15].
* **PLATI_CREDITE_BANCA**: Monitors payments made to clear credits/loans[cite: 16].
* [cite_start]**SUCURSALE_BANCA**: Defines the bank's territorial branches[cite: 17].
* **ANGAJATI_BANCA**: Contains bank personnel data, their roles, salaries, and assigned branch[cite: 18].
* **CURS_VALUTAR**: Serves as a reference table for currency exchange rates relative to RON[cite: 19].

## Architecture and SQL Concepts Used
[cite_start]The system utilizes integrity constraints (Primary Keys, Foreign Keys, CHECK constraints, and NOT NULL) to ensure data accuracy[cite: 21, 23, 24, 26, 27]. [cite_start]The relationships between tables are exclusively one-to-many[cite: 25].

Throughout the project, the following advanced functionalities were implemented:
* **Complex Queries**: Over 35 query scenarios using JOINs, aggregation functions, subqueries, and set operators[cite: 995, 1104, 1157, 1202, 1226].
* [cite_start]**Object Management**: Creation of `Views` for quick access to the financial profiles of clients[cite: 1753].
* [cite_start]**Optimization**: Use of `Indexes` to speed up name-based searches[cite: 1792, 1803].
* **Automation**: Implementation of `Sequences` for auto-generating primary keys for payments[cite: 1804, 1818].
* [cite_start]**Security & Maintenance**: Use of `Flashback` commands for recovering accidentally dropped tables[cite: 966, 977].

## Author
[cite_start]Project created by Celmare Miruna-Ştefana[cite: 2].
