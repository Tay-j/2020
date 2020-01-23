echo Enter username:

read USER

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password << EOF

SHUTDOWN;

exit;

EOF


singularity instance stop mysql
