# Always up to date [scrumonline](https://github.com/Toxantron/scrumonline) docker build

# 💁 🏃 📇 📅 
> (Helping your sprint user-story planning)

I build the [fauria/lamp](https://github.com/fauria/docker-lamp) because the built image is very old so this will be patched at least

You can then deploy this with ECS or something to your own stack when you want to run planning poker! 🥳🎉🥳

## [Original](https://hub.docker.com/r/chrisns/scrumonline) [![](https://images.microbadger.com/badges/image/chrisns/scrumonline.svg)](https://microbadger.com/images/chrisns/scrumonline) [![](https://images.microbadger.com/badges/version/chrisns/scrumonline.svg)](https://microbadger.com/images/chrisns/scrumonline)

This is the vanilla version, so follow the [official docs](https://github.com/Toxantron/scrumonline/blob/master/doc/Docker.md) for running it, it just has a current base with the fresh build of [fauria/lamp](https://github.com/fauria/docker-lamp). I've not run it this way, so you're on your own making it work



## [Stateless](https://hub.docker.com/r/chrisns/scrumonline-stateless) [![](https://images.microbadger.com/badges/image/chrisns/scrumonline-stateless.svg)](https://microbadger.com/images/chrisns/scrumonline-stateless) [![](https://images.microbadger.com/badges/version/chrisns/scrumonline-stateless.svg)](https://microbadger.com/images/chrisns/scrumonline-stateless)

> You can obviously make it stateful if you like by volume mounting

This is hacked without the volumes so that you can just do a docker run (even works with [Google Cloud Run](https://cloud.google.com/run)) (you'll wanna set at least 512mb ram)

```bash
docker run -p 8080:80 chrisns/scrumonline-stateless
```

## Todo

- [ ] Separate out
  - Use standard well maintained php base
  - Separate mysql container
- [ ] Provide google cloud run config