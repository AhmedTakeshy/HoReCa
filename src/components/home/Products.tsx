"use client"
import { useState, useEffect } from "react";
import ProductItem from "./ProductItem";
import {
    CarouselApi,
    Carousel as CarouselComponent,
    CarouselContent,
    CarouselItem,
    CarouselNext,
    CarouselPrevious,
} from "@/components/ui/carousel"
import {
    Card,
    CardContent,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
} from "@/components/ui/card"

import { getCategories } from "@/_actions/userActions";
import Link from "next/link";
import { Button } from "../ui/button";

type Props = {
    products: Product[]
}

export default function Products({ products }: Props) {
    const [categories, setCategories] = useState<string[]>([])
    const [api, setApi] = useState<CarouselApi>()
    const [current, setCurrent] = useState(0)
    const [count, setCount] = useState(0)

    useEffect(() => {
        if (!api) {
            return
        }

        setCount(api.scrollSnapList().length)
        setCurrent(api.selectedScrollSnap() + 1)

        api.on("select", () => {
            setCurrent(api.selectedScrollSnap() + 1)
        })
    }, [api])

    async function fetchCategories(): Promise<string | void> {
        const result = await getCategories();
        console.log("🚀 ~ file: Products.tsx:41 ~ fetchCategories ~ result:", result)
        if (result.status === "success") {
            setCategories(result.data);
        } else {
            return result.errorMessage;
        }
    }

    useEffect(() => {
        fetchCategories();
    }, [])

    return (
        categories.length > 0 && categories.map((category, index) => (
            <div key={index} className="container flex flex-col items-center justify-between px-0 py-4 transition-colors duration-500 ease-in border my-36 rounded-xl border-muted hover:bg-muted">
                <div className="flex items-center justify-start w-full gap-8 px-4">
                    <h2 className="text-2xl font-bold capitalize">{category}</h2>
                    <Button asChild className="px-4 py-2 mt-auto font-semibold transition-colors duration-300 ease-in border rounded-lg hover:bg-transparent hover:text-white hover:border-gray-200">
                        <Link href={`/${category}`}>
                            View all
                        </Link>
                    </Button>
                </div>
                <CarouselComponent
                    setApi={setApi}
                    opts={{ align: "start", }}>
                    <CarouselContent className="container gap-4 px-0 mt-4 rounded-md shadow-md">
                        <CarouselItem key={index} className="flex w-full h-full">
                            {
                                products.map((product, index) => (
                                    product.category === category &&
                                    <ProductItem data={product} key={index} />
                                ))
                            }
                        </CarouselItem>
                    </CarouselContent>
                    <CarouselPrevious className="-left-8 dark:text-white" />
                    <CarouselNext className="-right-8" />
                </CarouselComponent>
            </div>
        ))
    )
}

