all: sync

sync:
	mkdir -p ~/.config/fish
	mkdir -p ~/.tmux/

	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tmux/tmux-dark.conf ] || ln -s $(PWD)/tmux-dark.conf ~/.tmux/tmux-dark.conf
	[ -f ~/.tmux/tmux-light.conf ] || ln -s $(PWD)/tmux-light.conf ~/.tmux/tmux-light.conf
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig

clean:
	rm -f ~/.vimrc 
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/
	rm -f ~/.tmux.conf
	rm -f ~/.gitconfig

.PHONY: all clean sync 
