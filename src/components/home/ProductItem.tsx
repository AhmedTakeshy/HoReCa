import Link from 'next/link';
import React from 'react'
import { BsCart3 } from "react-icons/bs"
import { GoHeartFill } from "react-icons/go";
import crypto from "node:crypto"
import { Button } from '../ui/button';
import Image from 'next/image';
import ActionButton from '../shared/ActionButton';

type Props = {
    data: Product
}

export default function ProductItem({ data }: Props) {
    // const pId = crypto.randomBytes(16).toString("hex").substring(0, 21) // replace it with the real id
    return (
        <div  className="relative max-w-64 bg-slate-50 dark:bg-gray-600 shadow-md rounded-xl p-2 mx-1 my-3">
            <div className="overflow-x-hidden rounded-lg relative">
                <Image  className="h-40 rounded-md w-full object-cover" src={data.thumbnail} alt={`${data.title}-image`} width={332} height={160} />
                <ActionButton  size="icon" className="absolute right-2 top-2 rounded-full p-2 group">
                    <GoHeartFill className="w-6 h-6 group-hover:text-red-600 group-hover:animate-pumping-heart" />
                </ActionButton>
            </div>
            <div className="pl-2 my-4 flex justify-between items-center">
                <div className='pointer-events-none'>
                    <p className="text-lg font-semibold  mb-0">{data.title}</p>
                    <p className="text-md  mt-0">${data.price}</p>
                </div>
                <ActionButton data={data} size="icon" className="flex flex-col-reverse mb-1 mr-4 group">
                    <BsCart3 className="w-6 h-6 group-hover:text-blue-700" />
                </ActionButton>
            </div>
            <Button asChild className="w-full rounded-lg mt-auto hover:bg-blue-700 transition-colors duration-300 ease-in font-semibold py-2 px-4">
            <Link href={`${data.id}`}>
                View details
            </Link>
            </Button>
        </div>
    )
}