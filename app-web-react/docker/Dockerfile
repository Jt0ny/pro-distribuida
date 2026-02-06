#docker build -f docker/Dockerfile -t anthonyjoel/app-web-react .
#docker push anthonyjoel/app-web-react
FROM node:22-alpine AS builder

WORKDIR /app

ARG VITE_BOOKS_API_URL="http://localhost/app-books/books"
ENV VITE_BOOKS_API_URL=${VITE_BOOKS_API_URL}

COPY package.json package-lock.json* ./
RUN npm ci || npm install

COPY . .
RUN npm run build

FROM node:22-alpine

WORKDIR /app

RUN npm install -g serve

COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]

