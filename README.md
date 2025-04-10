# user_list

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Flutter BLoC User List App

A simple Flutter application demonstrating state management with BLoC, clean architecture, API integration, infinite scroll pagination, search, pull-to-refresh, and data caching.

![Flutter](https://img.shields.io/badge/Flutter-3.16-blue?logo=flutter)
![BLoC](https://img.shields.io/badge/BLoC-8.1.2-purple?logo=bloc)
![API](https://img.shields.io/badge/API-ReqRes-orange)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-brightgreen)

---

## 📱 Features

- 🔁 Fetch users from [ReqRes API](https://reqres.in/)
- 📄 User list with name and profile picture
- 👤 User detail screen with full info
- 🔍 Search users by name
- ⬇️ Infinite scrolling with pagination
- 🔄 Pull-to-refresh functionality
- ⚠️ Handles offline, empty state, and error scenarios
- 💾 Caching using Hive
- 🧪 Test cases for widgets and APIs (optional)
- 🚀 Clean Architecture + BLoC + Dependency Injection

---

## 📸 Screenshots

| User List | User Detail | Pull to Refresh |
|-----------|-------------|-----------------|
| ![list](assets/screenshots/user_list.png) | ![detail](assets/screenshots/user_detail.png) | ![refresh](assets/screenshots/pull_refresh.png) |

---

## 📦 Packages Used

| Package | Purpose |
|--------|---------|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management |
| [equatable](https://pub.dev/packages/equatable) | Efficient state comparisons |
| [dio](https://pub.dev/packages/dio) | HTTP requests |
| [hive](https://pub.dev/packages/hive) | Local storage / caching |
| [get_it](https://pub.dev/packages/get_it) | Dependency injection |
| [connectivity_plus](https://pub.dev/packages/connectivity_plus) | Internet connection check |
| [pull_to_refresh](https://pub.dev/packages/pull_to_refresh) | Pull to refresh list |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | Optimized image loading |

---

## 🧱 Project Structure (Clean Architecture)

