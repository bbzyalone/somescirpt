@echo off
echo "----------Begin----------"
echo "this branch:"
for /F %%i in ('git symbolic-ref --short HEAD')do ( set branch=%%i)
echo %branch%
echo "input commit info:"
set /p input=
git add .
git commit -m %a%%input%
git push origin %branch%
echo "----------Complate-------"