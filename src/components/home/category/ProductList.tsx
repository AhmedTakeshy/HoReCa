import { getProductsByFilterAndSort } from "@/_actions/userActions";
import SortingForm from "./SortingForm";
import { ProductItem } from "./ProductItem";
import FilterForm from "./FilterForm";


type ProductListProps = {
    category: string
    searchParams?: { [key: string]: string | undefined }
}

export default async function ProductList({ category, searchParams }: ProductListProps) {

    const response = await getProductsByFilterAndSort({ category, params: searchParams || {} });


    return (
        <div className="grid lg:grid-cols-[1fr,3fr] gap-8 ">
            <FilterForm />
            {response?.status === "Success" ?
                <div className="flex items-center flex-col justify-between w-full border-l-2 px-8">
                    <div className="flex items-center justify-between pb-8 w-full border-b-2 px-2">
                        <h2>There are <span className="font-semibold">{response.data.products.length}</span> products of {category}</h2>
                        <SortingForm />
                    </div>
                    <div className="grid grid-cols-2 gap-12">
                        {response.data.products.map((product) => <ProductItem key={product.id} data={product} />)}
                    </div>
                </div> :
                <h2 className="text-lg font-semibold text-center">There are no products with this filter at the moment!</h2>}
        </div>
    )
}