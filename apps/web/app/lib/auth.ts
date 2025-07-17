import { createAuthClient } from "better-auth/vue";
<<<<<<< HEAD
export const { useSession, signUp, signIn, signOut } = createAuthClient({
  baseURL: "http://127.0.0.1:8787",
=======
export const authClient = createAuthClient({
  /** The base URL of the server (optional if you're using the same domain) */
  baseURL: "http://localhost:8000",
>>>>>>> d81dd9104f147d0e59b5b35077c052df05fe42cb
});
