function github
    if test (count $argv) -gt 1
        git clone https://github.com/$argv[1]/$argv[2].git
        cd $argv[2];
        return
    end
    curl -s https://api.github.com/users/$argv[1]/repos | jq ".[].name" | tr -d '"'
end
