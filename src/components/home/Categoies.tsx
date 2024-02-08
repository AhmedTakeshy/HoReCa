import {
    Carousel as CarouselComponent,
    CarouselContent,
    CarouselItem,
    CarouselNext,
    CarouselPrevious,
} from "@/components/ui/carousel"

import { getCategories } from "@/_actions/userActions";
import { Button } from "../ui/button";
import Link from "next/link";
import Products from "./Products";



export default async function Categories() {
    const response = await getCategories();


    return (
        response.status === "Success" && response.data.map((category, i) => (
            <div key={i} className="container flex flex-col items-center justify-between px-0 py-4 transition-colors duration-500 ease-in border my-36 rounded-xl border-muted hover:bg-muted">
                <div className="flex items-center justify-start w-full gap-8 px-4">
                    <h2 className="text-2xl font-bold capitalize">{category}</h2>
                    <Button asChild className="px-4 py-2 mt-auto font-semibold transition-colors duration-300 ease-in border rounded-lg hover:bg-transparent hover:text-white hover:border-gray-200">
                        <Link href={`/${category}`}>
                            View all
                        </Link>
                    </Button>
                </div>
                <CarouselComponent
                    opts={{ align: "start", }}
                    orientation="horizontal"
                    className="w-full gap-4 px-0 mt-4 rounded-md shadow-md mx-4"
                >
                    <CarouselContent>
                        <CarouselItem key={i} className="flex justify-center items-start gap-4">
                            <Products category={category} />
                        </CarouselItem>
                    </CarouselContent>
                    <CarouselPrevious className="-left-8 dark:text-white" />
                    <CarouselNext className="-right-8" />
                </CarouselComponent>
            </div>
        ))
    )
}
