# 小白兔的开发之路

## 生成密钥与公钥

```
cd config
openssl
genrsa -out private.key 4096
rsa -in private.key -pubout -out public.key
exit
```
