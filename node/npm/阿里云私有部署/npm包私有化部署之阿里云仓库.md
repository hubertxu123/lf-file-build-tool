
## 介绍
    
    1.20200818：目前在公测
    2.问题：只能维护最后一个版本
    3.帮助文档：https://help.aliyun.com/document_detail/67306.html?spm=a2c4g.11186623.6.580.7d76c95cVqZYOh
    3.注意：
        ·上传时：若出现403问题，请查看是否为版本未升级，导致覆盖报错
            npm login --registry=https://registry-node.aliyun.com/org/1170113524267117/registry/kinovoreport/
            package.json:
                "name": "@kinovo-report-api/report-api",
                  "version": "1.0.9",
                  "private": false,
                  "bin": {
                    "report": "bin/report"
                  },
                  "publishConfig": {
                    "registry": "https://registry-node.aliyun.com/org/1170113524267117/registry/kinovoreport/"
                  },
            npm publish
        ·下载时：
            mkdir code/
            cd code/
            cp /.npmrc code/
            npm i -loglevel info @kinovo-report-api/report-api@1.0.9
        ·.npmrc文件:中的auth
            echo -n 'myuser:mypassword' | openssl base64
