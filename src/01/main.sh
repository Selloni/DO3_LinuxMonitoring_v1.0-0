#!/bin/bash

if ! [ $# -eq 1 ] #количество акругментов != 1
    then
        echo "error, there should be one word"
else
    #re='([[:alpha:]]+)'
    re='^([1-9]+)$'
    if [[ $1 =~ $re ]]
        then
            echo "uncorected value"
        else
            echo $1
    fi
fi
