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
import { toast } from "sonner"
import { SignUpFormSchema, signUpFormSchema } from "@/lib/formSchemas"
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select"
import SubmitButton from "./SubmitButton"
import { signUpAction } from "@/_actions/userActions"
import { LuUserPlus } from "react-icons/lu"
import { useRouter } from "next/navigation"

export function SignUpForm() {

    const [isPending, setIsPending] = useState<boolean>(false)
    const [open, setOpen] = useState<boolean>(false)
    const [showPassword, setShowPassword] = useState<{
        password: boolean,
        confirmPassword: boolean
    }>
        ({
            password: false,
            confirmPassword: false,
        })
    const router = useRouter()
    const form = useForm<SignUpFormSchema>({
        resolver: zodResolver(signUpFormSchema),
        defaultValues: {
            username: "",
            email: "",
            password: "",
            confirmPassword: "",
            role: "USER",
        },
    })

    async function signUp(data: SignUpFormSchema) {
        setIsPending(true)
        try {
            const result = await signUpFormSchema.safeParseAsync(data)
            if (!result.success) {
                toast("Error!", {
                    description: "Something went wrong with the form data. Please try again.",
                })
                return
            }

            const res = await signUpAction(result.data)

            if (!res?.error && res?.status === 201) {
                toast.success("Successfully!", {
                    description: res?.message,
                })
                form.reset()
                router.replace("/admin/accounts/")
                setOpen(false)
            } else {
                toast.error("Oops!", {
                    description: res?.message,
                })
            }
        } catch (error) {
            toast.error("Error!", {
                description: "Something went wrong. Please try again.",
            })
        }
        setIsPending(false)
    }
    return (
        <Form {...form} >
            <div className='w-full max-w-screen-md border-2 rounded-xl'>
                <div className="flex flex-col justify-start p-4 space-y-4 rounded-md shadow-lg ">
                    <form
                        onSubmit={form.handleSubmit(signUp)}
                        className="space-y-3"
                    >
                        <FormField
                            control={form.control}
                            name="username"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>أسم المستخدم</FormLabel>
                                    <FormControl>
                                        <Input type="text" placeholder="محمد احمد" {...field} />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="email"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>البريد الالكتروني</FormLabel>
                                    <FormControl>
                                        <Input type="email" placeholder="example@email.com" {...field} />
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
                                    <FormLabel>كلمة السر</FormLabel>
                                    <FormControl>
                                        <div className="relative">
                                            <Input placeholder="*******" {...field} type={`${showPassword.password ? "text" : "password"}`} />
                                            {showPassword.password ?
                                                <PiEyeBold
                                                    className={`hover:cursor-pointer absolute left-[10%] bottom-[28%]`}
                                                    onClick={() => setShowPassword(prevState => ({ ...prevState, password: false }))} /> :
                                                <PiEyeClosedBold
                                                    className={`hover:cursor-pointer absolute left-[10%] bottom-[28%]`} onClick={() => setShowPassword(prevState => ({ ...prevState, password: true }))} />
                                            }
                                        </div>
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="confirmPassword"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>تاكيد كلمة السر</FormLabel>
                                    <FormControl>
                                        <div className="relative">
                                            <Input placeholder="*******" {...field} type={`${showPassword.confirmPassword ? "text" : "password"}`} />
                                            {showPassword.confirmPassword ?
                                                <PiEyeBold
                                                    className={`hover:cursor-pointer absolute left-[10%] bottom-[28%]`}
                                                    onClick={() => setShowPassword(prevState => ({ ...prevState, confirmPassword: false }))} /> :
                                                <PiEyeClosedBold
                                                    className={`hover:cursor-pointer absolute left-[10%] bottom-[28%]`} onClick={() => setShowPassword(prevState => ({ ...prevState, confirmPassword: true }))} />}
                                        </div>
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="role"
                            render={({ field }) => (
                                <FormItem className="!mt-4">
                                    <FormControl>
                                        <Select {...field} onValueChange={field.onChange} value={field.value}>
                                            <SelectTrigger className="w-[180px]">
                                                <SelectValue placeholder="الصلاحيات" />
                                            </SelectTrigger>
                                            <SelectContent>
                                                <SelectItem value="Admin">جزئي الصلاحيات</SelectItem>
                                                <SelectItem value="SuperAdmin">كامل الصلاحيات</SelectItem>
                                            </SelectContent>
                                        </Select>
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                        <SubmitButton pending={isPending} text="إنشاء حساب" />
                    </form>
                </div>
            </div>
        </Form>
    )
}
