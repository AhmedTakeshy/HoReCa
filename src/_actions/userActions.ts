"use server"

import { PasswordSchema, SignUpFormSchema, UserUpdateSchema, passwordSchema, signUpFormSchema, userUpdateSchema } from "@/lib/formSchemas";
import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";
import bcrypt, { hash } from "bcryptjs";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";

export async function signUpAction(values: SignUpFormSchema) {
    try {
        const result = await signUpFormSchema.safeParseAsync(values)
        if (!result.success) {
            return { error: true, message: "Something wrong with entered data.", status: 401 }
        }
        const { username, email, password, role } = result.data
        const existedUserEmail = await prisma.user.findUnique({
            where: {
                email,
            }
        })
        if (existedUserEmail) {
            return { error: true, message: "There is a user already with this email!", status: 409 }
        }
        const hashedPassword = await hash(password, 10)
        if (!existedUserEmail) {
            const user = await prisma.user.create({
                data: {
                    username,
                    email: email.toLowerCase(),
                    password: hashedPassword,
                    role,
                }
            })
            const { email: userEmail } = user
            revalidatePath("/signin")
            return { error: false, message: `User has been created successfully with this email ${userEmail}`, status: 201 }
        }
    } catch (error) {
        console.log(error);
        return { error: true, message: "Something went wrong!", status: 401 }
    }
}


export async function updateUser(values: UserUpdateSchema) {
    try {
        const result = await userUpdateSchema.safeParseAsync(values)
        if (!result.success) {
            return { error: true, message: "Something wrong with entered data!", status: 401 }
        }
        const { username, email, newEmail } = result.data

        if (newEmail) {
            const existedUserEmail = await prisma.user.findUnique({
                where: {
                    email: newEmail,
                }
            })
            if (existedUserEmail) {
                return { error: true, message: "There is a user already with this email!", status: 409 }
            }
        }
        const res = await prisma.user.update({
            where: {
                email,
            },
            data: {
                username,
                email: newEmail,
            }
        })
        revalidatePath("/profile")
        return { error: false, message: `User has been updated successfully.`, status: 200 }
    } catch (error) {
        console.log(error);
        return { error: true, message: "Something went wrong!", status: 401 }
    }
}

export async function updatePassword(values: PasswordSchema) {
    try {
        const result = await passwordSchema.safeParseAsync(values)
        if (!result.success) {
            return { error: true, message: "Something wrong with entered data!", status: 401 }
        }
        const { currentPassword, newPassword, email } = result.data
        const user = await prisma.user.findUnique({
            where: {
                email
            }
        })
        const isMatch = await bcrypt.compare(currentPassword, user?.password!)
        if (!isMatch) {
            return { error: true, message: "Current password is not correct!", status: 401 }
        }
        const hashedPassword = await hash(newPassword, 10)
        await prisma.user.update({
            where: {
                email
            },
            data: {
                password: hashedPassword
            }
        })
        revalidatePath("/profile")
        return { error: false, message: "Password has been updated successfully.", status: 200 }
    } catch (error) {
        console.log(error);
        return { error: true, message: "Something went wrong!", status: 401 }
    }
}