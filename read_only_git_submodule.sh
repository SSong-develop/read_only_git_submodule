#!/bin/sh

#   1. make submodules writable,
#   2. init and update submodules, and
#   3. make them read-only

# make all (existing) submodule directories writable
# shellcheck disable=SC2006
for p in `git submodule status | sed -e "s/^[+\ ][^\ ]*\ //" -e s/\ .*$//`; do
    echo "making submodule directory $p writable"
    chmod -R u+w $p;
done

echo "updating submodules:"
git submodule init
git submodule update —remote

# make all submodules read-only
# shellcheck disable=SC2013
for p in `grep path .gitmodules | sed 's/.*= //'`; do
    echo "making submodule directory $p read-only"
    chmod -R a-w $p;
done