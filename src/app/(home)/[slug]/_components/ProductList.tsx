import { getProductsByFilterAndSort } from "@/_actions/productActions";
import SortingForm from "./SortingForm";
import { ProductItem } from "./ProductItem";
import FilterForm from "./FilterForm";
import PaginationControl from "@/components/PaginationControl";


type ProductListProps = {
    category: string
    searchParams: { [key: string]: string | undefined }
}

export default async function ProductList({ category, searchParams }: ProductListProps) {

    const response = await getProductsByFilterAndSort({ category, params: searchParams });
    const page = Number(searchParams.page) || 1;


    return (
        <div className="grid md:grid-cols-[1fr,3fr] gap-8 ">
            <FilterForm />
            {response?.status === "Success" ?
                <div className="flex items-center gap-8 md:gap-0 flex-col justify-between w-full md:border-l-2 md:px-8">
                    <div className="flex items-center justify-between pb-8 md:w-full md:gap-0 sm:gap-8 gap-4 border-b-2 md:px-2 mx-2 md:mx-0">
                        <h2>There are <span className="font-semibold">{response.data.products.length}</span> products of {category}</h2>
                        <SortingForm />
                    </div>
                    <div className="grid lg:grid-cols-2 gap-12 place-items-center">
                        {response.data.products.map((product) => <ProductItem key={product.product.id} data={product.product} quantity={product.quantity} />)}
                    </div>
                    <PaginationControl
                        className=" w-full"
                        currentPage={page}
                        metadata={response.data.metadata} />
                </div>
                :
                <h2 className="text-lg font-semibold text-center">There are no products with this filter at the moment!</h2>}
        </div>
    )
}