#!/bin/sh
#
# pylint wrapper couting errors and checking rating
#
base=`dirname $0`
[ -f "${base}/.pylintrc" ] && options="--rcfile ${base}/.pylintrc"
pylint ${options} -f parseable ${1+"$@"} | {
    errors=0
    metrics=0
    while read line; do
        if [ ${metrics} -eq 0 ]; then
            if [ "x${line}" = "x" ]; then
                metrics=1
                continue
            fi
            case "${line}" in
                *:\ \[[EF]*) errors=$((errors+1));;
            esac
            echo "pylint: ${line}"
        else
            case "${line}" in
                *rated\ at*)
                    line=`echo ${line} | sed -e 's/ (.*)//'`
                    echo -n "pylint: ${line} - "
                    case "${line}" in
                        *at\ 9*) echo "good";;
                        *at\ 10*) echo "perfect";;
                        *) echo "bad"; errors=$((errors+1));;
                    esac
                    ;;
            esac
        fi
    done
    echo "pylint: ${errors} errors detected"
    [ ${errors} -gt 0 ] && exit 1
}
exit $?
