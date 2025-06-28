{
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-a";
    baseIndex = 1;
    extraConfig = ''
      # Notifying if other windows has activities
      setw -g monitor-activity on
      # Renumber windows on window close
      set -g renumber-windows on
      # split panes using | and -
      bind s split-window -h
      bind v split-window -v
      unbind '"'
      unbind %
      # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-yank'
      set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
      set -g @plugin 'tmux-plugins/tmux-continuum'
      set -g @plugin 'niksingh710/minimal-tmux-status'

      # Undercurl
      set -g default-terminal "tmux-256color"
      set -g allow-passthrough 'on'
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
      set -g @continuum-restore 'off'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-strategy-nvim 'session'
      setenv -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins/"
      if "test ! -d ~/.tmux/plugins/tpm" \
      "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"
      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run -b '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
