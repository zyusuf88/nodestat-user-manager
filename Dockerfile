FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force
COPY *.js index.html Logo.png init.sql ./

FROM node:18-alpine
WORKDIR /app
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

COPY --from=builder /app /app

RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 3000
CMD ["npm", "start"]
