"use server"
export const getProducts = async (): Promise<ServerResponse<Product[]>> => {
    try {
        const loadingResponse: ServerResponse<Product[]> = { status: "loading" };

        const response = await fetch("https://dummyjson.com/products")

        if (response.ok) {
            const posts: Product[] = await response.json();
            return { data: posts, status: "success", statusCode: response.status };
        } else {
            const errorMessage = `Something wrong happened!! Status: ${response.status}`;
            return { error: errorMessage, status: "error", statusCode: response.status };
        }
        
    } catch (err) {
        console.log(err)
        return { error: "Something wrong happened!", statusCode: 401, status: "error" }
    }
}