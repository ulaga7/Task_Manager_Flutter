#📘 Task Manager App – Flutter + Back4App (Parse Server)

A simple Task Manager application built using Flutter and Back4App (Parse Server).
This app demonstrates:

User Authentication (Register/Login)

Secure Session Handling

CRUD Operations on Tasks

Cloud Database Integration

Provider-based State Management

Cross-platform support (Windows, Android, Web)

This project is developed as part of a WILP Flutter App Development Assignment.

#🚀 Features
 #🔐 User Authentication

Register using email & password

Login securely

Parse session token stored and auto-restored

Logout functionality included

 #📝 Task CRUD

Create Tasks (title + description)

View your tasks

Edit tasks

Delete tasks

All tasks are stored in Back4App Cloud Database

 #☁️ Backend: Back4App (Parse Server)

No custom backend needed

Uses Parse REST API

Cloud Database + ACLs

Session-based authentication

 #📱 Frontend: Flutter

Uses Provider for state management

Clean UI with AppBar, FAB, Popup menu

Windows/Desktop support

Responsive and simple UI

#🧩 Technology Stack
Layer	Technology
Frontend	Flutter (Dart)
Backend	Back4App (Parse Server)
Database	Back4App Cloud DB
State Management	Provider
Auth	Parse User Authentication
Platform	Windows / Android / Web

#📁 Project Structure
lib/
 ├── main.dart
 ├── services/
 │     ├── parse_service.dart
 │     ├── auth_service.dart
 │     └── task_service.dart
 ├── screens/
 │     ├── entry_screen.dart
 │     ├── login_screen.dart
 │     ├── home_screen.dart
 │     └── edit_task_screen.dart
 └── widgets/

#🔧 Setup Instructions
1️⃣ Clone the Repository
git clone <repo-url>
cd task_manager_app

2️⃣ Install Flutter Dependencies
flutter pub get

3️⃣ Configure Back4App Keys

Open main.dart and update with your Back4App credentials:

await ParseService.initialize(
  appId: 'YOUR_APP_ID',
  clientKey: 'YOUR_CLIENT_KEY',
  serverUrl: 'https://parseapi.back4app.com/',
);


#⚠️ Do NOT commit real keys to public GitHub.

#▶️ Running the App
Windows:
flutter run -d windows

Chrome/Web:
flutter run -d chrome

Android:
flutter run -d emulator-5554

#🧠 How It Works
 #🔐 Authentication Flow

AuthService.restoreSession() restores session on startup.

Session tokens are automatically included using autoSendSessionId: true.

If session is invalid → logout and redirect to login screen.

 #📝 Task Flow

TaskService loads tasks for the logged-in user.

Each task is stored in Back4App with an ACL giving read/write only to the owner.

Queries use pointer matching:

..whereEqualTo('owner', _user!)

 #📚 Screens Overview
  🏁 EntryScreen

Decides whether to show Login or Home based on auth state.

 #🔑 LoginScreen

Form to register or login a user.

 #🏠 HomeScreen

Displays user’s tasks + Logout button.
Includes pull-to-refresh + task menu (edit/delete).

 #✏️ EditTaskScreen

Add or update tasks.

 #🔐 Back4App Setup
Create the following Class:
Task
Field	Type
title	String
description	String
owner	Pointer → _User

Set ACL automatically in code:

task.setACL(ParseACL(owner: _user!));

 #🧪 Testing Steps

Register with a valid email.

Login.

Create a new task.

Edit the task.

Delete the task.

Restart the app → session restores automatically.

Logout → returns to login screen.

#🛡️ Security Notes

Never commit real client keys to public repos.

Always use ACLs for user data.

Use Authenticated Read in Back4App CLP for _User and Task.

#📦 Future Improvements

Add profile section

Rich text notes

Task categories/tags

Dark mode

Firebase push notifications

Offline sync

#🎉 Conclusion

This Task Manager App demonstrates full-stack Flutter development using a Backend-as-a-Service (BaaS).
It covers essential concepts like authentication, state management, cloud storage, and CRUD operations.