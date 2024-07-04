import Image from 'next/image'
import React from 'react'

export default function page() {
    return (
        <div className="py-16 ">
            <div className="py-12 relative xl:mr-0 lg:mr-5 mr-0">
                <div className="w-full max-w-7xl px-4 md:px-5 lg:px-5 mx-auto">
                    <div className="w-full justify-start items-center xl:gap-12 gap-10 grid lg:grid-cols-2 grid-cols-1">
                        <div className="w-full flex-col justify-center lg:items-start items-center gap-10 inline-flex">
                            <div className="w-full flex-col justify-center items-start gap-8 flex">
                                <div className="flex-col justify-start lg:items-start items-center gap-4 flex">
                                    <h6 className="text-gray-600 dark:text-slate-400 text-base font-normal leading-relaxed">About Us</h6>
                                    <div className="w-full flex-col justify-start lg:items-start items-center gap-3 flex">
                                        <h2 className="text-indigo-700 text-4xl font-bold font-manrope leading-normal lg:text-start text-center">The Tale of Our Achievement Story</h2>
                                        <p className="text-gray-600 dark:text-slate-400 text-base font-normal leading-relaxed lg:text-start text-center">Our achievement story is a testament to teamwork and perseverance. Together, we&apos;ve overcome challenges, celebrated victories, and created a narrative of progress and success.</p>
                                    </div>
                                </div>
                                <div className="w-full flex-col justify-center items-start gap-6 flex">
                                    <div className="w-full justify-start items-center gap-8 grid md:grid-cols-2 grid-cols-1">
                                        <div className="w-full h-full p-3.5 rounded-xl border dark:border-gray-200 border-slate-700 dark:hover:border-slate-900 hover:border-gray-400 transition-all duration-700 ease-in-out flex-col justify-start items-start gap-2.5 inline-flex">
                                            <h4 className="text-gray-900 dark:text-white text-2xl font-bold font-manrope leading-9">33+ Years</h4>
                                            <p className="text-gray-600 dark:text-slate-300 text-base font-normal leading-relaxed">Influencing Digital Landscapes Together</p>
                                        </div>
                                        <div className="w-full h-full p-3.5 rounded-xl border dark:border-gray-200 border-slate-700 dark:hover:border-slate-900 hover:border-gray-400 transition-all duration-700 ease-in-out flex-col justify-start items-start gap-2.5 inline-flex">
                                            <h4 className="text-gray-900 dark:text-white text-2xl font-bold font-manrope leading-9">125+ Projects</h4>
                                            <p className="text-gray-600 dark:text-slate-300 text-base font-normal leading-relaxed">Excellence Achieved Through Success</p>
                                        </div>
                                    </div>
                                    <div className="w-full h-full justify-start items-center gap-8 grid md:grid-cols-2 grid-cols-1">
                                        <div className="w-full p-3.5 rounded-xl border dark:border-gray-200 border-slate-700 dark:hover:border-slate-900 hover:border-gray-400 transition-all duration-700 ease-in-out flex-col justify-start items-start gap-2.5 inline-flex">
                                            <h4 className="text-gray-900 dark:text-white text-2xl font-bold font-manrope leading-9">26+ Awards</h4>
                                            <p className="text-gray-600 dark:text-slate-300 text-base font-normal leading-relaxed">Our Dedication to Innovation Wins Understanding</p>
                                        </div>
                                        <div className="w-full h-full p-3.5 rounded-xl border dark:border-gray-200 border-slate-700 dark:hover:border-slate-900 hover:border-gray-400 transition-all duration-700 ease-in-out flex-col justify-start items-start gap-2.5 inline-flex">
                                            <h4 className="text-gray-900 dark:text-white text-2xl font-bold font-manrope leading-9">99% Happy Clients</h4>
                                            <p className="text-gray-600 dark:text-slate-300 text-base font-normal leading-relaxed">Mirrors our Focus on Client Satisfaction.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button className="sm:w-fit w-full group px-3.5 py-2 bg-indigo-50 hover:bg-indigo-100 rounded-lg shadow-[0px_1px_2px_0px_rgba(16,_24,_40,_0.05)] transition-all duration-700 ease-in-out justify-center items-center flex">
                                <span className="px-1.5 text-indigo-600 text-sm font-medium leading-6 group-hover:-translate-x-0.5 transition-all duration-700 ease-in-out">Read More</span>
                                <svg className="group-hover:translate-x-0.5 transition-all duration-700 ease-in-out" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18" fill="none">
                                    <path d="M6.75265 4.49658L11.2528 8.99677L6.75 13.4996" stroke="#4F46E5" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" />
                                </svg>
                            </button>
                        </div>
                        <div className="w-full lg:justify-start justify-center items-start flex">
                            <div className="sm:w-[564px] w-full sm:h-[646px] h-full sm:bg-gray-100 rounded-3xl sm:border border-gray-200 relative">
                                <Image width={562} height={644} className="sm:mt-5 sm:ml-5 w-full h-full" src="https://pagedone.io/asset/uploads/1717742431.png" alt="about Us image" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div className="py-12">
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
