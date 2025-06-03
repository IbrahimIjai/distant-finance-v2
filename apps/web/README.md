# Nuxt UI Minimal Starter

Look at [Nuxt docs](https://nuxt.com/docs/getting-started/introduction) and [Nuxt UI docs](https://ui.nuxt.com) to learn more.

## Setup

Make sure to install the dependencies:

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install

# bun
bun install
```

## Development Server

Start the development server on `http://localhost:3000`:

```bash
# npm
npm run dev

# pnpm
pnpm run dev

# yarn
yarn dev

# bun
bun run dev
```

## Production

Build the application for production:

```bash
# npm
npm run build

# pnpm
pnpm run build

# yarn
yarn build

# bun
bun run build
```

Locally preview production build:

```bash
# npm
npm run preview

# pnpm
pnpm run preview

# yarn
yarn preview

# bun
bun run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.

# Guestbook Feature

The guestbook allows visitors to sign your website with their name, message, Twitter username, and a personalized signature drawn using the drawing pad. All entries are stored in Cloudflare R2 storage.

## Features

- Form with validation for name, comment, and signature
- Optional Twitter username field (automatically formats with @ symbol)
- Interactive signature pad with drawing tools and controls
- List of all previous signatures with pagination
- Responsive design that works on mobile and desktop
- Secure storage of signatures in Cloudflare R2

## Setup Instructions

### 1. Cloudflare R2 Setup

1. Create a Cloudflare account if you don't have one already
2. Go to R2 in the Cloudflare dashboard and create a new bucket
3. Create API tokens with read/write access to your R2 bucket
4. Note your Account ID, Access Key ID, Secret Access Key, and Bucket Name

### 2. Environment Variables

Create a `.env` file in the root of your project with the following variables:

```
CLOUDFLARE_ACCOUNT_ID=your_account_id
CLOUDFLARE_ACCESS_KEY_ID=your_access_key_id
CLOUDFLARE_SECRET_ACCESS_KEY=your_secret_access_key
CLOUDFLARE_R2_BUCKET_NAME=your_bucket_name
```

Replace the placeholder values with your actual Cloudflare R2 credentials.

### 3. Install Dependencies

Make sure you have the AWS SDK dependencies installed:

```bash
pnpm install
```

### 4. Test the Guestbook

Start your development server:

```bash
pnpm dev
```

Navigate to the guestbook page at `/guestbook` and try signing it. You should be able to:

- Enter your name, comment, and Twitter username
- Draw a signature
- Submit the form
- See your entry appear in the list of signatures

## Technical Details

### Data Structure

The guestbook stores entries in R2 using the following structure:

- `guestbook/entries.json`: JSON file containing metadata for all entries
- `guestbook/signatures/{id}.png`: Individual signature images

Each entry in the `entries.json` file has the following structure:

```json
{
	"id": "unique-uuid",
	"name": "John Doe",
	"twitter": "@johndoe",
	"comment": "Great website!",
	"signature": "/api/guestbook/signature/unique-uuid",
	"createdAt": "2023-06-15T12:34:56.789Z"
}
```

### API Endpoints

- `GET /api/guestbook`: Returns a list of all guestbook entries
- `POST /api/guestbook`: Creates a new guestbook entry
- `GET /api/guestbook/signature/{id}`: Returns a signature image

## Troubleshooting

If you encounter any issues:

1. Check that your Cloudflare R2 credentials are correct
2. Ensure your bucket has the appropriate permissions
3. Check the browser console and server logs for any errors
4. Verify that the required AWS SDK dependencies are installed

## Security Considerations

- Signatures are stored as PNG images to prevent XSS attacks
- Basic validation is performed on all user inputs
- Rate limiting should be implemented for production use
