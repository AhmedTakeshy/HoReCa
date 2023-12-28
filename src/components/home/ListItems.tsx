import Link from "next/link"

type ListItemsProps = {
    title: string,
    data: string[]
}
export default function ListItems({ title, data }: ListItemsProps) {
    const updateTitle = title.toLowerCase().replace(/[,\s]+/g, "-")
    return (
        <div className="flex flex-col items-start px-5 mt-10 border-none ">
            <h3 className="mb-4 text-sm font-medium text-blue-600">
                <Link href={`/${updateTitle}`}>{title.length > 20 ? title.split(",")[0] : title}</Link>
            </h3>
            <ul className="mb-4 border-none">
                {data.map((item, index) => {
                    const updateItem = item.toLowerCase().replace(/[,\s]+/g, "-")
                    return (
                        <li className="" key={index}>
                            <Link href={`/${updateTitle}/${updateItem}`} className="text-[13px]">{item}</Link>
                        </li>
                    )
                })}

            </ul>
            {data.length > 5 && <Link href="#" className="text-blue-400 text-[13px]">Show more</Link>}
        </div>
    )

}
