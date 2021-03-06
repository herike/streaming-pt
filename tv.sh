#!/bin/bash

PLAYER="mplayer"
RTMPDUMP="rtmpdump"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP 3"
  "SIC Noticias"
  "TVI24"
  "RTP Memoria"
  "RTP Internacional"
  "RTP Madeira"
  "RTP Acores"
  "RTP Africa"
  "ARTV"
  "ETV"
  "Euronews"
)

STREAMS=(
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch5h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch3h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://213.13.26.43/live -W http://js.sapo.pt/Assets/Images/ProjectVideo/flash/videojs.swf -y sic | $PLAYER -"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI -O - -o /dev/null | grep videoUrl |cut -d\' -f2)"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch64h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://213.13.26.41/live -W http://js.sapo.pt/Projects/SAPOPlayer/20160902R1/jwplayer.flash.swf -y sicnoticias | $PLAYER -"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI24 -O - -o /dev/null | grep videoUrl |cut -d\' -f2)"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch80h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch120h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch1016h264H14 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2rtpacores | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch27h264 | $PLAYER -"
  "$PLAYER http://193.126.16.68:1935/livenlin4/mp4:2liveplncleanpub/playlist.m3u8"
  "$RTMPDUMP -r rtmp://213.13.26.13/live -W http://js.sapo.pt/Projects/Video/160121R1/flash/videojs.swf -y etv_direto | $PLAYER -"
  "$PLAYER rtsp://ewns-hls-b-stream.hexaglobe.net/rtpeuronewslive/pt_vidan750_rtp.sdp"
)

PS3="Which TV channel do you want to watch? "
select choice in "${TITLES[@]}";
do
  if [[ -n $choice ]]; then
    for i in ${!TITLES[@]}
    do
      if [ "${TITLES[i]}" = "$choice" ]; then
        eval ${STREAMS[i]}
        break
      fi
    done
  else
    echo "Invalid selection."
  fi
done
