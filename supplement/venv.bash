function mkvenv() {
    venv_name="$1"
    [ -z "${venv_name}" ] && return
    project_dir="${HOME}/projects/${venv_name}"
    mkdir -p "${project_dir}" || return
    cd "${project_dir}" || return
    python3 -m venv --upgrade-deps --prompt "${venv_name}" .venv || return
    source .venv/bin/activate
}

function workon() {
    cd "${HOME}/projects/$1" || return
    source .venv/bin/activate
}

function rmvenv() {
    venv_name="$1"
    [ -z "${venv_name}" ] && return
    project_dir="${HOME}/projects/${venv_name}"
    cd "${project_dir}" || return
    deactivate
    rm -rf .venv
}

_workon_completions()
{
    if [ "${#COMP_WORDS[@]}" != "2" ]; then
        return
    fi
    _project_list=$(find ~/projects -maxdepth 2 -type d -name .venv -print0 | xargs --null -n1 dirname | xargs -n1 basename)
    COMPREPLY+=($(compgen -W "${_project_list}" "${COMP_WORDS[1]}"))
}

complete -F _workon_completions workon
complete -F _workon_completions rmvenv
