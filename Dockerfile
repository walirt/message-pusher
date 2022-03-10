# FROM --platform=amd64 node:16-bullseye

# WORKDIR /app

# COPY package*.json .

# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
#     touch /etc/apt/sources.list && \
#     echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list && \
#     echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
#     echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list && \
#     echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list && \
#     echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/clean && \
#     apt-get update && \
#     apt-get upgrade -y && \
#     npm config set python "$(which python3)" && \
#     npm install && \
#     npm install -g pm2

# COPY . .

# EXPOSE 3000

# CMD pm2 start ./app.js --name message-pusher --no-daemon

FROM --platform=amd64 node:16-alpine

WORKDIR /app

COPY package*.json .

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache python3 py3-pip && \
    npm config set python "$(which python3)" && \
    npm install && \
    npm install -g pm2

COPY . .

EXPOSE 3000

CMD pm2 start ./app.js --name message-pusher --no-daemon