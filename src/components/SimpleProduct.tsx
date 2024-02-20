"use client"
import Image from "next/image"
import { FaRegTrashCan } from "react-icons/fa6"
import { useAppDispatch } from "@/_store/hooks"
import { addToCart, removeFromCart } from "@/_store/cartSlice"
import { toast } from "sonner"
import Link from "next/link"
import { useSession } from "next-auth/react"
import { addProductToCart, removeProductFromCart } from "@/_actions/cartActions"

type Props = {
    data: CartProduct
}

export default function SimpleProduct({ data }: Props) {

    const dispatch = useAppDispatch()
    const { data: session } = useSession()

    const removeProduct = async () => {
        if (session?.user?.email) {
            const productId = data.product.id;
            const productToRemove = { data: data.product, quantity: data.quantity };

            dispatch(removeFromCart(productId));

            try {
                await removeProductFromCart(productId, session?.user?.email);
                toast.success("Removed Item", {
                    description: ` ${data.product.title} has been removed from the cart`,
                    action: {
                        label: "Undo",
                        onClick: async () => {
                            await addProductToCart(productId, data.quantity, session?.user?.email!);
                            dispatch(addToCart({ newProduct: productToRemove.data, quantity: 1 })); // Add back locally if undo is successful
                        },
                    },
                });
            } catch (error) {
                dispatch(addToCart({ newProduct: productToRemove.data, quantity: 1 }));
                toast.error("Error", {
                    description: "Failed to remove item from the cart. Please try again.",
                });
            }
        } else {
            dispatch(removeFromCart(data.product.id));
            toast.success("Removed Item", {
                description: `${data.product.title} has been removed from the cart`,
                action: {
                    label: "Undo",
                    onClick: () => dispatch(addToCart({ newProduct: data.product, quantity: 1 })),
                },
            });
        }
    };
    return (
        <div className="grid grid-cols-[1fr,auto] justify-between items-center p-2 dark:hover:text-slate-900 hover:bg-slate-100 rounded-lg">
            <Link href={`${data.product.category}/products/${data.product.id}`} className="flex justify-start items-center gap-2 h-14">
                <Image src={`${data.product.thumbnail}`} width={80} height={72.5} alt="product" className="rounded-md w-20 h-full" />
                <div >
                    <h2 className="text-sm font-medium">
                        {data.product.title}
                    </h2>
                    <p className="text-sm font-medium text-gray-500 dark:text-inherit">
                        ${data.product.price.toFixed(2) || data.product.price}
                    </p>
                </div>
            </Link>
            <div className="flex flex-col justify-between items-center h-full py-px">
                <FaRegTrashCan className="w-5 h-5 hover:text-red-700 hover:cursor-pointer" onClick={removeProduct} />
                <p className="text-sm font-medium text-gray-500 dark:text-inherit">(X{data.quantity})</p>
            </div>
        </div>
    )
}