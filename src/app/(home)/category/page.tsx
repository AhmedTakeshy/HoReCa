import ProductList from './_components/ProductList'
import { SparklesPreview } from './_components/SparklesPreview'
import React from 'react'

type Props = {
    searchParams: { [key: string]: string | undefined }
}

export default function page({  searchParams }: Props) {

    return (
        <div className='flex flex-col'>
            <SparklesPreview text="HoReCa" />
            <div className='flex flex-col container gap-8 my-12'>
                <ProductList searchParams={searchParams} />
            </div>
        </div>
    )
}