#!/bin/ash

name=$(git config --global --get user.name)
email=$(git config --global --get user.email)

ABUILD_PATH="$HOME/.abuild"
ABUILD_CONFIG="$ABUILD_PATH/abuild.conf"

if [ ! -d "$ABUILD_PATH" ]; then
  echo "Abuild configuration not found"

  mkdir "$ABUILD_PATH"
  sudo mv /etc/abuild.conf "$ABUILD_CONFIG"
  sudo ln -sf "$ABUILD_CONFIG" /etc/abuild.conf
  sudo sed -i -e "s/#PACKAGER.*/PACKAGER=\"$name <$email>\"/" -e 's/#\(MAINTAINER.*\)/\1/' "$ABUILD_CONFIG"
  abuild-keygen -a -i
fi

# TODO: remove these lines ... it'd better be in the Dockerfile
sudo chmod 777 /var/cache/distfiles
mkdir "$HOME/packages"
