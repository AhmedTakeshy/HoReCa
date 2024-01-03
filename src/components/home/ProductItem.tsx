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
        <div  className="relative flex flex-col justify-between p-2 mx-1 my-3 shadow-md max-w-64 bg-slate-50 dark:bg-gray-600 rounded-xl">
            <div className="relative overflow-x-hidden rounded-lg">
                <Image  className="object-cover w-full h-40 rounded-md" src={data.thumbnail} alt={`${data.title}-image`} width={332} height={160} />
                <ActionButton  size="icon" className="absolute p-2 rounded-full right-2 top-2 group">
                    <GoHeartFill className="w-6 h-6 group-hover:text-red-600 group-hover:animate-pumping-heart" />
                </ActionButton>
            </div>
            <div className="flex items-center justify-between pl-2 my-4 min-w-60">
                <div className='pointer-events-none'>
                    <p className="mb-0 text-lg font-semibold">{data.title}</p>
                    <p className="mt-0 text-md">${data.price}</p>
                </div>
                <ActionButton data={data} size="icon" className="flex flex-col-reverse mb-1 mr-4 group">
                    <BsCart3 className="w-6 h-6 group-hover:text-blue-700" />
                </ActionButton>
            </div>
            <Button asChild className="w-full px-4 py-2 mt-auto font-semibold transition-colors duration-300 ease-in rounded-lg hover:bg-blue-400">
            <Link href={`/${data.id}`}>
                View details
            </Link>
            </Button>
        </div>
    )
}