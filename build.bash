#!/bin/bash

# create python virtual env
# python -m venv env

source env/bin/activate

scons platform=linuxbsd module_mono_enabled=yes target=editor production=yes

./bin/godot.linuxbsd.editor.x86_64.mono --headless --generate-mono-glue modules/mono/glue

python ./modules/mono/build_scripts/build_assemblies.py --godot-output-dir ./bin --push-nupkgs-local ~/.nuget/GodotNET