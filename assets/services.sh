function create-services(){
    cf create-service cloudamqp lemur ALL_CLOUDAMQP
    cf create-service mlab sandbox TUBE_MONGODB
    cf create-service mlab sandbox FEEDBACK_MONGODB
    cf create-service mlab sandbox AUTH_MONGODB
    cf create-service rediscloud 30mb FEEDBACK_REDIS
    cf create-service searchly starter INDEXING_ELASTICSEARCHDB
    cf create-user-provided-service CLOUD_AWS -p '{"accessKey":"(env:USER:KEY:ACCESS)","secretKey":"(env:USER:KEY:SECRET)"}'
    cf create-user-provided-service CONFIG_CREDENTIALS -p '{"username":"**********","password":"**********","encoded_password":"{bcrypt}**********"}'
    cf create-user-provided-service EUREKA_CREDENTIALS -p '{"username":"**********","password":"**********","encoded_password":"{bcrypt}**********"}'
}