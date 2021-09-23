mkdir build
cd build

curl -fsSOL https://software-network.org/client/sw-master-windows-client.zip
if errorlevel 1 exit 1

unzip sw-master-windows-client.zip -d .
if errorlevel 1 exit 1

set PATH=%PATH%;%CD%

sw setup
if errorlevel 1 exit 1

cmake -G "NMake Makefiles" ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D BUILD_PROG=1 ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -D CMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
      -D CMAKE_LIBRARY_PATH=%LIBRARY_LIB% ^
      -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Make copies of the .lib file without the embedded version number
copy %LIBRARY_LIB%\leptonica-1.82.0.lib %LIBRARY_LIB%\leptonica.lib
copy %LIBRARY_LIB%\leptonica-1.82.0.lib %LIBRARY_LIB%\lept.lib
