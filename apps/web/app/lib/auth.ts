import { createAuthClient } from "better-auth/vue";
export const { useSession, signUp, signIn, signOut } = createAuthClient({
  baseURL: "http://127.0.0.1:8787",
});
