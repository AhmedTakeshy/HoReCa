"use client"

import Image from "next/image"
import { Button } from "../ui/button"
import { FaRegTrashCan } from "react-icons/fa6"
import { useAppDispatch } from "@/_store/hooks"
import { addToCart, removeFromCart } from "@/_store/cartSlice"
import { toast } from "sonner"
import Link from "next/link"
type Props = {
    data: Product
}

export default function SimpleProduct({ data }: Props) {
    const dispatch = useAppDispatch()
    const removeProduct = () => {
        dispatch(removeFromCart(data.id))
        toast(`Removed Item`, {
            description: `${data.title} has been removed from the cart`,
            action: {
                label: "Undo",
                onClick: () => dispatch(addToCart(data)),
            },
        })
    }
    return (
        <div className="grid grid-cols-[1fr,auto] justify-between items-center p-2 dark:hover:text-slate-900 hover:bg-slate-100 rounded-lg">
            <Link href={`${data.category}/products/${data.id}`} className="flex justify-start items-center gap-2 h-14">
                <Image src={`${data.thumbnail}`} width={80} height={72.5} alt="product" className="rounded-md w-20 h-full" />
                <div >
                    <h2 className="text-sm font-medium">
                        {data.title}
                    </h2>
                    <p className="text-sm font-medium text-gray-500 dark:text-inherit">
                        ${data.price}
                    </p>
                </div>
            </Link>
            <div className="flex flex-col justify-between items-center h-full">
            <FaRegTrashCan className="w-5 h-5 hover:text-red-700 hover:cursor-pointer" onClick={removeProduct} />
            <p className="text-sm font-medium text-gray-500 dark:text-inherit">(X{data.quantity})</p>
            </div>
        </div>
    )
}