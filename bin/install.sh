#!/usr/bin/env bash
dir=$(dirname $0);
./$dir/db-migration -I$dir/../lib install
