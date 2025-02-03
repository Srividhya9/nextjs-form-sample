
# Use the official Node.js image as the base image
FROM node:18 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Next.js app
RUN npm run build

# Use a smaller image for the final production environment
FROM node:18-slim

# Set the working directory for the production container
WORKDIR /app

# Copy only the build output and necessary files from the builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package.json /app/package-lock.json /app/

# Copy the index.js file from your local directory into the Docker container (if it's not already included)
COPY index.js /app/index.js

# Install only production dependencies
RUN npm install --production

# Expose the port that the app will run on
EXPOSE 3000

# Set the environment variable to indicate production environment
ENV NODE_ENV=production

# Start the Next.js app in production mode
CMD ["npm", "start"]


