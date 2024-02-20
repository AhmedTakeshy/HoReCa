"use server"
import { prisma } from "@/lib/prisma";


type ProductsProps = {
    page?: number;
    search?: number;

}

type Metadata = {
    products: CartProduct[]
    metadata: {
        hastNextPage: boolean;
        totalPages: number;
    }
}

export const getProductBySearch = async ({ search }: ProductsProps): Promise<ServerResponse<Product>> => {
    try {
        const product = await prisma.product.findUnique({
            where: {
                id: search
            }
        })
        if (product) {
            return { data: product, status: "Success", statusCode: 200, successMessage: "Product fetched successfully!" }
        } else {
            return { errorMessage: "Product not found!", status: "Error", statusCode: 400, }
        }
    } catch (err) {
        console.log(err)
        return { errorMessage: "Something wrong happened!", statusCode: 401, status: "Error", }
    }

}

export async function getProducts({ page = 1 }: ProductsProps): Promise<ServerResponse<Metadata>> {
    try {
        const products = await prisma.product.findMany({
            skip: (page - 1) * 6,
            take: 6
        })

        if (products.length > 0) {
            const totalProducts = await prisma.product.count()
            const formattedProducts: CartProduct[] = products.map(product => ({ product: { ...product, quantity: 0 }, quantity: 0 }))
            return {
                data: {
                    products: formattedProducts,
                    metadata: {
                        hastNextPage: totalProducts > page * 6,
                        totalPages: Math.ceil(totalProducts / 6)
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

type Category = {
    category: string;
    page: number;

}
export async function getProductsByCategory({ category, page = 1 }: Category): Promise<ServerResponse<Metadata>> {
    try {
        const products = await prisma.product.findMany({
            where: {
                category,
            },
            skip: (page - 1) * 6,
            take: 6
        })
        if (products.length > 0) {
            const totalProducts = await prisma.product.count({
                where: {
                    category
                }
            })
            const formattedProducts: CartProduct[] = products.map(product => ({ product: { ...product, quantity: 0 }, quantity: 0 }))
            return {
                data: {
                    products: formattedProducts,
                    metadata: {
                        hastNextPage: totalProducts > 6,
                        totalPages: Math.ceil(totalProducts / 6)
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

    params: { [key: string]: string | undefined }
}
export async function getProductsByFilterAndSort({ params }: FilterWithSort): Promise<ServerResponse<Metadata>> {
    const sortMappings = {
        "highest-ratings": { type: "ratings", order: "desc" },
        "lowest-ratings": { type: "ratings", order: "asc" },
        "highest-price": { type: "price", order: "desc" },
        "lowest-price": { type: "price", order: "asc" },
    };

    const sortType = sortMappings[params.sorting as keyof typeof sortMappings] || sortMappings["highest-ratings"];
    const category = params.query
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
            },
            skip: (Number(params.page || 1) - 1) * 6,
            take: 6
        })
        if (products.length > 0) {
            const totalProducts = await prisma.product.count({
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
                }
            })
            const formattedProducts: CartProduct[] = products.map(product => ({ product: { ...product, quantity: 0 }, quantity: 0 }))
            return {
                data: {
                    products: formattedProducts,
                    metadata: {
                        hastNextPage: totalProducts > 6,
                        totalPages: Math.ceil(totalProducts / 6)
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