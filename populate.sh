echo Enter username:

read USER

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password << EOF

CREATE DATABASE testDB;

EOF

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password testDB < /stornext/HPCScratch/lab_bahlo/MySQL_test/databases/TestDB.sql 

mysql -S ${PWD}/mysql/run/mysqld/mysqld.sock -u $USER --password=password testDB << EOF

INSERT INTO \`geneticinfo\` (\`marker\`,\`genotype\`) VALUES (1,1);

INSERT INTO \`markers\` (\`SNPID\`,\`SNPname\`,\`chrom\`,\`positionBP\`,\`REF\`,\`ALT\`) VALUES (1,'SNP1','chr1','1','A','T');

INSERT INTO \`pedigrees\` (\`pedigreeID\`,\`famID\`,\`individualID\`,\`fatherID\`,\`motherID\`,\`gender\`,\`affected\`,\`haplotype\`,\`ethnicity\`,\`RE\`,\`labID\`) VALUES (1,1,1,0,0,1,1,1,'y','RE2','lab2'); 

INSERT INTO \`variants\` (\`ID\`,\`gene\`,\`motif\`,\`disease\`,\`positionBP\`) VALUES (1,'gene1','motif1','disease1',1);

EOF
