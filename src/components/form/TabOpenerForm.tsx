"use client";

import { useState, useTransition } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";
import { saveUserData } from "@/app/actions";
import { Loader2, User, Hash, GitBranch, School, Mail, Phone } from "lucide-react";
import { SuccessDialog } from "@/components/ui/success-dialog";

const formSchema = z.object({
  name: z.string().min(2, { message: "Name must be at least 2 characters." }),
  roll: z.string().min(1, { message: "Roll number is required." }),
  branch: z.string().min(2, { message: "Branch is required." }),
  college: z.string().min(3, { message: "College/University is required." }),
  email: z.string().email({ message: "Please enter a valid email." }),
  mobile: z.string().min(10, { message: "Mobile number must be at least 10 digits." }).regex(/^\+?[0-9\s-()]+$/, "Invalid phone number format."),
});

export function TabOpenerForm() {
  const [isPending, startTransition] = useTransition();
  const [showSuccessDialog, setShowSuccessDialog] = useState(false);
  const [submittedName, setSubmittedName] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      name: "",
      roll: "",
      branch: "",
      college: "",
      email: "",
      mobile: "",
    },
  });

  function onSubmit(values: z.infer<typeof formSchema>) {
    startTransition(async () => {
      const result = await saveUserData(values);
      if (result.success) {
        // Store the name for the dialog
        setSubmittedName(values.name);
        // Show the cool success dialog
        setShowSuccessDialog(true);
        // Reset form
        form.reset();
      } else {
        toast({
          variant: "destructive",
          title: "❌ Uh oh! Something went wrong.",
          description: result.error || "There was a problem with your request.",
        });
      }
    });
  }

  return (
    <>
      <SuccessDialog 
        open={showSuccessDialog} 
        onOpenChange={setShowSuccessDialog}
        userName={submittedName}
      />
      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          <FormField
            control={form.control}
            name="name"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-lg font-semibold">Name</FormLabel>
                <div className="relative">
                  <User className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-primary" />
                  <FormControl>
                    <Input placeholder="John Doe" {...field} className="pl-12 h-12 text-lg border-2" />
                  </FormControl>
                </div>
                <FormMessage className="text-sm font-medium" />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="roll"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-lg font-semibold">Roll Number</FormLabel>
                 <div className="relative">
                  <Hash className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-primary" />
                  <FormControl>
                    <Input placeholder="e.g., 21CS001" {...field} className="pl-12 h-12 text-lg border-2"/>
                  </FormControl>
                </div>
                <FormMessage className="text-sm font-medium" />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="branch"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-lg font-semibold">Branch</FormLabel>
                 <div className="relative">
                  <GitBranch className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-primary" />
                  <FormControl>
                    <Input placeholder="Computer Science" {...field} className="pl-12 h-12 text-lg border-2"/>
                  </FormControl>
                </div>
                <FormMessage className="text-sm font-medium" />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="college"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-lg font-semibold">College / University</FormLabel>
                 <div className="relative">
                  <School className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-primary" />
                  <FormControl>
                    <Input placeholder="University of Technology" {...field} className="pl-12 h-12 text-lg border-2"/>
                  </FormControl>
                </div>
                <FormMessage className="text-sm font-medium" />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="email"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-lg font-semibold">Email ID</FormLabel>
                 <div className="relative">
                  <Mail className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-primary" />
                  <FormControl>
                    <Input type="email" placeholder="you@example.com" {...field} className="pl-12 h-12 text-lg border-2" />
                  </FormControl>
                </div>
                <FormMessage className="text-sm font-medium" />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="mobile"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-lg font-semibold">Mobile Number</FormLabel>
                <div className="relative">
                  <Phone className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-primary" />
                  <FormControl>
                    <Input type="tel" placeholder="+1 (555) 123-4567" {...field} className="pl-12 h-12 text-lg border-2" />
                  </FormControl>
                </div>
                <FormMessage className="text-sm font-medium" />
              </FormItem>
            )}
          />
        </div>
        <Button type="submit" className="w-full h-14 text-xl font-bold bg-gradient-to-r from-purple-500 to-blue-600 hover:from-purple-600 hover:to-blue-700 shadow-lg hover:shadow-xl transition-all duration-300 border-0" disabled={isPending}>
          {isPending ? (
            <>
              <Loader2 className="mr-3 h-6 w-6 animate-spin" />
              Submitting...
            </>
          ) : (
            "Submit and Open Tabs"
          )}
        </Button>
      </form>
    </Form>
    </>
  );
}
