import SideMenu from './_components/sideMenu'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

type ProfileLayoutProps = {
    readonly children: React.ReactNode
}

export default async function ProfileLayout({ children }: ProfileLayoutProps) {
    const session = await getServerSession(authOptions)
    return (
        <main className="flex lg:flex-row flex-col">
            <SideMenu name={session?.user.name ?? ""} />
            {children}
        </main>
    )
}
