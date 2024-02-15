"use client"

import { useAppDispatch } from "@/_store/hooks"
import { Button, ButtonProps } from "./ui/button"
import { addToCart, removeFromCart } from "@/_store/cartSlice"
import { toast } from "sonner"

type Props = ButtonProps & {
    children: string | React.ReactNode
    data?: Product
}

export default function ActionButton({ children, data, ...props }: Props) {
    const dispatch = useAppDispatch()
    const addProduct = () => {
        if (data) {
            dispatch(addToCart(data))
            toast(`Added Item`, {
                description: `${data.title} has been added to the cart`,
                action: {
                    label: "Undo",
                    onClick: () => dispatch(removeFromCart(data.id)),
                },
            })
        }
    }
    return (
        <Button {...props} onClick={addProduct}>
            {children}
        </Button>
    )
}