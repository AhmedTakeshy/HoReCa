import Link from "next/link";
import { MdOutlinePhoneAndroid } from "react-icons/md";
import { dataList } from "@/lib/DUMMYDATA";
import ListItems from "./ListItems";
import Image from "next/image";
import Carousel from "./Carousel";

export default function Banner() {
    return (
        <div className="container mx-auto my-20 px-14">
            <div className="grid lg:grid-cols-[23%,75%] gap-5 relative">
                <ul className="flex flex-row items-start bg-white rounded-sm shadow-md lg:flex-col dark:bg-slate-700">
                    <li className="item px-4 py-[7px] w-full no-click"></li>
                    {dataList.map((item, index) => (
                        <li key={index} className="w-full mx-2 lg:mx-0 item group">
                            <Link href="#"
                                className="flex mr-2 lg:px-4 py-[11px] items-center justify-start space-x-2 dark:border-y-slate-700 border-y-white  w-full border-y  dark:border-l-slate-700 border-l-white border-l-4 dark:group-hover:border-y-[#001] group-hover:border-y-[#ccc] group-hover:lg:border-l-blue-800">
                                <MdOutlinePhoneAndroid className="hidden w-6 h-6 text-blue-700 lg:inline-flex" />
                                <span className="text-left ">{item.header}</span>
                            </Link>
                            <div
                                className="hidden absolute z-[1] lg:top-0 top-36 lg:right-0 right-24 rounded-br-sm lg:rounded-br-none w-[77%] lg:h-full rounded-r-sm place-content-start group-hover:grid grid-cols-4 bg-white dark:bg-slate-700 shadow-md dark:shadow-none hover:grid">
                                {Object.keys(item.data).map((key, index) => (
                                    <ListItems key={index} title={key} data={item.data[key]} />
                                ))}
                            </div>
                        </li>
                    ))}
                    <li className="item px-4 py-[7px] w-full no-click"></li>
                </ul>
                <div className="flex flex-col justify-between gap-5">
                <Carousel />
                    <div className="flex items-center justify-between gap-5 pr-4">
                        <div className="grid grid-cols-[auto,1fr] gap-4 place-items-center p-4 bg-white dark:bg-gray-700 shadow-md rounded">
                            <Image className="w-28 h-28 rounded-md" src="https://n11scdn.akamaized.net/a1/194/01/01/37/98/IMG-1916864032408453496.jpg" alt="oil photo" width={112} height={112}/>
                            <div className="flex flex-col justify-center">
                                <p className="mt-3">Motul Moto 4T 20W-40 Motorcycle Oil</p>
                                <div className="flex items-center justify-between mt-4">
                                    <p className="-mt-12 font-bold">₺ 190,89 - 194,79</p>
                                    <Image  className="w-16 h-16 rounded" src="/images/shipping.jpg" alt="shipping photo"width={64} height={64} />
                                </div>
                            </div>
                        </div>
                        <div className="grid grid-cols-[auto,1fr] gap-4 p-4 place-items-center bg-white dark:bg-gray-700 shadow-md rounded">
                            <Image  className="w-28 h-28 rounded-md" src="https://n11scdn.akamaized.net/a1/194/01/01/37/98/IMG-1916864032408453496.jpg" alt="oil photo"width={112} height={112} />
                            <div className="flex flex-col justify-center ">
                                <p className="mt-3">Motul Moto 4T 20W-40 Motorcycle Oil</p>
                                <div className="flex items-center justify-between mt-4">
                                    <p className="-mt-12 font-bold">₺ 190,89 - 194,79</p>
                                    <Image className="w-16 h-16 rounded" src="/images/shipping.jpg" alt="shipping photo" width={64} height={64}/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    )
}
