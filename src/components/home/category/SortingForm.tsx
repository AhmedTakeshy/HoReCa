"use client"

import {
    Select,
    SelectContent,
    SelectGroup,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select"
import { usePathname, useSearchParams } from "next/navigation"
import { useRouter } from "next/navigation"
import { useCallback } from "react"
import { toast } from "sonner"

export default function SortingForm() {
    const router = useRouter()
    const pathname = usePathname()
    const searchParams = useSearchParams()

    const createQueryString = useCallback(
        (name: string, value: string) => {
            const params = new URLSearchParams(searchParams.toString())
            params.set(name, value)

            return params.toString()
        },
        [searchParams]
    )

    const sortHandler = (value: string) => {
        const newQueryString = createQueryString("sorting", value)
        router.push(`${pathname}?${newQueryString}`, { scroll: false })
        toast.success("Sorting applied successfully!")
    }

    return (
        <Select onValueChange={sortHandler}>
            <SelectTrigger className="w-[180px] mt-0">
                <SelectValue placeholder="Highest rating" />
            </SelectTrigger>
            <SelectContent>
                <SelectGroup>
                    <SelectItem value="highest-ratings" >
                        Highest rating
                    </SelectItem>
                    <SelectItem value="lowest-ratings">
                        Lowest rating
                    </SelectItem>
                    <SelectItem value="highest-price">Highest price</SelectItem>
                    <SelectItem value="lowest-price">Lowest price</SelectItem>
                </SelectGroup>
            </SelectContent>
        </Select>
    )
}