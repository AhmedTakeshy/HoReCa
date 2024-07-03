import { getOrderById } from "@/_actions/orderActions";
import OrderItems from "../_components/orderItems";

type Props = {
    searchParams?: { [key: string]: string };
};

export default async function page({ searchParams }: Props) {
    const orderId = searchParams?.query.slice(11, -10);
    const response = await getOrderById(Number(orderId));
    return (
        response.status === "Success" ? (
            <div className="mx-auto max-w-3xl px-4 py-16 sm:px-6 sm:py-24 lg:px-8">
                <div className="max-w-xl">
                    <h1 className="text-base font-medium text-indigo-600">Thank you!</h1>
                    <p className="mt-2 text-4xl font-bold tracking-tight sm:text-5xl">It's on the way!</p>
                    <p className="mt-2 text-base text-gray-500">
                        Your order #<span className="text-indigo-600 hover:underline">{searchParams?.query} </span>has shipped and will be with you soon.</p>
                </div>
                <div className="mt-10 border-t border-gray-200">
                    <h2 className="sr-only">Your order</h2>
                    <h3 className="sr-only">Items</h3>
                    {response.data.order_items.map((orderItem) => (
                        <OrderItems
                            imgClass="rounded-2xl lg:rounded-lg"
                            key={orderItem.product.id}
                            product={orderItem.product}
                            status={response.data.status}
                            quantity={orderItem.quantity}
                            expectedDeliveryTime={orderItem.createdAt}
                        />
                    ))}
                </div>
            </div>
        ) : (
            <div className="mx-auto max-w-3xl px-4 py-16 sm:px-6 sm:py-24 lg:px-8">
                <div className="max-w-xl">
                    <h1 className="text-base font-medium text-rose-600">Uh oh!</h1>
                    <p className="mt-2 text-4xl font-bold tracking-tight sm:text-5xl">Something went wrong.</p>
                    <p className="mt-2 text-base text-gray-500">We couldn't find your order. Please try again later.</p>
                </div>
            </div>
        )
    )
}
