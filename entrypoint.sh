#!/bin/bash
set -e
echo '_|_|_|_|                      _|                          _|            '
echo ' _|        _|_|_|    _|_|_|  _|_|_|_|    _|_|    _|  _|_|        _|_|   '
echo ' _|_|_|  _|    _|  _|          _|      _|    _|  _|_|      _|  _|    _| '
echo ' _|      _|    _|  _|          _|      _|    _|  _|        _|  _|    _| '
echo ' _|        _|_|_|    _|_|_|      _|_|    _|_|    _|        _|    _|_|   '
echo '                                                                        '

# Populate server-settings.json
SERVER_SETTINGS=/opt/factorio/server-settings.json

# Setting initial command
factorio_command="/opt/factorio/bin/x64/factorio --server-settings $SERVER_SETTINGS"

echo "# server-settings.json"
cat ${SERVER_SETTINGS}

FACTORIO_PORT=${FACTORIO_PORT:-34197}
factorio_command="$factorio_command --port ${FACTORIO_PORT}"
echo "# Game server port is '${FACTORIO_PORT}'"

FACTORIO_RCON_PORT=${FACTORIO_RCON_PORT:-27015}
factorio_command="$factorio_command --rcon-port ${FACTORIO_RCON_PORT}"
echo "# RCON port is '${FACTORIO_RCON_PORT}'"

if [ -z $FACTORIO_RCON_PASSWORD ]
then
  FACTORIO_RCON_PASSWORD=$(cat /dev/urandom | tr -dc 'a-f0-9' | head -c16)
fi

factorio_command="${factorio_command} --rcon-password ${FACTORIO_RCON_PASSWORD}"
echo "# RCON password is '${FACTORIO_RCON_PASSWORD}'"

cd /opt/factorio/saves
# Handling save settings
save_dir="/opt/factorio/saves"
if [ -z $FACTORIO_SAVE ]
then
  if [ "$(ls --hide=lost\+found ${save_dir})" ]
  then
  
    echo "# Taking latest save"
  
    ls -l --hide=lost\+found ${save_dir}
  else
  
    echo "# Creating a new map [save.zip]"
  
    /opt/factorio/bin/x64/factorio --create save.zip
  fi
  factorio_command="${factorio_command} --start-server-load-latest"
else
  factorio_command="${factorio_command} --start-server ${FACTORIO_SAVE}"
fi
echo "# launching Game"
echo "# ${factorio_command}"
# Closing stdin
exec 0<&-
exec ${factorio_command}
