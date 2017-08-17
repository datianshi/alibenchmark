#!/bin/bash

if [ $# -ne 4 ]
  then
    echo "mysqlbenchmark.sh [HOST] [USERNAME] [PASSWORD] [DATABASE]"
    exit 1
fi

HOST=$1
USERNAME=$2
PASSWORD=$3
DATABASE=$4

function mysqlfunc() {
    COMMAND=$1
    sysbench --num-threads=5 --test=oltp --oltp-table-size=1000000 --mysql-db=${DATABASE} --mysql-user=${USERNAME} --mysql-password=${PASSWORD} --mysql-host=${HOST} ${COMMAND}
}

mysqlfunc prepare
mysqlfunc run
mysqlfunc cleanup
