@echo off

cls

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::CREAR  .bat                                                                                                            :
::Al ejecutar el bat crea copia de seguridad de una carpeta en el directorio c:/users/(usuario)/desktop)/copias. -HECHO- :
::Como mucho pueden haber 3 copias.                                                                              -HECHO- :
::Si se quiere añadir otra más y ya hay 3,se elimina la más antigua.                                             -HECHO- :
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: No es necesario comparar ya los archivos por el atributo "fecha" porque el nombre tiene el siguiente formato:         :
::(año](mes](dia]_(hora](minuto](segundo]                                                                                :
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set /p RUTA_O=Introduzca la ruta del archivo a copiar:

set RUTA_D=%USERPROFILE%\Desktop\COPIAS\%date:~6,4%-%date:~3,2%-%date:~0,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%\

set RUTA_COPIA=%USERPROFILE%\Desktop\COPIAS

:inicio

if NOT EXIST %RUTA_COPIA% (

md %RUTA_COPIA%
goto inicio

) else (

goto fin_inicio

)

:fin_inicio
set contador=0
for /f %%i in ('dir /b "%RUTA_COPIA%" 2^>nul ^| find /v /c ""') do set contador=%%i


::echo El directorio %RUTA_O% tiene %contador% archivos
::en la carpeta COPIAS sólo pueden haber carpetas. [dentro de estas carpetas que haya lo que sea)



if NOT %contador% equ 3 (

robocopy %RUTA_O% %RUTA_D%

) else (


echo Ya hay 3 archivos. No se puede copiar.

set ultimo_archivo=""
for /f "delims=" %%j in ('dir /b /A:D /O:N %RUTA_COPIA%') do (
if not defined "%ultimo_archivo%" (
set ultimo_archivo=%%j
echo %ultimo_archivo%

goto definido
))


if defined "%ultimo_archivo%" (
:definido
rd /Q /S %RUTA_COPIA%\%ultimo_archivo%
robocopy %RUTA_O% %RUTA_D%


)
)
pause