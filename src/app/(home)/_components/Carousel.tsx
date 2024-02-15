"use client"
import {
  Carousel as CarouselComponent,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel"
import Autoplay from "embla-carousel-autoplay"
import Image from "next/image"
import bagImg from "@/../public/images/bag.jpg"
import giftsImg from "@/../public/images/gifts.jpg"
import shoesImg from "@/../public/images/shoes.jpg"
import shopImg from "@/../public/images/shop.jpg"
import wallImg from "@/../public/images/wall.jpg"


const images = [
  wallImg,
  shoesImg,
  shopImg,
  giftsImg,
  bagImg,
]

export default function Carousel() {

  return (
    <div className="container flex rounded-md">
      <CarouselComponent
        opts={{ loop: true, align: "start", }}
        plugins={[
          Autoplay({
            delay: 4000,
          }),
        ]}
      >
        <CarouselContent className="w-full rounded-md shadow-md max-h-[calc(100vh-10rem)]">
          {images.map((image, index) => (
            <CarouselItem key={index} className="">
              <Image src={image} alt="carousel" placeholder="blur" className="object-fill h-full mx-auto rounded-md" />
            </CarouselItem>
          ))}
        </CarouselContent>
        <CarouselPrevious className="left-4" />
        <CarouselNext className="right-8" />
      </CarouselComponent>
    </div>
  )
}
