# 构建php的Dockerfile

* 7.4

* 都默认安装了redis模块

* php配置在/data/apps/php/etc/目录下，可以通过挂载自定义

~~~
//构建7.336
docker build -t php:7.4 . -f ./Dockerfile
//构建mini 这样做可以使用mini下的Dockerfile,同时可以使用当前根目录的文件比如 copy_lib.sh
docker build -t php:7.4 . -f ./mini/Dockerfile
~~~