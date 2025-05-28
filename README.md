# 💸 Expense Tracker

A simple and intuitive Flutter app to track your daily, weekly, and monthly expenses. Helps you manage your personal finances with categorized transactions, charts, and budget insights.

---

## 🚀 Features

- Add, edit and delete expense transactions
- Categorize transactions (e.g., Food, Transportation, Bills)
- View spending history by date or category
- Pie chart or bar graph visualization of expenses
- Persistent local storage (Hive)
- Responsive UI for Android, iOS, Windows and Web

---

## 🛠️ Tech Stack

- **Flutter**: UI toolkit
- **Dart**: Programming language
- **Hive**: Local storage
- **Riverpod**: State management
- **Flutter Charts / fl_chart**: Data visualization

---

## 📦 Platforms Supported

- 🕹️ Web (HTML5)
- 💻 Windows
- 📱 Android

---

## 📸 Screenshots

> Screenshots from each platform

### 🖥️ Windows

| Home                                                              | New                                                             | Chart                                                               |
|-------------------------------------------------------------------|-----------------------------------------------------------------|---------------------------------------------------------------------|
| ![Windows Light Home](screenshots/windows/windows-light-home.png) | ![Windows Light New](screenshots/windows/windows-light-new.png) | ![Windows Light Chart](screenshots/windows/windows-light-chart.png) |
| ![Windows Dark Home](screenshots/windows/windows-dark-home.png)   | ![Windows Dark New](screenshots/windows/windows-dark-new.png)   | ![Windows Dark Chart](screenshots/windows/windows-dark-chart.png)   |

### 🌐 Web

| Home                                                  | New                                                 | Chart                                                       |
|-------------------------------------------------------|-----------------------------------------------------|-------------------------------------------------------------|
| ![Web Light Home](screenshots/web/web-light-home.png) | ![Web Light New](screenshots/web/web-light-new.png) | ![Windows Light Chart](screenshots/web/web-light-chart.png) |
| ![Web Dark Home](screenshots/web/web-dark-home.png)   | ![Web Dark New](screenshots/web/web-dark-new.png)   | ![Windows Dark Chart](screenshots/web/web-dark-chart.png)   |

### 📱 Android

| Home                                                                        | New                                                                       | Chart                                                                         |
|-----------------------------------------------------------------------------|---------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| ![Android Light Home](screenshots/android/android-portrait-light-home.png)  | ![Android Light New](screenshots/android/android-portrait-light-new.png)  |                                                                               |
| ![Android Light Home](screenshots/android/android-landscape-light-home.png) | ![Android Light New](screenshots/android/android-landscape-light-new.png) | ![Android Light Chart](screenshots/android/android-landscape-light-chart.png) |
| ![Android Dark Home](screenshots/android/android-portrait-dark-home.png)    | ![Android Dark New](screenshots/android/android-portrait-dark-new.png)    |                                                                               |
| ![Android Dark Home](screenshots/android/android-landscape-dark-home.png)   | ![Android Dark New](screenshots/android/android-landscape-dark-new.png)   | ![Android Dark Chart](screenshots/android/android-landscape-dark-chart.png)   |
---

## 🌐 Live Demo

- 🔗 **Web (GitHub Pages):**  
  [Demo](https://omnitechphilippines.github.io/expense-tracker/)

---

## 📦 Download Releases

- 💻 **Windows (.7z):**  
  [Download for Windows v1.0.1+1](https://github.com/omnitechphilippines/expense-tracker/releases/download/v1.0.1%2B1/windows-release-v1.0.1%2B1.7z)

- 📱 **Android (.apk):**  
  [Download for Android v1.0.1+1](https://github.com/omnitechphilippines/expense-tracker/releases/download/v1.0.1%2B1/app-release-v1.0.1%2B1.apk)

- 🌐 **Web build (.7z):**  
  [Download Web Build v1.0.1+1](https://github.com/omnitechphilippines/expense-tracker/releases/download/v1.0.1%2B1/web-release-v1.0.1%2B1.7z)

> You can also find all versions in the [Releases Page](https://github.com/omnitechphilippines/expense-tracker/releases)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `v3.29.0`
- Dart SDK `v3.7.0`

### Run the app

```bash
# Clone the repo
git clone https://github.com/omnitechphilippines/expense-tracker.git
cd expense-tracker

# Get packages
flutter pub get

# Run the game (Web)
flutter run -d chrome

# Run the game (Windows)
flutter config --enable-windows-desktop
flutter run -d windows

# Run the game (Android)
flutter run -d android