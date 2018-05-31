Go 语言安装
------
### 

最新版 Go 语言一键安装脚本。 
* 支持自定义版本。   
* 支持 **Linux / MacOS / FreeBSD** 等系统。

### 注意
* 必须在 **root** 用户下执行脚本。

## 安装
###
```sh
$ curl https://gitee.com/skiy/golang-install/raw/master/install.sh | sh
```
or
```sh
$ wget -qO- https://gitee.com/skiy/golang-install/raw/master/install.sh | sh
```

### 自定义版本   
* ***MY_DIY_GO_VERSION*** 是自定义版本号, 例如： ***1.10.1***
```sh
$ curl -SL https://gitee.com/skiy/golang-install/raw/master/install.sh | bash /dev/stdin MY_DIY_GO_VERSION
```
or
```sh
$ wget -qO- https://gitee.com/skiy/golang-install/raw/master/install.sh | bash /dev/stdin MY_DIY_GO_VERSION
```

### 离线执行
保存脚本并且命名为 **install.sh** 。   
执行脚本安装最新版 Go 语言。
```sh
$ sh go.install.sh
```
  
如果你给脚本可执行权限，那么同时可以自定义 Go 语言版本。  
```sh
# 添加可执行权限
$ chmod +x install.sh

# 最新版
$ ./install.sh

# 自定义版本
$ ./install.sh 1.9.2
```

### 作者
Author: Skiychan   
Email : dev@skiy.net   
Link  : https://www.skiy.net 