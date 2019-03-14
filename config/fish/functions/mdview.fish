function mdview
    pandoc $argv[1] | lynx -stdin
end
