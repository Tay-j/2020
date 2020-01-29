module load gatk/4.1.3.0

echo Enter filename:
read FILE

source activate gatk

gatk --java-options "-Xmx3g -Xms3g" VariantFiltration \
-V ${FILE}.vcf.gz \
--filter-expression "ExcessHet > 54.69" \
--filter-name ExcessHet \
-O ${FILE}_excesshet.vcf.gz

source deactivate
