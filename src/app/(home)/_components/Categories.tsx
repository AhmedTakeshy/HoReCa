import {
    Carousel as CarouselComponent,
    CarouselContent,
    CarouselNext,
    CarouselPrevious,
} from "@/components/ui/carousel"

import { getCategories } from "@/_actions/categoryActions";
import { Button } from "../../../components/ui/button";
import Link from "next/link";
import CategoryProducts from "./CategoryProducts";



export default async function Categories() {
    const response = await getCategories();


    return (
        <>
            {response.status === "Success" && (
                response.data
                    .map((category, i) => (
                        <div key={i} className="xl:container mx-6 lg:max-w-screen-xl md:max-w-screen-md max-w-xs gap-4 flex flex-col items-center justify-between px-0 py-4 transition-colors duration-500 ease-in border lg:mb-20 md:mb-12 mt-8 mb-8 rounded-xl border-muted hover:bg-muted shadow-md">
                            <div className="flex items-center justify-start w-full gap-8 px-4">
                                <h2 className="text-2xl font-bold capitalize">{category}</h2>
                                <Button asChild className="px-4 py-2 mt-auto font-semibold transition-colors duration-300 ease-in border rounded-lg hover:bg-transparent hover:text-black hover:border-sky-800">
                                    <Link href={{ pathname: `/category`, query: { query: category, page: 1 } }}>
                                        View all
                                    </Link>
                                </Button>
                            </div>
                            <CarouselComponent
                                opts={{ align: "start", }}
                                orientation="horizontal"
                                className="mt-4 rounded-md xl:max-w-6xl lg:max-w-4xl md:max-w-2xl max-w-xs"
                            >
                                <CarouselContent className="lg:ml-0 ml-4">
                                    <CategoryProducts category={category} />
                                </CarouselContent>
                                <CarouselPrevious className="left-0 sm:-left-12" />
                                <CarouselNext className="right-0 sm:-right-12" />
                            </CarouselComponent>
                        </div>
                    )).slice(0, 5)
            )}
            <Button
                asChild
                className=" bg-indigo-400 font-medium text-white hover:bg-indigo-700 ml-auto flex w-fit mr-16 mb-8 -mt-4"
            >
                <Link
                    href={{
                        pathname: '/category', query: {
                            query: response.status === "Success" ?
                                response.data[Math.floor(Math.random() * response.data.length)] : "beauty",
                            page: 1
                        }
                    }}>
                    Shop Collection
                </Link>
            </Button>
        </>
    )
}
