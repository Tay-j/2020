singularity instance start --bind ${HOME} --bind ${PWD}/mysql/var/lib/mysql/:/var/lib/mysql --bind ${PWD}/mysql/run/mysqld:/run/mysqld ./mysql.simg mysql 

singularity run instance://mysql 
