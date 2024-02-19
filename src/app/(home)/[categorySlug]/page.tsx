import ProductList from './_components/ProductList'
import { SparklesPreview } from './_components/SparklesPreview'
import React from 'react'

type Props = {
    params: {
        categorySlug: string
    }
    searchParams: { [key: string]: string | undefined }
}

export default function page({ params: { categorySlug }, searchParams }: Props) {

    return (
        <div className='flex flex-col'>
            <SparklesPreview text="HoReCa" />
            <div className='flex flex-col container gap-8 my-12'>
                <ProductList category={categorySlug} searchParams={searchParams} />
            </div>
        </div>
    )
}