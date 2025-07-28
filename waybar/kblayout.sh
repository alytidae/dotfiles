#!/bin/sh
layout=$(head -n1 /tmp/dwl-keymap | cut -c1-2 | tr '[:upper:]' '[:lower:]')
echo "{\"text\": \"$layout\"}"

