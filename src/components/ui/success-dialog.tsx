"use client";

import { useEffect, useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { CheckCircle2, ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";

interface SuccessDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  userName?: string;
}

export function SuccessDialog({ open, onOpenChange, userName }: SuccessDialogProps) {
  const [countdown, setCountdown] = useState(3);
  const [isOpening, setIsOpening] = useState(false);
  const [tabsOpened, setTabsOpened] = useState(false);

  const openAllTabs = () => {
    const urls = [
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=17',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=16',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=15',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=14',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=13'
    ];

    console.log('Opening tabs:', urls);

    // Open all tabs with a longer delay to avoid popup blocker
    urls.forEach((url, index) => {
      setTimeout(() => {
        try {
          const newWindow = window.open(url, `_blank_tab_${index}`, 'noopener,noreferrer');
          console.log(`Opened tab ${index + 1}: ${url}`, newWindow);
        } catch (error) {
          console.error(`Failed to open tab ${index + 1}: ${url}`, error);
        }
      }, index * 500); // 500ms delay between each tab
    });

    setTabsOpened(true);
  };

  useEffect(() => {
    if (open && countdown > 0) {
      const timer = setTimeout(() => {
        setCountdown(countdown - 1);
      }, 1000);
      return () => clearTimeout(timer);
    } else if (open && countdown === 0 && !isOpening) {
      setIsOpening(true);
      // Auto-open tabs after countdown with delay
      const urls = [
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=17',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=16',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=15',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=14',
      'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=13'

      ];

      console.log('Auto-opening tabs:', urls);

      urls.forEach((url, index) => {
        setTimeout(() => {
          try {
            const newWindow = window.open(url, `_blank_tab_${index}`, 'noopener,noreferrer');
            console.log(`Auto-opened tab ${index + 1}: ${url}`, newWindow);
          } catch (error) {
            console.error(`Failed to auto-open tab ${index + 1}: ${url}`, error);
          }
        }, index * 500); // 500ms delay between each tab
      });

      setTabsOpened(true);
    }
  }, [open, countdown, isOpening]);

  // Reset countdown when dialog opens
  useEffect(() => {
    if (open) {
      setCountdown(3);
      setIsOpening(false);
      setTabsOpened(false);
    }
  }, [open]);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <div className="mx-auto mb-4">
            <div className="relative">
              <CheckCircle2 className="h-16 w-16 text-green-500 animate-bounce" />
              <div className="absolute inset-0 h-16 w-16 text-green-500 opacity-25 animate-ping">
                <CheckCircle2 className="h-16 w-16" />
              </div>
            </div>
          </div>
          <DialogTitle className="text-center text-3xl font-bold bg-gradient-to-r from-purple-400 via-blue-500 to-purple-600 bg-clip-text text-transparent">
            🎉 Success!
          </DialogTitle>
          <DialogDescription className="text-center space-y-4 pt-2">
            {userName && (
              <p className="text-xl font-semibold text-foreground">
                Thank you, <span className="text-primary font-bold">{userName}</span>!
              </p>
            )}
            <p className="text-lg">Your information has been saved to the database.</p>

            {countdown > 0 ? (
              <div className="flex flex-col items-center gap-2 py-6">
                <div className="flex items-center gap-3">
                  <ExternalLink className="h-6 w-6 text-primary animate-pulse" />
                  <p className="text-xl font-bold text-foreground">
                    Opening tabs in {countdown}...
                  </p>
                </div>
                <div className="flex gap-3 mt-3">
                  {[...Array(5)].map((_, i) => (
                    <div
                      key={i}
                      className={`h-3 w-3 rounded-full bg-primary ${
                        countdown <= 3 - i ? 'animate-pulse shadow-lg' : 'opacity-40'
                      }`}
                    />
                  ))}
                </div>
              </div>
            ) : (
              <div className="py-6">
                <p className="text-xl font-bold text-green-500 flex items-center justify-center gap-3">
                  <CheckCircle2 className="h-6 w-6" />
                  {tabsOpened ? "Tabs Opened Successfully!" : "Attempting to Open Tabs..."}
                </p>
                <p className="text-base text-muted-foreground mt-3">
                  Opening: Google, GitHub, LinkedIn, Facebook, Twitter
                </p>
                {!tabsOpened && (
                  <div className="mt-6 p-4 bg-yellow-50 border-2 border-yellow-200 rounded-lg">
                    <p className="text-base text-yellow-800 mb-3 font-medium">
                      If tabs didn't open automatically, it might be due to your browser's popup blocker.
                    </p>
                    <p className="text-sm text-yellow-700 mb-4">
                      Try allowing popups for this site or click the button below:
                    </p>
                    <Button
                      onClick={openAllTabs}
                      className="w-full h-12 text-lg font-semibold bg-gradient-to-r from-purple-500 to-blue-600 hover:from-purple-600 hover:to-blue-700"
                      size="sm"
                    >
                      <ExternalLink className="h-5 w-5 mr-3" />
                      Open All Tabs Manually
                    </Button>
                  </div>
                )}
              </div>
            )}
          </DialogDescription>
        </DialogHeader>
        <div className="flex justify-center pt-2">
          <Button
            onClick={() => onOpenChange(false)}
            className="w-full h-12 text-lg font-semibold"
            variant={countdown === 0 ? "default" : "outline"}
          >
            {countdown === 0 ? "Done" : "Close"}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
