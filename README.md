# 🛍️ Product Browser App

A sophisticated product discovery and cart management application built with **Flutter**. This project demonstrates a production-ready implementation of **Clean Architecture**, robust **State Management**, and **Data Persistence**.

---

## 🚀 Tech Stack & Tools

* **Framework:** Flutter (Latest Stable)
* **State Management:** [BLoC](https://pub.dev/packages/flutter_bloc) (Event-driven approach for predictable state transitions)
* **Dependency Injection:** [GetIt](https://pub.dev/packages/get_it) (Service Locator pattern for decoupling classes)
* **Networking:** [Dio](https://pub.dev/packages/dio) (Configured with BaseOptions and Interceptors for centralized API handling)
* **Local Storage:** [SharedPreferences](https://pub.dev/packages/shared_preferences) (Used for Cart persistence)
* **Architecture:** Clean Architecture (Separation of concerns across Data, Domain, and Presentation layers)

---

## ✨ Key Features

* **Dynamic Product Feed:** Fetches real-time product data from external APIs (DummyJSON) with category-based filtering.
* **Advanced Search & Filtering:** Efficient search functionality to find specific products instantly.
* **Rich Product Details:** Comprehensive view featuring image carousels, ratings, stock status, and technical descriptions.
* **Persistent Shopping Cart:** * Add/Remove items with real-time UI updates.
    * Quantity management within the cart.
    * **Data Persistence:** Cart items are saved locally, ensuring no data loss after app restarts.
* **Optimized UI:** Fully responsive design using `ScreenUtil` for consistent layout across all device sizes.
* **Clean Code Standards:** Zero warnings/errors according to `flutter analyze`, utilizing **Barrel Files** for clean import management.

---

## 🏗️ Project Architecture

The project follows a modular **Clean Architecture** to ensure the codebase is scalable, maintainable, and testable:

* **Core:** Shared constants, themes, network configurations, and the `common_imports` barrel file.
* **Features:** Each feature (Cart, Products, Categories) is self-contained:
    * `Data`: Handles API calls (WebServices) and Data Transfer Objects (Models).
    * `Logic/Bloc`: Manages business logic and state transitions.
    * `View`: Reusable widgets and screen layouts.



---

## 🛠️ Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/SamiaSalhia/product_browser_app.git
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 👨‍💻 Developer
Developed by **Samia Salhia (dev.samia)**. 
Focused on building high-performance, scalable mobile applications with a commitment to clean code and architectural excellence.
