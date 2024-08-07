"use client"
import SignInForm from "../../signin/_components/SignInForm"
import { Dialog, DialogContent, DialogHeader, DialogTitle, } from "@/components/ui/dialog"
import { usePathname, useRouter } from 'next/navigation'
import { useEffect, useState } from "react"


export default function Page() {
  const pathname = usePathname()
  const router = useRouter()
  const [isOpened, setIsOpened] = useState<boolean>(true)

  const handleOpen = (val: boolean) => {
    setIsOpened(val)
  }
  useEffect(() => {
    handleOpen(pathname.includes("/signin"))
  }, [pathname])

  return (
    <div className='flex items-center justify-center mt-12 max-w-md w-full mx-auto'>
      <Dialog open={isOpened} onOpenChange={() => { setIsOpened(prev => !prev); router.back() }}>
        <DialogContent aria-describedby={"Login form for users"}>
          <DialogHeader>
            <DialogTitle>Login</DialogTitle>
          </DialogHeader>
          <SignInForm />
        </DialogContent>
      </Dialog>
    </div>
  )
}
