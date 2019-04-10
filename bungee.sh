#!/bin/sh


SCREEN="proxy"  # nom du screen 
NAME="proxy"  # nom du serveur
COMMAND="java -jar -Xincgc -Xmx1G bungee.jar"  # lancement

# Acces au repertoire du dossier
cd /home/serveur/bungee # emplacement du serveur
# --------------------------------------------------

running(){
 if ! screen -list | grep -q "$SCREEN"
 then
  return 1
 else
  return 0
 fi
}

case "$1" in
 start)
  if ( running )
  then
echo "[MonServeur] Le serveur "[$NAME]" est deja ouvert"
  else
echo "[MonServeur] Demarrage du serveur: [$NAME]"
   screen -dmS $SCREEN $COMMAND
  fi
  ;;
 status)
    if ( running )
    then
echo "Running"
    else
echo "Not running"
    fi
  ;;
 screen)
   screen -r $SCREEN
 ;;
 reload)
   screen -S $SCREEN -p 0 -X stuff `printf "reload\r"`
 ;;
 stop)
  if ( running )
  then
screen -S $SCREEN -p 0 -X stuff `printf "stop\r"`
   echo "[MonServeur] Arret du serveur: [$NAME]"
  else
echo "[MonServeur] Le serveur "[$NAME]" est pas demarrer"
  fi
 ;;
*)

 echo "[MonServeur] Usage : {start|stop|status|screen|reload}"
 exit 1
 ;;
esac

exit 0
