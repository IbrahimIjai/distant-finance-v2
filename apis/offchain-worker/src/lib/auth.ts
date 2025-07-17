import { betterAuth } from "better-auth";
import { prisma } from "@distant/db";
import { prismaAdapter } from "better-auth/adapters/prisma";
import { emailOTP } from "better-auth/plugins";

export const auth = betterAuth({
<<<<<<< HEAD
  baseURL: "https://example.com",
=======
>>>>>>> d81dd9104f147d0e59b5b35077c052df05fe42cb
  secret: process.env.BETTER_AUTH_SECRET as string,
  database: prismaAdapter(prisma, {
    provider: "postgresql",
  }),
  socialProviders: {
    google: {
      clientId: process.env.GOOGLE_CLIENT_ID as string,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET as string,
    },
  },
  plugins: [
    emailOTP({
      async sendVerificationOTP({ email, otp, type }) {
        console.log("Sending OTP to", email, otp, type);
      },
    }),
  ],
<<<<<<< HEAD
  advanced: {
    crossSubDomainCookies: {
      enabled: true,
    },
  },
=======
>>>>>>> d81dd9104f147d0e59b5b35077c052df05fe42cb
});
