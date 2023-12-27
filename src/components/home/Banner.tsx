import Link from "next/link";
import { MdOutlinePhoneAndroid } from "react-icons/md";
import { dataList } from "@/lib/DUMMYDATA";
import ListItems from "./ListItems";

export default function Banner() {
    return (
        <div className="container mx-auto px-14">
            <div className="grid grid-cols-[23%,75%] gap-5 mb-8 pt-8 relative">
                <ul className="flex flex-col items-start bg-white rounded-sm shadow-md">
                    <li className="item px-4 py-[7px] w-full no-click"></li>
                    {dataList.map((item, index) => (
                        <li key={index} className="w-full item group">
                            <Link href="#"
                                className="flex mr-2 px-4 py-[11px] items-center justify-start space-x-2 border-y-white w-full border-y  border-l-white border-l-4 group-hover:border-y-[#ccc] group-hover:border-l-blue-800">
                                <MdOutlinePhoneAndroid className="w-6 h-6 text-blue-700" />
                                <span className="text-left text-black">{item.header}</span>
                            </Link>
                            <div
                                className="hidden absolute z-[1] top-8 right-0 w-[77%] fill group-hover:grid grid-cols-4 bg-white hover:grid">
                                {Object.keys(item.data).map((key, index) => (
                                    <ListItems key={index} title={key} data={item.data[key]} />
                                ))}
                            </div>
                        </li>
                    ))}
                    <li className="item px-4 py-[7px] w-full no-click"></li>
                </ul>
                <div className="flex flex-col justify-between gap-5">
                    <div className="flex items-center justify-between gap-5">
                        <div className="grid grid-cols-[auto,1fr] gap-4 place-items-center p-4 bg-white shadow-md rounded-sm">
                            <img className="w-28 h-28" src="https://n11scdn.akamaized.net/a1/194/01/01/37/98/IMG-1916864032408453496.jpg"
                                alt="oil photo">
                                <div className="flex flex-col justify-center">
                                    <p className="mt-3">Motul Moto 4T 20W-40 Motorcycle Oil</p>
                                    <div className="flex items-center justify-start">
                                        <p className="mr-6 font-bold">₺ 190,89 - 194,79</p>
                                        <img className="w-16 h-16" src="/images/shipping.jpg" alt="shipping photo">
                                    </div>
                                </div>
                        </div>
                        <div className="grid grid-cols-[auto,1fr] gap-4 p-4 place-items-center bg-white shadow-md rounded-sm">
                            <img className="w-28 h-28" src="https://n11scdn.akamaized.net/a1/194/01/01/37/98/IMG-1916864032408453496.jpg" alt="oil photo">
                                <div className="flex flex-col justify-center ">
                                    <p className="mt-3">Motul Moto 4T 20W-40 Motorcycle Oil</p>
                                    <div className="flex items-center justify-start">
                                        <p className="mr-6 font-bold">₺ 190,89 - 194,79</p>
                                        <img className="w-16 h-16" src="/images/shipping.jpg" alt="shipping photo">
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
