# fox2ray


### 使用官方镜像集成，结构简洁，可随时跟随官方进行更新。

### 使用说明：

端口80默认由caddy使用，提供伪装服务，使用自签名证书，默认禁用自动申请证书；443由xray使用，提供数据传输和回落伪装。

提供XTLS+VLESS和WS+VMess等连接方式，WS+VMess连接路径为`/line`。

运行使用的主要配置文件保存在`server`文件夹下。

需要安装docker和docker-compose。

运行`other_install/install-docker.sh`安装docker和docker-compose
运行`other_install/install_update-portainer`安装或更新portainer。

复制`fox2ray.properties.example`为`fox2ray.properties`并修改文件中的参数，运行`./init.sh`进行配置文件初始化。

使用命令`./fox2ray.sh`启动相关服务。

### v2rayN配置样例：
```
vmess://ew0KICAidiI6ICIyIiwNCiAgInBzIjogInRlc3QiLA0KICAiYWRkIjogIjEuMS4xLjEiLA0KICAicG9ydCI6ICIxNDQ0MyIsDQogICJpZCI6ICIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDAiLA0KICAiYWlkIjogIjAiLA0KICAic2N5IjogImF1dG8iLA0KICAibmV0IjogIndzIiwNCiAgInR5cGUiOiAibm9uZSIsDQogICJob3N0IjogInRlc3QuZmxvdy5xcS5jb20iLA0KICAicGF0aCI6ICIvbGluZSIsDQogICJ0bHMiOiAidGxzIiwNCiAgInNuaSI6ICJ0ZXN0LmZsb3cucXEuY29tIiwNCiAgImFscG4iOiAiIg0KfQ==
```

### 其他
`http_forward.sh`可以设置80端口映射，可以免caddy伪装，需要有单独的http服务器。