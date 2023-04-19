#!/bin/bash

# create python virtual env
# python -m venv env

source env/bin/activate

# Compile using platform libraries (https://docs.godotengine.org/en/latest/contributing/development/compiling/compiling_for_linuxbsd.html#requirements)
# scons platform=linuxbsd module_mono_enabled=yes target=editor production=yes precision=double builtin_embree=no builtin_enet=no builtin_freetype=no builtin_graphite=no builtin_harfbuzz=no builtin_libogg=no builtin_libpng=no builtin_libtheora=no builtin_libvorbis=no builtin_libwebp=no builtin_mbedtls=no builtin_miniupnpc=no builtin_pcre2=no builtin_zlib=no builtin_zstd=no

scons platform=linuxbsd module_mono_enabled=yes target=editor production=yes precision=double

./bin/godot.linuxbsd.editor.x86_64.mono --headless --generate-mono-glue modules/mono/glue

python ./modules/mono/build_scripts/build_assemblies.py --godot-output-dir ./bin --push-nupkgs-local ~/.nuget/GodotNET --precision=double

dotnet nuget add source ~/.nuget/GodotNET --name GodotNET
