#!/bin/bash

# create python virtual env
python -m venv env

.\env\Scripts\Activate.ps1

# Another option is to compile using platform libraries (https://docs.godotengine.org/en/latest/contributing/development/compiling/compiling_for_linuxbsd.html#requirements)

# include the flag precision=double for double precision
scons platform=windows module_mono_enabled=yes target=editor production=yes vsproj=yes

.\bin\godot.windows.editor.x86_64.mono.exe --headless --generate-mono-glue modules\mono\glue

# include the flag --precision=double for double precision
python ./modules/mono/build_scripts/build_assemblies.py --godot-output-dir ./bin --push-nupkgs-local $env:APPDATA/NuGet/GodotNET

dotnet nuget add source $env:APPDATA/NuGet/GodotNET --name GodotNET
