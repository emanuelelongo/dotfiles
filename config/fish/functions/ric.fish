function ric
    pbpaste | sed -e 's/'"$argv[1]"'/'"$argv[2]"'/g' | pbcopy
end
