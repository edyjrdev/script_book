#!/bin/bash
cmd="s,\(images-.*\/(.*)\.(jpg|png)\),(images-final/\1.eps),"
sed -E "$cmd" text.md > text-final.md
