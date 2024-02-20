This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Getting Started

### First, rename env.example file to .env to be able to connect to the database, and to be able to use next-auth.

### Second, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

## Structure

### Home page has categories of the products can see all the products of that category by clicking on `View all` button,

### or click on view details to preview that all details of that product.

#### Within the category there are filtering and sorting.

#### Redux used to manage the cart process like adding, and removing.

#### The app is connected to the database by prisma to save the cart of the user in the database and sync the cart of a user, when they sign in.

### There are already 2 accounts made to make the process smoother but also you can sign-up.

## For normal user email: `user@user.com` password: `user1234`

## For admin has access to the dashboard email: `admin@admin.com` password: `admin123`

## The dashboard route is protected, only accessible with account has role=ADMIN

### Some extra features are not implemented yet such as:

#### wishlist

#### The content of dashboard for admins as well as profile for users
