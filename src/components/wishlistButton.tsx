"use client"
import { addToWishlist, removeFromWishlist } from "@/_actions/wishlistActions";
import { GoHeartFill } from "react-icons/go";
import { toast } from "sonner";
import { Button, ButtonProps } from "./ui/button";
import { useRouter } from "next/navigation";
import { useOptimistic, useTransition } from "react";
import { revalidatePath } from "next/cache";

type WishlistButtonProps = ButtonProps & {
    productId: number
    title: string
    email: string | null | undefined
    mode: "add" | "remove"
}

export default function WishlistButton({ productId, email, title, mode, ...props }: WishlistButtonProps) {
    const router = useRouter()
    const [isPending, startTransition] = useTransition()
    const [optimisticMode, addOptimisticMode] = useOptimistic<string, string>(
        mode,
        (state) => state === "add" ? "remove" : "add"
    )


    async function addItem() {
        if (!email) {
            toast.warning("Please sign in to add to wishlist", {
                action: {
                    label: "Sign in",
                    onClick: () => {
                        router.push("/signin")
                    }
                }
            })
            return
        }
        const response = await addToWishlist(email, productId)
        console.log("🚀 ~ addItem ~ response:", response)
        switch (response.status) {
            case "Success":
                toast.success("Added successfully", {
                    description: `${title} added to wishlist`,
                    action: {
                        label: "Undo",
                        onClick: async () => {
                            await removeFromWishlist(email, productId)
                        }
                    }
                })
                router.refresh()
                break;
            case "Error":
                toast.error(`Failed to add ${title} to wishlist`)
                break;
        }
    }

    async function removeItem() {
        if (!email) {
            toast.warning("Please sign in to add to wishlist", {
                action: {
                    label: "Sign in",
                    onClick: () => {
                        router.push("/signin")
                    }
                }
            })
            return
        }
        const response = await removeFromWishlist(email, productId)
        console.log("🚀 ~ removeItem ~ response:", response)
        switch (response.status) {
            case "Success":
                toast.success("Removed successfully", {
                    description: `${title} removed from wishlist`,
                    action: {
                        label: "Undo",
                        onClick: async () => {
                            await addToWishlist(email, productId)
                        }
                    }
                })
                break;
            case "Error":
                toast.error(`Failed to remove ${title} from wishlist`)
                break;
        }
    }

    return (
        <Button
            {...props}
            onClick={() => {
                startTransition(async () => {
                    if (optimisticMode === "add") {
                        addOptimisticMode("add")
                        await addItem()
                    } else {
                        addOptimisticMode("remove")
                        await removeItem()
                    }
                }
                )
            }}
            disabled={isPending}
        >
            <GoHeartFill
                className={`w-6 h-6 ${optimisticMode === "add" ? "group-hover:text-red-600 group-hover:animate-pumping-heart" : "!text-red-600 group-hover:!text-inherit transition-colors duration-300"}`} />
        </Button>
    )
}
