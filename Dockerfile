FROM node:16-stretch-slim as builder

ARG REACT_APP_GITHUB_CLIENT_ID

ARG REACT_APP_GITHUB_CLIENT_SECRET

WORKDIR /app

COPY package.json .

RUN npm install

COPY . /app/

ENV REACT_APP_GITHUB_CLIENT_ID $REACT_APP_GITHUB_CLIENT_ID

ENV REACT_APP_GITHUB_CLIENT_SECRET $REACT_APP_GITHUB_CLIENT_SECRET

RUN cd /app/public && npm run build

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
