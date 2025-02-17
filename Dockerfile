FROM node:18-alpine

# Install OpenSSL 3
RUN apk add --no-cache openssl

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Expose port and set start command
EXPOSE 3000
CMD ["npm", "run", "start"]
