{
  "AWSEBDockerrunVersion": "1",
  "Ports": [
    {
    "ContainerPort": "${docker_container_port}",
    "HostPort": "${docker_host_port}"
    }
  ],
  "Image": {
    "Name": "${docker_image}:${docker_tag}",
    "Update": "true"
  }
}