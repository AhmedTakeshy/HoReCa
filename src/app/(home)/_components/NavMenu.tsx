"use client"
import {
    NavigationMenu,
    NavigationMenuItem,
    NavigationMenuLink,
    NavigationMenuList,
    navigationMenuTriggerStyle,
} from "@/components/ui/navigation-menu"
import Link from "next/link"
import { ModeToggler } from "@/components/ModeToggler"
import { useEffect, useState } from "react"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { Button, buttonVariants } from "@/components/ui/button"
import {
    HoverCard,
    HoverCardContent,
    HoverCardTrigger,
} from "@/components/ui/hover-card"
import { GoHeartFill } from "react-icons/go";
import { BsCart3 } from "react-icons/bs";
import { LuUserCircle2 } from "react-icons/lu";
import { useAppDispatch, useAppSelector } from "@/_store/hooks"
import SimpleProduct from "@/components/SimpleProduct"
import { signOut, useSession } from "next-auth/react"
import { getCartFromDatabase } from "@/_actions/cartActions"
import { replaceCart } from "@/_store/cartSlice"
import Image from "next/image"
import logo from "@/../public/images/logo.png"


export default function NavMenu() {
    const [open, setOpen] = useState<boolean>(false)
    const cart = useAppSelector(state => state.cart)
    const { data: session } = useSession()
    const dispatch = useAppDispatch()
    useEffect(() => {
        if (session?.user.email) {
            const fetchCart = async () => {
                const response = await getCartFromDatabase(session?.user.email!)
                if (response.status === "Success") {
                    dispatch(replaceCart({ cartProducts: response.data.cartProducts, totalQuantity: response.data.totalQuantity, totalAmount: response.data.totalAmount }))
                }
            }
            fetchCart()
        }
    }, [session?.user.email, dispatch])



    return (
        <header className={`flex mt-6 mb-10 mx-auto md:justify-around justify-between items-center w-full md:px-8 px-3`}>
            <Image src={logo} width={200} height={75} alt="logo" />
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
                <Link href="/wishlist" aria-description="open wishlist" aria-label="open wishlist" aria-controls="navbar-default" aria-expanded="false" className="group">
                    <GoHeartFill className="w-6 h-6 group-hover:animate-pumping-heart group-hover:text-red-600" />
                </Link>
                <HoverCard openDelay={200} closeDelay={100}>
                    <HoverCardTrigger asChild>
                        <Link href="/cart" aria-description="open cart" aria-label="open cart" aria-controls="navbar-default" aria-expanded="false" className="relative group">
                            <BsCart3 className="w-6 h-6 group-hover:text-blue-700" />
                            {cart.totalQuantity > 0 && <span className="absolute w-6 h-6 text-xs rounded-lg flex-center -top-5 -right-3 bg-sky-500">{cart.totalQuantity}</span>}
                        </Link>
                    </HoverCardTrigger>
                    <HoverCardContent className="p-4 overflow-y-auto w-80 max-h-96">
                        {
                            cart.cartProducts.length > 0
                                ?
                                cart.cartProducts.map(product => (
                                    <SimpleProduct key={product.product.id} data={product} />
                                ))
                                :
                                <p>The cart is empty.</p>
                        }
                    </HoverCardContent>
                </HoverCard>
                {session?.user ?
                    <HoverCard openDelay={200} closeDelay={100}>
                        <HoverCardTrigger className="hover:cursor-pointer">
                            {session?.user.name}
                        </HoverCardTrigger>
                        <HoverCardContent className="p-4 space-y-4 w-40">
                            <Link href={`${session.user.role === "USER" ? "/profile" : "/dashboard"}`}
                                aria-description="open profile"
                                aria-label="open profile"
                                aria-controls="navbar-default"
                                aria-expanded="false"
                                className="flex items-center justify-start gap-3 group hover:text-cyan-700">
                                <LuUserCircle2 className="w-6 h-6 group-hover:text-cyan-700" />
                                {" "}
                                {session.user.role === "USER" ? "Profile" : "Dashboard"}
                            </Link>
                            <Button
                                className="w-full md:w-auto"
                                variant="destructive"
                                onClick={() => signOut({ callbackUrl: "/" })}
                            >
                                Sign out
                            </Button>
                        </HoverCardContent>
                    </HoverCard >
                    :
                    <Link href="/signin" aria-description="open profile" aria-label="open profile" aria-controls="navbar-default" aria-expanded="false" className="group">
                        <LuUserCircle2 className="w-6 h-6 hover:text-cyan-700" />
                    </Link>}
                <ModeToggler />
            </div>

            {/* Nav for small screens */}
            <div className={`flex items-center justify-between h-full md:hidden rounded-xl `}>
                <Popover onOpenChange={setOpen} open={open}>
                    <PopoverTrigger aria-controls="2" aria-labelledby="open menu button" asChild>
                        <div className="flex items-center gap-2">
                            <Button aria-description="open main menu" aria-label="open menu" data-collapse-toggle="navbar-default" type="button" className="inline-flex items-center justify-center w-10 h-10 p-2 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
                                <span className="sr-only">Open main menu</span>
                                <svg className="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                                    <path stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M1 1h15M1 7h15M1 13h15" />
                                </svg>
                            </Button>
                            <ModeToggler />
                        </div>
                    </PopoverTrigger>
                    <PopoverContent className="relative w-screen mx-px ">
                        <div className="flex flex-col items-center mx-auto">
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
                            <div className="flex items-center justify-between w-full gap-2 mx-2">
                                <Link href="/wishlist" className={`${buttonVariants({ variant: "default" })} w-full group`}>
                                    <GoHeartFill className="w-6 h-6 group-hover:animate-pumping-heart group-hover:text-red-600 " />
                                </Link>
                                <Link href="/cart" className={`${buttonVariants({ variant: "default" })} w-full group relative overflow-hidden`}>
                                    <BsCart3 className="absolute w-6 h-6 group-hover:animate-move-out group-hover:text-blue-700" />
                                </Link>
                            </div>
                            <Link href="/signin" className={`${buttonVariants({ variant: "default" })} my-2 w-full mx-4 relative group hover:animate-flip perspective hover:bg-cyan-950`}>
                                <LuUserCircle2 className="w-6 h-6" />
                                <span className="flex items-center justify-center text-lg shadow-md shadow-blue-500 backface">Sign in</span>
                            </Link>
                        </div>
                    </PopoverContent>
                </Popover>
            </div>
        </header>
    )
}