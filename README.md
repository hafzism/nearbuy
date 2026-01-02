# NearBuy - Professional Product Discovery Platform

**NearBuy** is a platform designed to connect customers with local stores. It allows users to browse products from nearby shops, find their exact locations, and request deliveries.

> [!NOTE]
> This project was developed as part of a **BCA (Bachelor of Computer Applications)** college project.

---

## 🌐 Live Demo & App Download

You can experience the platform live without any local setup:

- **Live URL**: [https://nearbuy-project.onrender.com/product_finder/login/](https://nearbuy-project.onrender.com/product_finder/login/)
- **Mobile App**: You can download the Android APK directly from the homepage of the live link (look for the "Download App" button in the navbar).

### 🔑 Default Credentials (for testing)
| Role | Username | Password |
| :--- | :--- | :--- |
| **Admin** | `admin` | `123` |
| **Shop** | `shop` | `123` |

---

## 🏗 Technology Stack
- **Backend**: Django 4.2 (Python 3.11)
- **Database**: SQLite (Local) / MySQL (Production)
- **Mobile**: Flutter 3.19 (Android/iOS)
- **Hosting**: Render.com

---

## 🚀 Local Development Setup

The backend is configured to use **SQLite** by default for easy local testing.

### 1. Setup Backend
```bash
cd nearbuy
python3 -m venv backend/venv
source backend/venv/bin/activate
pip install -r backend/requirements.txt
python backend/manage.py migrate
python backend/manage.py init_users  # Creates demo shop and admin
python backend/manage.py runserver
```

---

## 📱 Mobile App (Flutter)

1.  **Configure URL**: Update `nearbuy/mobile/lib/ip.dart` with your server IP or Render URL.
2.  **Run**:
    ```bash
    cd nearbuy/mobile
    flutter pub get
    flutter run
    ```

---

## 📦 Deployment
For detailed instructions on hosting this project on **Render.com**, please read:
👉 **[DEPLOYMENT_MASTERCLASS.md](DEPLOYMENT_MASTERCLASS.md)**

---

## 📂 Project Structure
- `nearbuy/backend`: Django Project Source
- `nearbuy/mobile`: Flutter App Source
- `nearbuy/docs`: Database Diagrams and Project Docs

