import { getWishlist } from '@/_actions/wishlistActions'
import { authOptions } from '@/lib/auth'
import { getServerSession } from 'next-auth'
import CategoryItem from '../../_components/CategoryItem'
import PaginationControl from '@/components/PaginationControl'

type Props = {
    searchParams: { [key: string]: string | undefined }
}

export default async function page({ searchParams }: Props) {
    const page = searchParams.page ? parseInt(searchParams.page) : 1
    const session = await getServerSession(authOptions)
    if (!session?.user?.email) {
        return (
            <div className='h-full flex flex-col justify-between'>
                <h1 className='text-2xl font-semibold text-center'>Wishlist</h1>
                <p className='text-center text-rose-600 text-lg'>You need to be logged in to view your wishlist.</p>
            </div>
        )
    }
    const response = await getWishlist({ email: session?.user?.email, page })

    return (
        response.status === "Success" ? (
            <div className='h-full flex flex-col justify-between items-center'>
                <div className="grid lg:grid-cols-4 md:grid-cols-3 sm:grid-cols-2 gap-6">
                    {response.data.wishlist.wishlist_items.map(({ product, wishlist_item }) => {
                        return (
                            <CategoryItem
                                key={wishlist_item.id}
                                data={product}
                                quantity={1}
                                email={session?.user.email}
                                wishlistItems={response.data.wishlist.wishlist_items.map(item => item.wishlist_item)}
                            />
                        )
                    })}
                </div>
                <PaginationControl
                    currentPage={page}
                    metadata={response.data.metadata}
                />
            </div>
        ) : (
            <div className='h-full flex flex-col justify-between'>
                <h1 className='text-2xl font-semibold text-center'>Wishlist</h1>
                <p className='text-center'>{response.errorMessage}</p>
            </div>
        )
    )
}
