import AuthProvider from "@/context/AuthProvider"
import NavMenu from "./_components/NavMenu"
import ScrollButton from "@/components/ScrollButton"

export default function MainLayout({
    children,
}: {
    children: React.ReactNode
}) {

    return (
        <>
            <AuthProvider>
                <NavMenu />
                {children}
                <ScrollButton />
            </AuthProvider>
        </>
    )
}