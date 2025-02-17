
# Use the official Node.js image as the base image
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .
COPY .env .env

COPY prisma ./prisma

# Generate Prisma Client (important for DB connection)
RUN npm install
RUN npx prisma generate

# Build the Next.js app
RUN npm run build

# Use a smaller image for the final production environment
FROM node:18-alpine AS runner

# Set the working directory for the production container
WORKDIR /app

# Copy only the build output and necessary files from the builder stage
COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/prisma ./prisma

# Set environment variables
ENV NODE_ENV=production

# Expose the port that the app will run on
EXPOSE 3000

# Start the Next.js application
CMD ["npm", "run", "start"]


