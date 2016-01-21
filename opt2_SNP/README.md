#Option 2: converting from structure (SNP data)
Creates a migrate file with each SNP recorded as a separate locus. This script expects a structure file with no locus-header row, and no pop-ID column. Population IDs will instead be populated from your pop_map file (which you can construct following the same guidelines as: https://github.com/laninsky/Making_migrate_files/blob/master/opt1_locus/README.md#pop-map-designations).

Place your pop_map file in the directory with your structure file, and then execute the function by pasting step1_SNP.R into your console/sourcing it. Expected arguments are:
step1_SNP("working_dir","structure_file_name")
