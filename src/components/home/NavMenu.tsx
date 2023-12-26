"use client"
import {
    NavigationMenu,
    NavigationMenuItem,
    NavigationMenuLink,
    NavigationMenuList,
    navigationMenuTriggerStyle,
} from "@/components/ui/navigation-menu"
import Link from "next/link"
import { ModeToggler } from "../shared/ModeToggler"
import Image from "next/image"
import { useState } from "react"
import { Popover, PopoverContent, PopoverTrigger } from "../ui/popover"
import { Button } from "../ui/button"
import {
    HoverCard,
    HoverCardContent,
    HoverCardTrigger,
} from "@/components/ui/hover-card"
import { GoHeartFill } from "react-icons/go";
import { BsCart3 } from "react-icons/bs";
import { LuUserCircle2 } from "react-icons/lu";


export default function NavMenu() {
    const [open, setOpen] = useState<boolean>(false)

    return (
        <header className={`flex my-6 mx-auto justify-around items-center w-full px-8`}>
            <h1 className="text-6xl font-bold">HoReCa</h1>
            <NavigationMenu className={` items-center  justify-between hidden gap-2 md:flex`}>
                <NavigationMenuList className="items-center justify-between hidden gap-2 md:flex ">
                    <NavigationMenuItem>
                        <Link href="/" legacyBehavior passHref>
                            <NavigationMenuLink className={navigationMenuTriggerStyle()}>Home</NavigationMenuLink>
                        </Link>
                    </NavigationMenuItem>
                    <NavigationMenuItem>
                        <Link href="/products" legacyBehavior passHref>
                            <NavigationMenuLink className={navigationMenuTriggerStyle()}>Products</NavigationMenuLink>
                        </Link>
                    </NavigationMenuItem>
                    <NavigationMenuItem>
                        <Link href="/services" legacyBehavior passHref>
                            <NavigationMenuLink className={navigationMenuTriggerStyle()}>Services</NavigationMenuLink>
                        </Link>
                    </NavigationMenuItem>
                    <NavigationMenuItem>
                        <Link href="/about" legacyBehavior passHref>
                            <NavigationMenuLink className={navigationMenuTriggerStyle()}>About</NavigationMenuLink>
                        </Link>
                    </NavigationMenuItem>
                </NavigationMenuList>
            </NavigationMenu>
            <div className="items-center justify-between hidden gap-4 md:flex ">
                <Link href="/wishlist" aria-description="open wishlist" aria-label="open wishlist" aria-controls="navbar-default" aria-expanded="false" className="">
                    <HoverCard>
                        <HoverCardTrigger>
                            <GoHeartFill className="w-6 h-6 hover:text-red-600" />
                        </HoverCardTrigger>
                        <HoverCardContent>
                            The React Framework – created and maintained by @vercel.
                        </HoverCardContent>
                    </HoverCard>
                </Link>
                <Link href="/cart" aria-description="open cart" aria-label="open cart" aria-controls="navbar-default" aria-expanded="false">
                    <HoverCard>
                        <HoverCardTrigger>
                            <BsCart3 className="w-6 h-6" />
                        </HoverCardTrigger>
                        <HoverCardContent>
                            The React Framework – created and maintained by @vercel.
                        </HoverCardContent>
                    </HoverCard>
                </Link>
                <Link href="/profile" aria-description="open profile" aria-label="open profile" aria-controls="navbar-default" aria-expanded="false">
                    <HoverCard>
                        <HoverCardTrigger>
                            <LuUserCircle2 className="w-6 h-6" />
                        </HoverCardTrigger>
                        <HoverCardContent>
                            The React Framework – created and maintained by @vercel.
                        </HoverCardContent>
                    </HoverCard>
                </Link>

                <ModeToggler />
            </div>

            {/* Nav for small screens */}
            {/* <div className={`flex items-center justify-between h-full md:hidden rounded-xl px-8 my-8 `}>
                <Popover onOpenChange={setOpen} open={open}>
                    <PopoverTrigger aria-controls="2" aria-labelledby="open menu button" asChild>
                        <div className="flex items-center gap-2">
                            <ModeToggler />
                            <Button aria-description="open main menu" aria-label="open menu" data-collapse-toggle="navbar-default" type="button" className="inline-flex items-center justify-center w-10 h-10 p-2 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
                                <span className="sr-only">Open main menu</span>
                                <svg className="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                                    <path stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M1 1h15M1 7h15M1 13h15" />
                                </svg>
                            </Button>
                        </div>
                    </PopoverTrigger>
                    <PopoverContent className="relative w-screen ">
                        <div className="flex flex-col items-center mx-auto md:flex-row">
                            <NavigationMenu>
                                <NavigationMenuList className="flex flex-col items-center justify-center gap-2">
                                    <NavigationMenuItem>
                                        <Link href="/" legacyBehavior passHref>
                                            <NavigationMenuLink onClick={() => setOpen(false)} className={navigationMenuTriggerStyle()}>Home</NavigationMenuLink>
                                        </Link>
                                    </NavigationMenuItem>
                                    <NavigationMenuItem>
                                        <Link href="/products" legacyBehavior passHref>
                                            <NavigationMenuLink onClick={() => setOpen(false)} className={navigationMenuTriggerStyle()}>Products</NavigationMenuLink>
                                        </Link>
                                    </NavigationMenuItem>
                                    <NavigationMenuItem>
                                        <Link href="/services" legacyBehavior passHref>
                                            <NavigationMenuLink onClick={() => setOpen(false)} className={navigationMenuTriggerStyle()}>Services</NavigationMenuLink>
                                        </Link>
                                    </NavigationMenuItem>
                                    <NavigationMenuItem>
                                        <Link href="/about" legacyBehavior passHref>
                                            <NavigationMenuLink onClick={() => setOpen(false)} className={navigationMenuTriggerStyle()}>About</NavigationMenuLink>
                                        </Link>
                                    </NavigationMenuItem>
                                </NavigationMenuList>
                            </NavigationMenu>
                        </div>
                    </PopoverContent>
                </Popover>
            </div> */}
        </header>
    )
}