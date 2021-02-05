#! /usr/bin/env bash

set -euo pipefail

if [ -e ~/.zshrc ]; then
  read -p "You have an existing ~/.zshrc file, would you like to replace it? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      exit 1
  else
      echo "Replacing existing ~/.zshrc file..."
  fi
fi

SCRIPTDIR=$(cd "$(dirname "$0")" && pwd)
export ZSHDIR=$SCRIPTDIR

mkdir -p "$ZSHDIR/nonshared-zshrc"
touch "$ZSHDIR/nonshared-zshrc/zshrc"

INSTALL_TO=~/.zshrc

cat <<EOF > $INSTALL_TO
export ZSHDIR=$SCRIPTDIR

export HOSTNAME=\$(hostname)

source \$ZSHDIR/zshrc_base

source \$ZSHDIR/zshrc_options

source \$ZSHDIR/aliases

# echo "sourcing general nonshared-zshrc/zshrc"
source \$ZSHDIR/nonshared-zshrc/zshrc


HOST_SPECIFIC_FILE=\$ZSHDIR/nonshared-zshrc/$HOSTNAME
if [ -e \$HOST_SPECIFIC_FILE ]
then
  echo "Loading zshrc for host $HOSTNAME"
  source \$ZSHDIR/nonshared-zshrc/$HOSTNAME
else 
  echo "creating file for host-specific overrides $HOSTNAME"
  touch \$ZSHDIR/nonshared-zshrc/$HOSTNAME
fi

EOF

echo "Done creating ~/.zshrc file that expects zsh script in $SCRIPTDIR"
echo ""
echo "You likely want to run these now and then restart your shell:"
echo "brew install fzf ripgrep bat fd findutils"
echo "brew install getantibody/tap/antibody"

