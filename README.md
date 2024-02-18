---

# Wenia App Test

This guide will assist you in building and running the app on your local machine for development and testing purposes.

## Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code with Flutter & Dart plugins
- An emulator or physical device

## Getting Started

To get a local copy up and running, follow these simple steps:

1. **Clone the repo**
```sh
git clone https://github.com/ndmunoz10/wenia_test.git
```

2. **Install dependencies and run code generator**

  Navigate to the project directory and run:
```sh
flutter pub get
```
  Or if you're on a MacBook, run 
```sh
make clean
```
  Then run
```sh
dart run build_runner build --delete-conflicting-outputs
```
  Or if you're on a MacBook, run 
```sh
make build
```
This will generate the necessary code and classes to run the project.

3. **Run the app**
   To launch the app on a connected emulator or physical device, run:
```sh
flutter run
```
For detailed instructions on setting up your Flutter environment and troubleshooting common issues, please contact me at nicdamun@gmail.com.

---
