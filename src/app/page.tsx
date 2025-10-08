import { TabOpenerForm } from '@/components/form/TabOpenerForm';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { ThemeSwitcher } from "@/components/ui/theme-switcher";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-4 sm:p-6 md:p-8 relative">
      <ThemeSwitcher />
      <Card className="w-full max-w-2xl shadow-2xl border-3 bg-card/95 backdrop-blur-sm">
        <CardHeader className="text-center pb-6">
          <CardTitle className="text-4xl md:text-5xl font-headline font-bold bg-gradient-to-r from-purple-400 via-blue-500 to-purple-600 bg-clip-text text-transparent">
            Gemini AI MindQuest
          </CardTitle>
          <CardDescription className="pt-3 text-lg text-muted-foreground">
            Fill in your details below. After submission, several tabs will open automatically.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <TabOpenerForm />
        </CardContent>
      </Card>
    </main>
  );
}
