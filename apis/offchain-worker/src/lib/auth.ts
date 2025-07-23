import { betterAuth } from "better-auth";
import { prisma } from "@distant/db";
import { prismaAdapter } from "better-auth/adapters/prisma";
import { emailOTP } from "better-auth/plugins";
export const auth = (env: CloudflareBindings): ReturnType<typeof betterAuth> => {
  return betterAuth({
    secret: env.BETTER_AUTH_SECRET,
    database: prismaAdapter(prisma, { provider: "postgresql" }),
    socialProviders: {
      google: {
        clientId: env.GOOGLE_CLIENT_ID,
        clientSecret: env.GOOGLE_CLIENT_SECRET,
      },
    },
    plugins: [
      emailOTP({
        async sendVerificationOTP({ email, otp, type }) {
          console.log("Sending OTP to", email, otp, type);
        },
      }),
    ],
  });
};
