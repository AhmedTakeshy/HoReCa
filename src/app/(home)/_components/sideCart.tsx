import SimpleProduct from "@/components/SimpleProduct";
import Link from "next/link";
import { SheetClose, SheetFooter } from "@/components/ui/sheet";

type SideCartProps = {
    cartProducts: CartProduct[];
    totalAmount: number;
    email: string | null | undefined;
}

export default function SideCart({ cartProducts, totalAmount, email }: SideCartProps) {
    return (
        <section className="py-12 relative">
            <div className="w-full max-w-7xl px-4 md:px-2 mx-auto overflow-y-auto">
                <h2 className="title font-manrope font-bold text-2xl leading-10 mb-8 text-center">
                    Shopping Cart
                </h2>
                {
                    cartProducts.length > 0
                        ?
                        cartProducts.map(product => (
                            <>
                                <div className="rounded-xl border-2 border-gray-200 p-2 grid mb-4 max-lg:max-w-lg w-full max-lg:mx-auto gap-y-4 ">
                                    <SimpleProduct key={product.product.id} data={product} />
                                </div>
                                <div className="flex flex-col md:flex-row items-center md:items-center justify-between lg:px-6 pb-6 border-b border-gray-200 max-lg:max-w-lg max-lg:mx-auto">
                                    <h5 className="dark:text-gray-200 text-gray-900 font-manrope font-semibold text-2xl leading-9 w-full max-md:text-center max-md:mb-4">Subtotal</h5>
                                    <div className="flex items-center justify-between gap-5 ">
                                        <h6 className="font-manrope font-bold text-3xl lead-10 text-indigo-600">${totalAmount}</h6>
                                    </div>
                                </div>
                                <div className="max-lg:max-w-lg max-lg:mx-auto">
                                    <p className="font-normal text-base leading-7 dark:text-gray-200 text-gray-500 text-center mb-5 mt-6">
                                        Shipping taxes, and discounts calculated at checkout
                                    </p>
                                    {email ? (
                                        <SheetFooter>
                                            <SheetClose asChild>
                                                <Link
                                                    href="/cart"
                                                    className="rounded-full inline-block py-2 px-4 bg-indigo-600 text-white font-semibold text-lg w-full text-center transition-all duration-500 hover:bg-indigo-700 ">
                                                    Proceed to cart
                                                </Link>
                                            </SheetClose>
                                        </SheetFooter>
                                    ) : (
                                        <Link
                                            href="/signin"
                                            className="rounded-full inline-block py-2 px-4 bg-indigo-600 text-white font-semibold text-lg w-full text-center transition-all duration-500 hover:bg-indigo-700 ">
                                            Login
                                        </Link>
                                    )}
                                </div>
                            </>
                        ))
                        :
                        <p className="text-center">The cart is empty.</p>
                }

            </div>
        </section >
    )
}
