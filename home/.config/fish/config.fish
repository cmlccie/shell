# echo "Loading: config.fish"

if status --is-login
	# Login Shell - Initialize Global Environment Variables
	# echo "Login Shell"

    ### Fish Shell Configuration
    set -gx SHELL /usr/local/bin/fish
	set -gx LC_ALL en_US.UTF-8
	set -gx LANG en_US.UTF-8
	# set -gx theme_powerline_fonts yes
	set -gx theme_nerd_fonts yes


	### PATH Extensions
	## Prefixes
	# Local Directories
	set -gx PATH ~/dev/bin $PATH


	### PKG_CONFIG_PATH Extensions
	set -gx PKG_CONFIG_PATH /usr/local/lib /usr/local/lib/pkgconfig $PKG_CONFIG_PATH


	### PYTHONPATH Extensions
	set -gx PYTHONPATH ~/dev/lib $PYTHONPATH


	### Tool Configuration
	# gpg
	set -gx GPG_TTY (tty)

	# direnv
	set -gx DIRENV_LOG_FORMAT ""

    # pew
    set -gx WORKON_HOME ~/.local/share/virtualenvs
    set -gx PROJECT_HOME ~/dev/projects

	# pipenv
	set -gx PIPENV_VENV_IN_PROJECT 1
    set -gx PIPENV_SHELL_FANCY 1
	set -gx PIPENV_DEFAULT_PYTHON_VERSION 3.7

	# pyenv
	if command -v pyenv 1>/dev/null 2>&1
		pyenv init - | source
	end

end


if status --is-interactive
    # Interactive Shell
	# echo "Interactive Shell"

	# pew
	source (pew shell_config)

    ### Interactive Environment Variable Management
    # direnv
    eval (direnv hook fish)


else
    # Non-Interactive Shell
	echo "Non-Interactive Shell"

    ### Non-Interactive Environment Variable Management
    # direnv
    eval (direnv export fish)

end
