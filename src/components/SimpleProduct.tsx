"use client"
import Image from "next/image"
import { TbCirclePlus } from "react-icons/tb";
import { TbCircleMinus } from "react-icons/tb";
import Link from "next/link"
import ActionButton from "./ActionButton"

type Props = {
    data: CartProduct
}

export default function SimpleProduct({ data }: Props) {

    return (
        <div className="grid grid-cols-[1fr,auto] justify-between items-center p-2 dark:hover:text-slate-900 hover:bg-slate-200 rounded-lg group">
            <Link href={`${data.product.category}/products/${data.product.id}`} className="flex justify-start items-center gap-2 h-14">
                <Image src={`${data.product.thumbnail}`} width={80} height={72.5} alt="product" className="rounded-md w-20 h-full" />
                <h2 className="text-sm font-medium">
                    {data.product.title.split(/[\s-]+/).slice(0, 2).join(" ")}
                </h2>
            </Link>
            <div className="flex flex-col justify-start gap-y-1">
                <div className="flex justify-end items-center h-full py-px">
                    <ActionButton
                        action="remove"
                        data={data.product}
                        quantity={1}
                        size={"icon"}
                        className="dark:text-slate-300 text-slate-800 group-hover:text-slate-800 flex items-center justify-center !bg-transparent shadow-none">
                        <TbCircleMinus className="w-6 h-6 hover:text-rose-300" />
                    </ActionButton>
                    <input
                        readOnly
                        type="text"
                        className="border border-gray-200 rounded-full w-6 h-6 p-1.5 aspect-square outline-none placeholder:text-gray-700 font-semibold text-sm bg-gray-100  text-center"
                        placeholder={`${data.quantity.toString()}`}
                    />
                    <ActionButton
                        action="add"
                        data={data.product}
                        quantity={1}
                        size={"icon"}
                        className="dark:text-slate-300 text-slate-800 group-hover:text-slate-800 flex items-center justify-center !bg-transparent shadow-none">
                        <TbCirclePlus className="w-6 h-6 hover:text-green-400" />
                    </ActionButton>
                </div>
                <p className="text-sm font-medium dark:group-hover:text-slate-800 dark:text-inherit mr-1.5 text-right">
                    ${data.product.price.toFixed(2) || data.product.price}
                </p>
            </div>
        </div>
    )
}