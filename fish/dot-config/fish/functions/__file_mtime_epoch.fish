#mtime in seconds
function __file_mtime_epoch --argument file
    # GNU coreutils (Linux)
    if stat -c %Y $file >/dev/null 2>&1
        stat -c %Y $file
        return
    end

    # BSD / macOS
    if stat -f %m $file >/dev/null 2>&1
        stat -f %m $file
        return
    end

    # Fallback: try Perl (very common)
    if command -q perl
        perl -e 'print +(stat($ARGV[0]))[9]' $file
        return
    end

    return 1
end

