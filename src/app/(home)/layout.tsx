import AuthProvider from "@/context/AuthProvider"
import NavMenu from "./_components/NavMenu"
import ScrollButton from "@/components/ScrollButton"
import Footer from "./_components/footer"

export default function MainLayout({
    children,
    auth,
}: {
    children: React.ReactNode
    auth: React.ReactNode
}) {

    return (
        <>
            <AuthProvider>
                <NavMenu />
                {children}
                {auth}
                <ScrollButton />
                <Footer />
            </AuthProvider>
        </>
    )
}