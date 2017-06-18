#!/bin/sh

me="$0"
date=`date +%Y%m%d`
time="00:00"
counter=1
args="$@"

help () {
    echo "
$me [OPCIO]...

A Bartók Rádió 'Notturno' c. műsorát lejátszó szkript.
http://www.mediaklikk.hu/musor/notturno/

Opciók:
  -d, --date	A lejátszani kívánt műsor dátuma (ÉÉHHNN). Alapértelmezett: ma
  -t, --time	Mikortól játtsza le (PERC:MÁSODPERC). Alapértelmezett: 00:00
  -h, --help	Kiírja ezt a segítséget.
"
    exit
}

for opt in "$@"; do
  counter=$((counter+1))
  case $opt in
      -h|--help)
        help
        exit
      ;;
      -d|--date)
        eval date=\$$counter
      ;;

      -t|--time)
        eval time=\$$counter
      ;;

      *)
        echo "Hiba történt!"
        exit 1
      ;;
    esac
done

if [ -z "$date" ]; then
  echo "Dátum hiányzik!"
  exit 10
fi

if [ -z "$time" ]; then
  echo "Idő hiányzik!"
  exit 20
fi

mplayer -ss ${time} -loop 0 -cache 16384 -cache-min 80 http://hangtar.cdn.connectmedia.hu/${date}000000/${date}060000/mr3.mp3
