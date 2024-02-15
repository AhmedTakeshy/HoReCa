import NextAuth from "next-auth"
import CredentialsProvider from "next-auth/providers/credentials"
import { PrismaAdapter } from "@auth/prisma-adapter"
import { prisma } from "@/lib/prisma"
import bcrypt from "bcryptjs";


export const {
    handlers: { GET, POST },
    auth,
    signIn,
    signOut,
} = NextAuth({
    pages: {
        signIn: '/signin',
    },
    adapter: PrismaAdapter(prisma),
    session: {
        strategy: "jwt",
        maxAge: 24 * 60 * 60,
        updateAge: 60 * 60,
    },
    providers: [
        CredentialsProvider({
            name: 'Credentials',
            credentials: {
                email: { label: "Email", type: "email", placeholder: "example@email.com" },
                password: { label: "Password", type: "password" },
            },
            async authorize(credentials) {
                if (!credentials?.email || !credentials?.password) return null;

                const existingUser = await prisma.user.findUnique({
                    where: {
                        email: credentials.email
                    }
                })
                if (!existingUser) return null;

                const isPasswordValid = await bcrypt.compare(credentials.password as string, existingUser.password)
                if (!isPasswordValid) return null;
                return {
                    id: existingUser.id,
                    publicId: existingUser.publicId,
                    username: existingUser.username,
                    email: existingUser.email,
                    role: existingUser.role,
                }
            }
        }),
    ],

    secret: process.env.NEXTAUTH_SECRET,
    callbacks: {
        async jwt({ token, user, account, profile }) {
            if (user) token.role = user.role
            return token
        },
        async signIn({ user, account, profile, email, credentials }) {
            return true
        },
        async session({ session, token, user }) {
            if (session?.user) session.user.role = token.role
            return session
        },
    }
})