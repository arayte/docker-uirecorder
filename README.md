# Docker-UIRecorder
## Description: Docker images for UIRecorder

### 使用说明
1. 由于UIRecorder的webdriver协议是比较旧的, 开发时未支持w3c，需要手动在生成的.spec.js中添加chromeOptions, w3c:false的配置：
`     let sessionConfig = Object.assign({}, webdriverConfig, {
                    'group': group,
                    'browserName': browserName,
                    'version': browserVersion,
                    'ie.ensureCleanSession': true,
                    'chromeOptions': {
                        'w3c': false
                    },
                });
`

2.在生成的UIRecorder工程中，打开package.json, 删除selenium-standalone的依赖项； 

3.在UIRecorder的工程目录下，添加Dockerfile，用于复制工程到docker镜像中，内容如下：
`FROM docker-uirecorder
COPY . .
`

4. 在工程目录下，添加entry_point.sh, 并执行 chmod a+x entry_point.sh，内容如下：
`#!bin/bash
nohup /opt/bin/entry_point.sh &
sleep 10
npm install
npm run moduletest baidu_search
`
其中，第2行是启动镜像中的chrome-standalone服务，第5行是例行用例的脚本，可自行修改

5. 提交git中需要把工程下的node_modules目录删除

6. 打包镜像并执行：
docker build -t imagename .
docker run -it -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm -v `pwd`/reports:/home/seluser/test/reports imagename sh entry_point.sh
