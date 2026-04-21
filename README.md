# 💰 Expense Tracker App (Flutter)

A simple and functional Expense Tracker application built using **Flutter**, following **MVVM architecture**, with **Provider** for state management and **SharedPreferences** for local storage.

---

## 🚀 Features

### 📊 Dashboard
- Displays:
  - Total Balance
  - Total Income
  - Total Expense
- Real-time updates when transactions change

### ➕ Add Transaction
- Add new transactions with:
  - Amount
  - Title
  - Date
  - Type (Income / Expense)
- Form validation included

### 📋 Transaction List
- View all saved transactions
- Clean and responsive UI using Material 3

### ❌ Delete Transaction
- Remove any transaction from the list
- Automatically updates dashboard values

---

## 🏗️ Tech Stack

- **Framework:** Flutter  
- **UI Design:** Material 3  
- **Architecture:** MVVM (Model-View-ViewModel)  
- **State Management:** Provider  
- **Local Storage:** SharedPreferences  

---

## 🧠 Architecture Overview (MVVM)

### ScreenShot
<img width="259" height="194" alt="image" src="https://github.com/user-attachments/assets/cb78c0fe-49a5-44ef-bba4-16d024bfa002" />


### 📦 Models
- Defines the data structure (`Transaction`)
- Includes:
  - `toJson()` → Convert object to JSON
  - `fromJson()` → Convert JSON to object

### 🔄 ViewModels (Providers)
- Handles:
  - Business logic
  - Data calculations (income, expense, balance)
  - Local storage (SharedPreferences)
- Notifies UI using `notifyListeners()`

### 🎨 Views (UI Screens)
- Pure UI layer
- Uses Material 3 components
- Reads data from ViewModel
- Calls ViewModel functions (no business logic here)

---

## 📁 Project Structure
