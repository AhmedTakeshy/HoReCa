type Product ={
    id: number,
    publicId: string,
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
    | { data: T; status: "success"; statusCode: number }
    | { errorMessage: string; status: "error"; statusCode: number };