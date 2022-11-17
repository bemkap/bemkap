FPRO=: 0 : 0
cc tb_prod table 1 5;
set tb_prod hdr codigo nombre marca costo porcentaje;
)

main_tb_prod_change=: 3 : 0
 wd'set tb_prod colwidth ',":<.1r5*_30+{.".wd'getp wh'
)