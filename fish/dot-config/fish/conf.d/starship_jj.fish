function __starship_jj_config --on-variable PWD --description 'Point starship at a git-module-free config inside colocated jj repos'
    set -l dir $PWD
    if command -v starship-jj >/dev/null 2>&1
        while true
            if test -d "$dir/.jj"
                set -gx STARSHIP_CONFIG $HOME/.config/starship-jj.toml
                return
            end
            if test "$dir" = /
                break
            end
            set dir (dirname $dir)
        end
    end
    set -e STARSHIP_CONFIG
end

__starship_jj_config
