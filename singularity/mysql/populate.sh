echo Enter username:
read USER

echo Enter database name:
read DATA

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password << EOF

CREATE DATABASE ${DATA};

EOF

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password ${DATA} < /stornext/HPCScratch/lab_bahlo/MySQL_test/databases/TestDB.sql 

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password ${DATA} << EOF

USE ${DATA};
LOAD DATA LOCAL INFILE '/stornext/Home/data/allstaff/t/tay.j/2020/1000genomes/samples.txt'
INTO TABLE samples;
LOAD DATA LOCAL INFILE '/stornext/Home/data/allstaff/t/tay.j/2020/1000genomes/pathogenicmutations.txt'
INTO TABLE pathogenicmutations;
LOAD DATA LOCAL INFILE '/stornext/Home/data/allstaff/t/tay.j/2020/1000genomes/geneticdata.txt'
INTO TABLE geneticdata;

EOF
