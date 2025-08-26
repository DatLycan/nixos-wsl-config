{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Clear the greeting message
      set fish_greeting

      # =========================================================================
      # Aliases
      # =========================================================================
      
      # Command Replacements
      alias e 'nvim'
      alias cd 'z'
      alias ls 'eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions'
      alias cat 'bat'

      # General Aliases
      alias .. 'z ..'
      alias ... 'z ../..'
      alias .... 'z ../../..'

      # Docker Compose Aliases
      alias dc 'docker compose up -d'
      alias dcb 'docker compose build'
      alias dcp 'docker compose pull'
      alias dcd 'docker compose down'
      alias dcl 'docker compose logs --tail=1000 -f'

      function dcbash
        docker compose exec $argv /bin/bash
      end

      # =========================================================================
      # Abbreviations
      # =========================================================================

      abbr --add -- cc 'clear'
      abbr --add -- lg 'lazygit'
      abbr --add -- ld 'lazydocker'
      abbr --add -- ncc 'nix-store --gc'
      abbr --add -- nr 'sudo nixos-rebuild switch --flake /etc/nixos#(hostname) --show-trace'

      # =========================================================================
      # Plugin and Function Initialization
      # =========================================================================

      # Initialize zoxide (jump to directories)
      zoxide init fish | source

      # Enable repeat last command with '!'
      function bind_bang
        switch (commandline -t)[-1]
          case "!"
            commandline -t -- $history[1]
            commandline -f repaint
          case "*"
            commandline -i !
        end
      end

      # Set key binding for '!'
      function fish_user_key_bindings
        bind ! bind_bang
      end
    '';
  };
}