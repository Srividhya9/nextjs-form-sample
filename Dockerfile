FROM node:latest

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install
RUN npm install -g netlify-cli

COPY . .

EXPOSE 4000
CMD ["npm", "start"]

