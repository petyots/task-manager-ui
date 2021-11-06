FROM node:14

# Create app directory
WORKDIR /app
ADD . /app/

RUN rm yarn.lock
RUN yarn

ENV HOST 0.0.0.0
EXPOSE 3000

# start command
CMD [ "yarn", "dev" ]
