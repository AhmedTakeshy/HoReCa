type Product ={
    id: number,
    title: string,
    price: number,
    thumbnail: string,
    image: string[],
    brand: string,
    rating: number,
    description: string,
    category: string,
    stock: number,
    quantity: number,
}

type Cart ={
    items:Product[],
    totalAmount: number,
    totalQuantity: number,
}

type ServerResponse<T> =
    | { status: "loading" }
    | { data: T; status: "success"; statusCode: number }
    | { error: string; status: "error"; statusCode: number };