import { Skeleton } from "../../../components/ui/skeleton";

export default function LoadingBanner() {

    return (
        <div className="container mx-auto mt-10 mb-20 px-14">
            <Skeleton className=" w-full h-[calc(100vh-15rem)] rounded-md" />
        </div>
    );
}

