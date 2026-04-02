mkdir build
cd build

cmake %CMAKE_ARGS% ^
      -D BUILD_PROG=1 ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -D CMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
      -D CMAKE_LIBRARY_PATH=%LIBRARY_LIB% ^
      -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -D SW_BUILD=OFF ^
      -D BUILD_SHARED_LIBS=ON ^
      -G "NMake Makefiles" ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1
