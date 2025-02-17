# Build stage
FROM node:18-bullseye AS build

# Install OpenSSL if required by your dependencies
RUN apt-get update && apt-get install -y openssl

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all app files
COPY . .

# Build Next.js app and generate Prisma client
RUN npm run build
RUN npx prisma generate

# Production stage
FROM node:18-bullseye

# Set working directory
WORKDIR /app

# Copy from build stage
COPY --from=build /app /app

# Expose port and run the app
EXPOSE 3000
CMD ["npm", "start"]
