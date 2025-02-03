# Use Node.js as base image
FROM node:16-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all app files
COPY . .

# Build app (for React)
RUN npm run build

# Expose port 80
EXPOSE 80


