"use client";

import { clearCart } from "@/_actions/cartActions";
import { useAppSelector } from "@/_store/hooks";
import ActionButton from "@/components/ActionButton";
import SubmitButton from "@/components/SubmitButton";
import { buttonVariants } from "@/components/ui/button";
import { loadStripe } from "@stripe/stripe-js";
import Image from "next/image";
import Link from "next/link";
import { FormEvent, useState } from "react";
import { FaMinus, FaPlus, FaRegTrashCan } from "react-icons/fa6";



type CartProps = {
    cartDb?: Cart
    user?: {
        role: string;
    } & {
        name?: string | null | undefined;
        email?: string | null | undefined;
        image?: string | null | undefined;
    }

}
export default function Cart({ cartDb, user }: CartProps) {
    const cartStore = useAppSelector(state => state.cart);
    const [isPending, setIsPending] = useState(false);
    const userCart = cartDb ? cartDb : cartStore;
    const stripePromise = loadStripe(`${process.env.NEXT_PUBLIC_STRIPE_PUBLIC_KEY}`);

    async function handleCheckout(e: FormEvent) {
        e.preventDefault();
        setIsPending(true);
        const stripe = await stripePromise;
        try {
            const response = await fetch("/api/checkout_session", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    products: userCart.cartProducts,
                }),
            });
            const { sessionId } = await response.json();
            const result = await stripe?.redirectToCheckout({
                sessionId,
            });
            if (result?.error) {
                console.error(result.error.message);
            }
        } catch (err) {
            console.error(err)
        }
        setIsPending(false);
    }

    return (
        userCart.totalQuantity > 0 ? (
            <div className="mx-auto max-w-5xl justify-center px-6 md:flex md:space-x-6 xl:px-0 mb-4 sm:mb-0">
                <div className="rounded-lg md:w-2/3">
                    {userCart.cartProducts.map(({ product, quantity }) => (
                        <div key={product.id} className="justify-between mb-6 rounded-lg dark:bg-slate-800 p-6 shadow-md sm:flex sm:justify-start">
                            <Image src={`${product.thumbnail}`} alt={`${product.title} - image`} className="w-full rounded-lg sm:w-40" width={160} height={107} />
                            <div className="sm:ml-4 sm:flex sm:w-full sm:justify-between">
                                <div className="mt-5 sm:mt-0 flex flex-col justify-between h-full">
                                    <div className="sm:mb-0 mb-4">
                                        <h2 className="text-lg font-semibold dark:text-slate-100">
                                            {product.title}
                                        </h2>
                                        <p className="mt-1 text-xs font-medium dark:text-slate-200">
                                            {product.category} - {product.brand}
                                        </p>
                                    </div>
                                    <p className="text-sm leading-tight">
                                        {product.description}
                                    </p>
                                </div>
                                <div className="mt-4 flex justify-between sm:space-y-6 sm:mt-0 sm:block sm:space-x-6 rounded">
                                    <div className="flex items-center border-gray-100">
                                        <ActionButton action="remove" data={product} quantity={1} className="cursor-pointer !rounded-l !rounded-r-none dark:bg-gray-700 bg-slate-300 py-1 px-3.5 duration-100 dark:hover:bg-slate-900 dark:hover:text-blue-50">
                                            {quantity > 1 ? <FaMinus className="!w-5 !h-5" /> :
                                                <FaRegTrashCan className="!w-5 !h-5 hover:text-red-700 hover:cursor-pointer shadow-none bg-transparent hover:bg-transparent text-inherit" />
                                            }
                                        </ActionButton>
                                        <input readOnly className="h-9 w-8 dark:border-0 border-y dark:bg-slate-500 text-center text-xs outline-none" type="text" value={quantity} min="1" />
                                        <ActionButton action="add" data={product} quantity={1} className="cursor-pointer !rounded-l-none !rounded-r dark:bg-gray-700 bg-slate-300 py-1 px-3 duration-100 dark:hover:bg-slate-900 dark:hover:text-blue-50">
                                            <FaPlus className="!w-5 !h-5" />
                                        </ActionButton>
                                    </div>
                                    <div className="flex items-end justify-end">
                                        <p className="text-lg font-bold text-indigo-700">${product.price.toFixed(2)}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>

                {/* <!-- Sub total --> */}
                <div className="mt-6 h-full rounded-lg border dark:bg-slate-800 p-6 shadow-md md:mt-0 md:w-1/3">
                    <div className="mb-2 flex justify-between">
                        <p className="dark:text-slate-300">Subtotal</p>
                        <p className="">${userCart.totalAmount}</p>
                    </div>
                    <div className="flex justify-between">
                        <p className="dark:text-slate-300">Shipping</p>
                        <p className="">+ $20.00</p>
                    </div>
                    <div className="flex justify-between">
                        <p className="dark:text-slate-300">Discount</p>
                        <p className="">- $20.00</p>
                    </div>
                    <hr className="my-4" />
                    <div className="flex justify-between">
                        <p className="text-lg font-bold">Total</p>
                        <div className="">
                            <p className="mb-1 text-lg font-bold">${userCart.totalAmount} USD</p>
                            <p className="text-sm dark:text-slate-300">including VAT</p>
                        </div>
                    </div>
                    {user?.email ? (
                        <SubmitButton text="Checkout" pending={isPending} onClick={handleCheckout} className={` mt-6 w-full rounded-md !bg-blue-500 py-1.5 font-medium text-blue-50 hover:!bg-blue-600 disabled:!cursor-progress`} />
                    ) : (
                        <Link href={"/signin"} className={`${buttonVariants()} mt-6 w-full rounded-md !bg-blue-500 py-1.5 font-medium text-blue-50 hover:!bg-blue-600`}>
                            Sign in to checkout
                        </Link>
                    )}
                </div>
            </div>
        ) : (
            <p className="text-center text-xl">No items in cart</p>
        )
    )
}
