FROM node:20 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
# RUN npm install workspaces focus --production

COPY . .

RUN npm run build

FROM node:20-alpine3.20

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

EXPOSE 3000

CMD ["npm", "run", "start:prod"]
