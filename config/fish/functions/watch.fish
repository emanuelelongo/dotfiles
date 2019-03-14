function watch
    fswatch -0 $argv[1] | xargs -0 -n 1 -I {} $argv[2] {}
end
