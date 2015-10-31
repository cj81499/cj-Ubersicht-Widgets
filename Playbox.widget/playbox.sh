#!/bin/sh


PWD=`pwd ${0}`

TRACK=`osascript "$PWD/Playbox.widget/as/Get Current Track.applescript"`;
ARTWORK=`osascript "$PWD/Playbox.widget/as/Get Current Artwork.applescript"`;

#echo $0;
#echo `pwd ${0}`;

find "$PWD/Playbox.widget/as" -name "cover-*" ! -name "$ARTWORK" -exec rm {} \;
# rm -rf ``;
echo $TRACK "~" $ARTWORK
