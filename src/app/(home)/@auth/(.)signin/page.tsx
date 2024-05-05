"use client"
import SignInForm from "../../signin/_components/SignInForm"
import { Dialog, DialogContent, } from "@/components/ui/dialog"
import { useRouter } from 'next/navigation'


export default function Page() {
  const router = useRouter()
  return (
    <div className='flex items-center justify-center mt-12 max-w-md w-full mx-auto'>
      <Dialog defaultOpen={true} onOpenChange={() => router.back()}>
        <DialogContent>
          <SignInForm />
        </DialogContent>
      </Dialog>
    </div>
  )
}
