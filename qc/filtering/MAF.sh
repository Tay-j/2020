module load gatk/4.1.3.0

echo Enter filename:
read FILE

source activate gatk

gatk --java-options "-Xmx3g -Xms3g" VariantFiltration \
-V ${FILE}.vcf.gz \
--filter-expression "AF > 0.0005" \
--filter-name MAF \
-O ${FILE}_maf.vcf.gz

source deactivate
