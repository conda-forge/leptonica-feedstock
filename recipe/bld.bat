mkdir build
cd build

curl -fsSOL https://software-network.org/client/sw-master-windows_x86_64-client.zip
if errorlevel 1 exit 1

unzip sw-master-windows_x86_64-client.zip -d .
if errorlevel 1 exit 1

set PATH=%PATH%;%CD%

sw setup
if errorlevel 1 exit 1

cmake %CMAKE_ARGS% ^
      -D BUILD_PROG=1 ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -D CMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
      -D CMAKE_LIBRARY_PATH=%LIBRARY_LIB% ^
      -D BUILD_SHARED_LIBS=ON ^
      -D CMAKE_MODULE_LINKER_FLAGS=-whole-archive ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Make copies of the .lib file without the embedded version number
copy %LIBRARY_LIB%\leptonica-%PKG_VERSION%.lib %LIBRARY_LIB%\leptonica.lib
copy %LIBRARY_LIB%\leptonica-%PKG_VERSION%.lib %LIBRARY_LIB%\lept.lib
