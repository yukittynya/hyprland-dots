#!/bin/bash

print_logo() {
  cat << "EOF"
 
  ,---.   .--.   ____     __   ____    .-------.        _______   .---.  .---.         
  |    \  |  |   \   \   /  /.'  __ `. |  _ _   \      /   __  \  |   |  |_ _|         
  |  ,  \ |  |    \  _. /  '/   '  \  \| ( ' )  |     | ,_/  \__) |   |  ( ' )         
  |  |\_ \|  |     _( )_ .' |___|  /  ||(_ o _) /   ,-./  )       |   '-(_{;}_)        
  |  _( )_\  | ___(_ o _)'     _.-`   || (_,_).' __ \  '_ '`)     |      (_,_)         
  | (_ o _)  ||   |(_,_)'   .'   _    ||  |\ \  |  | > (_)  )  __ | _ _--.   |         
  |  (_,_)\  ||   `-'  /    |  _( )_  ||  | \ `'   /(  .  .-'_/  )|( ' ) |   |         
  |  |    |  | \      /     \ (_ o _) /|  |  \    /  `-'`-'     / (_{;}_)|   | Arch Linux Configuration, Inspired by Typecraft        
  '--'    '--'  `-..-'       '.(_,_).' ''-'   `'-'     `._____.'  '(_,_) '---' By: yukitty        
                                                                                     
EOF
}

clear 
print_logo

set -e

if [ ! -f "packages.conf" ]; then
  echo "Err! packages.conf not found! Exiting :c"
  exit 1
fi

source packages.conf

if [ ! -f "lib.sh" ]; then
  echo "Err! libs.sh not found! Exiting :c"
  exit 1
fi

source lib.sh 

if [ ! -d "src" ]; then
  echo "Err! Missing configs!"
  exit 1
fi

echo "Upgrading to nyarch :3"
sudo pacman -Syu --noconfirm

if ! command -v yay &> /dev/null; then
  echo "Installing yay"
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git
  cd yay
  echo "building yay yippee"
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "yay is already installed, skipping that oopsy"
fi

install_packages "${desktop_env[@]}"
install_packages "${dev_tools[@]}"
install_packages "${apps[@]}"
install_packages "${fonts[@]}"

install_configs
