import { initializeApp, getApps, type FirebaseOptions } from "firebase/app";
import { getDatabase } from "firebase/database";

// Firebase configuration using environment variables from .env.local
const firebaseConfig: FirebaseOptions = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY || "",
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN || "",
  databaseURL: process.env.NEXT_PUBLIC_FIREBASE_DATABASE_URL || "",
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID || "",
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET || "",
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID || "",
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID || "",
};

// Debug: Log configuration status (remove in production)
console.log('Firebase Config Status:', {
  hasApiKey: !!firebaseConfig.apiKey,
  hasDatabaseURL: !!firebaseConfig.databaseURL,
  projectId: firebaseConfig.projectId,
});

// Validate Firebase configuration
if (!firebaseConfig.apiKey || !firebaseConfig.databaseURL) {
  console.error(
    "❌ Firebase config is missing! Please ensure .env.local file exists with all required Firebase credentials."
  );
} else {
  console.log('✅ Firebase configuration loaded successfully!');
}

const app = getApps().length === 0 ? initializeApp(firebaseConfig) : getApps()[0];
const database = getDatabase(app);

export { app, database, firebaseConfig };
