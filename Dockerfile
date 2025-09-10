FROM node:22.12-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM node:22-alpine AS release

WORKDIR /app
COPY --from=builder /app /app

ENV NODE_ENV=production
ENV PORT=80

RUN npm ci --ignore-scripts --omit-dev

EXPOSE 80
ENTRYPOINT ["node", "server.js"]
