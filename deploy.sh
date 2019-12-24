echo "Deploy $DOCKER_USERNAME/$NAME:$VERSION"
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push $DOCKER_USERNAME/$NAME:$VERSION

if [ "$AS_DEF" = "true" ]; then
  docker tag $DOCKER_USERNAME/$NAME:$VERSION $DOCKER_USERNAME/$NAME:latest
  docker push $DOCKER_USERNAME/$NAME:latest
fi
