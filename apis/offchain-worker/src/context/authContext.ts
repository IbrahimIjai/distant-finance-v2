import { Context, Next } from "hono";
import { auth } from "../lib/auth";

const authContext = async (ctx: Context, next: Next) => {
  const session = await auth.api.getSession({ headers: ctx.req.raw.headers });

  if (!session) {
    ctx.set("user", null);
    ctx.set("session", null);
    return next();
  }

  ctx.set("user", session.user);
  ctx.set("session", session.session);
  return next();
};

export default authContext;
