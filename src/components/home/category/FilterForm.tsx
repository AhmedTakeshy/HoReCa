"use client"
import { CaretSortIcon, CheckIcon } from "@radix-ui/react-icons"

import { cn } from "@/lib/utils"
import { Button, buttonVariants } from "@/components/ui/button"
import {
    Command,
    CommandEmpty,
    CommandGroup,
    CommandInput,
    CommandItem,
} from "@/components/ui/command"
import {
    Popover,
    PopoverContent,
    PopoverTrigger,
} from "@/components/ui/popover"
import { toast } from "sonner"
import { useCallback, useEffect, useState } from "react"
import { getCategories } from "@/_actions/userActions"
import { Label } from "@/components/ui/label"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group"
import { usePathname, useSearchParams } from "next/navigation"
import { useRouter } from "next/navigation"
import Link from "next/link"

export default function FilterForm() {
    const router = useRouter()
    const pathname = usePathname()
    const searchParams = useSearchParams()
    const [open, setOpen] = useState<boolean>(false)
    const [value, setValue] = useState<string>("")
    const [categories, setCategories] = useState<{ label: string, value: string }[]>([
        {
            label: "",
            value: ""
        }
    ])

    useEffect(() => {
        const fetchCategories = async () => {
            const response = await getCategories()
            if (response.status === "Success") {
                setCategories((prev) => [...response.data
                    .map((category) => ({ label: category.toUpperCase(), value: category.toLowerCase() }))])
            } else {
                toast.error(response.errorMessage)
            }
        }
        fetchCategories()
    }, [])

    const createQueryString = useCallback(
        (name: string, value: string) => {
            const params = new URLSearchParams(searchParams.toString())
            params.set(name, value)

            return params.toString()
        },
        [searchParams]
    )

    const ratingHandler = (value: string) => {
        const newQueryString = createQueryString("ratings", value)
        router.push(`${pathname}?${newQueryString}`, { scroll: false })
        toast.success("Rating filter applied successfully!")
    }
    const priceHandler = (value: string) => {
        const newQueryString = createQueryString("price", value)
        router.push(`${pathname}?${newQueryString}`, { scroll: false })
        toast.success("Price filter applied successfully!")
    }

    return (
        <div className='flex flex-col items-start gap-5 border-2 rounded-xl py-4 px-8 h-fit'>
            <h2 className="text-lg">Filter</h2>
            <Popover open={open} onOpenChange={setOpen}>
                <PopoverTrigger asChild>
                    <Button
                        variant="outline"
                        role="combobox"
                        aria-expanded={open}
                        className="w-[200px] justify-between"
                    >
                        {value
                            ? categories.find((category) => category.value === value)?.label
                            : "Select category..."}
                        <CaretSortIcon className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                    </Button>
                </PopoverTrigger>
                <PopoverContent className="w-[200px] p-0">
                    <Command>
                        <CommandInput placeholder="Search category..." className="h-9" />
                        <CommandEmpty>No category found.</CommandEmpty>
                        <CommandGroup>
                            {categories.map((category) => (
                                <CommandItem
                                    key={category.value}
                                    value={category.value}
                                    onSelect={(currentValue) => {
                                        setValue(currentValue === value ? "" : currentValue)
                                        router.push(currentValue)
                                        setOpen(false)
                                    }}
                                >
                                    {category.label}
                                    <CheckIcon
                                        className={cn(
                                            "ml-auto h-4 w-4",
                                            value === category.value ? "opacity-100" : "opacity-0"
                                        )}
                                    />
                                </CommandItem>
                            ))}
                        </CommandGroup>
                    </Command>
                </PopoverContent>
            </Popover>
            <RadioGroup onValueChange={ratingHandler}>
                <Label>Ratings</Label>
                <div className="flex items-center space-x-2">
                    <RadioGroupItem value="1" id="r1" />
                    <Label htmlFor="r1">1 start and above</Label>
                </div>
                <div className="flex items-center space-x-2">
                    <RadioGroupItem value="2" id="r2" />
                    <Label htmlFor="r2">2 stars and above</Label>
                </div>
                <div className="flex items-center space-x-2">
                    <RadioGroupItem value="3" id="r3" />
                    <Label htmlFor="r3">3 stars and above</Label>
                </div>
                <div className="flex items-center space-x-2">
                    <RadioGroupItem value="4" id="r4" />
                    <Label htmlFor="r4">4 stars and above</Label>
                </div>
                <div className="flex items-center space-x-2">
                    <RadioGroupItem value="5" id="r5" />
                    <Label htmlFor="r5">5 stars</Label>
                </div>
            </RadioGroup>
            <div className="w-full mb-2 gap-2">
                <RadioGroup onValueChange={priceHandler}>
                    <Label>Price</Label>
                    <div className="flex items-center space-x-2">
                        <RadioGroupItem className="rounded" value="0-500" id="p1" />
                        <Label htmlFor="p1">$0 - $500</Label>
                    </div>
                    <div className="flex items-center space-x-2">
                        <RadioGroupItem className="rounded" value="500-1500" id="p2" />
                        <Label htmlFor="p2">$500 - $1500</Label>
                    </div>
                    <div className="flex items-center space-x-2">
                        <RadioGroupItem className="rounded" value="1500-3000" id="p3" />
                        <Label htmlFor="p3">$1500 - $3000</Label>
                    </div>
                    <div className="flex items-center space-x-2">
                        <RadioGroupItem className="rounded" value="3000-5000" id="p4" />
                        <Label htmlFor="p4">$3000 - $5000</Label>
                    </div>
                    <div className="flex items-center space-x-2">
                        <RadioGroupItem className="rounded" value="5000-" id="p5" />
                        <Label htmlFor="p5">$5000+</Label>
                    </div>
                </RadioGroup>
            </div>
            <Link className={`${buttonVariants({ variant: "default" })}`} href={`${pathname}`}>Reset filters</Link>
        </div>
    )
}