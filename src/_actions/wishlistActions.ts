"use server"

import { revalidatePath } from "next/cache";
import { prisma } from "@/lib/prisma";
import { Wishlist } from "@prisma/client";

type WishlistProps = {
    page?: number;
    search?: string;
    email: string;
}

type Metadata = {
    wishlists: Wishlist[]
    metadata: {
        hastNextPage: boolean;
        totalPages: number;
    }
}

export async function getWishlistItems({ email }: WishlistProps): Promise<ServerResponse<WishlistItem[]>> {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email
            }
        })
        const wishlist = await prisma.wishlist.findUnique({
            where: {
                userId: user?.id
            },
            select: {
                wishlist_items: {
                    include: {
                        product: true
                    }
                }
            }
        })
        if (!wishlist?.wishlist_items) {
            return {
                errorMessage: "Wishlist not found",
                status: "Error",
                statusCode: 404,
            }
        }
        return {
            data: wishlist.wishlist_items,
            status: "Success",
            successMessage: "Wishlists fetched successfully",
            statusCode: 200,
        }
    }
    catch (error) {
        return {
            errorMessage: "Failed to fetch wishlists",
            status: "Error",
            statusCode: 500,
        }
    }
}

export async function getWishlist({ page = 1 }: WishlistProps): Promise<ServerResponse<Metadata>> {
    try {
        const wishlists = await prisma.wishlist.findMany({
            include: {
                user: true,
                wishlist_items: {
                    include: {
                        product: true
                    }
                }
            },
            skip: (page - 1) * 6,
            take: 6
        })
        const totalWishlists = await prisma.wishlist.count()
        return {
            data: {
                wishlists,
                metadata: {
                    hastNextPage: totalWishlists > page * 6,
                    totalPages: Math.ceil(totalWishlists / 6)
                }
            },
            status: "Success",
            successMessage: "Wishlists fetched successfully",
            statusCode: 200,
        }
    }
    catch (error) {
        return {
            errorMessage: "Failed to fetch wishlists",
            status: "Error",
            statusCode: 500,
        }
    }
}

export async function getWishlistsBySearch({ page = 1, search = "" }: WishlistProps): Promise<ServerResponse<Metadata>> {
    try {
        const wishlists = await prisma.wishlist.findMany({
            include: {
                user: true,
                wishlist_items: {
                    include: {
                        product: true
                    }
                }
            },
            where: {
                OR: [
                    {
                        wishlist_items: {
                            some: {
                                product: {
                                    category: {
                                        contains: search,
                                        mode: "insensitive"
                                    }
                                }
                            }
                        }
                    },
                    {
                        wishlist_items: {
                            some: {
                                product: {
                                    title: {
                                        contains: search,
                                        mode: "insensitive"
                                    }
                                }
                            }
                        }
                    }
                ]
            },
            skip: (page - 1) * 6,
            take: 6
        })

        const totalWishlists = await prisma.wishlist.count({
            where: {
                OR: [
                    {
                        wishlist_items: {
                            some: {
                                product: {
                                    category: {
                                        contains: search,
                                        mode: "insensitive"
                                    }
                                }
                            }
                        }
                    },
                    {
                        wishlist_items: {
                            some: {
                                product: {
                                    title: {
                                        contains: search,
                                        mode: "insensitive"
                                    }
                                }
                            }
                        }
                    }
                ]
            }
        })
        return {
            data: {
                wishlists,
                metadata: {
                    hastNextPage: totalWishlists > page * 6,
                    totalPages: Math.ceil(totalWishlists / 6)
                }
            },
            status: "Success",
            successMessage: "Wishlists fetched successfully",
            statusCode: 200,
        }
    }
    catch (error) {
        return {
            errorMessage: "Failed to fetch wishlists",
            status: "Error",
            statusCode: 500,
        }
    }
}

export async function addToWishlist(email: string, productId: number): Promise<ServerResponse<null>> {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email
            },
            select: {
                id: true
            }
        })
        await prisma.wishlist.update({
            where: {
                userId: user?.id
            },
            include: {
                wishlist_items: true
            },
            data: {
                wishlist_items: {
                    create: {
                        productId
                    }
                }
            }
        })
        revalidatePath("/wishlist")
        return {
            data: null,
            status: "Success",
            successMessage: "Product added to wishlist",
            statusCode: 200,
        }
    }
    catch (error) {
        return {
            errorMessage: "Failed to add product to wishlist",
            status: "Error",
            statusCode: 500,
        }
    }
}

export async function removeFromWishlist(email: string, productId: number): Promise<ServerResponse<null>> {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email
            },
            select: {
                id: true
            }
        })
        await prisma.wishlist.update({
            where: {
                userId: user?.id
            },
            include: {
                wishlist_items: true
            },
            data: {
                wishlist_items: {
                    deleteMany: [{
                        productId
                    }]
                }
            }
        })
        revalidatePath("/wishlist")
        return {
            data: null,
            status: "Success",
            successMessage: "Product removed from wishlist",
            statusCode: 200,
        }
    }
    catch (error) {
        return {
            errorMessage: "Failed to remove product from wishlist",
            status: "Error",
            statusCode: 500,
        }
    }
}