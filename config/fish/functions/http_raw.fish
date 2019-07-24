function http_raw
    if test (count $argv) -lt 2
        echo "Send raw http request\n"
        echo "Usage: raw_http <request_file> <endpoint>"
        return
    end
    cat $argv[1]; sleep 1 | ncat $argv[2] 80
end
