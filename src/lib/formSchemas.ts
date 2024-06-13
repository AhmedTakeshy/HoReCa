import * as z from "zod";


export const signInFormSchema = z.object({
    email: z.string().trim().email({
        message: "Please enter a valid email address",
    }),
    password: z.string().trim().min(8, {
        message: "Password must be at least 8 characters",
    })
})

export const signUpFormSchema = z.object({
    username: z.string().min(3, {
        message: "Username must be at least 3 characters",
    }),
    email: z.string().email({
        message: "Please enter a valid email address",
    }),
    role: z.enum(["USER", "ADMIN"]),
    password: z.string().min(8, {
        message: "Password must be at least 8 characters",
    }),
    confirmPassword: z.string().min(8, {
        message: "Password must be at least 8 characters",
    })
}).refine((data) => data.password === data.confirmPassword, {
    path: ["confirmPassword"],
    message: "Passwords do not match",
})

export const userUpdateSchema = z.object({
    username: z.string().min(3, { message: "Username must be at least 3 characters" }).optional(),
    email: z.string().email({ message: "Please enter a valid email address" }).optional(),
})

export const passwordSchema = z.object({
    email: z.string().email({ message: "Please enter a valid email address" }),
    currentPassword: z.string().min(8, { message: "Password must be at least 8 characters." }),
    newPassword: z.string().min(8, { message: "Password must be at least 8 characters." }),
    confirmPassword: z.string().min(8, { message: "Password must be at least 8 characters." }),
}).refine((data) => data.newPassword === data.confirmPassword, {
    path: ["confirmPassword"],
    message: "Passwords do not match",
})


export type SignInFormSchema = z.infer<typeof signInFormSchema>
export type SignUpFormSchema = z.infer<typeof signUpFormSchema>
export type UserUpdateSchema = z.infer<typeof userUpdateSchema>
export type PasswordSchema = z.infer<typeof passwordSchema>