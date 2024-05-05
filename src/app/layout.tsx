import type { Metadata } from 'next'
import { Poppins } from 'next/font/google'
import '../styles/globals.css'
import ProviderWrapper from '@/_store/provider'
import { ThemeProvider } from '@/context/ThemeProvider'
import { Toaster } from "@/components/ui/sonner"

const poppins = Poppins({
  subsets: ['latin'],
  weight: ["400", "500", "600", "700", "800", "900"],
})

export const metadata: Metadata = {
  title: 'HoReCa App',
  description: "HoReCa App is a web application for managing restaurants, cafes, and hotels.",
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={`${poppins.className} antialiased flex flex-col min-h-screen`}>
        <ThemeProvider
          attribute="class"
          defaultTheme="system"
          enableSystem
          disableTransitionOnChange
        >
          <ProviderWrapper>
            <Toaster richColors />
            {children}
          </ProviderWrapper>
        </ThemeProvider>
      </body>
    </html>
  )
}
