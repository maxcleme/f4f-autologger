# F4F-Autologger

## Command

Script ```f4f-login.sh``` can be used as is

#### Run

```
./f4f-login.sh [-u|--username username] [-p|--password password]
```

*Note : Username and password will be asked if not set by start-up command, OR you can also set env variables instead : ```F4F_USERNAME``` and ```F4F_PASSWORD```* 


## Docker

Docker image to log you everyday at 2PM to win 4 reward points.

#### Build
```
docker build --rm -t f4f-autologger .
```

#### Start

```
docker run -t -i --env-file=[ENV-FILE] --rm f4f-autologger
```


```ENV-FILE``` is based on ```default.env``` file, be sure to define both user and password variable.