cobc -I ../src ^
  -I ../src/ui ^
  -I ../src/ui/error-scr ^
  -free ^
  -x ../src/main.cob ^
  ../src/*.cob ^
  -o ../bin/CobAll ^
  -w -q
