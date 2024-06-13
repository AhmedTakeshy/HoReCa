"use server"
import { prisma } from "@/lib/prisma";

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