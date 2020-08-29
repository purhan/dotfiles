#!/bin/sh

shopt -s expand_aliases
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

printf "  >>> "
while :
do
  read INPUT_STRING arg1
  case $INPUT_STRING in
      help)
          echo "The following commands can be used inside this shell:"
          echo "add             ---> (Extra Arguments: '-a': For complete config) Add files to the local repo"
          echo "commit          ---> (Extra Arguments: 'comment': As commit comment) Commit to the local repo"
          echo "download        ---> Download the whole config in $HOME/dotfiles"
          echo "exit            ---> Exit this shell"
          echo "push            ---> Push to the local repository"
          ;;
      download)
		echo "Downloading complete config into $HOME/dotfiles"
        git clone --bare https://github.com/Purhan/dotfiles $HOME/dotfiles
        echo "Do you want to add alias to .bashrc? [y/n]"
        read INPUT
        case $INPUT in
            y)
                echo "Adding alias 'config' to $HOME/.bashrc  ..."
                echo '# DOTFILES ALIAS' >> ~/.bashrc
                echo "alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> ~/.bashrc
                echo 'config config --local status.showUntrackedFiles no' >> ~/.bashrc
                ;;
            *)
                ;;
        esac
		;;
    add)
        case $arg1 in
            -a)
                echo "Adding the whole config ..."
                cd ~/
                config add README.md .gitignore assistant.sh .bashrc .vimrc .astylerc conf-scripts .gtkrc-2.0 RICE vampire.sh

                cd .config
                config add awesome Code sublime-text-3 gtk-2.0 gtk-3.0 guake powerline-shell konsolerc spectaclerc termite

                cd ~/.local/share
                config add color-schemes konsole
                echo "Added all files in the current config."
                cd $HOME
                ;;
            *)
                config add $arg1
                echo "Added file $arg1 to the local repository"
        esac
        ;;
    commit)
        config commit -m "$arg1"
        ;;
    log)
	config log;;
    status)
	config status;;
    push)
        config push
        ;;
	exit)
		break
		;;
	*)
		echo "Invalid Command!"
		;;
  esac
  printf "  >>> "
done
echo
