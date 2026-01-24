function __gitignoreio_cache_file
    set -l cache_root $XDG_CACHE_HOME
    if test -z "$cache_root"
        set cache_root ~/.cache
    end
    echo $cache_root/fish/gitignoreio/list
end

function __gitignoreio_get_command_list
    set -l cache_file (__gitignoreio_cache_file)
    set -l ttl_seconds (math "60 * 60 * 24 * 7")  # 7 days

    if test -f $cache_file
        set -l mtime (__file_mtime_epoch $cache_file)
        set -l now (date +%s)

        if test (math "$now - $mtime") -lt $ttl_seconds
            cat $cache_file
            return
        end
    end

    # Refresh cache
    set -l tmp (mktemp)
    if curl -sfL https://www.toptal.com/developers/gitignore/api/list \
        | string split "," > $tmp
        mkdir -p (dirname $cache_file)
        mv $tmp $cache_file
        cat $cache_file
    else
        # Network failed — fall back to stale cache if present
        rm -f $tmp
        test -f $cache_file; and cat $cache_file
    end
end

function __gi_complete
    set -l token (commandline -ct)
    set -l parts (string split -r -m1 "," $token)

    if test (count $parts) -eq 2
        set -l prefix $parts[1],
        for x in (__gitignoreio_get_command_list)
            echo $prefix$x
        end
    else
        __gitignoreio_get_command_list
    end
end

complete -c gi -f -a "(__gi_complete)"

