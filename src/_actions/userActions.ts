"use server"

import { prisma } from "@/lib/prisma";

type ProductsProps = {
    page?: number;
    search?: string | undefined;

}

type Metadata = {
    products: Product[]
    metadata: {
        hastNextPage?: boolean;
        totalPages?: number;
    }
}
export async function getProducts({ page = 1, search }: ProductsProps): Promise<ServerResponse<Metadata>> {
    try {
        const products = await prisma.product.findMany({
            where: {
                title: {
                    contains: search
                }
            },
            skip: (page - 1) * 10,
            take: 10
        })


        if (products.length > 0) {
            const totalProducts = await prisma.product.count()
            return {
                data: {
                    products,
                    metadata: {
                        hastNextPage: totalProducts > page * 10,
                        totalPages: Math.ceil(totalProducts / 10)
                    }
                },
                status: "Success",
                statusCode: 200,
                successMessage: "Products fetched successfully!",
            };
        } else {
            return { errorMessage: "There are no products at the moment!", status: "Error", statusCode: 400, };
        }

    } catch (err) {
        console.log(err)
        return { errorMessage: "Something wrong happened!", statusCode: 401, status: "Error", }
    }
}

export async function getProductsByCategory(category: string): Promise<ServerResponse<Metadata>> {
    try {
        const products = await prisma.product.findMany({
            where: {
                category,
            }
        })
        if (products.length > 0) {
            const totalProducts = await prisma.product.count()
            return {
                data: {
                    products,
                    metadata: {
                        hastNextPage: totalProducts > 10,
                        totalPages: Math.ceil(totalProducts / 10)
                    }
                }, status: "Success", statusCode: 200, successMessage: "Products fetched successfully!"
            };
        } else {
            return { errorMessage: "There are no products at the moment!", status: "Error", statusCode: 400, };
        }
    }
    catch (err) {
        console.log(err)
        return { errorMessage: "Something wrong happened!", statusCode: 401, status: "Error", }
    }
}


type FilterWithSort = {
    category: string;
    params: { [key: string]: string | undefined }
}
export async function getProductsByFilterAndSort({ category, params }: FilterWithSort): Promise<ServerResponse<Metadata>> {
    const sortMappings = {
        "highest-ratings": { type: "ratings", order: "desc" },
        "lowest-ratings": { type: "ratings", order: "asc" },
        "highest-price": { type: "price", order: "desc" },
        "lowest-price": { type: "price", order: "asc" },
    };

    const sortType = sortMappings[params.sorting as keyof typeof sortMappings] || sortMappings["highest-ratings"];

    try {
        const products = await prisma.product.findMany({
            where: {
                category,
                ratings: {
                    gte: params.ratings ? Number(params.ratings) : 0,
                    lte: 5
                },
                price: {
                    gte: params.price?.split("-")[0] ? Number(params.price?.split("-")[0]) : 0,
                    lte: params.price?.split("-")[1] ? Number(params.price?.split("-")[1]) : 10000,
                }
            },
            orderBy: {
                [sortType.type]: sortType.order
            }
        })
        if (products.length > 0) {
            const totalProducts = await prisma.product.count()

            return {
                data: {
                    products,
                    metadata: {
                        hastNextPage: totalProducts > 10,
                        totalPages: Math.ceil(totalProducts / 10)
                    }
                },
                status: "Success",
                statusCode: 200,
                successMessage: "Products fetched successfully!"
            };
        } else {
            return { errorMessage: "There are no products at the moment!", status: "Error", statusCode: 400, };
        }
    }
    catch (err) {
        console.log(err)
        return { errorMessage: "Something wrong happened!", statusCode: 401, status: "Error", }
    }
}

export async function getCategories(): Promise<ServerResponse<string[]>> {
    try {
        const categories: { category: string }[] = await prisma.product.findMany({
            select: {

                category: true,
            },
            distinct: ['category']
        })
        if (categories.length > 0) {
            const uniqueCategories = categories.map((category) => category.category)
            return { data: uniqueCategories, status: "Success", statusCode: 200, successMessage: "Categories fetched successfully!" };
        } else {
            return { errorMessage: "There are no categories at the moment!", status: "Error", statusCode: 400 };
        }
    } catch (err) {
        console.log(err)
        return { errorMessage: "Something wrong happened!", statusCode: 401, status: "Error" }
    }
}