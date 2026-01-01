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
    - **Root Directory**: `backend` (if you are in the `nearbuy` repo)
    - **Runtime**: `Python 3`
    - **Build Command**: 
        ```bash
        pip install -r requirements.txt && python manage.py migrate && python manage.py collectstatic --noinput
        ```
    - **Start Command**: 
        ```bash
        gunicorn product_finder.wsgi:application
        ```
    > **Note**: If you see `ModuleNotFoundError: No module named 'cgi'`, it means Render is using Python 3.13 (which removed `cgi`). We added `runtime.txt` to force Python 3.9. If it persists, ensure `runtime.txt` is in the Root Directory you set above.

4.  **Environment Variables**:
    Go to the **Environment** tab in Render and add:
    - `SECRET_KEY`: `(click 'Generate' or enter a long random string)`
    - `DEBUG`: `False` (Important: always False in production!)
    - `ALLOWED_HOSTS`: `*` (or your actual `.onrender.com` domain)

---

## 3. The SQLite Challenge on Render

**⚠️ Warning**: Your database is currently using **SQLite** (`db.sqlite3`). 
On Render's Free tier, the disk is "ephemeral." This means **every time you push new code or the server restarts, your database will be wiped clean.**

### How to handle this:
1.  **For a College Demo**: It is usually okay. Just register a shop and customer right before the demo. 
2.  **For Real Use**: You must use a "Managed Database" like **Render PostgreSQL** or a free MySQL provider like **Aiven**. 
    - If you switch, you just need to change the `DATABASE_URL` and Render will handle the connection.

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
