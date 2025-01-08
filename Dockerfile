# Stage 1: Build React App
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package.json and yarn.lock to install dependencies
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Build the React application
RUN yarn build

# Stage 2: Serve React App with nginx
FROM nginx:alpine AS production

# Copy the build output to the nginx public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
