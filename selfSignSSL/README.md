红色部分是输入，注意4次输入的口令都是一样的。

在当前目录下会创建出4个文件：

www.test.com.crt：自签名的证书
www.test.com.csr：证书的请求
www.test.com.key：不带口令的Key
www.test.com.origin.key：带口令的Key
Web服务器需要把www.test.com.crt发给浏览器验证，然后用www.test.com.key解密浏览器发送的数据，剩下两个文件不需要上传到Web服务器上。

以Nginx为例，需要在server {...}中配置：

server {
    ...
    ssl on;
    ssl_certificate     /etc/nginx/ssl/www.test.com.crt;
    ssl_certificate_key /etc/nginx/ssl/www.test.com.key;
}

