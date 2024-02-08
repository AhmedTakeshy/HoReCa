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

        const totalProducts = await prisma.product.count()

        if (products.length > 0) {
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

export async function getProductsByCategory(category: string): Promise<ServerResponse<Product[]>> {
    try {
        const products = await prisma.product.findMany({
            where: {
                category
            },
        })
        if (products.length > 0) {
            return { data: products, status: "Success", statusCode: 200, successMessage: "Products fetched successfully!" };
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