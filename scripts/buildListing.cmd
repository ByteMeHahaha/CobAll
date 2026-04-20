cobc -I ../src ^
  -I ../src/ui ^
  -free ^
  -tListing.lst --tlines=0 -ftsymbols ^
  -x ../src/main.cob ^
  -o ../bin/CobAll ^
  -w -q
