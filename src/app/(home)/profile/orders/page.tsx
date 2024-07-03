import { getOrders } from '@/_actions/orderActions'
import PaginationControl from '@/components/PaginationControl'
import { authOptions } from '@/lib/auth'
import { getServerSession } from 'next-auth'
import React from 'react'
import Invoice from './_components/invoice'
import Image from 'next/image'
import { FaCircleCheck } from 'react-icons/fa6'
import { MdPending } from "react-icons/md";
import { MdCancel } from "react-icons/md";
import Link from 'next/link'
import { Button } from '@/components/ui/button'



type Props = {
    searchParams: { [key: string]: string | undefined }
}

export default async function page({ searchParams }: Props) {
    const page = searchParams.page ? searchParams.page : { page: 1 }
    const session = await getServerSession(authOptions)
    const response = await getOrders({ email: session?.user.email ?? "", page: 1, })


    return (
        <div className="dark:bg-slate-900 mx-2 rounded-md w-full">
            <div className="pb-12 sm:pb-20 pt-6">
                <div className="mx-auto max-w-7xl sm:px-2 lg:px-8">
                    <div className="mx-auto max-w-2xl px-4 lg:max-w-4xl lg:px-0">
                        <h1 className="text-2xl font-bold tracking-tight dark:text-slate-200 sm:text-3xl">Order history</h1>
                        <p className="mt-2 text-sm dark:text-slate-400">Check the status of recent orders, manage returns, and discover similar products.</p>
                    </div>
                </div>
                {response.status === "Success" ? response.data.orders.map(({ order, order_items }) => {
                    const orderPublicId = order.publicId.slice(0, 11) + order.id + order.publicId.slice(-10)
                    return (
                        <div className="mt-16" key={orderPublicId}>
                            <h2 className="sr-only">Recent orders</h2>
                            <div className="mx-auto max-w-7xl sm:px-2 lg:px-8">
                                <div className="mx-auto max-w-2xl space-y-8 sm:px-4 lg:max-w-4xl lg:px-0">
                                    <div className="border-b border-t border-slate-300 dark:bg-slate-800 shadow-sm sm:rounded-lg sm:border">
                                        <h3 className="sr-only">
                                            Order placed on <time dateTime={order.createdAt.toISOString()}>
                                                {order.createdAt.toDateString()}
                                            </time>
                                        </h3>

                                        <div className="flex items-center border-b border-slate-300 p-4 sm:grid sm:grid-cols-3 sm:gap-y-6 sm:p-6">
                                            <dl className="grid flex-1 grid-cols-3 gap-x-6 text-sm sm:col-span-3 place-items-center">
                                                <div>
                                                    <dt className="font-medium dark:text-slate-400">Order ID</dt>
                                                    <dd className="mt-1 dark:text-gray-200">
                                                        {orderPublicId}
                                                    </dd>
                                                </div>
                                                <div className="hidden sm:block">
                                                    <dt className="font-medium dark:text-slate-400">Date placed</dt>
                                                    <dd className="mt-1 dark:text-gray-200">
                                                        <time dateTime={order.createdAt.toISOString()}>
                                                            {order.createdAt.toDateString()}
                                                        </time>
                                                    </dd>
                                                </div>
                                                <div>
                                                    <dt className="font-medium dark:text-slate-400">Total amount</dt>
                                                    <dd className="mt-1 font-medium dark:text-slate-100">${order.total_price}</dd>
                                                </div>
                                            </dl>
                                            <div className="hidden lg:col-span-2 lg:flex lg:items-center lg:justify-end lg:space-x-4">
                                                <Button asChild variant={"outline"}>
                                                    <Link href={`/order?query=${orderPublicId}`} className={`flex items-center justify-center rounded-md border border-gray-300 bg-white px-2.5 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2`}>
                                                        View Order
                                                        <span className="sr-only">{orderPublicId}</span>
                                                    </Link>
                                                </Button>
                                                <Invoice
                                                    date={order.createdAt.toDateString()}
                                                    amount={order.total_price}
                                                    invoiceId={orderPublicId}
                                                />
                                            </div>
                                        </div>

                                        {/* <!-- Products --> */}
                                        <h4 className="sr-only">Items</h4>
                                        <ul role="list" className="divide-y divide-gray-200">
                                            {order_items.map(({ product }) => {
                                                const productPublicId = product.publicId.slice(0, 11) + product.id + product.publicId.slice(-10)
                                                return (
                                                    <li className="p-4 sm:p-6">
                                                        <div className="flex items-center sm:items-start">
                                                            <Image className="h-20 w-20 flex-shrink-0 overflow-hidden rounded-lg bg-gray-200 sm:w-60 object-cover sm:h-40 aspect-square" width={160} height={160} src={product.thumbnail} alt={`${product.title}-image`} />
                                                            <div className="ml-6 flex-1 text-sm">
                                                                <div className="font-medium dark:text-slate-200 sm:flex sm:justify-between">
                                                                    <h5 className='flex items-center gap-2'>
                                                                        {product.title}{" - "}
                                                                        <span className="text-gray-500">{product.brand}</span>
                                                                    </h5>
                                                                    <p className="mt-2 sm:mt-0">${product.price}</p>
                                                                </div>
                                                                <p className="hidden dark:text-gray-500 sm:mt-2 sm:block">{product.description}</p>
                                                            </div>
                                                        </div>

                                                        <div className="mt-6 sm:flex sm:justify-between">
                                                            {order.status === "COMPLETED" ?
                                                                <div className="flex items-center">
                                                                    <FaCircleCheck className="h-5 w-5 text-green-500" aria-hidden="true" />
                                                                    <p className="ml-2 text-sm font-medium dark:text-gray-500">Delivered on <time dateTime="2021-07-12">July 12, 2021</time></p>
                                                                </div>
                                                                :
                                                                order.status === "PENDING" ?
                                                                    <div className="flex items-center">
                                                                        <MdPending className="h-5 w-5 text-yellow-500" aria-hidden="true" />
                                                                        <p className="ml-2 text-sm font-medium dark:text-gray-500">Will deliver on <time dateTime="2021-07-12">July 12, 2021</time></p>
                                                                    </div>
                                                                    :
                                                                    <div className="flex items-center">
                                                                        <MdCancel className="h-5 w-5 text-rose-500" aria-hidden="true" />
                                                                        <p className="ml-2 text-sm font-medium dark:text-gray-500">Canceled</p>
                                                                    </div>
                                                            }
                                                            <div className="mt-6 flex items-center space-x-4 divide-x divide-gray-200 border-t border-gray-200 pt-4 text-sm font-medium sm:ml-4 sm:mt-0 sm:border-none sm:pt-0">
                                                                <div className="flex flex-1 justify-center">
                                                                    <Link href={`/product?query=${product.title.replace(" ", "-")}-${productPublicId}`} className="whitespace-nowrap text-indigo-600 hover:text-indigo-500">View product</Link>
                                                                </div>
                                                                <div className="flex flex-1 justify-center pl-4">
                                                                    <a href="#" className="whitespace-nowrap text-indigo-600 hover:text-indigo-500">Buy again</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                )
                                            })}

                                            {/* <!-- More products... --> */}
                                        </ul>
                                    </div>
                                    {/* <!-- More orders... --> */}
                                </div>
                            </div>
                        </div>
                    )
                })
                    : (
                        <p className="text-center font-medium">There are no orders at the moment.</p>
                    )}


            </div>
            {/* <PaginationControl/> */}
        </div>
    )
}
