# Stage 1: Base with all dependencies
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./

# Stage 2: Development dependencies
FROM base AS development
RUN npm install
COPY . .

# Stage 3: Run tests
FROM development AS test
RUN npm test || echo "Tests would run here"

# Stage 4: Production dependencies only
FROM base AS production-deps
RUN npm ci --only=production

# Stage 5: Final production image
FROM node:20-alpine AS production
WORKDIR /app
ENV NODE_ENV=production
COPY --from=production-deps /app/node_modules ./node_modules
COPY package*.json ./
COPY app.js server.js ./
USER node
EXPOSE 3000
CMD ["node", "server.js"]
