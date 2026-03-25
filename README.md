
Laundry Order App

A simple Flutter application to manage laundry orders using SQLite.
Allows adding orders, updating status, filtering by status, searching, and viewing total revenue.

Features :

Add new laundry orders

Update order status (Received → Washing → Ready → Delivered)

Search orders by customer name or order ID

Filter orders by status

Simple dashboard with total number of orders and revenue

Local storage using SQLite


Requirements:

Flutter SDK ≥ 3.0

Android Studio or VS Code

Android emulator


Installation & Running:

Clone the repository:

git clone https://github.com/naaju91/laundry-order-app.git

cd laundry-order-app


Install dependencies:

flutter pub get


Run the app:

By Android emulator:

flutter emulators --launch <device_id>

flutter run


Project Structure :
lib/

├─ main.dart
├─ models/
│   └─ order.dart
├─ screens/
│   ├─ order_list_screen.dart
│   └─ add_order_screen.dart
└─ services/
    ├─ db_helper.dart
    └─ order_provider.dart

main.dart – Entry point

models/order.dart – Order model

screens/ – Flutter screens for list and adding orders

services/db_helper.dart – SQLite database helper

services/order_provider.dart – Provider for state management



Database Structure:

Table: orders

id	INTEGER	Auto-increment primary key

orderId	TEXT	Unique order identifier (ORD + timestamp)

name	TEXT	Customer name

phone	TEXT	Customer phone number

service	TEXT	Service type (Wash or Dry Clean)

items	INTEGER	Number of items

price	REAL	Price per item

total	REAL	Total price (items × price)

status	TEXT	Order status (Received, Washing, Ready, Delivered)
