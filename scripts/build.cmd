cobc -I ../src ^
  -I ../src/ui ^
  -free ^
  -x ../src/main.cob ^
  ../src/*.cob ^
  -o ../bin/CobAll ^
  -w -q
