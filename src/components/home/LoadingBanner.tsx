import Link from 'next/link';
import React from 'react'
import { Skeleton } from "../ui/skeleton";
import { MdOutlinePhoneAndroid } from 'react-icons/md';

export default function LoadingBanner() {

    return (
        <div className="container mx-auto mt-10 mb-20 px-14">
            <Skeleton className=" w-full h-[calc(100vh-10rem)] rounded-md" />
        </div>
    );
}

