import NavMenu from "@/components/home/NavMenu"
import ScrollButton from "@/components/shared/ScrollButton"

export default function MainLayout({
    children,
}: {
    children: React.ReactNode
}) {
    return (
        <>
            <NavMenu />
            {children}
            <ScrollButton />
        </>
    )
}