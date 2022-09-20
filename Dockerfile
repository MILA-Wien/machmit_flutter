#Building
# Install Operating system and dependencies
FROM ubuntu:20.04 AS build-env

ENV DEBIAN_FRONTEND="noninteractive" TZ="Europe/Vienna"

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean
# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable web sdk
RUN flutter config --enable-web

# Run flutter doctor
RUN flutter doctor



RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web


# Running
FROM nginx:alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html