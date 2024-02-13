/*
  Warnings:

  - You are about to drop the `CartItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OrderItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WishlistItem` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_cartId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_productId_fkey";

-- DropForeignKey
ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_orderId_fkey";

-- DropForeignKey
ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_productId_fkey";

-- DropForeignKey
ALTER TABLE "WishlistItem" DROP CONSTRAINT "WishlistItem_productId_fkey";

-- DropForeignKey
ALTER TABLE "WishlistItem" DROP CONSTRAINT "WishlistItem_wishlistId_fkey";

-- AlterTable
ALTER TABLE "Product" ADD COLUMN     "quantity" INTEGER NOT NULL DEFAULT 0;

-- DropTable
DROP TABLE "CartItem";

-- DropTable
DROP TABLE "OrderItem";

-- DropTable
DROP TABLE "WishlistItem";

-- CreateTable
CREATE TABLE "_CartToProduct" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ProductToWishlist" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_OrderToProduct" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_CartToProduct_AB_unique" ON "_CartToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_CartToProduct_B_index" ON "_CartToProduct"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ProductToWishlist_AB_unique" ON "_ProductToWishlist"("A", "B");

-- CreateIndex
CREATE INDEX "_ProductToWishlist_B_index" ON "_ProductToWishlist"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_OrderToProduct_AB_unique" ON "_OrderToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_OrderToProduct_B_index" ON "_OrderToProduct"("B");

-- AddForeignKey
ALTER TABLE "_CartToProduct" ADD CONSTRAINT "_CartToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "Cart"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CartToProduct" ADD CONSTRAINT "_CartToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProductToWishlist" ADD CONSTRAINT "_ProductToWishlist_A_fkey" FOREIGN KEY ("A") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProductToWishlist" ADD CONSTRAINT "_ProductToWishlist_B_fkey" FOREIGN KEY ("B") REFERENCES "Wishlist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrderToProduct" ADD CONSTRAINT "_OrderToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrderToProduct" ADD CONSTRAINT "_OrderToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
