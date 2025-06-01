FROM node:18-alpine AS builder
WORKDIR /app
COPY app/package.json ./package.json
COPY app/package-lock.json ./package-lock.json
RUN npm ci --only=production && npm cache clean --force
COPY app/index.js app/index.html app/init.sql ./
COPY app/assets ./assets

FROM node:18-alpine
WORKDIR /app
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

COPY --from=builder /app /app

RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 3000
CMD ["npm", "start"]
