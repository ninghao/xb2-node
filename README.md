# 小白兔的开发之路

## 生成密钥与公钥

```
cd config
openssl
genrsa -out private.key 4096
rsa -in private.key -pubout -out public.key
exit
```

## bcrypt 与 bcryptjs

我们在课程中用到了 bcrypt 这个包提供的功能 hash 用户密码。安装这个包的时候需要编译一个模块，这要求系统配置好编译环境。这对初学者来说可能会比较麻烦，所以我们暂时用 bcryptjs 替换了 bcrypt。它们的用法是一样的，只不过 bcryptjs 是用纯 JavaScript 语言写的，不需要额外的编译工作。虽然性能方面会比 bcrypt 差一些，但安装它的时候不会遇到问题。
