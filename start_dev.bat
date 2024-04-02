::place just outside ALweb folder
mode con: cols=80 lines=15

cd ALweb/build/dev
start cmd.exe /k ""npm install && npm run dev"
::start cmd.exe /k "sass --watch stylingSrc:public/static/editor/css"
::start cmd.exe /k "node workers/FolderReportMailWorker"

cd ../../learn
start cmd.exe /k ""npm install && npm run dev"

::cd ../mail-server
::start cmd.exe /k "npm install && npm run dev"

cd ..
start git-bash.exe
