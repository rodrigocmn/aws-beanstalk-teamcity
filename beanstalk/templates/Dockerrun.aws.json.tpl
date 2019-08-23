{
  "AWSEBDockerrunVersion": "2",
  "containerDefinitions": [
    {
      "name": "teamcity-server",
      "image": "${docker_image}:${docker_tag}",
      "memory": 3700,
      "cpu": 2048,
      "essential": true,
      "portMappings": [
        {
          "hostPort": ${docker_host_port},
          "containerPort": ${docker_container_port}
        }
      ],
      "command": [
        "/bin/bash",
        "-c",
        "if [ ! -f /data/teamcity_server/datadir/lib/jdbc ]; then mkdir -p /data/teamcity_server/datadir/lib/jdbc; curl -o /data/teamcity_server/datadir/lib/jdbc/mysql-connector-java-bin.jar http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.43/mysql-connector-java-5.1.43.jar; fi; if [ ! -f /data/teamcity_server/datadir/config/database.properties ]; then mkdir -p /data/teamcity_server/datadir/config; echo connectionProperties.user=${db_username} > /data/teamcity_server/datadir/config/database.properties; echo connectionProperties.password=${db_password} >> /data/teamcity_server/datadir/config/database.properties; echo connectionUrl=jdbc:mysql://${db_address}:${db_port}/${db_name} >> /data/teamcity_server/datadir/config/database.properties; fi; if [ ! -f /data/teamcity_server/datadir/plugins ]; then mkdir -p /data/teamcity_server/datadir/plugins; curl -o /data/teamcity_server/datadir/plugins/aws-ecs.zip https://teamcity.jetbrains.com/guestAuth/app/rest/builds/buildType:TestDrive_TeamCityAmazonEcsPlugin_Build20172x,tag:release/artifacts/content/aws-ecs.zip; fi; echo 'docker-ubuntu-aws' > /opt/teamcity/webapps/ROOT/WEB-INF/DistributionType.txt; exec /run-services.sh;"
      ]
    }
  ]
}