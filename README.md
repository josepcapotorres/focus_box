# FocusBox

**FocusBox** is a task management and time-tracking application built with Flutter. Its goal is to
help users plan their days, assign an estimated amount of time to each task, and stay focused while
working through them.

The application combines task planning with a built-in focus timer, allowing users to track how much
time they actually spend on each task.

> 🚧 **Status:** FocusBox is currently in a testing/beta phase and is being prepared for distribution
> to a small group of testers. And then, it will be published in the Play Store only so far.

---

## ✨ Features

### 📅 Daily task planning

FocusBox allows users to organize their tasks around a specific day.

Each task can have:

* A title
* A planned date
* An estimated duration
* A current status
* Tracked time

The main screen provides an overview of the current and the next day's workload and progress.

### ⏱️ Focus Mode

Each task can be started using its timer.

Focus Mode provides a dedicated environment for concentrating on the current task while tracking the
time spent on it by enabling and activating the Do Not Disturb (DND) mode from the running O.S.

Tasks can be:

* ▶️ Started
* ⏸️ Paused
* ✅ Completed

The application keeps track of the time accumulated for each task.

### 📊 Daily progress

The home screen provides an overview of the user's progress throughout the day, including:

* Total planned time
* Time already spent
* Overall progress
* Task status

This makes it possible to quickly see how much of the planned work has been completed.

### 📚 History

FocusBox includes a history section where users can review their previous activity and focus
performance.

The history provides information such as the amount of time spent working and the user's focus
ratio.

### 🗂️ Task management

Tasks can be created and edited through dedicated interfaces.

The application supports assigning tasks to different dates, making it possible to plan work beyond
the current day.

### 🌙 Light & Dark themes

The application supports both light and dark themes through Flutter's `ThemeData` and `ColorScheme`.

The UI follows a centralized design system so colors, typography and component styles remain
consistent throughout the application.

---

## 🏗️ Architecture

FocusBox follows a layered architecture designed to keep presentation, business logic and data
access separated.

The general dependency flow is:

```text
Presentation
     │
     ▼
Providers (riverpod)
     │
     ▼
 Repositories
     │
     ▼
 Data Sources
     │
     ▼
    Data
```

---

## 🧭 Navigation

FocusBox uses **GoRouter** for navigation.

---

## 💾 Persistence

The application uses a local data layer for storing application data.
This app uses Hive as NoSQL local db.

---

## 🧩 Dependency Injection

FocusBox uses dependency injection to manage application dependencies through providers in
repositories and datasources.

---

## 🐛 Crash Reporting

FocusBox integrates **Firebase Crashlytics** to monitor crashes and unexpected errors during
testing.

---

## 📱 Main Screens

### Home

The main dashboard displays the tasks planned for the current and next day and the user's progress.

It provides an overview of:

* Today's date
* Planned tasks
* Task durations
* Completed/in-progress status
* Daily progress
* Time spent

### Focus Mode

A dedicated screen for working on the currently selected task.

It focuses on the active task and provides controls for starting and pausing its timer.

It also alows an option to activate / deactivate the DND mode to maximize the focus mode from the
user.

### History

Provides access to previous activity and focus statistics.

---

## 🗺️ Roadmap

Potential future improvements include:

* [ ] Internationalization of the strings
* [ ] Add tests to make the app more stable

---

## 📄 License

License information will be added when the project is ready for public distribution.

---

## 👨‍💻 Author

**Josep Capó**
