function gi
    curl -fLw '\n' "https://www.toptal.com/developers/gitignore/api/"(string join "," $argv)
end
