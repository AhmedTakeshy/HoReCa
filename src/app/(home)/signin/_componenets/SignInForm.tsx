"use client"

import { zodResolver } from "@hookform/resolvers/zod"
import { useForm } from "react-hook-form"
import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { PiEyeBold, PiEyeClosedBold } from "react-icons/pi";
import { useState } from "react"
import { useRouter } from "next/navigation"
import { toast } from "sonner"
import { SignInFormSchema, signInFormSchema } from "@/lib/formSchemas"
import SubmitButton from "./SubmitButton"
import { signIn } from "@/lib/auth"




export function SignInForm() {

    const [isPending, setIsPending] = useState<boolean>(false)
    const [showPassword, setShowPassword] = useState<boolean>(false);
    const router = useRouter()


    const form = useForm<SignInFormSchema>({
        resolver: zodResolver(signInFormSchema),
        defaultValues: {
            email: "",
            password: "",
        },
    })

    async function signInCredentials(data: SignInFormSchema) {
        setIsPending(true)
        try {
            const result = await signInFormSchema.safeParseAsync(data)
            if (!result.success) {
                toast.error("Error!", {
                    description: "Something went wrong with the form data. Please try again.",
                })
                return
            }
            const values = result.data
            const signInData = await signIn("credentials", {
                redirect: false,
                email: values.email.toLowerCase(),
                password: values.password,
            })
            if (signInData?.status === 200) {
                toast.success(`Welcome back!`, {
                    description: "You have successfully signed in",
                })
                router.replace("/admin")
            } else {
                toast("Oops!", {
                    description: "Please check your email and password and try again.",
                })
            }
        } catch (error) {
            toast("Error!", {
                description: "Something went wrong. Please try again.",
            })
        }
        setIsPending(false)
    }

    return (
        <Form {...form} >
            <div className="w-full p-4 mb-4 space-y-2 border-2 rounded-md max-sm:max-w-xs border-slate-800 dark:border-slate-400">
                <form onSubmit={form.handleSubmit(signInCredentials)} className="">
                    <FormField
                        control={form.control}
                        name="email"
                        render={({ field }) => (
                            <FormItem>
                                <FormLabel>Email</FormLabel>
                                <FormControl>
                                    <Input placeholder="example@email.com" {...field} />
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}
                    />
                    <FormField
                        control={form.control}
                        name="password"
                        render={({ field }) => (
                            <FormItem>
                                <FormLabel>Password</FormLabel>
                                <FormControl>
                                    <div className="relative">
                                        <Input placeholder="*******" {...field} type={`${showPassword ? "text" : "password"}`} />
                                        {showPassword ?
                                            <PiEyeBold
                                                className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`}
                                                onClick={() => setShowPassword(false)} /> :
                                            <PiEyeClosedBold
                                                className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`} onClick={() => setShowPassword(true)} />
                                        }
                                    </div>
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}
                    />
                    <SubmitButton className="mt-4 w-full" text="Login" pending={isPending} />
                </form>
            </div>
        </Form>
    )
}
