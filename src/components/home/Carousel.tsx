"use client"
import {
  Carousel as CarouselComponent,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel"
import { ImgProps } from "next/dist/shared/lib/get-img-props"
import Image from "next/image"
import { type CarouselApi } from "@/components/ui/carousel"
import { useEffect, useState } from "react"
type CarouselItemProps = {
  image?: React.Component<ImgProps>[] | React.Component<ImgProps>
}
const images = [
  "https://n11scdn.akamaized.net/a1/878_420/wholesale/16/69/87/02/11695843.jpeg",
  "https://n11scdn.akamaized.net/a1/878_420/wholesale/79/28/20/26/59697996.jpeg",
  "https://n11scdn.akamaized.net/a1/878_420/wholesale/42/10/96/56/81373951.jpeg",
  "https://n11scdn.akamaized.net/a1/878_420/wholesale/94/61/58/44/20675891.jpeg"
]

export default function Carousel({ image }: CarouselItemProps) {
  const [api, setApi] = useState<CarouselApi>()
  const [current, setCurrent] = useState(0)
  const [count, setCount] = useState(0)

  useEffect(() => {
    if (!api) {
      return
    }

    setCount(api.scrollSnapList().length)
    setCurrent(api.selectedScrollSnap() + 1)

    api.on("select", () => {
      setCurrent(api.selectedScrollSnap() + 1)
    })
  }, [api])


  return (
    <CarouselComponent
    setApi={setApi}
    opts={{ loop: true, align: "start", }}>
      <CarouselContent className="w-full h-full shadow-md rounded-md">
        {images.map((image, index) => (
          <CarouselItem key={index} className="flex flex-col justify-center">
            <Image src={image} alt="carousel" width={970} height={420} className="mx-auto w-full rounded-md" />
          </CarouselItem>
        ))}
      </CarouselContent>
      <CarouselPrevious className="left-0" />
      <CarouselNext className="right-4" />
    </CarouselComponent>
  )
}
