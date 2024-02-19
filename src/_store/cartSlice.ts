import { createSlice, PayloadAction, } from "@reduxjs/toolkit";

const initialState: Cart = {
    cartProducts: [],
    totalAmount: 0,
    totalQuantity: 0,
    isChanged: false
};

const cartSlice = createSlice({
    initialState,
    name: "cart",
    reducers: {
        replaceCart(state, action: PayloadAction<Cart>) {
            const { cartProducts, totalAmount, totalQuantity } = action.payload;
            state.totalAmount = totalAmount;
            state.totalQuantity = totalQuantity;
            state.cartProducts = cartProducts;
            state.isChanged = false;
        },
        addToCart(state, action: PayloadAction<Product>) {
            const newProduct = action.payload;
            const existingProduct = state.cartProducts.find((item) => item.product.id === newProduct.id);
            if (!existingProduct) {
                state.cartProducts.push({
                    product: newProduct,
                    quantity: 1,
                });
            } else {
                existingProduct.quantity++;
            }
            state.totalQuantity++;
            state.totalAmount += newProduct.price;
            state.isChanged = true;
        },
        removeFromCart(state, action: PayloadAction<number>) {
            const productId = action.payload;
            const existingProduct = state.cartProducts.find((item) => item.product.id === productId);
            if (existingProduct && existingProduct.quantity === 1) {
                state.cartProducts = state.cartProducts.filter((item) => item.product.id !== productId);
            } else if (existingProduct) {
                existingProduct.quantity--;
            }
            state.totalQuantity--;
            state.totalAmount -= existingProduct!.product.price;
            state.isChanged = true;
        },
        deleteEntireProduct(state, action: PayloadAction<number>) {
            const productId = action.payload;
            const existingProduct = state.cartProducts.find((item) => item.product.id === productId);
            if (existingProduct) {
                state.totalQuantity -= existingProduct.quantity;
                state.totalAmount -= existingProduct.product.price * existingProduct.quantity;
                state.cartProducts = state.cartProducts.filter((item) => item.product.id !== productId);
            }
            state.isChanged = true;
        },
        clearCart(state) {
            state.cartProducts = [];
            state.totalAmount = 0;
            state.totalQuantity = 0;
            state.isChanged = true;
        },
    },
});

export const { addToCart, removeFromCart, clearCart, replaceCart } = cartSlice.actions;
export default cartSlice.reducer;