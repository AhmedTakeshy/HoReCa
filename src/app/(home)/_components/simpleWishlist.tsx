import Link from 'next/link'
import Image from 'next/image'
import WishlistButton from '@/components/wishlistButton'

type SimpleWishlistProps = {
    wishlistItem: WishlistItem
    email: string
}

export default function SimpleWishlist({ wishlistItem, email }: SimpleWishlistProps) {
    return (
        <div className="grid grid-cols-[1fr,auto] justify-between items-center p-2 dark:hover:text-slate-900 hover:bg-slate-100 rounded-lg ">
            <Link href={`${wishlistItem.product.category}/products/${wishlistItem.product.id}`} className="flex justify-start items-center gap-2 h-14">
                <Image src={`${wishlistItem.product.thumbnail}`} width={80} height={72.5} alt="product" className="rounded-md w-20 h-full" />
                <div >
                    <h2 className="text-sm font-medium">
                        {wishlistItem.product.title}
                    </h2>
                    <p className="text-sm font-medium text-gray-500 dark:text-inherit">
                        ${wishlistItem.product.price.toFixed(2) || wishlistItem.product.price}
                    </p>
                </div>
            </Link>
            <div className="flex flex-col justify-between items-center h-full py-px">
                <WishlistButton
                    productId={wishlistItem.productId}
                    email={email}
                    mode="remove"
                    title={wishlistItem.product.title}
                    className=" p-2 rounded-full mt-2 group"
                />
            </div>
        </div>
    )
}