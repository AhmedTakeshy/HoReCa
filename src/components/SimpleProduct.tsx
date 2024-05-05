"use client"
import Image from "next/image"
import { FaRegTrashCan } from "react-icons/fa6"
import Link from "next/link"
import ActionButton from "./ActionButton"

type Props = {
    data: CartProduct
}

export default function SimpleProduct({ data }: Props) {

    return (
        <div className="grid grid-cols-[1fr,auto] justify-between items-center p-2 dark:hover:text-slate-900 hover:bg-slate-100 rounded-lg group">
            <Link href={`${data.product.category}/products/${data.product.id}`} className="flex justify-start items-center gap-2 h-14">
                <Image src={`${data.product.thumbnail}`} width={80} height={72.5} alt="product" className="rounded-md w-20 h-full" />
                <div >
                    <h2 className="text-sm font-medium">
                        {data.product.title}
                    </h2>
                    <p className="text-sm font-medium text-gray-500 dark:text-inherit">
                        ${data.product.price.toFixed(2) || data.product.price}
                    </p>
                </div>
            </Link>
            <div className="flex flex-col justify-between items-center h-full py-px ">
                <ActionButton action="remove" data={data.product} quantity={data.quantity} size={"icon"} asChild >
                    <FaRegTrashCan className="!w-5 !h-5 hover:!text-red-700 hover:cursor-pointer shadow-none bg-transparent hover:bg-transparent text-slate-800 dark:text-slate-500" />
                </ActionButton>
                <p className="text-sm font-medium text-gray-500 dark:text-inherit">(X{data.quantity})</p>
            </div>
        </div>
    )
}