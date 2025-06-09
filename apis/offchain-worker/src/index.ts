import { Hono } from "hono";
import { cors } from "hono/cors";

const app = new Hono();

app.use(
  "/*",
  cors({
    origin: ["http://localhost:3000", "https://example.org"],
  })
);

// Simple in-memory storage for demo
let users = [
  { id: 1, name: "John Doe", email: "john@example.com" },
  { id: 2, name: "Jane Smith", email: "jane@example.com" },
];

app.get("/", (c) => {
  return c.text("Hello Hono!");
});

// GET all users
app.get("/users", (c) => {
  return c.json({
    success: true,
    data: users,
    message: "Users fetched successfully",
  });
});

// GET single user
app.get("/users/:id", (c) => {
  const id = parseInt(c.req.param("id"));
  const user = users.find((u) => u.id === id);

  if (!user) {
    return c.json(
      {
        success: false,
        message: "User not found",
      },
      404
    );
  }

  return c.json({
    success: true,
    data: user,
    message: "User fetched successfully",
  });
});
// POST create new user
app.post("/users", async (c) => {
  try {
    const body = await c.req.json();

    // Basic validation
    if (!body.name || !body.email) {
      return c.json(
        {
          success: false,
          message: "Name and email are required",
        },
        400
      );
    }

    // Create new user
    const newUser = {
      id: Math.max(...users.map((u) => u.id), 0) + 1,
      name: body.name,
      email: body.email,
    };

    users.push(newUser);

    return c.json(
      {
        success: true,
        data: newUser,
        message: "User created successfully",
      },
      201
    );
  } catch (error) {
    return c.json(
      {
        success: false,
        message: "Invalid JSON data",
      },
      400
    );
  }
});

export default app;
