# Always up to date [scrumonline](https://github.com/Toxantron/scrumonline) docker build

# 💁 🏃 📇 📅 
> (Helping your sprint user-story planning)

You can then deploy this with docker/docker-compose/docker-swarm/AKS/EKS/ECS/k8s/google cloud run or something to your own stack when you want to run planning poker! 🥳🎉🥳

## [chrisns/scrumonline:latest](https://hub.docker.com/r/chrisns/scrumonline)

> ‼️ Requires an external mysql service available to it, also note the db init script usage as below

```bash
docker run \
  -p 8080:80 \
  -e DB_NAME=scrum_online \
  -e DB_USER=root \
  -e DB_PASS=passwd \
  -e DB_HOST=192.168.0.1 \
  -e HOST="http://localhost:8080" \
  chrisns/scrumonline:latest
```

## [chrisns/scrumonline:bundled](https://hub.docker.com/r/chrisns/scrumonline)

> Comes with an **embedded mysql**, breaks the anti-pattern of only one process in a container, and obviously won't let you scale things sensibly but if all you need is a cheap runner for this to run in something like a single thread knative (like google cloud run) then this is a winner for you!

```bash
docker run \
  -p 8080:80 \
  -e HOST="http://localhost:8080" \
  chrisns/scrumonline:bundled
```

> State is only in the container, so when you stop the container, so does your data, you can get around this by volume mounting mysql's data in, and also running the init manually to create tables:

```bash
docker run \
  -v ${PWD}/db:/var/lib/mysql
  chrisns/scrumonline:bundled \
  ./mysql_init.sh
```

## Notes

Without the volumes and persistence you can just do a docker run as above (even works with [Google Cloud Run](https://cloud.google.com/run)) (you'll wanna set at least 512mb ram)

## Todo

- [ ] example kube config
- [ ] example knative config
- [ ] kustomize template
- [ ] docker compose
- [ ] Provide google cloud run config
- [ ] Update PHP
