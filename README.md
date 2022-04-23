# 《小白的开发之路：Node.js 服务端应用开发实践》代码

## 本地开发

### **1：把项目克隆到本地**

```
git clone https://github.com/ninghao/xb2-node.git
```

### **2：安装依赖**

```
cd xb2-node
npm install
```

### **3：环境变量**

项目要运行起来需要用到一个环境变量文件，复制一份 _assets/example.env_ 这个文件，把复制的文件放在项目的根目录的下面，并且把文件名改成 _.env_。然后根据自己的需要修改在 _.env_ 这个环境变量文件里的内容。

```
# 应用配置
APP_PORT=3000

# 内容配置
POSTS_PER_PAGE=30

# 数据仓库配置
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=PASSWORD
MYSQL_DATABASE=xb2_node

# 密钥
PRIVATE_KEY=LS0tLS1CR
PUBLIC_KEY=LS0tLS1CRUd
```

在这个环境变量里的 PRIVATE_KEY 与 PUBLIC_KEY 是签发验证用户令牌的时候需要用的密钥与公钥。这里需要的是经过 Base64 编码之后的密钥与公钥，这样做主要是为了可以把密钥与公钥内容转换成一行，这样我们才能把它放在这个环境变量文件里使用。

在 _assets/example.env_ 文件里已经包含了 PRIVATE_KEY 与 PUBLIC_KEY 的值，这对密钥是我自己签发的，你在本地开发的时候可以直接使用，但是你的应用要在生产环境上运行的时候，你要准备自己的密钥与公钥，然后替换掉在环境变量里的 PRIVATE_KEY 与 PUBLIC_KEY 的值。

## 准备数据

- xb2-node-assets（coding.net 仓库）：https://e.coding.net/ninghao/xb2/xb2-node-assets.git
- xb2-node-assets（github 仓库）：https://github.com/ninghao/xb2-node-assets.git
- xb2-node-assets（百度网盘）：https://pan.baidu.com/s/18ICmhWa_MoRIM2lEPvCBCw?pwd=5xxc

### 1：新建一个数据仓库

在本地你需要安装 MySQL，然后给应用创建一个数据仓库，名字可以叫 xb2_node。

### 2：导入演示数据

在之前创建的 xb2_node 数据仓库里，导入在 xb2-node-assets 里面的 database/xb2_node.sql 这个文件。这样这个 xb2_node 数据仓库里会出现应用需要的数据表，数据表里面会有一些演示数据。

![tableplus](https://raw.githubusercontent.com/ninghao/xb2-node/master/assets/images/screenshot-tableplus.png)

### 3：复制上传文件

在 xb2-node-assets 项目里，找到 _uploads_ 目录，把这个目录复制一份放到我们的 _xb2-node_ 这个项目的根目录下面。这个 _uploads_ 里面的东西就是上传的图片与用户头像的原始文件，以及它们的调整尺寸之后的文件。

## 接口测试

测试应用接口的时候，可以使用 Insomnia 这个客户端软件。在测试的时候你需要创建一些对接口的请求，然后要做一些配置，比如请求的地址，请求里带的数据等等。

打开 Insomnia 以后，点击 Create 按钮，在弹出的菜单里，Import from 的下面，选择 File，然后选择 xb2-node-assets 这个项目里的 _insomnia-workspace/xb2-node.yaml_ 这个文件，这样会为你创建好测试应用接口的时候需要的请求。

![insomnia](https://raw.githubusercontent.com/ninghao/xb2-node/master/assets/images/screenshot-insomnia.png)

## bcrypt 与 bcryptjs

我们在课程中用到了 bcrypt 这个包提供的功能 hash 用户密码。安装这个包的时候需要编译一个模块，这要求系统配置好编译环境。这对初学者来说可能会比较麻烦，所以我们暂时用 bcryptjs 替换了 bcrypt。它们的用法是一样的，只不过 bcryptjs 是用纯 JavaScript 语言写的，不需要额外的编译工作。虽然性能方面会比 bcrypt 差一些，但安装它的时候不会遇到问题。

## 生成密钥

在生产环境上运行这个应用的时候，你需要准备自己的密钥与公钥。

### 1：生成密钥与公钥文件

```

cd config
openssl
genrsa -out private.key 4096
rsa -in private.key -pubout -out public.key
exit

```

### 2：转换密钥与公钥格式

在项目下面，执行：

```
node config/convert.key.js
```

你会看到转换成 Base64 格式的 Private Key 与 Public Key，把得到的内容交给 .env 文件里的 PRIVATE_KEY 与 PUBLIC_KEY。
