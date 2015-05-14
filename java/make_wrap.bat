@echo off
call set-java-path.bat
set JAVA_INCLUDE=%JAVA_DIR%\include
set SWIG=..\..\swig\swigwin-3.0.2\swig.exe
set PACKAGE_NAME=mcl.bn
set PACKAGE_DIR=%PACKAGE_NAME:.=\%

echo [[run swig]]
mkdir %PACKAGE_DIR%
echo %SWIG% -java -package %PACKAGE_NAME% -outdir %PACKAGE_DIR% -c++ -Wall bn_if.i
%SWIG% -java -package %PACKAGE_NAME% -outdir %PACKAGE_DIR% -c++ -Wall bn_if.i
echo [[make dll]]
mkdir ..\bin
cl /MD /DNOMINMAX /DNDEBUG /LD /Ox /EHsc bn_if_wrap.cxx ../src/zm.cpp ../src/zm2.cpp -I%JAVA_INCLUDE% -I%JAVA_INCLUDE%\win32 -I../include -I../../cybozulib_ext/mpir/include -I../../xbyak  /link /LIBPATH:../../cybozulib_ext/mpir/lib /OUT:../test/bn_if_wrap.dll

call run-bn.bat

echo [[make jar]]
%JAVA_DIR%\bin\jar cvf bn.jar mcl
