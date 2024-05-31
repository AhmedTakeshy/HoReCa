import { NextResponse } from "next/server";
import Stripe from "stripe";

export async function POST(request: Request) {
    const { products } = await request.json();
    const stripe = new Stripe(`${process.env.STRIPE_SECRET_KEY}`);
    const checkoutProducts = products.map((product: CartProduct) => {
        return {
            price_data: {
                currency: "usd",
                product_data: {
                    name: product.product.title,
                    images: [product.product.thumbnail],
                },
                unit_amount: product.product.price * 100,
            },
            quantity: product.quantity,
        };
    }
    );
    try {
        // Create Checkout Sessions from body params.
        const session = await stripe.checkout.sessions.create({
            payment_method_types: ["card"],
            line_items: checkoutProducts,
            mode: "payment",
            success_url: process.env.NEXTAUTH_URL + `/success?session_id={CHECKOUT_SESSION_ID}`,
            cancel_url: process.env.NEXTAUTH_URL + "/cart",
        });
        return NextResponse.json({ sessionId: session.id }, { status: 200 });
    } catch (err: any) {
        console.log("🚀 ~ POST ~ err:", err)
        return new NextResponse(err, {
            status: 400,
        });
    }
}