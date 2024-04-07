#!/bin/bash

install_files() {
    srcfile=$1
    dstfile=$2
    if [ -d "$dstfile" -a ! -h "$dstfile" ]; then
        mv -fv "$srcfile" "${srcfile}.$(date +%Y%m%d)"
    fi
    if [ ! -h "$dstfile" ]; then
        ln -sf "$srcfile" "${dstfile}"
    fi

}

install_dotfiles() {
    sourcedir=$(pwd -P)
    for file in zshrc gitconfig gitignore tmux.conf ; do
        destfile="${HOME}/.${file}"
        sourcefile="${sourcedir}/${file}"
        install_files $sourcefile $destfile
    done
}

install_vscode_files() {
    sourcedir=$(pwd -P)
    codeconfigpath="${HOME}/.config/Code - OSS/User"
    install_files "${sourcedir}/keybindings.json" "${codeconfigpath}/keybindings.json"
    install_files "${sourcedir}/settings.json" "${codeconfigpath}/settings.json"
}

install_fzf() {
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   echo "y y n" | ~/.fzf/install
}

install_dotfiles
install_vscode_files
