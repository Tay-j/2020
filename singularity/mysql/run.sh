cd /stornext/HPCScratch/lab_bahlo/MySQL_test 

singularity instance start --bind ${HOME} --bind ${PWD}/mysql/var/lib/mysql/:/var/lib/mysql --bind ${PWD}/mysql/run/mysqld:/run/mysqld ./mysql.simg mysql 

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock
