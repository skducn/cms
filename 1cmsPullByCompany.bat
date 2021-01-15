@echo off


git stash


git pull origin master


ipconfig /all >ip.txt


for /f "tokens=2 delims=:(Ê×Ñ¡)" %%b in ('findstr /c:"IPv4 µØÖ·" "ip.txt"') do (
httpcfg set iplisten -i %%b



"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %%b
)
)

pause