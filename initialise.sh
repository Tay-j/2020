module load singularity/3.5.2 

singularity pull --name mysql.simg shub://ISU-HPC/mysql

curl https://raw.githubusercontent.com/ISU-HPC/mysql/master/my.cnf > \ 
    ${HOME}/.my.cnf 

curl https://raw.githubusercontent.com/ISU-HPC/mysql/master/mysqlrootpw > \ 
    ${HOME}/.mysqlrootpw 

mkdir -p ${PWD}/mysql/var/lib/mysql ${PWD}/mysql/run/mysqld 

singularity instance start --bind ${HOME} --bind ${PWD}/mysql/var/lib/mysql/:/var/lib/mysql --bind ${PWD}/mysql/run/mysqld:/run/mysqld ./mysql.simg mysql 

singularity run instance://mysql 

singularity instance stop mysql
