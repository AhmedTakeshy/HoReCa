import {
    ChevronLeftIcon,
    ChevronRightIcon,
} from "@radix-ui/react-icons"
import Link from "next/link"
import { Button } from "./ui/button"


type PaginationControlProps = {
    currentPage: number
    metadata: {
        hastNextPage: boolean,
        totalPages: number,
    }
    className?: string
}

export default function PaginationControl({ currentPage, metadata, className }: PaginationControlProps) {

    const hasPreviousPage = currentPage > 1

    return (
        <div className={`${className} flex items-center justify-center gap-1 mx-auto px-2.5 mt-12`}>
            <ChevronLeftIcon className="h-4 w-4" />
            <Button
                asChild={hasPreviousPage}
                variant="ghost"
                className={`rounded-md pl-0 text-base${currentPage === 1 ? " text-accent-foreground" : "text-white"}`}
                disabled={!hasPreviousPage}>
                <Link href={{ query: { page: currentPage > 1 ? currentPage - 1 : currentPage } }}>
                    Previous
                </Link>
            </Button>
            {Array.from({ length: metadata.totalPages }, (_, i) => i + 1).map(page => (
                <Button
                    asChild
                    variant={currentPage === page ? "outline" : "ghost"}
                    className={`rounded-md mx-2${currentPage === page ? "bg-accent text-accent-foreground" : ""}`} key={page}>
                    <Link href={{ query: { page: page } }}>
                        {page}
                    </Link>
                </Button>
            ))}
            <Button
                asChild={metadata.hastNextPage}
                variant="ghost"
                className={`rounded-md pr-0 text-base${currentPage === metadata.totalPages ? " text-accent-foreground" : "text-white"}`}
                disabled={!metadata.hastNextPage}>
                <Link href={{ query: { page: currentPage < metadata.totalPages ? currentPage + 1 : currentPage } }}>
                    Next
                </Link>
            </Button>
            <ChevronRightIcon className="h-4 w-4" />
        </div>
    )
}