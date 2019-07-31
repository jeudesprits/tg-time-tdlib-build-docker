# 📜 About
Simple Docker container to build TDLib (Telegram Database library) on Docker for [tg-time](https://github.com/jeudesprits/tg-time) or for your **NodeJS** project.

# 🏗 Setup
1. Clone this repo: `git clone https://github.com/jeudesprits/tg-time-tdlib-build-docker`
2. Go to folder: `cd tg-time-tdlib-build-docker`
3. Build docker container: `docker build --tag=jeudesprits/tg-time-tdlib-build-docker .`
4. Run docker container. Be sure that you specify the correct path to copy `libtdjson.so` file:
```
docker run -i --rm -v $HOME/dev/tg-time/lib:/libtdjson jeudesprits/tg-time-tdlib-build-docker:latest
```
