

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
}

type CartProduct = {
    product: Product,
    quantity: number,
}

type Cart = {
    cartProducts: CartProduct[],
    totalAmount: number,
    totalQuantity: number,
    isChanged?: boolean,
}

type ServerResponse<T> =
    { successMessage: string, data: T; status: "Success"; statusCode: number } |
    { errorMessage: string; status: "Error"; statusCode: number };

type User = {
    id: number;
    publicId: string;
    name: string;
    role: Role;
    email: string;
    updatedAt: Date;
    publicId: string;
    createdAt: Date;
}

enum Role {
    ADMIN,
    USER,
}

type WishlistItem = {
    id: number;
    publicId: string;
    productId: number;
    product: Product;
    wishlistId: number;
    createdAt: Date;
    updatedAt: Date;
}