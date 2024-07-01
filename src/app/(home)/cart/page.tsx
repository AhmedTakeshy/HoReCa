import React from 'react'
import Cart from './_components/cart'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { getCartFromDatabase } from '@/_actions/cartActions'

export default async function page() {
    const session = await getServerSession(authOptions)
    const cartResponse = session?.user.email ? await getCartFromDatabase(session.user.email) : undefined

    return (
        <div className='flex flex-col gap-4'>
            <h1 className="mb-10 text-center text-2xl font-semibold tracking-widest">Cart Items</h1>
            <Cart cartDb={cartResponse?.status === "Success" ? cartResponse.data : undefined} user={session?.user} />
        </div>
    )
}
