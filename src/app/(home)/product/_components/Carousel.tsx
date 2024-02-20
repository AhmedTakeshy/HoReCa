"use client"
import {
  Carousel as CarouselComponent,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel"
import Image from "next/image"
import { useState } from "react"

type CarouselProps = {
  images: string[]
}
export default function Carousel({ images }: CarouselProps) {
  const [activeIndex, setActiveIndex] = useState(0);

  const nextSlide = () => {
    setActiveIndex((prevIndex) =>
      prevIndex === images.length - 1 ? 0 : prevIndex + 1
    );
  };

  const prevSlide = () => {
    setActiveIndex((prevIndex) =>
      prevIndex === 0 ? images.length - 1 : prevIndex - 1
    );
  };


  return (
    <div className="flex flex-col gap-4 rounded-md">
      <CarouselComponent
        opts={{ align: "start", }}
      >
        <CarouselContent className="w-full rounded-md shadow-md">
          <CarouselItem key={activeIndex} >
            <Image
              src={images[activeIndex]}
              alt={`carousel image-${activeIndex}`}
              className="object-fill h-full mx-auto rounded-md"
              width={645}
              height={260} />
          </CarouselItem>
        </CarouselContent>
      </CarouselComponent>

      <CarouselComponent
        opts={{ align: "start", }}
        className="flex flex-col gap-4"
      >
        <CarouselContent className="w-full rounded-md shadow-md">
          {images.map((image, index) => (
            <CarouselItem key={index} className={`md:basis-1/2 lg:basis-1/3`}>
              <Image
                src={image}
                alt={`carousel image-${index}`}
                className="object-fill h-full mx-auto rounded-md"
                width={167}
                height={104.2} />
            </CarouselItem>
          ))}
        </CarouselContent>
        <CarouselPrevious className="-left-12" onClick={prevSlide} />
        <CarouselNext className="-right-8" onClick={nextSlide} />
      </CarouselComponent>
    </div>
  )
}
