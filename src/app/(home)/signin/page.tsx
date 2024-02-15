import { SignInForm } from './_componenets/SignInForm'

export default function SignIn() {
  return (
    <div className='flex flex-col items-center justify-center gap-8 mx-auto max-w-xs w-full mt-12'>
      <p className='text-2xl'>Please sign In</p>
      <SignInForm />
    </div>

  )
}
