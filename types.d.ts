interface Product {
    id: number,
    name: string,
    price: number,
    image: string,
    description: string,
    category: string,
    stock: number,
    quantity: number,
}

interface Cart {
    items:Product[],
    totalAmount: number,
    totalQuantity: number,
}