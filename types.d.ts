type Product = {
    id: number,
    publicId: string,
    title: string,
    description: string,
    price: number,
    ratings: number,
    stock: number,
    brand: string,
    category: string,
    thumbnail: string,
    images: string[],
    quantity: number
}

type Cart = {
    items: Product[],
    totalAmount: number,
    totalQuantity: number,
}

type ServerResponse<T> =
    { successMessage: string, data: T; status: "Success"; statusCode: number } |
    { errorMessage: string; status: "Error"; statusCode: number };