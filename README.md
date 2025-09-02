# 🎬 Movies App

## 📌 Project Info
This is a **Graduation Project** for **Cycle 15 - Flutter** in **Route Academy**.  
We are **Team 3** and this app is called **Movies App**.

## 👨‍💻 Team Members
- Osama Alaa Eldin Mohamed Abdallah.
- Fawzy Omar Mohamed Omara.
- Ahmed Hussien Adel.
- Karim Ezat Elrefaay.
- Habiba Mohamoud Awadallah.

---

## 📱 Features & Screens

### Authentication
- Login
- Register
- Forget Password

### App Flow
1. **Splash Screen**
2. **Onboarding**
3. **Auth**
    - Login
    - Register
    - Forget Password
4. **Home Screen**
    - Home Tab
    - Search Tab
    - Browse Tab
    - Profile Tab
    - Update Profile
    - Movie Details Screen

---

## 🌐 API’s
We are using:
- [YTS API](https://yts.mx/api) to fetch movies.
- [Postman Documentation](https://documenter.getpostman.com/view/24969030/2sAYBUDC3i) for Authentication APIs.

### API Endpoints
- **List Movies** → `https://yts.mx/api/v2/list_movies.json`
- **Movie Details** → `https://yts.mx/api/v2/movie_details.json`
- **Movie Suggestions** → `https://yts.mx/api/v2/movie_suggestions.json`

---

## 📌 Project Phases

### **Phase 1**
- Splash Screen
- Onboarding
- Login UI
- Register UI
- Forget Password UI
- Update Profile UI

### **Phase 2**
- Login, Register, Reset Password, Update Profile Logic
- Home Screen (Bottom Navigation Bar with 4 Tabs UI)
- Home Tab (UI + Logic)

👉 Used APIs:
- `POST` Login API
- `POST` Register API
- `PATCH` Reset Password API
- `GET` List Movies API

---

### **Phase 3**
- Movie Details Screen

👉 Used APIs:
- `GET` Movie Details API
- `GET` Movie Suggestions API

---

### **Phase 4**
- Search Tab
- Browse Tab
- Profile Tab (Watchlist + History)

👉 Used APIs:
- Search Movies by Title → `list_movies.json`
- Browse Movies by Genre
- Profile Watchlist (Favorite Movies API)
- Profile History (Save last visited movies locally/API)
