
import { createOrder, deleteOrCancelOrder } from "@/_actions/orderActions";
import { authOptions } from "@/lib/auth";
import { Status } from "@prisma/client";
import { getServerSession } from "next-auth";
import OrderItems from "../_components/orderItems";
import { RedirectType, redirect } from "next/navigation";

type Props = {
    searchParams?: { [key: string]: string };
};

export default async function page({ searchParams }: Props) {
    if (!searchParams?.session_id) {
        redirect("/", RedirectType.replace);
    }
    const session = await getServerSession(authOptions)
    const response = await createOrder({ email: session?.user.email ?? "" })


    return (
        response.status === "Success" ? (
            <section className="py-24 relative">
                <div className="w-full max-w-7xl px-4 md:px-5 lg-6 mx-auto">
                    <h2 className="font-manrope font-bold text-4xl leading-10  text-center">
                        Payment Successful
                    </h2>
                    <p className="mt-4 font-normal text-lg leading-8 text-gray-500 mb-11 text-center">Thanks for making a purchase
                        you can
                        check our order summary from below</p>
                    <div className="main-box border border-gray-200 rounded-xl pt-6 max-w-xl max-lg:mx-auto lg:max-w-full">
                        <div
                            className="flex flex-col lg:flex-row lg:items-center justify-between px-6 pb-6 border-b border-gray-200">
                            <div className="data">
                                <p className="font-semibold text-base leading-7 ">Order Id: <span className="text-indigo-600 font-medium">#{response.data.publicId}</span></p>
                                <p className="font-semibold text-base leading-7  mt-4">
                                    Order Payment : <span className="text-gray-400 font-medium"> {new Date(response.data.createdAt).toDateString()}</span>
                                </p>
                            </div>
                        </div>
                        <div className="w-full px-3 min-[400px]:px-6">
                            {response.data.order_items.map((orderItem) => (
                                <OrderItems
                                    key={orderItem.product.id}
                                    product={orderItem.product}
                                    status={Status.PENDING}
                                    quantity={orderItem.quantity}
                                    expectedDeliveryTime={orderItem.createdAt}
                                />
                            ))}
                        </div>
                        <div className="w-full border-t border-gray-200 px-6 flex flex-col lg:flex-row items-center justify-between ">
                            <form
                                action={async () => {
                                    "use server"
                                    await deleteOrCancelOrder(response.data.id)
                                    redirect("/", RedirectType.replace)
                                }}
                                className="flex flex-col sm:flex-row items-center max-lg:border-b border-gray-200">
                                <button
                                    className="flex outline-0 py-6 sm:pr-6  sm:border-r border-gray-200 whitespace-nowrap gap-2 items-center justify-center font-semibold group text-lg  transition-all duration-500 hover:text-indigo-600">
                                    <svg className="dark:stroke-white stroke-black transition-all duration-500 group-hover:stroke-indigo-600" xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22"
                                        fill="none">
                                        <path d="M5.5 5.5L16.5 16.5M16.5 5.5L5.5 16.5" stroke="" strokeWidth="1.6"
                                            strokeLinecap="round" />
                                    </svg>
                                    Cancel Order
                                </button>
                            </form>
                            <p className="font-semibold text-lg py-6">Total Price: <span className="text-indigo-600"> ${response.data.total_price}</span></p>
                        </div>
                    </div>
                </div>
            </section>
        ) : (
            <p className="text-center text-2xl font-bold text-red-500">
                Failed to create order
            </p>
        )
    )
}
