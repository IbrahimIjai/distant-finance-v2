import { cors as corsMiddleware } from "hono/cors";

const allowedOrigins = ["http://localhost:3000", "https://example.org"];

const cors = corsMiddleware({
  origin: allowedOrigins,
  allowHeaders: ["Content-Type", "Authorization"],
  allowMethods: ["POST", "GET", "OPTIONS"],
  exposeHeaders: ["Content-Length"],
  maxAge: 600,
  credentials: true,
});

export default cors;
