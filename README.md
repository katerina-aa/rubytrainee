## Repository description
This is my way of completing tasks in accordance with [the rump-up plan](https://confluence.softserveinc.com/display/CiscoArrAy/Rump-up+plan+K.Belenova).

The first six solutions are located in "tasks" folder. These tasks were aimed at consolidating knowledge of the Ruby fundamentals and OOP principles.

The second part of tasks are located in "api" folder. There were created an automation framework, specs for testing API and also added Dockerfile to create a docker image.

#### Pre-conditions to create docker image 
1. Pull this repo locally
2. Setup Docker Desktop

#### Usage to create docker image 
1. Run your Docker daemon
2. Go to "api" folder in terminal
3. Start the container with the following command 
```bash
docker compose up -d --build
```
4. Wait about 2 minutes for the tests to complete and reports to be generated.
5. Test reports location is  
```bash
api-web-1:/home/testing/tmp/
```
6. Use the following command for stop running container 
```bash
docker compose stop
``` 
7. Use the following command for stop running container and delete containers, images, volumes and networks
```bash
bash bin/destroy.sh
```
