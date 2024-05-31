"use server"

import { revalidatePath } from "next/cache";
import { clearCart, getCartFromDatabase } from "./cartActions";
import { prisma } from "@/lib/prisma";
import { Order, Status } from "@prisma/client";

type OrderProps = {
    page?: number;
    search?: number;
    email: string;
}

type Metadata = {
    orders: Order[]
    metadata: {
        hastNextPage: boolean;
        totalPages: number;
    }
}

export async function createOrder({ email }: OrderProps): Promise<ServerResponse<Order>> {
    try {
        const response = await getCartFromDatabase(email)
        if (response.status === "Success") {
            await clearCart(email)
            const order = await prisma.order.create({
                data: {
                    total_price: response.data.totalAmount,
                    total_quantity: response.data.totalQuantity,
                    order_items: {
                        create: response.data.cartProducts.map((cartProduct) => ({
                            product: {
                                connect: {
                                    id: cartProduct.product.id
                                }
                            },
                            quantity: cartProduct.quantity,
                        }))
                    },
                    user: {
                        connect: { email }
                    },
                    status: Status.PENDING
                },
                include: {
                    order_items: {
                        include: {
                            product: true
                        }
                    }
                }
            })
            revalidatePath("/profile/orders")
            return {
                successMessage: "Order created successfully",
                data: order,
                status: "Success",
                statusCode: 201
            }
        } else {
            return {
                errorMessage: "Failed to create order",
                status: "Error",
                statusCode: 400
            }
        }
    } catch (error) {
        console.log("🚀 ~ createOrder ~ error:", error)
        return {
            errorMessage: "Failed to create order",
            status: "Error",
            statusCode: 500
        }
    }
}

export async function getOrders({ email, page = 1 }: OrderProps): Promise<ServerResponse<Metadata>> {
    try {
        const orders = await prisma.order.findMany({
            where: {
                user: {
                    email
                }
            },
            include: {
                order_items: {
                    include: {
                        product: true
                    }
                }
            },
            skip: (page - 1) * 6,
            take: 6
        })

        const totalOrders = await prisma.order.count({
            where: {
                user: {
                    email
                }
            }
        })

        return {
            data: {
                orders,
                metadata: {
                    hastNextPage: totalOrders > page * 6,
                    totalPages: Math.ceil(totalOrders / 6)
                }

            },
            status: "Success",
            successMessage: "Orders fetched successfully",
            statusCode: 200
        }
    } catch (error) {
        console.log("🚀 ~ getOrders ~ error:", error)
        return {
            errorMessage: "Failed to get orders",
            status: "Error",
            statusCode: 500
        }
    }
}

export async function updateOrderStatus(orderId: number, status: Status): Promise<ServerResponse<Order>> {
    try {
        const order = await prisma.order.update({
            where: {
                id: orderId
            },
            data: {
                status
            },
            include: {
                order_items: {
                    include: {
                        product: true
                    }
                }
            }
        })
        return {
            successMessage: "Order status updated successfully",
            data: order,
            status: "Success",
            statusCode: 200
        }
    } catch (error) {
        console.log("🚀 ~ updateOrderStatus ~ error:", error)
        return {
            errorMessage: "Failed to update order status",
            status: "Error",
            statusCode: 500
        }
    }
}

export async function deleteOrCancelOrder(orderId: number): Promise<ServerResponse<null>> {
    try {
        await prisma.order.delete({
            where: {
                id: orderId
            }
        })
        return {
            successMessage: "Order deleted successfully",
            status: "Success",
            data: null,
            statusCode: 200
        }
    } catch (error) {
        console.log("🚀 ~ deleteOrCancelOrder ~ error:", error)
        return {
            errorMessage: "Failed to delete order",
            status: "Error",
            statusCode: 500
        }
    }
}

export async function getLastOrder(email: string): Promise<ServerResponse<Order>> {
    try {
        const order = await prisma.order.findFirst({
            where: {
                user: {
                    email
                }
            },
            orderBy: {
                createdAt: "desc"
            },
            include: {
                order_items: {
                    include: {
                        product: true
                    }
                }
            }
        })
        if (!order) {
            return {
                errorMessage: "No order found",
                status: "Error",
                statusCode: 404
            }
        }
        return {
            successMessage: "Last order fetched successfully",
            data: order,
            status: "Success",
            statusCode: 200
        }
    } catch (error) {
        console.log("🚀 ~ getLastOrder ~ error:", error)
        return {
            errorMessage: "Failed to get last order",
            status: "Error",
            statusCode: 500
        }
    }
}