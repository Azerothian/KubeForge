FROM node:20-alpine AS builder

WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install

COPY . .

RUN NEXT_IGNORE_TYPE_ERRORS=true npm run build

FROM node:20-alpine
USER node

WORKDIR /app
COPY --from=builder --chown=node:node /app ./
ENV NODE_ENV=production

EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]
