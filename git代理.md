# 本地代理
请优先查看本地科学上网工具代理的端口
## 设置代理:
```
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```
## 取消和查看代理:

- 取消代理
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```

- 查看代理
```
git config --global --get http.proxy
git config --global --get https.proxy
git  config --list
```

# 在线代理 + 加速网页工具
git clone私有仓库
Clone 私有仓库需要用户在 [Personal access tokens](https://github.com/settings/tokens) 申请 Token 配合使用.

git clone https://user:your_token@ui.ghproxy.cc/https://github.com/your_name/your_private_repo