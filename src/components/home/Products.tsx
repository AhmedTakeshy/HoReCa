import { getProducts } from "@/_actions/user"


export default async function Products() {
    const result = await getProducts();
    if (result.status === "loading") {
        return <div>Loading...</div>
    } else if (result.status === "success") {
        return <div>{result.data.map(item => (
            <p key={item.id}>{item.title}</p>
        ))}</div>
    } else {
        return <div>Error</div>
    }

    return (
        <div>
            {/* {result.data.map(item => (<p key={item.id}>{item.title}</p>))} */}
        </div>
    )
}
