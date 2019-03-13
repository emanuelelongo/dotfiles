function http_raw_ssl
    if test (count $argv) -lt 2
        echo "Send raw http request through ssl\n"
        echo "Usage: http_raw_ssl <request_file> <endpoint>"
        return
    end
    (cat $argv[1]; sleep 1 ) | ncat --ssl $argv[2] 443
end
