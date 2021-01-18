# Start configuration added by Zim install {{{
#
# User configuration sourced by all invocations of the shell
#

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
# }}} End configuration added by Zim install

is_wsl() {
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
        echo "wsl"
    elif grep -qEI "(Microsoft|WSL)" /proc/sys/kernel/osrelease &> /dev/null; then
        echo "wsl"
    else
        echo "other"
    fi
}

export IS_WSL=$(is_wsl)