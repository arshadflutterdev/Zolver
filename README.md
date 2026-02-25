# Zolver 🛠️
**Zolver** is a premium, global double-sided marketplace built with **Flutter** and **GetX**. It connects skilled service providers (Workers) with people seeking professional help (Clients) across the globe.

---

## 🚀 The Vision
Zolver aims to bridge the gap between local talent and global needs. Whether you are a plumber in Riyadh, a designer in London, or a developer in Faisalabad, Zolver provides the platform to get "Solved."

## 📱 User Flow
1. **Onboarding:** A 3-page immersive introduction to the platform.
2. **Persona Selection:** A critical choice at entry:
   - **Service Provider (Worker):** "I want to work."
   - **Service Seeker (Client):** "I want to find a professional."
3. **Authentication:** Secure Firebase-powered OTP/Email login.

---

## 🛠️ Project Structure (GetX Pattern)
The project follows a modular and scalable structure to ensure clean code management.

```text
lib/
├── app/
│   ├── data/
│   │   ├── models/           # Data models (User, Worker, Service)
│   │   ├── providers/        # API / Firebase implementations
│   │   └── repositories/     # Abstracted data logic
│   ├── modules/              # Feature-based modules
│   │   ├── onboarding/       # PageView slides
│   │   ├── role_selection/   # Worker vs Client logic
│   │   ├── auth/             # Login & Registration
│   │   ├── home/             # Dashboards (Dual view)
│   │   └── profile/          # User portfolios
│   ├── routes/               # App routing (GetPage)
│   └── widgets/              # Reusable custom UI components
├── core/                     # Global Utils, Themes, & Translations
└── main.dart                 # Application Entry Point