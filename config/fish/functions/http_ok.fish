function http_ok
    if test (count $argv) -lt 1
        echo "Create a simple http server that always return \"200 OK\" response\n"
        echo "Usage: http_ok <port> [response text]"
        return
    end
    ncat -l -k -p $argv[1] -c "echo HTTP/1.1 200 OK'\n\n'$argv[2]'\n'" -o /dev/stdout
end
