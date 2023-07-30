mkdir build
cd build

curl -fsSOL https://software-network.org/client/sw-master-windows_x86_64-client.zip
if errorlevel 1 exit 1

unzip sw-master-windows_x86_64-client.zip -d .
if errorlevel 1 exit 1

set PATH=%PATH%;%CD%

sw setup
if errorlevel 1 exit 1

:: As of July 2023, the build system for this package can run into issues if the
:: version of `cl` found via %PATH% is not exactly the same as the version used
:: by MSBuild. The only way I can figure out to avoid the problem is to avoid
:: MSBuild altogether, which can be done by using the NMake Makefiles generator,
:: as well as explicitly specifying the full path to the desired compilers.
set "clpathunix=%VCToolsInstallDir%bin\Hostx64\x64\cl.exe"
set "clpathunix=%clpathunix:\=/%"

cmake %CMAKE_ARGS% ^
      -D BUILD_PROG=1 ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -D CMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
      -D CMAKE_LIBRARY_PATH=%LIBRARY_LIB% ^
      -D BUILD_SHARED_LIBS=ON ^
      -D CMAKE_MODULE_LINKER_FLAGS=-whole-archive ^
      -D "CMAKE_C_COMPILER=%clpathunix%" ^
      -D "CMAKE_CXX_COMPILER=%clpathunix%" ^
      -G "NMake Makefiles" ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Make copies of the .lib file without the embedded version number
copy %LIBRARY_LIB%\leptonica-%PKG_VERSION%.lib %LIBRARY_LIB%\leptonica.lib
copy %LIBRARY_LIB%\leptonica-%PKG_VERSION%.lib %LIBRARY_LIB%\lept.lib
