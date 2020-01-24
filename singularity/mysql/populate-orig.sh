echo Enter username:

read USER

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password << EOF

CREATE DATABASE testDB;

EOF

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password testDB < /stornext/HPCScratch/lab_bahlo/MySQL_test/databases/TestDB.sql 

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password testDB << EOF

INSERT INTO \`geneticdata\` (\`marker\`,\`genotype\`,\`chr\`) VALUES (1,1,'chr1');

INSERT INTO \`geneticmarkers\` (\`markerID\`,\`markername\`,\`chr\`,\`positionBP\`,\`REF\`,\`ALT\`,\`markertype\`) VALUES (1,'SNP1','chr1','1','A','T','SNP');

INSERT INTO \`samples\` (\`sampleID\`,\`famID\`,\`individualID\`,\`fatherID\`,\`motherID\`,\`gender\`,\`affected\`,\`haplotype\`,\`ethnicity\`,\`mutation\`,\`validation\`,\`labID\`,\`datatype\`) VALUES (1,1,1,0,0,1,1,1,'y','RE1','pedigree','lab1','WGS'); 

INSERT INTO \`pathogenicmutations\` (\`ID\`,\`gene\`,\`motif\`,\`disease\`,\`diseasemodel\`,\`positionBP\`,\`region\`,\`OMIMID\`) VALUES (1,'gene1','motif1','disease1','AD',1,'coding','OMIM1');

EOF
