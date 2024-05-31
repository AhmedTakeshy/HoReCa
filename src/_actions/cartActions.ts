"use server"

import { prisma } from "@/lib/prisma"
import { revalidatePath } from "next/cache";



export const addCartToDatabase = async (cart: Cart, email: string): Promise<ServerResponse<Cart>> => {

    try {
        const user = await prisma.user.findUnique({
            where: {
                email,
            },
            select: {
                id: true,
            },
        })
        let userCart = await prisma.cart.findUnique({
            where: {
                userId: user?.id,
            },
            include: {
                cart_items: true,
            },
        })
        if (!userCart) {
            userCart = await prisma.cart.create({
                data: {
                    userId: user?.id!,
                    cart_items: {
                        create: cart.cartProducts.map((product) => ({
                            quantity: product.quantity,
                            productId: product.product.id,
                        })),
                    },
                },
                include: {
                    cart_items: true,
                },
            });
        }
        else {
            for (const product of cart.cartProducts) {
                const existingProduct = userCart.cart_items.find((item) => item.productId === product.product.id)

                if (existingProduct) {
                    await prisma.cartItem.update({
                        where: {
                            id: existingProduct.id,
                        },
                        data: {
                            quantity: { increment: product.quantity }
                        },
                    })
                }
                else {
                    await prisma.cartItem.create({
                        data: {
                            cartId: userCart.id,
                            productId: product.product.id,
                            quantity: product.quantity,
                        },
                    })
                }
            }
        }

        const products = await prisma.cartItem.findMany({
            where: {
                cartId: userCart.id,
            },
            select: {
                product: true,
                quantity: true,
            },
        })
        revalidatePath("/cart")
        return {
            data: {
                cartProducts: products.map((product) => ({
                    quantity: product.quantity,
                    product: product.product
                })),
                totalAmount: cart.cartProducts.reduce((acc, product) => acc + product.product.price * product.quantity, 0),
                totalQuantity: cart.cartProducts.reduce((acc, product) => acc + product.quantity, 0),
            },
            successMessage: "Cart updated successfully!",
            status: "Success",
            statusCode: 200,
        }

    } catch (error) {
        return {
            errorMessage: "Something went wrong. Please try again.",
            status: "Error",
            statusCode: 404,
        }
    }
}

export const getCartFromDatabase = async (email: string): Promise<ServerResponse<Cart>> => {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email,
            },
            select: {
                id: true,
            },
        })

        const userCart = await prisma.cart.findUnique({
            where: {
                userId: user?.id,
            },
            include: {
                cart_items: {
                    include: {
                        product: true,
                    },
                },
            },
        })
        const products = await prisma.cartItem.findMany({
            where: {
                cartId: userCart?.id,
            },
            select: {
                product: true,
                quantity: true,
            },
        })
        return {
            data: {
                cartProducts: products.map((product) => ({
                    quantity: product.quantity,
                    product: product.product
                })),
                totalAmount: userCart?.cart_items.reduce((acc, item) => acc + item.product.price * item.quantity, 0)!,
                totalQuantity: userCart?.cart_items.reduce((acc, item) => acc + item.quantity, 0)!,
            },
            successMessage: "Cart fetched successfully!",
            status: "Success",
            statusCode: 200,
        }
    } catch (error) {
        console.log("🚀 ~ getCartFromDatabase ~ error:", error)
        return {
            errorMessage: "Something went wrong. Please try again.",
            status: "Error",
            statusCode: 404,
        }
    }
}

export const addProductToCart = async (productId: number, quantity: number, email: string): Promise<ServerResponse<Cart>> => {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email,
            },
            select: {
                id: true,
            },
        })

        let userCart = await prisma.cart.findUnique({
            where: {
                userId: user?.id,
            },
            include: {
                cart_items: true,
            },
        })
        if (!userCart) {
            userCart = await prisma.cart.create({
                data: {
                    userId: user?.id!,
                    cart_items: {
                        create: {
                            quantity,
                            productId,
                        },
                    },
                },
                include: {
                    cart_items: true,
                },
            });
        }
        else {
            const existingProduct = userCart.cart_items.find((item) => item.productId === productId)
            if (existingProduct) {
                await prisma.cartItem.update({
                    where: {
                        id: existingProduct.id,
                    },
                    data: {
                        quantity: { increment: quantity }
                    },
                })
            }
            else {
                await prisma.cartItem.create({
                    data: {
                        cartId: userCart.id,
                        productId,
                        quantity,
                    },
                })
            }
        }
        const products = await prisma.cartItem.findMany({
            where: {
                cartId: userCart.id,
            },
            select: {
                product: true,
                quantity: true,
            },
        })
        revalidatePath("/cart")
        return {
            data: {
                cartProducts: products.map((product) => ({
                    quantity: product.quantity,
                    product: product.product
                })),
                totalAmount: products.reduce((acc, item) => acc + item.product.price * item.quantity, 0),
                totalQuantity: products.reduce((acc, item) => acc + item.quantity, 0),
            },
            successMessage: "Product added to cart successfully!",
            status: "Success",
            statusCode: 200,
        }
    } catch (error) {
        return {
            errorMessage: "Something went wrong. Please try again.",
            status: "Error",
            statusCode: 404,
        }
    }
}

export const removeProductFromCart = async (productId: number, email: string): Promise<ServerResponse<Cart>> => {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email,
            },
            select: {
                id: true,
            },
        })

        const userCart = await prisma.cart.findUnique({
            where: {
                userId: user?.id,
            },
            include: {
                cart_items: {
                    include: {
                        product: true,
                    },
                },
            },
        })

        const existingProduct = userCart?.cart_items.find((item) => item.productId === productId)
        if (existingProduct) {
            await prisma.cartItem.delete({
                where: {
                    id: existingProduct.id,
                },
            })
        }
        const products = await prisma.cartItem.findMany({
            where: {
                cartId: userCart?.id,
            },
            select: {
                product: true,
                quantity: true,
            },
        })
        revalidatePath("/cart")
        return {
            data: {
                cartProducts: products.map((product) => ({
                    quantity: product.quantity,
                    product: product.product
                })),
                totalAmount: products.reduce((acc, item) => acc + item.product.price * item.quantity, 0),
                totalQuantity: products.reduce((acc, item) => acc + item.quantity, 0),
            },
            successMessage: "Product removed from cart successfully!",
            status: "Success",
            statusCode: 200,
        }
    } catch (error) {
        return {
            errorMessage: "Something went wrong. Please try again.",
            status: "Error",
            statusCode: 404,
        }
    }
}

export const clearCart = async (email: string): Promise<ServerResponse<Cart>> => {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email,
            },
            select: {
                id: true,
            },
        })

        const userCart = await prisma.cart.findUnique({
            where: {
                userId: user?.id,
            },
            include: {
                cart_items: {
                    include: {
                        product: true,
                    },
                },
            },
        })

        await prisma.cartItem.deleteMany({
            where: {
                cartId: userCart?.id,
            },
        })

        revalidatePath("/cart")
        return {
            data: {
                cartProducts: [],
                totalAmount: 0,
                totalQuantity: 0,
            },
            successMessage: "Cart cleared successfully!",
            status: "Success",
            statusCode: 200,
        }
    } catch (error) {
        return {
            errorMessage: "Something went wrong. Please try again.",
            status: "Error",
            statusCode: 404,
        }
    }
}