#!/usr/bin/env bash
find "$HOME/.plp" -type f | grep --color=always "$1" && grep --color=always -RIn "$1" "$HOME/.plp"

