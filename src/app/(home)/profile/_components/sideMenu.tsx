"use client";
import { useCallback, useState } from 'react'
import { usePathname, useRouter, useSearchParams } from 'next/navigation'
import Link from 'next/link';
import { BsBox2Heart } from 'react-icons/bs';
import { signOut } from 'next-auth/react';
import { HiOutlineLogout } from "react-icons/hi";
import { IoSettingsOutline } from "react-icons/io5";
import { FaRegUser } from "react-icons/fa";
import { IoIosArrowUp } from "react-icons/io";
import { TfiMoreAlt } from "react-icons/tfi";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuGroup,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuSub,
    DropdownMenuSubContent,
    DropdownMenuSubTrigger,
    DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import { Command, CommandInput, CommandList, CommandEmpty, CommandGroup, CommandItem } from '@/components/ui/command'
import { Button } from '@/components/ui/button';
import { GoHeartFill } from 'react-icons/go';



type SideMenuProps = {
    name: string
}


export default function SideMenu({ name }: SideMenuProps) {
    const options = ["membership", "password", "communication"]
    const [open, setOpen] = useState<boolean>(false)
    const searchParams = useSearchParams()
    const type = searchParams.get('type')
    const isIncluded = type && ["membership", "password", "communication"].includes(type)
    const pathname = usePathname()
    const router = useRouter()

    const createQueryString = useCallback((name: string, value: string) => {
        const params = new URLSearchParams(searchParams.toString())
        params.set(name, value)

        return params.toString()
    }, [searchParams])

    const handleMenu = (sel: string = "membership") => {
        router.push("/profile?" + createQueryString('type', sel))
    }

    return (
        <>
            <aside className="flex lg:hidden w-auto mb-6 justify-between rounded-md border px-4 py-3 flex-row items-center mx-2">
                <p className="text-sm font-medium leading-none">
                    {!!isIncluded && (
                        <span className="mr-2 rounded-lg bg-primary px-2 py-1 text-xs text-primary-foreground">
                            {type}
                        </span>
                    )}
                    <span className="text-muted-foreground capitalize">{!!isIncluded ? "Profile" : pathname.split("/")[pathname.split("/").includes("profile") ? 2 : 1]}</span>
                </p>
                <DropdownMenu open={open} onOpenChange={setOpen}>
                    <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="sm">
                            <TfiMoreAlt />
                        </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end" className="w-[175px]">
                        <DropdownMenuLabel>Profile</DropdownMenuLabel>
                        <DropdownMenuGroup>
                            <DropdownMenuItem>
                                <BsBox2Heart className="mr-2 h-4 w-4" />
                                <Link href="/profile/orders?page=1">
                                    Orders
                                </Link>
                            </DropdownMenuItem>
                            <DropdownMenuItem>
                                <GoHeartFill className="w-4 h-4 mr-2 group-hover:animate-pumping-heart group-hover:text-red-600 " />
                                <Link href="/wishlist">
                                    Wishlist
                                </Link>
                            </DropdownMenuItem>
                            <DropdownMenuItem disabled>
                                <IoSettingsOutline className="w-4 h-4 mr-2" />
                                <Link href="/#">
                                    Settings
                                </Link>
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuSub>
                                <DropdownMenuSubTrigger>
                                    <FaRegUser className="mr-2 h-4 w-4" />
                                    Profile
                                </DropdownMenuSubTrigger>
                                <DropdownMenuSubContent className="p-0">
                                    <Command>
                                        <CommandInput
                                            placeholder="Filter option..."
                                            autoFocus={true}
                                        />
                                        <CommandList>
                                            <CommandEmpty>No option found.</CommandEmpty>
                                            <CommandGroup>
                                                {options.map((option) => (
                                                    <CommandItem
                                                        asChild
                                                        key={option}
                                                        value={option}
                                                        onSelect={() => setOpen(false)}
                                                    >
                                                        <Link href={{ pathname: "/profile", query: { type: option } }}>
                                                            {option}
                                                        </Link>
                                                    </CommandItem>
                                                ))}
                                            </CommandGroup>
                                        </CommandList>
                                    </Command>
                                </DropdownMenuSubContent>
                            </DropdownMenuSub>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem className="text-red-600" onClick={() => signOut({ callbackUrl: "/" })}>
                                <HiOutlineLogout className="mr-2 h-4 w-4" />
                                Logout
                            </DropdownMenuItem>
                        </DropdownMenuGroup>
                    </DropdownMenuContent>
                </DropdownMenu>
            </aside>

            <aside className="relative lg:flex hidden flex-col w-1/12 md:w-1/6 min-h-screen text-gray-800 items-start lg:pl-6 pl-2 lg:border-r-2 pt-6">
                <div className="flex items-baseline justify-start gap-12">
                    <span
                        className="flex items-center justify-center w-12 h-12 text-xl font-extrabold text-center rounded-full dark:bg-slate-300 dark:text-slate-800 text-slate-200 bg-slate-600">
                        {name.split(" ").map((n) => n[0]).join("")}
                    </span>
                    <h1 className="font-bold text-slate-500 font-2xl -ml-9">{name}</h1>
                </div>
                <div className="flex-grow overflow-x-hidden overflow-y-auto">
                    <ul className="flex flex-col py-4 space-y-2">
                        <li className="px-5">
                            <div className="flex flex-row items-start h-8">
                                <span className="text-sm font-light tracking-wide dark:text-gray-400">Menu</span>
                            </div>
                        </li>
                        <li>
                            <Link href="/profile/orders?page=1"
                                className={`relative flex text-gray-600 flex-row items-center pr-6 border-l-4 h-11 focus:outline-none ${pathname.includes("orders") ? "bg-gray-200 text-gray-800 border-indigo-500 rounded-r-lg border-l-4 " : "border-transparent"} hover:bg-gray-200 hover:text-gray-800 hover:border-indigo-500 hover:rounded-r-lg`}>
                                <BsBox2Heart className="inline-flex items-center justify-center w-5 h-5 ml-4" />
                                <span className="ml-2 text-sm font-semibold tracking-wide">Orders</span>
                            </Link>
                        </li>
                        <li>
                            <Link href="/profile/wishlist?page=1"
                                className={`relative flex text-gray-600 flex-row items-center pr-6 border-l-4 h-11 focus:outline-none ${pathname.includes("wishlist") ? "bg-gray-200 text-gray-800 border-indigo-500 rounded-r-lg border-l-4 " : "border-transparent"} hover:bg-gray-200 hover:text-gray-800 hover:border-indigo-500 hover:rounded-r-lg`}>
                                <GoHeartFill className="inline-flex items-center justify-center w-5 h-5 ml-4 group-hover:animate-pumping-heart group-hover:text-red-600" />
                                <span className="ml-2 text-sm font-semibold tracking-wide">Wishlist</span>
                            </Link>
                        </li>
                        <li
                            className={`relative rounded-r-lg inset-0 ${isIncluded ? "bg-gray-50 border-solid border-indigo-500 border-l-4" : ""} `}>
                            <span
                                role="button"
                                onClick={() => handleMenu()}
                                className={`relative flex flex-row items-center pr-6 text-gray-600 border-l-4 border-transparent hover:rounded-r-lg group h-11 focus:outline-none ${!isIncluded ? "hover:border-indigo-500 hover:bg-gray-200 hover:text-gray-800" : ""}`}
                            >
                                <FaRegUser className={`inline-flex items-center h-5 w-5 justify-center ml-4 ${isIncluded ? "hidden" : ""}`} />
                                <IoIosArrowUp
                                    style={isIncluded ? { display: "inline-flex", transform: "rotateZ(180deg)" } : { display: "none" }}
                                    className={`items-center justify-center hidden w-5 h-5 ml-2 transition duration-500 group-hover:inline-flex bg-gray-300 rounded-full text-blue-700`}
                                />
                                <span className="ml-4 text-sm font-semibold tracking-wide">Profile</span>
                            </span>
                            {isIncluded ? (
                                <ul
                                    className="flex flex-col items-start justify-center gap-2 pl-2 my-3 ml-5 text-gray-600 border-l-2 border-gray-400">
                                    <li
                                        className={`${type === "membership" ? "text-[#4F46E5]" : ""} hover:text-indigo-500 hover:cursor-pointer`}>
                                        <Link href={{ query: { type: "membership" } }}>Membership</Link>
                                    </li>
                                    <li
                                        className={`${type === "password" ? "text-[#4F46E5]" : ""} hover:text-indigo-500 hover:cursor-pointer`}>
                                        <Link href={{ query: { type: "password" } }}>Password</Link>
                                    </li>
                                    <li
                                        className={`${type === "communication" ? "text-[#4F46E5]" : ""} hover:text-indigo-500 hover:cursor-pointer`}>
                                        <Link href={{ query: { type: "communication" } }}>Communication</Link>
                                    </li>
                                </ul>
                            ) : null}
                        </li>
                        <li>
                            <Link href="#"
                                tabIndex={-1}
                                className={`relative pointer-events-none flex flex-row items-center pr-6 text-gray-600 border-l-4 border-transparent h-11 focus:outline-none ${pathname.includes("settings") ? "bg-gray-200 text-gray-800 border-indigo-500 rounded-r-lg" : ""} hover:bg-gray-200 hover:text-gray-800 hover:border-indigo-500 hover:rounded-r-lg`}>
                                <IoSettingsOutline className="inline-flex items-center h-5 w-5 justify-center ml-4" />
                                <span className="ml-2 text-sm font-semibold tracking-wide">Settings</span>
                            </Link>
                        </li>
                        <li>
                            <Button
                                onClick={() => signOut({ callbackUrl: "/" })}
                                variant={"ghost"}
                                className={`relative flex flex-row items-center pr-6 pl-[0.15rem] text-gray-600 border-l-4 border-transparent h-11 focus:outline-none ${pathname.includes("logout") ? "bg-gray-200 text-gray-800 border-indigo-500 rounded-r-lg" : ""} hover:bg-gray-200 rounded-l-none hover:text-gray-800 hover:border-indigo-500 hover:rounded-r-lg`}>
                                <HiOutlineLogout className="inline-flex items-center h-5 w-5 justify-center ml-4" />
                                <span className="ml-2 text-sm font-semibold tracking-wide">Logout</span>
                            </Button>
                        </li>
                    </ul>
                </div>
            </aside>
        </>
    )
}
