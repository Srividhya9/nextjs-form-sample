FROM node:18-bullseye

# Install OpenSSL
RUN apt-get update && apt-get install -y openssl

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the app
COPY . .
RUN npm run build
# Generate Prisma client
RUN npx prisma generate

# Expose port and set start command
EXPOSE 3000
CMD ["npm", "run", "start"]
