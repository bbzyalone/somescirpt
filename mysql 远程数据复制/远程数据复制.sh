
#远程数据复制
mysqldump  3_km_test -h 101.37.158.254 -P 3306  -uroot -pwkqdmm | mysql shouxin_main -uroot -pwkq1234..00;
mysqldump  shouxin_pfc -h 101.37.158.254 -P 3306  -uroot -pwkqdmm | mysql shouxin_pfc -uroot -pwkq1234..00;
mysqldump  shouxin_sys -h 101.37.158.254 -P 3306  -uroot -pwkqdmm | mysql shouxin_sys -uroot -pwkq1234..00;
mysqldump  tx_manager -h 101.37.158.254 -P 3306  -uroot -pwkqdmm | mysql tx_manager -uroot -pwkq1234..00;