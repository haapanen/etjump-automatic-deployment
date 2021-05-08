#!/bin/bash

mod_directory="etjump_test"
latest_install="$(cat ./.version)"
latest_update="$(ls $UPDATEPATH)"

if [[ $GAMEPATH == "" ]]; then
    echo "GAMEPATH is empty"
    exit 1
fi

if [[ $UPDATEPATH == "" ]]; then
    echo "UPDATEPATH is empty"
    exit 2
fi

if [[ $latest_update == $latest_install ]]; then
    echo "Latest version is already installed"
    exit 0
fi

rm $GAMEPATH/$mod_directory/*.pk3
rm $GAMEPATH/$mod_directory/*.dll
rm $GAMEPATH/$mod_directory/*.so
rm $GAMEPATH/$mod_directory/qagame_mac
unzip -o "$UPDATEPATH/$latest_update" -d $GAMEPATH
mv $GAMEPATH/etjump/* "$GAMEPATH/$mod_directory/"
rmdir $GAMEPATH/etjump

echo "$latest_update" > .version
printf "\xff\xff\xff\xffrcon $RCON_PASSWORD quit" | nc -u $ET_HOST $ET_PORT