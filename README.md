Golang-Install
------
### 

The latest version of the golang is installed.   
* Support custom versions.   
* Support **Linux / MacOS / FreeBSD**.

### Note
* You must be **root** to run this script.

## Installation
###
```sh
$ curl https://raw.githubusercontent.com/skiy/golang-install/master/install.sh | sh
```
or
```sh
$ wget -qO- https://raw.githubusercontent.com/skiy/golang-install/master/install.sh | sh
```

### Custom version   
* ***MY_DIY_GO_VERSION*** is a custom golang version, such as： ***1.10.1***
```sh
$ curl -SL https://raw.githubusercontent.com/skiy/golang-install/master/install.sh | bash /dev/stdin MY_DIY_GO_VERSION
```
or
```sh
$ wget -qO- https://raw.githubusercontent.com/skiy/golang-install/master/install.sh | bash /dev/stdin MY_DIY_GO_VERSION
```

### Offline
Save the script as a file name **install.sh** .   
Execute the script and install the latest version of the golang.
```sh
$ sh install.sh
```
  
When you add executable permissions, you can customize the version.   
```sh
# add executable
$ chmod +x install.sh

# latest version
$ ./install.sh

# customize version
$ ./install.sh 1.9.2
```

### Author
Author: Skiychan   
Email : dev@skiy.net   
Link  : https://www.skiy.net 