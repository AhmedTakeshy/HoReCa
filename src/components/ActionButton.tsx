"use client"

import { useAppDispatch } from "@/_store/hooks"
import { Button, ButtonProps } from "./ui/button"
import { addToCart, removeFromCart, replaceCart } from "@/_store/cartSlice"
import { toast } from "sonner"
import { addProductToCart, removeProductFromCart } from "@/_actions/cartActions"
import { useSession } from "next-auth/react"


type Props = ButtonProps & {
    children: string | React.ReactNode
    data?: Product
    quantity: number
}

export default function ActionButton({ children, data, quantity, ...props }: Props) {

    const dispatch = useAppDispatch()
    const { data: session } = useSession()

    const addProduct = async () => {
        if (data) {
            const productToAdd = { ...data, quantity: quantity > 0 ? quantity : 1 };


            dispatch(addToCart(productToAdd));

            if (session?.user?.email) {
                try {
                    await addProductToCart(data.id, productToAdd.quantity, session?.user?.email);
                    toast.success("Added Item", {
                        description: `${data.title} has been added to the cart`,
                        action: {
                            label: "Undo",
                            onClick: async () => {
                                await removeProductFromCart(data.id, session?.user?.email!);
                                // Roll back optimistic UI update if undo action is taken
                                dispatch(removeFromCart(data.id));
                            },
                        },
                    });
                } catch (error) {

                    dispatch(removeFromCart(data.id));

                    toast.error("Error", {
                        description: "Failed to add item to the cart. Please try again.",
                    });
                }
            } else {
                // If not logged in, simply show a toast, as the cart update is local
                toast.success("Added Item", {
                    description: `${data.title} has been added to the cart`,
                    action: {
                        label: "Undo",
                        onClick: () => dispatch(removeFromCart(data.id)),
                    },
                });
            }
        }
    };
    return (
        <Button {...props} onClick={addProduct}>
            {children}
        </Button>
    )
}