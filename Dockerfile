FROM mhart/alpine-node:latest

ENV HOST 0.0.0.0

RUN mkdir -p /app
WORKDIR /app
ADD . /app

RUN yarn global add nuxt
RUN yarn global add typescript
RUN yarn install
