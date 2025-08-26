#  Currency Rate Calculator

A Flutter app to convert currencies with live exchange rates.


##  Setup

### Requirements

* **Flutter**: 3.32.6 (stable)
* **Dart**: 3.8.1
* **Hive**: for local storage
* **BLoC**: for state management

### Clone & Install

```bash
git clone https://github.com/your-repo/currency_rate_calculator.git
cd currency_rate_calculator
flutter pub get
```

## ⚙️ Environment Config

Instead of typing `--dart-define` each time, you can use **VSCode launch configs**:

`.vscode/launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter (Development)",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=BASE_URL=https://api.exconvert.com/convert",
        "--dart-define=ACCESS_KEY=YOUR_DEV_KEY"
      ]
    },
    {
      "name": "Flutter (Staging)",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=BASE_URL=https://api.exconvert.com/convert",
        "--dart-define=ACCESS_KEY=YOUR_STAGE_KEY"
      ]
    },
    {
      "name": "Flutter (Production)",
      "request": "launch",
      "type": "dart",
      "args": [
        "--release",
        "--dart-define=BASE_URL=https://api.exconvert.com/convert",
        "--dart-define=ACCESS_KEY=YOUR_PROD_KEY"
      ]
    }
  ]
}
```

---

## Build & Run

Run with:

```bash
flutter run --dart-define=BASE_URL=https://api.exconvert.com/convert --dart-define=ACCESS_KEY=YOUR_KEY
```

Build APK:

```bash
flutter build apk --release --dart-define=BASE_URL=https://api.exconvert.com/convert --dart-define=ACCESS_KEY=YOUR_KEY
```

---
