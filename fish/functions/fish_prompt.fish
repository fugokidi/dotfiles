function fish_prompt
     echo -n -s (set_color $fish_color_cwd --bold) (prompt_pwd)(set_color normal) (fish_git_prompt) " "
     if set -q VIRTUAL_ENV
         echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
     end
end
