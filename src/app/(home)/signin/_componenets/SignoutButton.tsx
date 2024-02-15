"use client"
import { signOut } from "@/lib/auth"
import { Button } from "@/components/ui/button"
export default function SignoutButton() {
  return (
    <Button
      className="w-full md:w-auto"
      onClick={() => signOut({ redirectTo: `/` })}
      variant="destructive"
    >
      Sign out
    </Button>
  )
}
