# Nearbuy Deployment Masterclass

Welcome to the **Deployment Masterclass**. This guide is not just a list of commands; it is a conceptual walkthrough designed to help you understand *how* your application lives on the internet.

## 1. The Architecture of Hosting

Your project, **Nearbuy**, is a "Client-Server" application. This means it has two distinct parts that need to live in different places but talk to each other.

### 🏗 Part A: The Backend (The Brain)
- **What it is**: The Django application + MySQL Database.
- **Role**: Stores data, processes orders, handles logic.
- **Where it lives**: It must run on a **Server** that is always online (24/7).
- **URL**: It will have a public address like `https://nearbuy-api.onrender.com`.

### 📱 Part B: The Mobile App (The Body)
- **What it is**: The Flutter application installed on phones.
- **Role**: Shows the UI to the user and sends requests to the Backend.
- **Where it lives**: On the user's phone (Android/iOS).
- **Connection**: It knows the Backend's URL to send data (e.g., "Login", "Get Products").

---

## 2. Hosting the Backend (Free/Cheap Strategies)

We will use **Render.com** (or similar PaaS like Railway) because it simplifies the complex work of server management.

### Step-by-Step Deployment on Render

1.  **Push to GitHub**:
    - Ensure your fully stabilized code is on GitHub.
    - Your repo structure must be `nearbuy/backend/...`.

2.  **Create Web Service**:
    - Go to [Render Dashboard](https://dashboard.render.com/).
    - Click **New +** -> **Web Service**.
    - Connect your GitHub repository.

3.  **Configure Build Settings**:
    - **Root Directory**: `nearbuy/backend` (Critical! Tell Render where the code is).
    - **Runtime**: `Python 3`.
    - **Build Command**:
        ```bash
        pip install -r requirements.txt && python manage.py collectstatic --noinput
        ```
        *Explanation*: This installs libraries and prepares static files (CSS/Images) for the web.
    - **Start Command**:
        ```bash
        gunicorn product_finder.wsgi:application
        ```
        *Explanation*: `gunicorn` is a production-grade server. `python runserver` is ONLY for your laptop.

4.  **Environment Variables**:
    - Add these secrets in the "Environment" tab:
        - `SECRET_KEY`: (Generate a random string)
        - `DEBUG`: `False` (Security best practice)
        - `DATABASE_URL`: (See Section 3 below)

---

## 3. The Database (MySQL)

You cannot store the database files (`db.sqlite3`) on Render's free tier because the filesystem is ephemeral (it resets every restart). You need a dedicated Database Server.

### Option A: Render MySQL (Paid)
- Easiest integration, but costs money (~$7/mo).

### Option B: Clever Cloud / Railway (Free Tier)
- **Clever Cloud** offers a free MySQL addon.
- **Railway** offers a trial.
- **Steps**:
    1. Create a MySQL database on the provider.
    2. Get the **Connection URL** (looks like `mysql://user:pass@host:port/dbname`).
    3. Go back to Render -> Environment Variables.
    4. Set `DATABASE_URL` = `mysql://...` (You may need to update `settings.py` to read this variable using `dj-database-url` library, which is a standard industry practice).

**Note for this Academic Project**:
If you just want to show a demo and don't care about data persistence after restart, you can stick to `SQLite` (default) on Render. It **will** work, but data will vanish if the server sleeps/restarts. For a college demo, this is often acceptable.

---

## 4. Mobile Distribution (The App)

Unlike the backend, you don't "host" the mobile app. You "distribute" it.

### 📦 Building the APK
1.  **Configure URL**:
    - **Crucial Step**: You must update `nearbuy/mobile/lib/ip.dart`.
    - Change `10.0.2.2` to your **Real Render URL** (e.g., `https://nearbuy-api.onrender.com`).
    - Failure to do this means the app will look for the server on the user's phone itself (localhost), which will fail.

2.  **Build Release**:
    ```bash
    flutter build apk --release
    ```
    - Output: `build/app/outputs/flutter-apk/app-release.apk`
    - This file is optimized for speed and size.

### 🚀 Sharing
- **Google Drive**: Upload the APK and share the link.
- **Website Download**:
    - You can put the APK file in your Django `media/` folder.
    - Add a link on your Shop Landing page: "Download Delivery App".

---

## 5. Masterclass Summary Checklist

- [ ] **Code**: Clean, no junk, pushed to GitHub.
- [ ] **Backend**: Live on Render. `STATIC` files working (CSS loads).
- [ ] **Database**: Connected (SQLite for demo, MySQL for real).
- [ ] **Mobile Config**: `ip.dart` points to the *Live HTTPS URL*.
- [ ] **Mobile Build**: `flutter build apk --release`.
- [ ] **Test**: Install APK on phone -> Turn off WiFi (use 4G) -> Login. If it works, you have built a real cloud system.
