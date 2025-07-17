import {  PrismaClient } from "@distant/db";
import { withAccelerate } from "@prisma/extension-accelerate";

export const prisma = new PrismaClient({
   datasourceUrl: process.env.BETTER_AUTH_SECRET,
 }).$extends(withAccelerate());