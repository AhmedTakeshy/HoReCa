import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel"
import { ImgProps } from "next/dist/shared/lib/get-img-props"
import Image from "next/image"

type CarouselItemProps = {
  image?: React.Component<ImgProps>[] | React.Component<ImgProps>
}
export default function Carousell({ image }: CarouselItemProps) {
  const images = [
    "https://n11scdn.akamaized.net/a1/878_420/wholesale/16/69/87/02/11695843.jpeg",
    "https://n11scdn.akamaized.net/a1/878_420/wholesale/79/28/20/26/59697996.jpeg",
    "https://n11scdn.akamaized.net/a1/878_420/wholesale/42/10/96/56/81373951.jpeg",
    "https://n11scdn.akamaized.net/a1/878_420/wholesale/94/61/58/44/20675891.jpeg"
  ]
  return (
    <Carousel className="flex flex-col justify-between gap-5">
      <CarouselContent className="w-[55rem] h-[26.25rem] shadow-md rounded-md">
        {images.map((image, index) => (
          <CarouselItem key={index} className="flex flex-col justify-center w-full h-full">
            <Image src={image} alt="carousel" layout="fill"  width={100} height={100} className="mx-auto"/>
          </CarouselItem>
        ))}
      </CarouselContent>
      <CarouselPrevious />
      <CarouselNext />
    </Carousel>

  )
}
