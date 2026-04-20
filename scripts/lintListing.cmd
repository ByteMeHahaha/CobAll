cobc -I ../src ^
  -I ../src/ui ^
  -tlisting.lst --tlines=0 -ftsymbols ^
  -free ^
  -fsyntax-only ^
  ../src/*.cob ^
  -Wall ^
  -Wextra
