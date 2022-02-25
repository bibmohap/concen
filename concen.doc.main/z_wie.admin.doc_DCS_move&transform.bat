@echo off
set arg1=C:\localBuilds
set ditaname=wid_admin_plugin
set plugname=com.ibm.wbpm.wid.admin.doc
set dsh=wid_admin.dsh
@rem change the upper parameters for different builds
set ditamap=%ditaname%.ditamap
set sumlog=%plugname%_Summary.log
set fulllog=%plugname%_full.log
set outputdir=%arg1%\%plugname%
set BUILDDIR=%cd%\..\xprod.doc.build
set filter=%BUILDDIR%\wid_ic.ditaval
set logdel=ditatozip_%ditaname%_ditamap.log
@rem end of setup

DEL /F/Q/S %outputdir% > NUL
RMDIR /Q/S %outputdir%
call dcsmapzip -dir %cd% -dsh %dsh% -map %ditamap% -outdir %outputdir%
DEL /F %logdel%
@rem delete logs
DEL /F/Q/S "out"> NUL
RMDIR /Q/S "out"
DEL /F/Q/S "temp"> NUL
RMDIR /Q/S "temp"
cd %outputdir%
echo Summary > %sumlog%
call "c:\DITATools\DCS\oxygenAuthor\frameworks\ibmdita\DITA-OT\bin\dita.bat" --input=%ditamap% --format=ibmhtml5 --logfile=%fulllog%  --output=%outputdir%\out --filter=%filter%
setlocal EnableDelayedExpansion
set "substring=[ERROR]"
set "substring2=[WARN]"
set "substring3=[INFO]"
set /A errc=0
set /A infoc=0
set /A warnc=0
for /f "delims=," %%a in (%fulllog%) do (
    set "string=%%a"
    if NOT "!string:%substring%=!"=="!string!" (
        set /A errc += 1
        echo. !string! >> %sumlog%
 
    )
    if NOT "!string:%substring2%=!"=="!string!" (
        set /A warnc += 1
        echo. !string! >> %sumlog%
    )
    if NOT "!string:%substring3%=!"=="!string!" (
        set /A infoc += 1
        echo. !string! >> %sumlog%
    )

)
echo. ***STATISTICS*** >> %fulllog%
echo. Total_NUM_OF_ERROR_IS__________[%errc%]_____ >> %fulllog%
echo. Total_NUM_OF_WARN_IS___________[%warnc%]_____ >> %fulllog%
echo. Total_NUM_OF_INFO_IS___________[%infoc%]_____ >> %fulllog%
echo. ***STATISTICS*** >> %sumlog%
echo. Total_NUM_OF_ERROR_IS__________[%errc%]_____ >> %sumlog%
echo. Total_NUM_OF_WARN_IS___________[%warnc%]_____ >> %sumlog%
echo. Total_NUM_OF_INFO_IS___________[%infoc%]_____ >> %sumlog%
endlocal
pause