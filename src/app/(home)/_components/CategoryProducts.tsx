import { getProductsByCategory } from "@/_actions/productActions";
import CategoryItem from "./CategoryItem";
import { CarouselItem } from "@/components/ui/carousel";
type ProductsProps = {
    category: string;
}

export default async function CategoryProducts({ category }: ProductsProps) {
    const response = await getProductsByCategory({ category, page: 1 });

    return response.status === "Success" && response.data.products.map((product) => (
        <CarouselItem key={product.product.id} className="xl:basis-1/4 lg:basis-2/6 md:basis-2/4 sm:pl-3 md:pl-6">
            <CategoryItem data={product.product} quantity={product.quantity} />
        </CarouselItem>
    ))
}

