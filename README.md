# Nearbuy - Hyperlocal E-Commerce Platform

A comprehensive solution for local shopping, connecting Customers, Shops, and Delivery Boys.

## 🏗 Technology Stack
- **Backend**: Django 3.2 (Python 3.12 compatible)
- **Database**: SQLite (Pre-configured for local dev) / MySQL (Production ready)
- **Mobile**: Flutter 3.19 (Android/iOS)
- **Architecture**: Monorepo with REST-like APIs.

---

## 🚀 Quickstart (Local Backend)

The backend is configured to use **SQLite** by default. You do **NOT** need to install MySQL to run the project locally.

### 1. Setup Backend
Open your terminal in the project root:

```bash
# 1. Create access to required tools
cd nearbuy
# Standard python setup
python3 -m venv backend/venv
source backend/venv/bin/activate

# 2. Install Dependencies
pip install -r backend/requirements.txt

# 3. Apply Database Migrations (Creates db.sqlite3)
python backend/manage.py migrate
# (Optional) Create superuser for Admin access
python backend/manage.py createsuperuser

# 4. Start the Server
python backend/manage.py runserver
```

**Access the Portals:**
- **Admin Panel**: [http://127.0.0.1:8000/product_finder/login/](http://127.0.0.1:8000/product_finder/login/)
    - **Default Credentials**: `admin` / `123` (Auto-created on startup)
- **Shop Login**: [http://127.0.0.1:8000/product_finder/login/](http://127.0.0.1:8000/product_finder/login/)
- **Shop Registration**: [http://127.0.0.1:8000/product_finder/shop_register/](http://127.0.0.1:8000/product_finder/shop_register/)
    - *Note*: Use the registration link to create a new Shop account.

---

## 📱 Mobile App (Flutter)

To build the mobile app, you need the Flutter SDK.

### 1. Automatic Setup
We have provided a script to download and configure Flutter for you.

```bash
# From project root
./install_dependencies.sh
source setup_env.sh
```

### 2. Build & Run
```bash
cd nearbuy/mobile
flutter pub get
flutter run
```

---

## 📦 Deployment & Hosting

For detailed instructions on how to host this project on **Render.com** (Backend) and distribute the App, mostly for free, please read:

👉 **[DEPLOYMENT_MASTERCLASS.md](DEPLOYMENT_MASTERCLASS.md)**

---

## 📂 Project Structure
- `nearbuy/backend`: Django Project Source
- `nearbuy/mobile`: Flutter App Source
- `nearbuy/docs`: Database Diagrams and Project Docs
