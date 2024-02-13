import ProductList from '@/components/home/category/ProductList'
import { SparklesPreview } from '@/components/home/category/SparklesPreview'
import React from 'react'

type Props = {
    params: {
        slug: string
    }
    searchParams: { [key: string]: string | undefined }
}

export default function page({ params: { slug }, searchParams }: Props) {

    return (
        <div className='flex flex-col'>
            <SparklesPreview text="HoReCa" />
            <div className='flex flex-col container gap-8 my-12'>
                <ProductList category={slug} searchParams={searchParams} />
            </div>
        </div>
    )
}