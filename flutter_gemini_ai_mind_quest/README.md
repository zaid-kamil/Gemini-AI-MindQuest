# Gemini AI MindQuest - Flutter Web

[![Deploy to GitHub Pages](https://github.com/zaid-kamil/johnny_task/actions/workflows/flutter-pages.yml/badge.svg)](https://github.com/zaid-kamil/johnny_task/actions/workflows/flutter-pages.yml)

A Flutter web application that replicates the functionality of the React/Next.js version with the same beautiful purple-blue gradient theme and BLoC state management pattern.

**🌐 Live Demo**: [https://zaid-kamil.github.io/johnny_task/](https://zaid-kamil.github.io/johnny_task/)

## Features

✨ **Form Management**: 6-field form with real-time validation using Formz
- Name (minimum 2 characters)
- Roll Number (required)
- Branch (required)
- College (required)
- Email (valid email format)
- Mobile (10 digits)

🔥 **Firebase Integration**: Automatic data storage in Firebase Realtime Database with timestamp

🎉 **Success Dialog**: Beautiful countdown dialog (3 seconds) with automatic tab opening

🌐 **Tab Opening**: Programmatically opens 5 tabs after successful submission:
- Google
- GitHub
- LinkedIn
- Facebook
- Twitter

🎨 **Theme System**: Dark/light mode toggle with persistent storage
- Blue-purple gradient theme
- Smooth transitions
- High contrast for readability

📱 **Responsive Design**: Optimized for web browsers with Material 3 design

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── firebase_constants.dart        # Firebase configuration
│   └── theme/
│       └── app_theme.dart                 # Dark/light theme definitions
├── features/
│   ├── form/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── user_data.dart        # UserData model
│   │   │   └── repositories/
│   │   │       └── firebase_repository.dart  # Firebase operations
│   │   ├── domain/
│   │   │   └── validators/
│   │   │       └── form_validators.dart   # Formz validators
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── form_bloc.dart        # Form BLoC
│   │       │   ├── form_event.dart       # Form events
│   │       │   └── form_state.dart       # Form state
│   │       └── widgets/
│   │           └── user_form_widget.dart # Form UI + Success dialog
│   ├── theme/
│   │   └── presentation/
│   │       └── bloc/
│   │           ├── theme_bloc.dart       # Theme BLoC
│   │           ├── theme_event.dart      # Theme events
│   │           └── theme_state.dart      # Theme state
│   └── home/
│       └── presentation/
│           └── pages/
│               └── home_page.dart        # Main page
└── main.dart                             # App entry point
```

## Architecture

This project follows **Clean Architecture** with **BLoC Pattern**:

- **Presentation Layer**: UI components and BLoC (Business Logic Component)
- **Domain Layer**: Business logic and validators
- **Data Layer**: Models and repositories

### State Management

- **flutter_bloc**: For managing form state and theme state
- **formz**: For form validation with typed validators
- **equatable**: For value equality in state objects

## Technology Stack

- **Flutter**: 3.x (web-only platform)
- **Dart**: 3.7.2
- **Puro**: 1.4.11 (Flutter version manager)

### Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.6
  firebase_core: ^3.8.1
  firebase_database: ^11.5.2
  formz: ^0.7.0
  url_launcher: ^6.3.1
  equatable: ^2.0.7
  intl: ^0.20.1
  flutter_animate: ^4.5.2
```

## Firebase Configuration

The app connects to the same Firebase project as the React version:
- **Project ID**: mbu-event-ga
- **Database URL**: https://mbu-event-ga-default-rtdb.firebaseio.com

Credentials are stored in `lib/core/constants/firebase_constants.dart`.

## Getting Started

### Prerequisites

1. Install Puro (Flutter version manager):
   ```powershell
   # Follow instructions at https://puro.dev
   ```

2. Verify installation:
   ```powershell
   puro --version
   puro flutter --version
   ```

### Installation

1. Navigate to the project directory:
   ```powershell
   cd flutter_gemini_ai_mind_quest
   ```

2. Install dependencies:
   ```powershell
   puro flutter pub get
   ```

### Running the App

**Development mode** (with hot reload):
```powershell
puro flutter run -d chrome
```

**Build for production**:
```powershell
puro flutter build web --release
```

The built files will be in `build/web/` directory.

### Deployment

#### GitHub Pages (Automatic - Recommended)

The app automatically deploys to GitHub Pages on every push to `main` branch via GitHub Actions.

**Live URL**: [https://zaid-kamil.github.io/johnny_task/](https://zaid-kamil.github.io/johnny_task/)

**Setup**:
1. Enable GitHub Pages in repository settings
2. Set source to "GitHub Actions"
3. Push to main branch - deployment happens automatically!

See [GITHUB_PAGES_DEPLOYMENT.md](GITHUB_PAGES_DEPLOYMENT.md) for detailed setup instructions.

#### Other Hosting Options

The web build can also be deployed to:
- **Firebase Hosting**: `firebase deploy`
- **Vercel**: Deploy the `build/web` folder
- **Netlify**: Deploy the `build/web` folder

## Color Scheme

### Dark Theme (Default)
- **Primary Purple**: #A78BFA (purple-400)
- **Primary Blue**: #60A5FA (blue-500)
- **Background**: #0F172A (slate-900)
- **Surface**: #1E293B (slate-800)
- **Card**: #334155 (slate-700)

### Light Theme
- **Primary Purple**: #9333EA (purple-600)
- **Primary Blue**: #2563EB (blue-700)
- **Background**: #FFFFFF
- **Surface**: #F8FAFC
- **Card**: #FFFFFF

## Key Features Implementation

### Form Validation (Formz)
Each field has a custom validator extending `FormzInput`:
- `Name`: Minimum 2 characters
- `Email`: Valid email format with regex
- `Mobile`: Exactly 10 digits
- `RequiredField`: Non-empty validation

### Success Dialog
- 3-second countdown with animated dots
- Automatic tab opening with 500ms stagger
- Manual fallback button
- Uses `dart:html` for `window.open()`

### Firebase Integration
- Saves data to `/users/{pushId}` path
- Includes timestamp (millisecondsSinceEpoch)
- Includes createdAt (ISO 8601 string)

### Theme Switching
- BLoC pattern for theme state
- Persists theme preference (future enhancement)
- Smooth transitions between dark/light modes

## Differences from React Version

1. **State Management**: BLoC pattern instead of React Hook Form
2. **Validation**: Formz validators instead of Zod
3. **Styling**: Material 3 theming instead of Tailwind CSS
4. **Tab Opening**: dart:html instead of JavaScript window.open
5. **No Server Actions**: Direct Firebase SDK usage

## Known Issues

- `dart:html` is deprecated (will migrate to `package:web` in future)
- WebAssembly build not supported due to dart:html usage
- Theme persistence not implemented yet (uses default dark mode)

## Future Enhancements

- [ ] Migrate to `package:web` and `dart:js_interop`
- [ ] Add local storage for theme persistence
- [ ] Add form field animations with flutter_animate
- [ ] Add unit tests with bloc_test
- [ ] Add integration tests
- [ ] Add form reset functionality
- [ ] Add loading animation during Firebase operations

## Development

### Code Style
Follow Flutter/Dart conventions:
```powershell
# Format code
puro flutter format .

# Analyze code
puro flutter analyze

# Run tests (when added)
puro flutter test
```

### Adding New Features
1. Create feature folder in `lib/features/`
2. Implement clean architecture layers
3. Use BLoC for state management
4. Add Formz validators for form fields
5. Follow Material 3 design guidelines

## License

This project matches the license of the React version.

## Related Projects

- **React/Next.js version**: `../` (parent directory)
- Uses the same Firebase database
- Shares identical color scheme and branding

---

**Built with** ❤️ **using Flutter & BLoC**
