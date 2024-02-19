"use client";
import React from "react";
import { BackgroundGradient } from "@/components/background-gradient";
import Image from "next/image";
import ActionButton from "@/components/ActionButton";
import { BsCart3 } from "react-icons/bs";
import Stars from "./Stars";
import { Button } from "@/components/ui/button";


type ProductItemProps = {
    data: Product
    quantity?: number
}
export function ProductItem({ data, quantity }: ProductItemProps) {
    console.log("🚀 ~ ProductItem ~ data:", data)
    return (
        <div className="mt-8">
            <BackgroundGradient className="rounded-[22px] max-w-sm p-4 sm:p-10 bg-white dark:bg-zinc-900 h-[500px] flex flex-col justify-start">
                <Image
                    src={data.thumbnail}
                    alt="jordans"
                    height="400"
                    width="400"
                    className="object-fit rounded-xl max-h-52"
                />
                <div className="flex flex-col justify-between mt-3 h-full">
                    <div>
                        <p className="text-base sm:text-xl text-black mt-4 mb-2 dark:text-neutral-200">
                            {data.title}
                        </p>
                        <p className="text-sm text-neutral-600 dark:text-neutral-400 mb-2 line-clamp-2">
                            {data.description}
                        </p>
                        <Stars
                            count={data.ratings}
                        />
                    </div>
                    <div className="rounded-full pl-4 pr-2 py-1 text-white flex items-center justify-between space-x-4 bg-black mt-4 text-xs font-bold hover:bg-black">
                        <span className="">${data.price.toFixed(2)}</span>
                        <span className="bg-zinc-700 rounded-full text-[0.6rem] px-2 py-0 text-white">
                            <ActionButton quantity={quantity ?? 1} data={data} size="icon" className="flex justify-center items-center hover:bg-transparent bg-transparent text-white">
                                <BsCart3 className="w-5 h-5 hover:text-sky-500 " />
                            </ActionButton>
                        </span>
                    </div>
                </div>
            </BackgroundGradient>
        </div>
    );
}
