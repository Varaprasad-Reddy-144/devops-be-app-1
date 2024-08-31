FROM node:18.16.1-alpine3.18 AS builder

# Set the working directory
WORKDIR /app

# Copy files into /app
COPY package*.json ./

RUN apk --no-cache add --virtual native-deps \
      g++ gcc libgcc libstdc++ linux-headers make python3 && \
    npm install --quiet node-gyp -g && \
    npm install --quiet && \
    apk del native-deps

# Copy the rest of the application code
COPY . .

# Stage 2: Runtime
FROM node:18.16.1-alpine3.18

# Set the working directory in the runtime stage
WORKDIR /app

# Copy the built application and node_modules from the builder stage
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app /app

# Expose the port your app runs on
EXPOSE 8000

CMD ["node", "server.js"]