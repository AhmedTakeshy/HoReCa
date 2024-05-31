import { getProductById } from "@/_actions/productActions"
import ProductDetails from "./_components/ProductDetails"


type Props = {
    searchParams: { [key: string]: string | undefined }
}

export default async function page({ searchParams }: Props) {
    const query = searchParams.query
    const id = Number(query?.split("-").pop()?.slice(11, -10))
    const response = await getProductById({ id })
    if (response.status === "Error") {
        return (<h1 className="text-2xl font-semibold text-center">The page of the product is not available at the moment!</h1>)
    }
    const product = response.data
    return (
        <ProductDetails product={product} />
    )
}
