#!/bin/sh
LC_ALL=C

INITIAL_REV=23183
SVNURI=svn://tug.org/texlive/branches/branch2011/
TARGET_REV=`svn info $SVNURI | grep -i "^Revision" | cut -d" " -f2-`

REV_LIST=`svn log -r ${INITIAL_REV}:${TARGET_REV} $SVNURI | grep ^r | cut -d" " -f1 | tr -d 'r' | tr '$' ' '`
for i in $REV_LIST ; do
        TARGET=rev$i.patch
        svn log -r$i $SVNURI > $TARGET
        svn diff -r$((i-1)):$i $SVNURI >> $TARGET
done
