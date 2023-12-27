import Link from "next/link"



type ListItemsProps = {
    title: string,
    data: string[]
}
export default function ListItems({ title, data }: ListItemsProps) {

    return (
        <div className="flex flex-col items-start px-5 mt-12 border-none item">
            <h3 className="mb-4 text-sm font-medium text-mid-blue">
                <Link href={`/${title}`}>{title.length > 20 ? title.split(",")[0] : title}</Link>
            </h3>
            <ul className="mb-4">
                {data.map((item, index) => (
                    <li className="text-black" key={index}>
                        <Link href={`/${title}/${item}`} className="text-[13px]">{item}</Link>
                    </li>
                ))}

            </ul>
            {data.length > 5 && <Link href="#" className="text-mid-blue text-[13px]">Show more</Link>}
        </div>
    )

}
