FROM node:18 AS builder 
WORKDIR '/app'
COPY package.json .
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test \
    && apt-get update && apt-get install -y libc6
RUN npm install 
COPY . .
RUN npm run build 


FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
