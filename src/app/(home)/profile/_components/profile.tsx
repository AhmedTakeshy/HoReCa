"use client"
import { PasswordSchema, UserUpdateSchema, passwordSchema, userUpdateSchema } from '@/lib/formSchemas'
import Link from 'next/link'
import { useSearchParams, useRouter } from 'next/navigation'
import { useState } from 'react'
import { useForm } from 'react-hook-form'
import { zodResolver } from "@hookform/resolvers/zod"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage, } from "@/components/ui/form"
import { PiEyeBold, PiEyeClosedBold } from "react-icons/pi";
import { toast } from "sonner"
import SubmitButton from "@/components/SubmitButton"
import { updatePassword, updateUser } from '@/_actions/userActions'
import { signOut, useSession } from 'next-auth/react'

export default function Profile() {
    const searchParams = useSearchParams()
    const type = searchParams.get('type')
    const { data: session } = useSession()
    const router = useRouter()
    const [isPending, setIsPending] = useState<{ user: boolean, password: boolean }>({ user: false, password: false })
    const [showPassword, setShowPassword] = useState<{ currentPassword: boolean, newPassword: boolean, confirmPassword: boolean }>({
        currentPassword: false,
        newPassword: false,
        confirmPassword: false
    });


    const userForm = useForm<UserUpdateSchema>({
        resolver: zodResolver(userUpdateSchema),
        defaultValues: {
            username: "",
            email: session?.user.email ?? "",
            newEmail: "",
        },
    })

    const passwordForm = useForm<PasswordSchema>({
        resolver: zodResolver(passwordSchema),
        defaultValues: {
            email: session?.user.email ?? "",
            currentPassword: "",
            newPassword: "",
            confirmPassword: "",
        },
    })

    async function handleUserUpdate(data: UserUpdateSchema) {
        setIsPending(prev => ({ ...prev, user: true }))
        try {
            const result = await userUpdateSchema.safeParseAsync(data)
            if (!result.success) {
                toast.error("Error!", {
                    description: "Something went wrong with the form data. Please try again.",
                })
                return
            }
            const { username, email, newEmail } = result.data
            const response = await updateUser({ username, email, newEmail })
            if (response.status === 200) {
                toast.success("Success!", {
                    description: "User information updated successfully.",
                })
                toast.info("Please sign in again to see the changes.")
                userForm.reset()
                signOut({ callbackUrl: "/signin" })
            } else {
                toast.error("Error!", {
                    description: response.message,
                })
            }
        } catch (error) {
            toast.error("Error!", {
                description: "Something went wrong. Please try again.",
            })
        }
        setIsPending(prev => ({ ...prev, user: false }))
    }

    async function handlePasswordUpdate(data: PasswordSchema) {
        setIsPending(prev => ({ ...prev, password: true }))
        try {
            const result = await passwordSchema.safeParseAsync(data)
            if (!result.success) {
                toast.error("Error!", {
                    description: "Something went wrong with the form data. Please try again.",
                })
                return
            }
            const { currentPassword, newPassword, confirmPassword, email } = result.data
            const response = await updatePassword({ currentPassword, newPassword, confirmPassword, email })
            if (response.status === 200) {
                toast.success("Success!", {
                    description: "Password updated successfully.",
                })
                passwordForm.reset()
                router.refresh()
            } else {
                toast.error("Error!", {
                    description: response.message,
                })
            }
        } catch (error) {
            toast.error("Error!", {
                description: "Something went wrong. Please try again.",
            })
        }
        setIsPending(prev => ({ ...prev, password: false }))
    }


    return (
        <div className="flex flex-col w-11/12 md:w-5/6 mb-4 items-start container">
            <h1 className="mt-2 mb-10 text-2xl md:text-3xl font-extrabold">My user information</h1>
            <ul className="flex flex-col md:flex-row items-baseline md:justify-start justify-center w-full gap-4 mb-8 md:border-b">
                <li className="flex flex-col items-center hover:cursor-pointer">
                    <Link href={{ query: { type: "membership" } }} className={`${type === "membership" ? "font-bold md:pb-[10px] md:border-none border-2 dark:border-white rounded-full px-4 md:px-0 py-2 text-center md:text-left transition-all duration-300 md:transition-none" : ""}`}>My membership information</Link>
                    {type === "membership" && (<hr className="w-32 hidden md:inline-block border-primary rounded-br-md rounded-tl-md border-b-[3px]" />)}
                </li>
                <li className="flex flex-col items-center hover:cursor-pointer">
                    <Link href={{ query: { type: "password" } }} className={`${type === "password" ? "font-bold md:pb-[10px] md:border-none border-2 dark:border-white rounded-full px-4 md:px-0 py-2 text-center md:text-left transition-all duration-300 md:transition-none" : ""}`}>Password change</Link>
                    {type === "password" && (<hr className="w-32 hidden md:inline-block border-primary rounded-br-md rounded-tl-md border-b-[3px]" />)}
                </li>
                <li className="flex flex-col items-center hover:cursor-pointer">
                    <Link href={{ query: { type: "communication" } }} className={`${type === "communication" ? "font-bold md:pb-[10px] md:border-none border-2 dark:border-white rounded-full px-4 md:px-0 py-2 text-center md:text-left transition-all duration-300 md:transition-none" : ""}`}>My communication preference</Link>
                    {type === "communication" && (<hr className="w-32 hidden md:inline-block border-primary rounded-br-md rounded-tl-md border-b-[3px]" />)}
                </li>
            </ul>
            {type === "membership" && (
                <div className="flex flex-col space-y-8 justify-center w-full md:space-y-16 max-w-[40rem] mx-auto">
                    <article className="w-full my-8 text-left">
                        <h2 className="mb-3 font-bold">Information Profile</h2>
                        <p>You can edit the information you need here so that we can keep your experience at HoReCa at the
                            best level.</p>
                    </article>
                    <Form {...userForm}>
                        <form
                            onSubmit={userForm.handleSubmit(handleUserUpdate)}
                            className="grid grid-cols-1 gap-4 mb-6">
                            <div className="mb-6">
                                <FormField
                                    control={userForm.control}
                                    name="username"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel htmlFor='username' className="block w-full mb-2 text-sm font-bold ">Name</FormLabel>
                                            <FormControl>
                                                <input

                                                    className="w-full h-12 px-4 py-2 transition-colors duration-300 bg-transparent border-2 rounded-lg focus:border-primary focus:outline-none"
                                                    id="username"
                                                    {...field}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <div className=" mb-6">
                                <FormField
                                    control={userForm.control}
                                    name="newEmail"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel htmlFor='newEmail' className="block w-full mb-2 text-sm font-bold ">New email</FormLabel>
                                            <FormControl>
                                                <input
                                                    className="w-full h-12 px-4 py-2 transition-colors duration-300 bg-transparent border-2 rounded-lg focus:border-primary focus:outline-none"
                                                    id="newEmail"
                                                    {...field}
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <SubmitButton
                                pending={isPending.user}
                                text='Update'
                                className="w-full p-4 rounded-md disabled:bg-slate-500 bg-primary disabled:cursor-not-allowed" />
                        </form>
                    </Form>
                </div>
            )}
            {type === "password" && (
                <div className="flex flex-col justify-center w-full space-y-8 md:space-y-16 max-w-[40rem] mx-auto">
                    <article className="w-full my-8 text-left">
                        <h2 className="mb-3 font-bold">Password change</h2>
                        <p>You can edit the information you need here so that we can keep your experience at HoReCa at the
                            best level.</p>
                    </article>
                    <Form {...passwordForm}>
                        <form
                            onSubmit={passwordForm.handleSubmit(handlePasswordUpdate)}
                            className="grid gap-4 mb-6">
                            <div className="mb-6">
                                <FormField
                                    control={passwordForm.control}
                                    name="currentPassword"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel htmlFor='currentPassword' className="block w-full mb-2 text-sm font-bold ">Current password</FormLabel>
                                            <FormControl>
                                                <div className="relative">
                                                    <input
                                                        className="w-full h-12 px-4 py-2 transition-colors duration-300 bg-transparent border-2 rounded-lg focus:border-primary focus:outline-none"
                                                        id="currentPassword"
                                                        {...field}
                                                        type={`${showPassword.currentPassword ? "text" : "password"}`} />
                                                    {showPassword.currentPassword ?
                                                        <PiEyeBold
                                                            className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`}
                                                            onClick={() => setShowPassword(prev => ({ ...prev, currentPassword: false }))} /> :
                                                        <PiEyeClosedBold
                                                            className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`}
                                                            onClick={() => setShowPassword(prev => ({ ...prev, currentPassword: true }))} />
                                                    }
                                                </div>
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <div className="mb-6">
                                <FormField
                                    control={passwordForm.control}
                                    name="newPassword"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel htmlFor='newPassword' className="block w-full mb-2 text-sm font-bold ">New password</FormLabel>
                                            <FormControl>
                                                <div className="relative">
                                                    <input
                                                        className="w-full h-12 px-4 py-2 transition-colors duration-300 bg-transparent border-2 rounded-lg focus:border-primary focus:outline-none"
                                                        id="newPassword"
                                                        {...field}
                                                        type={`${showPassword.newPassword ? "text" : "password"}`} />
                                                    {showPassword.newPassword ?
                                                        <PiEyeBold
                                                            className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`}
                                                            onClick={() => setShowPassword(prev => ({ ...prev, newPassword: false }))} /> :
                                                        <PiEyeClosedBold
                                                            className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`}
                                                            onClick={() => setShowPassword(prev => ({ ...prev, newPassword: true }))} />
                                                    }
                                                </div>
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <div className="sm:col-span-2 mb-6">
                                <FormField
                                    control={passwordForm.control}
                                    name="confirmPassword"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel htmlFor='confirmPassword' className="block w-full mb-2 text-sm font-bold ">Confirm password</FormLabel>
                                            <FormControl>
                                                <div className="relative">
                                                    <input
                                                        className="w-full h-12 px-4 py-2 transition-colors duration-300 bg-transparent border-2 rounded-lg focus:border-primary focus:outline-none"
                                                        id="confirmPassword"
                                                        {...field}
                                                        type={`${showPassword.confirmPassword ? "text" : "password"}`} />
                                                    {showPassword.confirmPassword ?
                                                        <PiEyeBold
                                                            className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`}
                                                            onClick={() => setShowPassword(prev => ({ ...prev, confirmPassword: false }))} /> :
                                                        <PiEyeClosedBold
                                                            className={`hover:cursor-pointer absolute right-[10%] bottom-[28%]`}
                                                            onClick={() => setShowPassword(prev => ({ ...prev, confirmPassword: true }))} />
                                                    }
                                                </div>
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <SubmitButton
                                pending={isPending.password}
                                text='Update'
                                className="w-full sm:grid-cols-2 p-4 rounded-md disabled:bg-slate-500 bg-primary disabled:cursor-not-allowed" />
                        </form>
                    </Form>
                </div>
            )}
            {type === "communication" && (
                <div className="flex flex-col justify-center w-full space-y-16 max-w-[40rem] mx-auto">
                    <article className="w-full my-8 text-left">
                        <h2 className="mb-3 font-bold">Communication preference</h2>
                        <p>You can edit the information you need here so that we can keep your experience at HoReCa at the
                            best level.
                        </p>
                        <h3 className="text-2xl font-bold mt-12">
                            Coming soon.
                        </h3>
                    </article>
                </div>
            )}
        </div>
    )
}
