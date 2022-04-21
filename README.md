1) Make build.sh executable ```chmod +x build.sh```
2) Build the Docker image ```./build.sh```
3) Run the Docker image in a container ```docker run glob_test:latest```
4) "Starting" and "All files searched" should be outputted, but "Finished" never appears
5) ```docker ps -a``` to find the container then
   1) ```docker container stop [...]```
   2) ```docker container remove [...]```
