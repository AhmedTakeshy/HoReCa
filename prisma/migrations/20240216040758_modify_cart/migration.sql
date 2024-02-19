/*
  Warnings:

  - Added the required column `totalAmount` to the `Cart` table without a default value. This is not possible if the table is not empty.
  - Added the required column `totalQuantity` to the `Cart` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Cart" ADD COLUMN     "totalAmount" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "totalQuantity" INTEGER NOT NULL;
