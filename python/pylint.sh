#!/bin/sh
#
# pylint wrapper
#
status=0
metrics=0
pylint -f parseable ${1+"$@"} | while read line; do
    if [ ${metrics} -eq 0 ]; then
        if [ "x${line}" = "x" ]; then
            metrics=1
        else
            echo "pylint: ${line}"
        fi
    else
        case "${line}" in
            *rated*) echo "pylint: ${line}" | sed -e 's/ (.*)//';;
        esac
    fi
done
# FIXME: exit -1 if errors or rating < limit
exit ${status}
