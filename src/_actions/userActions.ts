"use server"
type ProductsProps = {
    page?: number;
    search?: string | undefined;

}
export const getProducts = async ({ page = 1, search }: ProductsProps): Promise<ServerResponse<Product[]>> => {
    try {
        // let url = `https://dummyjson.com/products?limit=10&page=${page}`

        const response = await fetch("https://dummyjson.com/products")
        if (response.ok) {
            const res = await response.json();
            const posts: Product[] = res.products;
            return { data: posts, status: "success", statusCode: response.status };
        } else {
            return { errorMessage: "There are no products at the moment!", status: "error", statusCode: response.status };
        }

    } catch (err) {
        console.log(err)
        return { errorMessage: "Something wrong happened!", statusCode: 401, status: "error" }
    }
}

export const getCategories = async (): Promise<ServerResponse<string[]>> => {
    try {
        const response = await fetch("https://dummyjson.com/products/categories")
        console.log("🚀 ~ file: userActions.ts:33 ~ getCategories ~ response:", response)
        if (response.ok) {
            const res = await response.json();
            const posts: string[] = res.categories;
            return { data: posts, status: "success", statusCode: response.status };
        } else {
            return { errorMessage: "There are no categories at the moment!", status: "error", statusCode: response.status };
        }
    } catch (err) {
        console.log(err)
        return { errorMessage: "Something wrong happened!", statusCode: 401, status: "error" }
    }
}