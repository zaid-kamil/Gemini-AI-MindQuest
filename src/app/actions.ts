'use server';

import { database } from '@/lib/firebase';
import { ref, push, set } from 'firebase/database';
import { z } from 'zod';

const FormSchema = z.object({
  name: z.string(),
  roll: z.string(),
  branch: z.string(),
  college: z.string(),
  email: z.string().email(),
  mobile: z.string(),
});

type ActionResponse = {
  success: boolean;
  error?: string;
};

export async function saveUserData(data: unknown): Promise<ActionResponse> {
  const parsedData = FormSchema.safeParse(data);

  if (!parsedData.success) {
    return { success: false, error: 'Invalid data provided. Please check the form.' };
  }

  try {
    const usersRef = ref(database, 'users');
    const newUserRef = push(usersRef);
    
    // Add timestamp to the data
    const dataWithTimestamp = {
      ...parsedData.data,
      timestamp: Date.now(),
      createdAt: new Date().toISOString(),
    };
    
    await set(newUserRef, dataWithTimestamp);
    return { success: true };
  } catch (error: any) {
    console.error('Firebase Error:', error);
    // In a real app, you might want to log this error to a service
    return { success: false, error: error.message || 'Failed to save data to the database.' };
  }
}
