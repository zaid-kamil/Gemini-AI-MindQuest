# Gemini AI MindQuest

A beautiful Next.js application with Firebase integration, featuring a stunning blue-purple theme, form submission with database storage, and automatic tab opening functionality.

## Features

- 🎨 **Beautiful UI**: Blue and purple gradient theme with dark/light mode toggle
- 📝 **Form Submission**: Collect user data with validation
- 🔥 **Firebase Integration**: Real-time database storage
- 🚀 **Auto Tab Opening**: Opens multiple websites after form submission
- 🌙 **Theme Switcher**: Toggle between light and dark modes
- 📱 **Responsive Design**: Works on all devices

## Tech Stack

- **Framework**: Next.js 15
- **Styling**: Tailwind CSS
- **Database**: Firebase Realtime Database
- **Forms**: React Hook Form + Zod validation
- **UI Components**: Radix UI + shadcn/ui

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/zaid-kamil/johnny_task.git
   cd johnny_task
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up Firebase**
   - Create a Firebase project at https://console.firebase.google.com/
   - Enable Realtime Database
   - Copy your Firebase config to `.env.local`

4. **Run development server**
   ```bash
   npm run dev
   ```

5. **Open** [http://localhost:9002](http://localhost:9002)

## Deployment

### 🚀 Vercel (Recommended)

This app uses Server Actions and requires a server environment. Vercel is the best choice for deployment.

1. **Connect to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Import your GitHub repository
   - Vercel will automatically detect Next.js

2. **Add Environment Variables**
   In Vercel dashboard → Project Settings → Environment Variables:
   ```
   NEXT_PUBLIC_FIREBASE_API_KEY=your-api-key
   NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
   NEXT_PUBLIC_FIREBASE_DATABASE_URL=https://your-project-default-rtdb.firebaseio.com
   NEXT_PUBLIC_FIREBASE_PROJECT_ID=your-project-id
   NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
   NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your-sender-id
   NEXT_PUBLIC_FIREBASE_APP_ID=your-app-id
   ```

3. **Deploy**
   - Push to `main` branch
   - Vercel will auto-deploy

### ❌ GitHub Pages (Not Supported)

GitHub Pages only supports static sites and cannot run Server Actions. The GitHub Actions workflow for Pages will fail because of this limitation.

## Environment Variables

Create a `.env.local` file in the root directory:

```env
NEXT_PUBLIC_FIREBASE_API_KEY=your-api-key
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
NEXT_PUBLIC_FIREBASE_DATABASE_URL=https://your-project-default-rtdb.firebaseio.com
NEXT_PUBLIC_FIREBASE_PROJECT_ID=your-project-id
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your-sender-id
NEXT_PUBLIC_FIREBASE_APP_ID=your-app-id
```

## Firebase Setup

1. **Create Firebase Project**
2. **Enable Realtime Database**
3. **Set Database Rules** (for development):
   ```json
   {
     "rules": {
       "users": {
         ".read": true,
         ".write": true
       }
     }
   }
   ```

## Project Structure

```
├── src/
│   ├── app/                 # Next.js app directory
│   │   ├── actions.ts       # Server actions for Firebase
│   │   ├── globals.css      # Global styles
│   │   ├── layout.tsx       # Root layout
│   │   └── page.tsx         # Home page
│   ├── components/
│   │   ├── form/            # Form components
│   │   └── ui/              # Reusable UI components
│   ├── hooks/               # Custom React hooks
│   └── lib/                 # Utilities and Firebase config
├── .github/workflows/       # GitHub Actions
├── public/                  # Static assets
└── package.json
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

MIT License - feel free to use this project for your own purposes!
