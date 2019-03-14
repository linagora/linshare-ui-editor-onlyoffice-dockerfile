# linshare-editor-onlyoffice-frontend-dockerfile
#### How to build the image
You can set a custom version number on the command-line by using the --build-args switch.
```bash
$ docker build --build-arg VERSION="2.0.0-SNAPSHOT" --build-arg CHANNEL="snapshots" -t linagora/linshare-ui-editor-onlyoffice:latest .
```

#### How to run the container

```bash
$ docker run -d \
-e LINSHARE_BACKEND_HOST=<linshare-backend-host> \
-e LINSHARE_BACKEND_PORT=<linshare-backend-port> \
-p 8888:80 \
linagora/linshare-ui-editor-onlyoffice
```

#### Options

* LINSHARE_BACKEND_HOST : Linshare backend host, default to `linshare.local`
* LINSHARE_BACKEND_PORT : Linshare backend port, default to `28080`
