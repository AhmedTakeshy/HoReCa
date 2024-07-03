import SideMenu from './_components/sideMenu'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { redirect } from 'next/navigation'

type ProfileLayoutProps = {
    readonly children: React.ReactNode
}

export default async function ProfileLayout({ children }: ProfileLayoutProps) {
    const session = await getServerSession(authOptions)
    session?.user.name ? null : redirect("/signin")
    return (
        <main className="flex lg:flex-row flex-col">
            <SideMenu name={session?.user.name ?? ""} />
            {children}
        </main>
    )
}
