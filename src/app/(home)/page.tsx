
import Image from "next/image";
import Categories from "./_components/Categories";
import { Lamp } from "./_components/Lamp";
import Link from "next/link";

export default function Home() {
  return (
    <main className="mb-8">
      <Lamp />
      <section className="bg-white dark:hidden ">
        {/* Hero section */}
        <div className="relative">
          {/* Background image and overlap */}
          <div aria-hidden="true" className="absolute inset-0 hidden sm:flex sm:flex-col">
            <div className="relative w-full flex-1 bg-gray-800">
              <div className="absolute inset-0 overflow-hidden">
                <Image
                  src="https://tailwindui.com/img/ecommerce-images/home-page-04-hero-full-width.jpg"
                  alt="banner image"
                  fill
                  sizes="100vw"
                  className="h-full w-full object-cover object-center"
                />
              </div>
              <div className="absolute inset-0 bg-gray-900 opacity-50" />
            </div>
          </div>
          <div className="relative mx-auto max-w-3xl px-4 pb-96 text-center sm:px-6 sm:pb-0 lg:px-8">
            {/* Background image and overlap */}
            <div aria-hidden="true" className="absolute inset-0 flex flex-col sm:hidden">
              <div className="relative w-full flex-1 bg-gray-800">
                <div className="absolute inset-0 overflow-hidden">
                  <Image
                    src="https://tailwindui.com/img/ecommerce-images/home-page-04-hero-full-width.jpg"
                    alt="banner image"
                    fill
                    sizes="100vw"
                    className="h-full w-full object-cover object-center"
                  />
                </div>
                <div className="absolute inset-0 bg-gray-900 opacity-50" />
              </div>
              <div className="h-48 w-full bg-white" />
            </div>
            <div className="relative py-32">
              <h1 className="text-4xl font-bold tracking-tight text-white sm:text-5xl md:text-6xl">Mid-Season Sale</h1>
              <div className="mt-4 sm:mt-6">
                <Link href="/products"
                  className="inline-block rounded-md border border-transparent bg-indigo-600 px-8 py-3 font-medium text-white hover:bg-indigo-700"
                >
                  Shop Now
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>
      <div className="md:flex md:items-center md:justify-between container mt-24">
        <h2 className="text-2xl font-bold tracking-tight text-slate-900 dark:text-slate-200">Trending Products</h2>
        <Link href="/products" className="hidden text-sm font-medium text-indigo-400 hover:text-indigo-600 md:block">
          Shop the collections
          <span aria-hidden="true"> →</span>
        </Link>
      </div>
      <Categories />
    </main>
  )
}
