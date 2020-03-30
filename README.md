# cms 测试知识库 数据库

1，1.bat = 开机自动pull拉去代码。

git pull

c:
cd\
ipconfig /all >ip.txt
for /f "tokens=2 delims=:(首选)" %%b in ('findstr /c:"IPv4 地址" "ip.txt"') do (
httpcfg set iplisten -i %%b

del ip.txt
"C:\Users\JohnWork\AppData\Local\Google\Chrome\Application\chrome.exe" %%b
)
)

2，push.bat = 手工推送代码。
git add .
git commit -m '来自mac'
git push