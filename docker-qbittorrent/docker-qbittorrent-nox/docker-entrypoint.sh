#!/bin/bash
 
# Get Host user id
# 获取主机用户id
USER_ID=${LOCAL_USER_ID:-9001}

#
# 创建和主机用户相同uid的用户，名为userind(user in docker)
useradd --shell /bin/bash -u $USER_ID -o -c "" -m userindocker
usermod -a -G root userindocker
export HOME=/home/userindocker
 
exec /usr/local/bin/gosu userindocker "$@"