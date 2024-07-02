# https://stackoverflow.com/questions/52706888/anaconda-python-causing-slow-terminal-startup-prompt
function conda-init -d "initialize conda shell functions"
    if type conda | grep -q alias
        echo "initializing conda..."
        eval /Users/pyone/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    end
end

function python3 -d python3
    conda-init
    functions -e python3
    python3 $argv
end

function py -d python3
    conda-init
    functions -e py
    alias py python3
    python3 $argv
end

function ipy -d ipython
    conda-init
    functions -e ipy
    ipython $argv
    alias ipy ipython
end

alias conda "conda-init; conda"
