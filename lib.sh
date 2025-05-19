#!/bin/bash

is_installed() {
  pacman -Qi "$1" &> /dev/null
}

is_group_installed() {
  pacman -Qg "$1" &> /dev/null
}

install_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg" && ! is_group_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then  
    echo "Installing: ${to_install[*]}"
    yay -S "${to_install[@]}"
  fi
} 

install_nvchad() {
  git clone https://github.com/NvChad/starter ~/.config/nvim
}

install_sddm() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
}

install_configs() {
  xdg-user-dir

  cd src 
  cp -r yukitty.png .config .wallpapers .zshenv $HOME/
  cd ..

  install_nvchad
  install_sddm

  bash ~/.config/hypr/scripts/selectWallpaper.sh ~/.wallpapers/Lofi_Cat.png
}
