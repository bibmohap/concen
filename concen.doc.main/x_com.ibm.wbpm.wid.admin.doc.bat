@echo off

if "%1"== "" goto else
set arg1=%1%
goto endif
:else
set arg1=C:\localBuilds
:endif

mkdir %arg1%

set BUILDDIR="%cd%\..\xprod.doc.build"

@rem build parms
set mapname=wid_admin_plugin.ditamap
set plugname=com.ibm.wbpm.wid.admin.doc
set outdirscope=ADJUST
set navtype=IEHS
set xsl=%BUILDDIR%\P024126.xsl
set outext=html
set css=
set dsh=wid_admin.dsh
set filter=%BUILDDIR%\wid_ic.ditaval

set outdir=%arg1%\%PLUGNAME%


if not exist %OUTDIR% md %OUTDIR%

echo Building %MAPNAME% to %OUTDIR%...

call map2xhtml /I:%MAPNAME% /OUTDIR:%OUTDIR% /OUTDIRSCOPE:%OUTDIRSCOPE% /NAVTYPE:%NAVTYPE% /H /L /XSL:%XSL% /OUTEXT:%OUTEXT% /COPYCSS /DSH:%dsh% /FILTER:%FILTER% /WL:ERROR /KCMIGRATION /PLUGINOUTPUT:ZIP

move wid_admin_pluginxhm.bom %OUTDIR%\wid_admin_pluginxhm.bom
move wid_admin_pluginxhm.log %OUTDIR%\wid_admin_pluginxhm.log