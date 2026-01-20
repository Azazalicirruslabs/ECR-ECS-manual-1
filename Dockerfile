# Stage 1 (build)
FROM node:18 AS builder

WORKDIR /build

COPY package*.json ./
RUN npm install

COPY tsconfig.json ./
COPY src/ ./src/

RUN npm run build


# Stage 2 (run)
FROM node:18-slim AS runner

WORKDIR /app

# Copy package files and install only production dependencies
COPY --from=builder /build/package*.json ./
RUN npm install --omit=dev

# Copy built application
COPY --from=builder /build/dist ./dist

# Use non-root user
USER node

CMD ["npm", "start"]