# Use the official Node.js 18 image (Alpine for a lightweight version)
FROM node:18.17-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies using npm
RUN npm install --production

# Copy the rest of the application’s code
COPY . .

# Set environment variables (optional)
# ENV NEXT_PUBLIC_API_URL=http://your-api-url
# or you can set them dynamically when running the container

# Build the application for production
RUN npm run build

# Expose the port that Next.js uses (usually 3000)
EXPOSE 3000

# Run the Next.js application
CMD ["npm", "start"]
