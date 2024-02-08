import { getProductsByCategory } from "@/_actions/userActions";
import ProductItem from "./ProductItem";


export default async function Products({ category }: { category: string }) {
    const response = await getProductsByCategory(category);

    return response.status === "Success" &&
        response.data.map(product => <ProductItem key={product.id} data={product} />)
}

