import Link from 'next/link';
import React from 'react'
import { Skeleton } from "../ui/skeleton";
import { MdOutlinePhoneAndroid } from 'react-icons/md';

export default function LoadingBanner() {

    return (
        <div className="container mx-auto my-20 px-14">
            <div className="grid lg:grid-cols-[23%,75%] gap-5 relative">
                <ul className="flex flex-row items-start bg-white rounded-sm shadow-md lg:flex-col dark:bg-slate-700">
                    <li className="item px-4 py-[7px] w-full no-click">
                        <Skeleton className="w-full h-[40px] rounded-full" />
                    </li>
                    {Array.from({ length: 10 }).map((_, i) => (
                        <li key={i} className="w-full mx-2 lg:mx-0 item group">
                            <Link href="#" className="flex mr-2 lg:px-4 py-[11px] items-center justify-start space-x-2 dark:border-y-slate-700 border-y-white w-full border-y dark:border-l-slate-700 border-l-white border-l-4 dark:group-hover:border-y-[#001] group-hover:border-y-[#ccc] group-hover:lg:border-l-blue-800">
                                <MdOutlinePhoneAndroid className="hidden w-6 h-6 text-blue-700 lg:inline-flex" />
                                <Skeleton className="w-2/3 h-[20px] rounded-full" />
                            </Link>
                            <div className="hidden absolute z-[1] lg:top-0 top-36 lg:right-0 right-24 rounded-br-sm lg:rounded-br-none w-[77%] lg:h-full rounded-r-sm place-content-start group-hover:grid grid-cols-4 bg-white dark:bg-slate-700 shadow-md dark:shadow-none hover:grid">
                                {Array.from({ length: 4 }).map((_, index) => (
                                    <Skeleton key={index} className="w-full h-[120px] rounded-md" />
                                ))}
                            </div>
                        </li>
                    ))}
                    <li className="item px-4 py-[7px] w-full no-click">
                        <Skeleton className="w-full h-[40px] rounded-full" />
                    </li>
                </ul>
                <div className="flex flex-col justify-between gap-5">
                    <Skeleton className="h-[200px]" />
                    <div className="flex items-center justify-between gap-5">
                        <Skeleton className="w-28 h-28 rounded-md" />
                        <Skeleton className="w-28 h-28 rounded-md" />
                    </div>
                </div>
            </div>
        </div>
    );
}

