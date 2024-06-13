"use client"

import { useAppDispatch } from "@/_store/hooks"
import { Button, ButtonProps } from "./ui/button"
import { addToCart, removeFromCart } from "@/_store/cartSlice"
import { toast } from "sonner"
import { addProductToCart, removeProductFromCart } from "@/_actions/cartActions"
import { useSession } from "next-auth/react"


type ActionButtonProps = ButtonProps & {
    children: string | React.ReactNode
    data: Product
    quantity: number
    action: "add" | "remove"
}

export default function ActionButton({ children, data, action, quantity, ...props }: ActionButtonProps) {


    const dispatch = useAppDispatch()
    const { data: session } = useSession()

    const addProduct = async () => {
        if (data) {
            const productToAdd = { data, quantity: quantity > 0 ? quantity : 1 };


            dispatch(addToCart({ newProduct: productToAdd.data, quantity: productToAdd.quantity }));

            if (session?.user?.email) {
                try {
                    await addProductToCart(data.id, productToAdd.quantity, session?.user?.email);
                    toast.success("Added Item", {
                        description: `${data.title} has been added to the cart`,
                        action: {
                            label: "Undo",
                            onClick: async () => {
                                await removeProductFromCart(data.id, session?.user?.email!);
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
    }
    const removeProduct = async () => {
        if (session?.user?.email) {
            const productId = data.id;
            const productToRemove = { data: data, quantity: quantity };

            dispatch(removeFromCart(productId));

            try {
                await removeProductFromCart(productId, session?.user?.email);
                toast.success("Removed Item", {
                    description: ` ${data.title} has been removed from the cart`,
                    action: {
                        label: "Undo",
                        onClick: async () => {
                            await addProductToCart(productId, quantity, session?.user?.email!);
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
            dispatch(removeFromCart(data.id));
            toast.success("Removed Item", {
                description: `${data.title} has been removed from the cart`,
                action: {
                    label: "Undo",
                    onClick: () => dispatch(addToCart({ newProduct: data, quantity: 1 })),
                },
            });
        }
    };


    return (
        <Button
            {...props}
            onClick={() => action === "add" ? addProduct() : removeProduct()}
        >
            {children}
        </Button>
    )
}