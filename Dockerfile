FROM node:20-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci --omit=dev

USER node

COPY . ./

EXPOSE 3000

CMD ["node", "index.js"]