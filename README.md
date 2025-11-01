# 🏨 Travaly Flutter Assignment

This Flutter project is a **3-page application** built as part of the Travaly technical task. It demonstrates Google Authentication (frontend only), API-based hotel search with pagination, and a clean architecture using the **BLoC pattern**.

---

## 📱 Features

### Page 1 - Google Sign In/Sign Up

* Frontend-only Google Authentication flow.
* Simulates Google sign-in/sign-up UI.
* Used to assess understanding of authentication integration.

### Page 2 - Home Page (Hotel List)

* Displays a list of sample hotels.
* Integrated **search bar** to search hotels by:

  * Name
  * City
  * State
  * Country
* API integration with pagination.

### Page 3 - Search Results

* Displays API-fetched search results.


## 🌐 API Information

* **Base URL:** `https://api.mytravaly.com/public/v1/`
* **Documentation:** Available on Postman (as provided in the task)

---

##  Project Architecture

This project follows **Clean Architecture** with **BLoC state management**.


## ⚙️ Environment Setup

Three environment files are configured:

* `.env.dev`
* `.env.staging`
* `.env.production`

Each file contains environment-specific variables (e.g., base URLs, tokens).

---

## 🚀 Run Commands

You can run the app in different environments using **VS Code launch configurations** or the command line.

### **Run using VS Code**

Open the project in VS Code → Press `F5` → Select one of:

* `Run Dev`
* `Run Staging`
* `Run Production`

### **Run from Command Line**

```bash
# Development
flutter run --dart-define=ENV=dev

# Staging
flutter run --dart-define=ENV=staging

# Production
flutter run --dart-define=ENV=production
```

---

## 🧠 Tech Stack

* **Flutter:** 3.x
* **State Management:** BLoC
* **Networking:** `http` package
* **Routing:** `go_router`
* **Environment Handling:** `flutter_dotenv`


---

## 📦 Installation & Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/<your-username>/travaly_flutter_assignment.git
   cd travaly_flutter_assignment
   ```

2. Get dependencies:

   ```bash
   flutter pub get
   ```

3. Run the desired environment:

   ```bash
   flutter run --dart-define=ENV=dev
   ```

---


