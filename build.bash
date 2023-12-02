#!/bin/bash

# create python virtual env
# python -m venv env

source env/bin/activate

# Another option is to compile using platform libraries (https://docs.godotengine.org/en/latest/contributing/development/compiling/compiling_for_linuxbsd.html#requirements)

# include the flag precision=double for double precision
scons platform=linuxbsd module_mono_enabled=yes target=editor production=yes # linker=lld

./bin/godot.linuxbsd.editor.x86_64.mono --headless --generate-mono-glue modules/mono/glue

# include the flag --precision=double for double precision
python ./modules/mono/build_scripts/build_assemblies.py --godot-output-dir ./bin --push-nupkgs-local ~/.nuget/GodotNET

dotnet nuget add source ~/.nuget/GodotNET --name GodotNET
