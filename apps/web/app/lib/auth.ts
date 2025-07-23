import { createAuthClient } from "better-auth/vue";
export const { useSession, signIn, signOut } = createAuthClient({
  baseURL: "http://127.0.0.1:8787",
  
});
