# Laundry Order Management App (Flutter + SQLite)

A simple Flutter application to manage laundry orders with local database support using SQLite and state management using Provider.

---

## Features

* Add new laundry orders
* View all orders
* Update order status:
* Received → Washing → Ready → Delivered
* Search orders by name or Order ID
* Filter orders by status
* Dashboard:
  * Total Orders
  * Total Revenue
* Local data storage using SQLite

---

## Technologies Used

* Flutter
* Dart
* SQLite (sqflite)
* Provider (State Management)

---

## Project Setup

### Clone the repository

bash
git clone <your-repo-url>
cd <project-folder>

---

### 2Install dependencies

bash
flutter pub get

---

#### Run on Android Emulator

bash
flutter emulators --launch (device_id)
flutter run

#### Run on Chrome (Web - No SQLite support)

bash
flutter run -d chrome


## Project Structure

lib/
│
├── models/
│   └── order.dart
│
├── services/
│   ├── db_helper.dart
│   └── order_provider.dart
│
├── screens/
│   ├── order_list_screen.dart
│   └── add_order_screen.dart
│
└── main.dart


## 💾 Database Info

* Database: SQLite
* Table: `orders`
* Stored locally on device

| Column Name | Type    | Description                                        |
| ----------- | ------- | -------------------------------------------------- |
| `id`        | INTEGER | Primary key (auto-increment)                       |
| `name`      | TEXT    | Customer name                                      |
| `phone`     | TEXT    | Customer phone number                              |
| `service`   | TEXT    | Type of service (e.g., Wash, Dry Clean)            |
| `items`     | INTEGER | Number of items                                    |
| `price`     | REAL    | Price per item                                     |
| `total`     | REAL    | Total amount (items × price)                       |
| `status`    | TEXT    | Order status (Received, Washing, Ready, Delivered) |



## Author

Fathimathu Najiya
