import { createSlice, PayloadAction, } from "@reduxjs/toolkit";


const initialState:Cart = {
    items: [],
    totalAmount: 0,
    totalQuantity: 0,
    };

const cartSlice = createSlice({
    initialState,
    name: "cart",
    reducers: {
        addToCart(state, action: PayloadAction<Product>) {
            const product = action.payload;
            const existingProduct = state.items.find((item) => item.id === product.id);
            if (!existingProduct) {
                state.items.push({
                    ...product,
                    quantity: 1,
                });
            } else {
                existingProduct.quantity++;
            }
            state.totalQuantity++;
            state.totalAmount += product.price;
        },
        removeFromCart(state, action: PayloadAction<number>) {
            const productId = action.payload;
            const existingProduct = state.items.find((item) => item.id === productId);
            if (existingProduct && existingProduct.quantity === 1) {
                state.items = state.items.filter((item) => item.id !== productId);
            } else if (existingProduct) {
                existingProduct.quantity--;
            }
            state.totalQuantity--;
            state.totalAmount -= existingProduct!.price;
        },
        deleteEntireProduct(state, action: PayloadAction<number>) {
            const productId = action.payload;
            const existingProduct = state.items.find((item) => item.id === productId);
            if (existingProduct) {
                state.totalQuantity -= existingProduct.quantity;
                state.totalAmount -= existingProduct.price * existingProduct.quantity;
                state.items = state.items.filter((item) => item.id !== productId);
            }
        },
        clearCart(state) {
            state.items = [];
            state.totalAmount = 0;
            state.totalQuantity = 0;
        },
    },
});

export const { addToCart, removeFromCart, clearCart } = cartSlice.actions;
export default cartSlice.reducer;