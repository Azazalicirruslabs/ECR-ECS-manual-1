# Stage 1: Build
FROM node:18.20.0 AS builder

WORKDIR /build

COPY package*.json ./
RUN npm install

COPY tsconfig.json ./
COPY src ./src

RUN npm run build


# Stage 2: Runtime
FROM node:18.20.0-slim AS runner

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /build/package*.json ./
RUN npm install --omit=dev

COPY --from=builder /build/dist ./dist

EXPOSE 8000

USER node

CMD ["node", "dist/index.js"]
