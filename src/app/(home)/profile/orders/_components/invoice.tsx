"use client"
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import html2canvas from "html2canvas";
import jsPDF from "jspdf";

type InvoiceProps = {
    invoiceId: string
    date: string
    amount: number
}

export default function Invoice({ date, amount, invoiceId }: InvoiceProps) {
    function handlePrint() {
        window.print()
    }

    async function handleDownloadPDF() {
        const element = document.getElementById("invoice-content");
        if (!element) return;

        const canvas = await html2canvas(element);
        const imgData = canvas.toDataURL("image/png");
        const pdf = new jsPDF({
            orientation: "portrait",
            unit: "px",
            format: [canvas.width, canvas.height],
        });

        pdf.addImage(imgData, "PNG", 0, 0, canvas.width, canvas.height);
        pdf.save(`invoice_${invoiceId}.pdf`);
    }

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button>
                    View Invoice
                </Button>
            </DialogTrigger>
            <DialogContent aria-describedby={"This is the invoice for your order."}>
                <DialogHeader className=" sr-only">
                    <DialogTitle>
                        Invoice
                    </DialogTitle>
                    <DialogDescription>
                        This is the invoice for your order.
                    </DialogDescription>
                </DialogHeader>
                {/* <-- Body --> */}
                <div id="invoice-content" className="rounded-xl shadow opacity-100 duration-500 ease-out transition-all sm:max-w-lg sm:w-full sm:mx-auto">
                    <div className="relative flex flex-col bg-slate-300 shadow-lg rounded-xl pointer-events-auto dark:bg-neutral-800">
                        <div className="relative overflow-hidden min-h-32 bg-gray-900 text-center rounded-t-xl dark:bg-neutral-950">
                            <figure className="absolute inset-x-0 bottom-0 -mb-px">
                                <svg preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" viewBox="0 0 1920 100.1">
                                    <path fill="currentColor" className="fill-slate-300 dark:fill-neutral-800" d="M0,0c0,0,934.4,93.4,1920,0v100.1H0L0,0z"></path>
                                </svg>
                            </figure>
                        </div>
                        <div className="relative z-10 -mt-12">
                            <span className="mx-auto flex justify-center items-center size-[62px] rounded-full border border-white bg-slate-300 text-gray-700 shadow-sm dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-400">
                                <svg className="flex-shrink-0 size-6" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                    <path d="M1.92.506a.5.5 0 0 1 .434.14L3 1.293l.646-.647a.5.5 0 0 1 .708 0L5 1.293l.646-.647a.5.5 0 0 1 .708 0L7 1.293l.646-.647a.5.5 0 0 1 .708 0L9 1.293l.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .801.13l.5 1A.5.5 0 0 1 15 2v12a.5.5 0 0 1-.053.224l-.5 1a.5.5 0 0 1-.8.13L13 14.707l-.646.647a.5.5 0 0 1-.708 0L11 14.707l-.646.647a.5.5 0 0 1-.708 0L9 14.707l-.646.647a.5.5 0 0 1-.708 0L7 14.707l-.646.647a.5.5 0 0 1-.708 0L5 14.707l-.646.647a.5.5 0 0 1-.708 0L3 14.707l-.646.647a.5.5 0 0 1-.801-.13l-.5-1A.5.5 0 0 1 1 14V2a.5.5 0 0 1 .053-.224l.5-1a.5.5 0 0 1 .367-.27zm.217 1.338L2 2.118v11.764l.137.274.51-.51a.5.5 0 0 1 .707 0l.646.647.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.509.509.137-.274V2.118l-.137-.274-.51.51a.5.5 0 0 1-.707 0L12 1.707l-.646.647a.5.5 0 0 1-.708 0L10 1.707l-.646.647a.5.5 0 0 1-.708 0L8 1.707l-.646.647a.5.5 0 0 1-.708 0L6 1.707l-.646.647a.5.5 0 0 1-.708 0L4 1.707l-.646.647a.5.5 0 0 1-.708 0l-.509-.51z" />
                                    <path d="M3 4.5a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm8-6a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5z" />
                                </svg>
                            </span>

                        </div>
                        <div className="p-4 sm:p-7 overflow-y-auto">
                            <div className="text-center">
                                <h3 className="text-lg font-semibold text-gray-800 dark:text-neutral-200">
                                    Invoice
                                </h3>
                                <p className="text-sm text-gray-500 dark:text-neutral-500">
                                    Invoice ID #{invoiceId}
                                </p>
                            </div>

                            {/* <!-- Grid --> */}
                            <div className="mt-5 sm:mt-10 grid grid-cols-2 sm:grid-cols-3 gap-5">
                                <div>
                                    <span className="block text-xs uppercase text-gray-500 dark:text-neutral-500">Amount paid:</span>
                                    <span className="block text-sm font-medium text-gray-800 dark:text-neutral-200">${amount}</span>
                                </div>
                                {/* <!-- End Col --> */}

                                <div>
                                    <span className="block text-xs uppercase text-gray-500 dark:text-neutral-500">Date paid:</span>
                                    <span className="block text-sm font-medium text-gray-800 dark:text-neutral-200">{date.split(" ").slice(1).join(" ")}</span>
                                </div>
                                {/* <!-- End Col --> */}

                                <div>
                                    <span className="block text-xs uppercase text-gray-500 dark:text-neutral-500">Payment method:</span>
                                    <div className="flex items-center gap-x-2">
                                        <svg className="size-5" width="400" height="248" viewBox="0 0 400 248" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <g clipPath="url(#clip0)">
                                                <path d="M254 220.8H146V26.4H254V220.8Z" fill="#FF5F00" />
                                                <path d="M152.8 123.6C152.8 84.2 171.2 49 200 26.4C178.2 9.2 151.4 0 123.6 0C55.4 0 0 55.4 0 123.6C0 191.8 55.4 247.2 123.6 247.2C151.4 247.2 178.2 238 200 220.8C171.2 198.2 152.8 163 152.8 123.6Z" fill="#EB001B" />
                                                <path d="M400 123.6C400 191.8 344.6 247.2 276.4 247.2C248.6 247.2 221.8 238 200 220.8C228.8 198.2 247.2 163 247.2 123.6C247.2 84.2 228.8 49 200 26.4C221.8 9.2 248.6 0 276.4 0C344.6 0 400 55.4 400 123.6Z" fill="#F79E1B" />
                                            </g>
                                            <defs>
                                                <clipPath id="clip0">
                                                    <rect width="400" height="247.2" fill="slate-300" />
                                                </clipPath>
                                            </defs>
                                        </svg>
                                        <span className="block text-sm font-medium text-gray-800 dark:text-neutral-200">•••• 4242</span>
                                    </div>
                                </div>
                                {/* <!-- End Col --> */}
                            </div>
                            {/* <!-- End Grid --> */}

                            <div className="mt-5 sm:mt-10">
                                <h4 className="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">Summary</h4>

                                <ul className="mt-3 flex flex-col">
                                    <li className="inline-flex items-center gap-x-2 py-3 px-4 text-sm border text-gray-800 -mt-px first:rounded-t-lg first:mt-0 last:rounded-b-lg dark:border-neutral-700 dark:text-neutral-200">
                                        <div className="flex items-center justify-between w-full">
                                            <span>Payment left</span>
                                            <span>$0.00</span>
                                        </div>
                                    </li>
                                    <li className="inline-flex items-center gap-x-2 py-3 px-4 text-sm border text-gray-800 -mt-px first:rounded-t-lg first:mt-0 last:rounded-b-lg dark:border-neutral-700 dark:text-neutral-200">
                                        <div className="flex items-center justify-between w-full">
                                            <span>Tax fee</span>
                                            <span>$0.00</span>
                                        </div>
                                    </li>
                                    <li className="inline-flex items-center gap-x-2 py-3 px-4 text-sm font-semibold bg-gray-400 border text-gray-800 -mt-px first:rounded-t-lg first:mt-0 last:rounded-b-lg dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-200">
                                        <div className="flex items-center justify-between w-full">
                                            <span>Amount paid</span>
                                            <span>${amount}</span>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                            {/* <!-- Button --> */}
                            <div className="mt-5 flex justify-end gap-x-2">
                                <button onClick={handleDownloadPDF} className="py-2 px-3 inline-flex justify-center items-center gap-2 rounded-lg border font-medium bg-slate-300 text-gray-700 shadow-md align-middle hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-white focus:ring-blue-600 transition-all text-sm dark:bg-neutral-800 dark:hover:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-400 dark:hover:text-white dark:focus:ring-offset-gray-800">
                                    <svg className="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><polyline points="7 10 12 15 17 10" /><line x1="12" x2="12" y1="15" y2="3" /></svg>
                                    Invoice PDF
                                </button>
                                <button onClick={handlePrint} className="py-2 px-3 shadow-md inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-500 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none">
                                    <svg className="flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="6 9 6 2 18 2 18 9" /><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2" /><rect width="12" height="8" x="6" y="14" /></svg>
                                    Print
                                </button>
                            </div>
                            {/* <!-- End Buttons --> */}
                        </div>
                    </div>
                </div>
            </DialogContent>
        </Dialog >
    )
}
