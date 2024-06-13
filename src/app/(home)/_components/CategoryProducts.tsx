import { getProductsByCategory } from "@/_actions/productActions";
import CategoryItem from "./CategoryItem";
import { CarouselItem } from "@/components/ui/carousel";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { getWishlistItems } from "@/_actions/wishlistActions";

type ProductsProps = {
    category: string;
}

export default async function CategoryProducts({ category }: ProductsProps) {
    const productsResponse = await getProductsByCategory({ category, page: 1 });
    const session = await getServerSession(authOptions)
    const wishlistItemsResponse = await getWishlistItems({ email: session?.user.email ?? "" })

    return productsResponse.status === "Success" && productsResponse.data.products.map((product) => (
        <CarouselItem key={product.product.id} className="xl:basis-1/4 lg:basis-2/6 md:basis-2/4 sm:pl-3 md:pl-6">
            <CategoryItem
                data={product.product}
                quantity={product.quantity}
                email={session?.user.email}
                wishlistItems={wishlistItemsResponse.status === "Success" ? wishlistItemsResponse.data : []}
            />
        </CarouselItem>
    ))
}

