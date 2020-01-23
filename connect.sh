module load singularity/3.5.2

echo Enter username:

read USER

echo Enter password:

read PASS

check=`singularity instance list | grep mysql`

if [ ! -z "check" ]
then
	echo Connecting
else
	singularity instance start --bind ${HOME} --bind ${PWD}/mysql/var/lib/mysql/:/var/lib/mysql --bind ${PWD}/mysql/run/mysqld:/run/mysqld ./mysql.simg mysql 
fi

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password
