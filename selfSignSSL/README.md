红色部分是输入，注意4次输入的口令都是一样的。

在当前目录下会创建出4个文件：

```
www.test.com.crt：自签名的证书
www.test.com.csr：证书的请求
www.test.com.key：不带口令的Key
www.test.com.origin.key：带口令的Key
```

Web服务器需要把www.test.com.crt发给浏览器验证，然后用www.test.com.key解密浏览器发送的数据，剩下两个文件不需要上传到Web服务器上。

以Nginx为例，需要在server {...}中配置：

```nginx
server {
    ...
    ssl on;
    ssl_certificate     /etc/nginx/ssl/www.test.com.crt;
    ssl_certificate_key /etc/nginx/ssl/www.test.com.key;
}
```

如果一切顺利，打开浏览器，就可以通过HTTPS访问网站。第一次访问时会出现警告（因为我们的自签名证书不被浏览器信任），把证书通过浏览器导入到系统（Windows使用IE导入，Mac使用Safari导入）并设置为“受信任”，以后该电脑访问网站就可以安全地连接Web服务器了：

