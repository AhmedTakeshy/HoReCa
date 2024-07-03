"use client"
import ActionButton from '@/components/ActionButton'
import Link from 'next/link'
import React, { useState } from 'react'
import Carousel from './Carousel'

type ProductDetailsProps = {
    product: Product
}

export default function ProductDetails({ product }: ProductDetailsProps) {
    const [quantity, setQuantity] = useState<number>(1)


    const handleQuantityChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
        setQuantity(Number(e.target.value))
    }

    return (
        <div className="flex flex-col md:flex-row container my-12 gap-8">
            <div className='md:flex-1 px-4'>
                <Carousel images={product.images} />
            </div>
            <div className="md:flex-1 px-4">
                <h2 className="mb-2 leading-tight tracking-tight font-bold text-gray-800 text-2xl md:text-3xl">{product.title}</h2>
                <p className="text-gray-500 text-sm">
                    By
                    <Link href={`https://www.google.com/search?q=${product.brand}`} className="text-indigo-600 hover:underline">
                        {product.brand}
                    </Link>
                </p>
                <div className="flex items-center space-x-4 my-4">
                    <div>
                        <div className="rounded-lg bg-gray-100 flex py-2 px-3">
                            <span className="text-indigo-400 mr-1 mt-1">$</span>
                            <span className="font-bold text-indigo-600 text-3xl">{product.price.toFixed(2)}</span>
                        </div>
                    </div>
                    <div className="flex-1">
                        <p className="text-green-500 text-xl font-semibold">Save 12%</p>
                        <p className="text-gray-400 text-sm">Inclusive of all Taxes.</p>
                    </div>
                </div>
                <p className="text-gray-500">{product.description}</p>
                <div className="flex py-4 space-x-4">
                    <div className="relative">
                        <div className="text-center left-0 pt-2 right-0 absolute block text-xs uppercase text-gray-400 tracking-wide font-semibold">Qty</div>
                        <select onChange={handleQuantityChange} className="cursor-pointer appearance-none rounded-xl border border-gray-200 pl-4 pr-8 h-14 flex items-end pb-1">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </select>
                        <svg className="w-5 h-5 text-gray-400 absolute right-0 bottom-0 mb-2 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M8 9l4-4 4 4m0 6l-4 4-4-4" />
                        </svg>
                    </div>
                    <ActionButton action='add' data={product} quantity={quantity} type="button" className="h-14 px-6 py-2 font-semibold rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white">
                        Add to Cart
                    </ActionButton>
                </div>
            </div>
        </div>
    )
}