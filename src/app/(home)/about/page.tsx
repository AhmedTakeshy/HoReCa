import Image from 'next/image'
import React from 'react'

export default function page() {
    return (
        <div className="py-16 ">
            <div className="container m-auto px-6 text-gray-600 md:px-12 xl:px-6">
                <div className="space-y-6 md:space-y-0 md:flex md:gap-6 lg:items-center lg:gap-12">
                    <div className="md:5/12 lg:w-5/12">
                        <Image
                            src="https://tailus.io/sources/blocks/left-image/preview/images/startup.png"
                            alt="startup-image" width={387} height={328} className='rounded-2xl' />
                    </div>
                    <div className="md:7/12 lg:w-6/12">
                        <h2 className="text-2xl text-gray-900 dark:text-white font-bold md:text-4xl">Next development is carried out by passionate developers</h2>
                        <p className="mt-6 text-gray-600 dark:text-slate-300">Lorem ipsum dolor, sit amet consectetur adipisicing elit. Eum omnis voluptatem accusantium nemo perspiciatis delectus atque autem! Voluptatum tenetur beatae unde aperiam, repellat expedita consequatur! Officiis id consequatur atque doloremque!</p>
                        <p className="mt-4 text-gray-600 dark:text-slate-300"> Nobis minus voluptatibus pariatur dignissimos libero quaerat iure expedita at? Asperiores nemo possimus nesciunt dicta veniam aspernatur quam mollitia.</p>
                    </div>
                </div>
            </div>
            <div className="py-24">
                <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                    <div className="flex justify-between items-center flex-col lg:flex-row md:mt-20">
                        <div className="w-full lg:w-1/2">
                            <h2
                                className="font-manrope text-5xl text-gray-900 dark:text-white font-bold leading-[4rem] mb-7 text-center lg:text-left">
                                Our leading, strong & creative team</h2>
                            <p className="text-lg text-gray-700 dark:text-slate-300 mb-16 text-center lg:text-left">These people work on making our
                                product best.</p>
                            <button className="cursor-pointer py-3 px-8 w-60 bg-indigo-500 text-white text-base font-semibold transition-all duration-500 block text-center rounded-full hover:bg-indigo-700 mx-auto lg:mx-0">Join
                                our team</button>
                        </div>
                        <div className="w-full lg:w-1/2 lg:mt-0 md:mt-40 mt-16 max-lg:max-w-2xl">
                            <div className="grid grid-cols-1 min-[450px]:grid-cols-2 md:grid-cols-3 gap-8">
                                <Image
                                    width={176}
                                    height={224}
                                    src="https://pagedone.io/asset/uploads/1696238644.png" alt="Team tailwind section"
                                    className="w-44 h-56 rounded-2xl object-cover md:mt-20 mx-auto min-[450px]:mr-0" />
                                <Image
                                    width={176}
                                    height={224}
                                    src="https://pagedone.io/asset/uploads/1696238665.png" alt="Team tailwind section"
                                    className="w-44 h-56 rounded-2xl object-cover mx-auto min-[450px]:ml-0 md:mx-auto" />
                                <Image
                                    width={176}
                                    height={224}
                                    src="https://pagedone.io/asset/uploads/1696238684.png" alt="Team tailwind section"
                                    className="w-44 h-56 rounded-2xl object-cover md:mt-20 mx-auto min-[450px]:mr-0 md:ml-0" />
                                <Image
                                    width={176}
                                    height={224}
                                    src="https://pagedone.io/asset/uploads/1696238702.png" alt="Team tailwind section"
                                    className="w-44 h-56 rounded-2xl object-cover mx-auto min-[450px]:ml-0 md:mr-0 md:ml-auto" />
                                <Image
                                    width={176}
                                    height={224}
                                    src="https://pagedone.io/asset/uploads/1696238720.png" alt="Team tailwind section"
                                    className="w-44 h-56 rounded-2xl object-cover md:-mt-20 mx-auto min-[450px]:mr-0 md:mx-auto" />
                                <Image
                                    width={176}
                                    height={224}
                                    src="https://pagedone.io/asset/uploads/1696238737.png" alt="Team tailwind section"
                                    className="w-44 h-56 rounded-2xl object-cover mx-auto min-[450px]:ml-0 md:mr-0" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
