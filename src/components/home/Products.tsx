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
        if (result.status === "success") {
            setCategories(result.data);
        } else {
            return result.errorMessage;
        }
    }
    useEffect(() => {
        fetchCategories();
    }, [categories])

    return (
        categories.length > 0 && categories.map((category, index) => (
            <div key={index} className="flex flex-col items-center justify-between">
                <div className="flex items-center justify-start gap-6">
                    <h2 className="text-2xl font-bold mb-12">{category}</h2>
                    <Button asChild className="rounded-lg mt-auto hover:bg-blue-700 transition-colors duration-300 ease-in font-semibold py-2 px-4">
                        <Link href={`/${category}`}>
                            View all
                        </Link>
                    </Button>
                </div>
                <CarouselComponent
                    setApi={setApi}
                    opts={{ align: "start", }}>
                    <CarouselContent className="container p-8 my-20 gap-4 w-full h-full shadow-md rounded-md">
                        {
                            products.map((product, index) => (
                                product.category === category &&
                                <CarouselItem key={index} className="flex flex-col justify-center">
                                    <ProductItem data={product} />
                                </CarouselItem>
                            ))
                        }
                    </CarouselContent>
                    <CarouselPrevious className="left-0" />
                    <CarouselNext className="right-4" />
                </CarouselComponent>
            </div>
        ))
    )
}

