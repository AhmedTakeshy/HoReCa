import { LiaStarSolid } from "react-icons/lia";

type Props = {
    count: number
}

export default function Stars({ count }: Props) {

    return (
        <div className='flex items-center gap-px'>
            {Array(5).fill(0).map((_, i) => <LiaStarSolid key={i} className={`${i < count ? 'text-yellow-500' : 'text-gray-300'} `} />
            )}
        </div>
    )
}