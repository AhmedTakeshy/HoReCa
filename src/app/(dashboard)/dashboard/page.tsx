import { authOptions } from '@/lib/auth'
import { getServerSession } from 'next-auth'
import { permanentRedirect } from 'next/navigation'

export default async function page() {
    const session = await getServerSession(authOptions)
    if (session?.user.role !== 'ADMIN') {
        permanentRedirect("/")
    }
    return (
        <h1 className='flex justify-center items-center mx-auto text-4xl font-semibold h-screen w-screen'>Dashboard page</h1>
    )
}
