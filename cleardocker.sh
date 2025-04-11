echo "stopping all running containers"
docker stop $(docker ps -aq)
echo "removing all stored data"
docker system prune -af --volumes
echo "Done cleaning up!"
