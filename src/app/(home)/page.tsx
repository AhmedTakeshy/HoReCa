
import Image from "next/image";
import Categories from "./_components/Categories";
import { Lamp } from "./_components/Lamp";
import Link from "next/link";
import IncentiveLogo from "./_components/incentiveLogo";
import { InfiniteMovingCards } from "@/components/infiniteMovingCards";
import { getCategories } from "@/_actions/categoryActions";

export default async function Home() {
  const items = [
    {
      quote: 'Integer id nunc sit semper purus. Bibendum at lacus ut arcu blandit montes vitae auctor libero. Hac condimentum dignissim nibh vulputate ut nunc. Amet nibh orci mi venenatis blandit vel et proin. Non hendrerit in vel ac diam.',
      name: 'Brenna Goyette',
      title: 'brennagoyette',
      imgSrc: 'https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=1024&h=1024&q=80',
    },
    {
      quote: 'Laborum quis quam. Dolorum et ut quod quia. Voluptas numquam delectus nihil. Aut enim doloremque et ipsam.',
      name: 'Leslie Alexander',
      title: 'lesliealexander',
      imgSrc: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
    },
    {
      quote: 'Aut reprehenderit voluptatem eum asperiores beatae id. Iure molestiae ipsam ut officia rem nulla blanditiis.',
      name: 'Lindsay Walton',
      title: 'lindsaywalton',
      imgSrc: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
    },
    {
      quote: 'Voluptas quos itaque ipsam in voluptatem est. Iste eos blanditiis repudiandae. Earum deserunt enim molestiae ipsum perferendis recusandae saepe corrupti.',
      name: 'Tom Cook',
      title: 'tomcook',
      imgSrc: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
    },
    {
      quote: 'Molestias ea earum quos nostrum doloremque sed. Quaerat quasi aut velit incidunt excepturi rerum voluptatem minus harum.',
      name: 'Leonard Krasner',
      title: 'leonardkrasner',
      imgSrc: 'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
    },
  ]
  const categories = await getCategories()

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
                <Link href={{
                  pathname: '/category', query: {
                    query: categories.status === "Success" ?
                      categories.data[Math.floor(Math.random() * categories.data.length)] : "beauty",
                    page: 1
                  }
                }}
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
        <Link
          href={{
            pathname: '/category', query: {
              query: categories.status === "Success" ?
                categories.data[Math.floor(Math.random() * categories.data.length)] : "beauty",
              page: 1
            }
          }}
          className="hidden text-sm font-medium text-indigo-400 hover:text-indigo-600 md:block">
          Shop the collections
          <span aria-hidden="true"> →</span>
        </Link>
      </div>
      <Categories />
      <IncentiveLogo />
      <InfiniteMovingCards items={items} speed="slow" pauseOnHover={true} direction="right" />
    </main>
  )
}
