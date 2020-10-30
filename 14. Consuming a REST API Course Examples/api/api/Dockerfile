FROM node:12-slim
WORKDIR /src
COPY package*.json ./
COPY tqnotes-service-account.json ./
RUN npm install --only=production
COPY . ./
CMD [ "npm", "start" ]