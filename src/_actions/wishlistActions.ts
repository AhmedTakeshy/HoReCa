"use server"

import { revalidatePath } from "next/cache";
import { prisma } from "@/lib/prisma";
import { Wishlist, WishlistItem } from "@prisma/client";

type WishlistProps = {
    page?: number;
    search?: string;
    email: string;
}

type Metadata = {
    wishlist: {
        wishlist: Wishlist;
        wishlist_items: {
            wishlist_item: WishlistItem;
            product: Product;
        }[];
    };
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

export async function getWishlist({ email, page = 1 }: WishlistProps): Promise<ServerResponse<Metadata>> {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email,
            }
        })
        if (!user) {
            return {
                errorMessage: "User not found",
                status: "Error",
                statusCode: 404,
            }
        }

        const wishlist = await prisma.wishlist.findUnique({
            where: {
                userId: user.id
            },
            include: {
                wishlist_items: {
                    include: {
                        product: true
                    },
                    skip: (page - 1) * 12,
                    take: 12
                },
            },
        })

        if (!wishlist) {
            return {
                errorMessage: "Wishlist not found",
                status: "Error",
                statusCode: 404,
            }
        }

        const totalWishlistItems = await prisma.wishlistItem.count({
            where: {
                wishlistId: wishlist.id
            }
        })
        return {
            data: {
                wishlist: {
                    wishlist,
                    wishlist_items: wishlist.wishlist_items.map(wishlistItem => ({
                        wishlist_item: wishlistItem,
                        product: wishlistItem.product
                    }))
                },
                metadata: {
                    hastNextPage: totalWishlistItems > page * 12,
                    totalPages: Math.ceil(totalWishlistItems / 12)
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

export async function getWishlistItemsBySearch({ email, page = 1, search = "" }: WishlistProps): Promise<ServerResponse<Metadata>> {
    try {
        const user = await prisma.user.findUnique({
            where: {
                email,
            }
        })
        if (!user) {
            return {
                errorMessage: "User not found",
                status: "Error",
                statusCode: 404,
            }
        }
        const wishlist = await prisma.wishlist.findUnique({
            where: {
                userId: user.id,
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
                    },
                ],
            },
            include: {
                wishlist_items: {
                    include: {
                        product: true
                    },
                    skip: (page - 1) * 12,
                    take: 12
                }
            }
        })

        if (!wishlist) {
            return {
                errorMessage: "Wishlist not found",
                status: "Error",
                statusCode: 404,
            }
        }
        const totalWishlistItems = await prisma.wishlist.count({
            where: {
                userId: user.id,
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
                wishlist: {
                    wishlist,
                    wishlist_items: wishlist.wishlist_items.map(wishlistItem => ({
                        wishlist_item: wishlistItem,
                        product: wishlistItem.product
                    }))
                },
                metadata: {
                    hastNextPage: totalWishlistItems > page * 12,
                    totalPages: Math.ceil(totalWishlistItems / 12)
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
        if (!user) {
            return {
                errorMessage: "User not found",
                status: "Error",
                statusCode: 404,
            }
        }
        let wishlist = await prisma.wishlist.findUnique({
            where: {
                userId: user.id
            }
        })

        if (!wishlist) {
            wishlist = await prisma.wishlist.create({
                data: {
                    userId: user.id
                }
            })
        }
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
        revalidatePath("/profile/wishlist")
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
        revalidatePath("/profile/wishlist")
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