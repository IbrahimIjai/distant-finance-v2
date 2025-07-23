import { Hono } from "hono";
import cors from "./middleware/cors";
import { auth } from "./lib/auth";

const app = new Hono<{
  Bindings: CloudflareBindings;
  Variables: {
    user: Awaited<ReturnType<typeof auth>>["$Infer"]["Session"]["user"] | null;
    session:
      | Awaited<ReturnType<typeof auth>>["$Infer"]["Session"]["session"]
      | null;
  };
}>();

// middleware/Contexts
app.use(cors);
app.use("*", async (c, next) => {
  const session = await auth(c.env).api.getSession({
    headers: c.req.raw.headers,
  });

  if (!session) {
    c.set("user", null);
    c.set("session", null);
    return next();
  }

  c.set("user", session.user);
  c.set("session", session.session);
  return next();
});

app.on(["POST", "GET"], "/api/auth/*", (c) => {
  return auth(c.env).handler(c.req.raw);
});
export default app;
