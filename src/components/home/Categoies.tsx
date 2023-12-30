import { getProducts } from "@/_actions/userActions";
import Products from "./Products";



export default async function Categories() {
    const result = await getProducts({});
    return (
        result.status === "success" && <Products products={result.data} />
    )
}
