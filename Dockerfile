# Stage 1 (build)
FROM node:18 AS builder

WORKDIR /build

COPY package*.json ./
RUN npm install

COPY tsconfig.json ./
COPY src/ ./src/

RUN npm run build


# Stage 2 (run)
FROM node:18 AS runner

WORKDIR /app

COPY --from=builder /build/package*.json ./
COPY --from=builder /build/node_modules ./node_modules
COPY --from=builder /build/dist ./dist

CMD ["npm", "start"]
