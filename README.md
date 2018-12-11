# asrevo
[asrevo](https://asrevo.cfapps.io) is sample spring cloud project for video it is like social apps it provide uploading video see trending videos follow other people like them video comment them  and soon 


![](/assets/site.png)
![](/assets/services.png)	

## asrevo  microservices
*  [eureka](https://github.com/asrevo/eureka)> this is service registry for the application
*  [config](https://github.com/asrevo/config)> config server that provide central configuration for any service   
*  [auth](https://github.com/asrevo/auth)> provide central authentication for any service 
*  [zuul](https://github.com/asrevo/zuul)> provide gateway for the services
*  [tube](https://github.com/asrevo/tube)> provide the main endpoints for the app display media
*  [bento4](https://github.com/asrevo/bento4)> converting video to hls format push them to s3
*  [file](https://github.com/asrevo/file)> upload and unzip files and push them to s3
*  [ffmpeg](https://github.com/asrevo/ffmpeg)> converting video to mp4 format using ffmpeg  create and upload thumb for video 
*  [feedback](https://github.com/asrevo/feedback)> provide some feedback like followers following likes comments on video and trending feed
*  [indexing](https://github.com/asrevo/indexing)> provide the ability to index the data and provide search endpoint for them  
*  [torrent](https://github.com/asrevo/torrent)> provide the ability to download form torrnet


## Pre install
- 1 create [github](https://github.com) account
- 2 create [travis-ci](https://travis-ci.org) account
- 3 create [docker](https://hub.docker.com) account
- 4 create [pivotal](https://account.run.pivotal.io/z/uaa/sign-up) account
- 5 create [aws](https://aws.amazon.com/) account

## Deploy Steps
- 1 <pre>[eureka,config,bento4,tube,file,ffmpeg,feedback,indexing,auth,zuul,torrent].
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forEachOrdered({
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;star(${it});
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fork(${it});
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;add_to_travis(${it});
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;clone(${it});
})</pre>
- 2 <pre>[eureka,config].
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forEachOrdered({
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;add_route in "${it}/manifest.yml" 
})</pre>
- 3 <pre>[config].
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forEachOrdered({
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;update ORG_REVO_ENV_EUREKA_EXTERNALURL in "${it}/manifest.yml"
})</pre>

- 4 <pre>[bento4,tube,file,ffmpeg,feedback,indexing,auth,zuul,torrent].
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forEachOrdered({
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;update ORG_REVO_ENV_CONFIG_EXTERNALURL in "${it}/manifest.yml"
})</pre>
- 5 create aws cloudformation template using this file    [ENV](/templates/ENV.yaml) and provide stack name (env) [application.yaml](https://github.com/asrevo/config/blob/master/src/main/resources/application.yaml#L14)
- 6 create aws CloudFront key pairs and store them in [pk-revo.pm](https://github.com/asrevo/config/blob/master/src/main/resources/static/revo-pk.pem) and [tube.yml](https://github.com/asrevo/config/blob/master/src/main/resources/config/tube.yml#L23)
- 7 add accessKey,secretKey,username,password,encoded_password for config and eureka in [services.sh](assets/services.sh) note encoded_password=encrypt(password) [see](https://github.com/asrevo/config/blob/master/src/main/java/org/revo/Config/Util.java#L138)
- 8 run [./services.sh](assets/services.sh)
- 9 <pre>[eureka,config,bento4,tube,file,ffmpeg,feedback,indexing,auth,zuul,torrent].
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forEachOrdered({
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;provide this [keys](/assets/repo.key) to [Environment Variables(${it})](https://travis-ci.org/${github_username}/${it}/settings)
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//see that we need
         ![](/assets/travis_settings.png)
})</pre>
- 10 <pre>[eureka,config,bento4,tube,file,ffmpeg,feedback,indexing,auth,zuul,torrent].
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forEachOrdered({
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;change ${it}/README.md with your ${github_username} in "Build Status url"
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;commit(${it});
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;push(${it});
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sleep(3 minutes);
})</pre>


## Features will supported
<pre>[paypal,notifier].
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forEach({
        implement(${it})
})</pre>

## Support us

 [paypal](https://www.paypal.me/ashrafrevo)
