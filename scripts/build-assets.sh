#!/bin/sh

set -e

scripts/build-roblox-model.sh .darklua.json build/StudioCreator.rbxm
scripts/build-wally-package.sh
