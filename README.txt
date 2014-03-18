vimdir
======

My .vim directory.

This uses pathogen and it is stored under bundle/, so you'll want to add

	runtime bundle/vim-pathogen/autoload/pathogen.vim
	call pathogen#infect()

to your .vimrc

Because of the use of submodules, the initial clone should be done via:

	git clone --recursive ...
