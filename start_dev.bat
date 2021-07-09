::place just outside ALweb folder
mode con: cols=80 lines=20

cd ALweb/build/dev
start cmd.exe /k "npm run dev"

cd ../../learn
start cmd.exe /k "npm run dev"

cd ../mail-server
start cmd.exe /k "npm run dev"

cd ..
start git-bash.exe
