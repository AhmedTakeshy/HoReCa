import { Skeleton } from "../../../components/ui/skeleton";

export default function LoadingCard() {
    return (
        <div className="container flex flex-wrap items-start justify-center gap-4 my-20">
            {Array.from({ length: 15 }).map((_, i) => (
                <Skeleton key={i} className="w-[310px] h-[270px] rounded-lg flex flex-col justify-start items-start p-4 gap-4" >
                    <Skeleton className="w-3/4 h-[25px] rounded-full" />
                    <Skeleton className="w-2/4 h-[25px] rounded-full" />
                    <Skeleton className="flex flex-col items-start justify-start w-full gap-4 p-4 my-4 rounded-md h-2/4" >
                        <Skeleton className="w-full h-[30px] rounded-full" />
                        <Skeleton className="w-full h-[30px] rounded-full" />
                        <Skeleton className="w-full h-[30px] rounded-full" />
                    </Skeleton>
                    <Skeleton className="w-full h-[50px] rounded-lg" />
                </Skeleton>
            ))}
        </div>
    )
}
