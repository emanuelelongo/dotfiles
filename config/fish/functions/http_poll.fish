function http_poll
    if test (count $argv) -lt 1
        echo "Notify when an http endpoint becomes available\n"
        echo "Usage: http_poll <endpoint>"
        return
    end

    while true
        set output "200"
        # set output (http -h $argv[1] --timeout=5 2>1 | grep HTTP/1.1 | awk '{print $2}')
        if test "$output" = "200" 
            osascript -e 'tell app "System Events" to display alert "'$argv[1]' is now available"'
            return
        end
        sleep 60
    end
end
