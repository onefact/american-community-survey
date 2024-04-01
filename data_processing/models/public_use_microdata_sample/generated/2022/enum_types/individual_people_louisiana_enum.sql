-- SQL transformation for psam_p22 generated by generate_sql_with_enum_types.py
{{ config(materialized='external', location=var('output_path') + '/individual_people_louisiana_enum_types.parquet') }}

SELECT
    RT::ENUM ('H','P'),
    SERIALNO::VARCHAR,
    DIVISION::ENUM ('0','1','2','3','4','5','6','7','8','9'),
    PUMA::VARCHAR,
    REGION::ENUM ('1','2','3','4','9'),
    ST::ENUM ('01','02','04','05','06','08','09','10','11','12','13','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','44','45','46','47','48','49','50','51','53','54','55','56','72'),
    ADJINC::VARCHAR,
    SPORDER::VARCHAR,
    PWGTP::VARCHAR,
    AGEP::VARCHAR,
    CIT::ENUM ('1','2','3','4','5'),
    CITWP::ENUM ('bbbb','1947','1948','1950','1952','1953','1954','1955','1956','1957','1958','1959','1960','1961','1962','1963','1964','1965','1966','1967','1968','1969','1970','1971','1972','1973','1974','1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022'),
    COW::ENUM ('b','1','2','3','4','5','6','7','8','9'),
    DDRS::ENUM ('b','1','2'),
    DEAR::ENUM ('1','2'),
    DEYE::ENUM ('1','2'),
    DOUT::ENUM ('b','1','2'),
    DPHY::ENUM ('b','1','2'),
    DRAT::VARCHAR,
    DRATX::ENUM ('b','1','2'),
    DREM::ENUM ('b','1','2'),
    ENG::ENUM ('b','1','2','3','4'),
    FER::ENUM ('b','1','2'),
    GCL::VARCHAR,
    GCM::VARCHAR,
    GCR::VARCHAR,
    HIMRKS::VARCHAR,
    HINS1::VARCHAR,
    HINS2::ENUM ('1','2'),
    HINS3::ENUM ('1','2'),
    HINS4::VARCHAR,
    HINS5::ENUM ('1','2'),
    HINS6::ENUM ('1','2'),
    HINS7::ENUM ('1','2'),
    INTP::VARCHAR,
    JWMNP::VARCHAR,
    JWRIP::ENUM ('bb','1','2','3','4','5','6','7','8','9','10'),
    JWTRNS::ENUM ('bb','01','02','03','04','05','06','07','08','09','10','11','12'),
    LANX::VARCHAR,
    MAR::ENUM ('1','2','3','4','5'),
    MARHD::ENUM ('b','1','2'),
    MARHM::ENUM ('b','1','2'),
    MARHT::VARCHAR,
    MARHW::ENUM ('b','1','2'),
    MARHYP::ENUM ('bbbb','1943','1944','1945','1946','1947','1948','1949','1950','1951','1952','1953','1954','1955','1956','1957','1958','1959','1960','1961','1962','1963','1964','1965','1966','1967','1968','1969','1970','1971','1972','1973','1974','1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022'),
    MIG::ENUM ('b','1','2','3'),
    MIL::ENUM ('b','1','2','3','4'),
    MLPA::ENUM ('b','0','1'),
    MLPB::ENUM ('b','0','1'),
    MLPCD::ENUM ('b','0','1'),
    MLPE::ENUM ('b','0','1'),
    MLPFG::ENUM ('b','0','1'),
    MLPH::ENUM ('b','0','1'),
    MLPIK::VARCHAR,
    MLPJ::ENUM ('b','0','1'),
    NWAB::ENUM ('b','1','2','3'),
    NWAV::ENUM ('b','1','2','3','4','5'),
    NWLA::ENUM ('b','1','2','3'),
    NWLK::ENUM ('b','1','2','3'),
    NWRE::ENUM ('b','1','2','3'),
    OIP::VARCHAR,
    PAP::VARCHAR,
    RELSHIPP::ENUM ('20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38'),
    RETP::VARCHAR,
    SCH::ENUM ('b','1','2','3'),
    SCHG::ENUM ('bb','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16'),
    SCHL::ENUM ('bb','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24'),
    SEMP::VARCHAR,
    SEX::ENUM ('1','2'),
    SSIP::VARCHAR,
    SSP::VARCHAR,
    WAGP::VARCHAR,
    WKHP::VARCHAR,
    WKL::ENUM ('b','1','2','3'),
    WKWN::VARCHAR,
    WRK::ENUM ('b','1','2'),
    YOEP::ENUM ('bbbb','1934','1935','1939','1943','1945','1946','1947','1948','1949','1950','1951','1952','1953','1954','1955','1956','1957','1958','1959','1960','1961','1962','1963','1964','1965','1966','1967','1968','1969','1970','1971','1972','1973','1974','1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022'),
    ANC::ENUM ('1','2','3','4'),
    ANC1P::ENUM ('001','003','005','008','009','011','012','020','021','022','024','026','032','040','046','049','050','051','068','077','078','082','084','087','088','089','091','094','097','098','099','100','102','103','109','111','112','114','115','122','124','125','128','129','130','131','142','144','146','148','152','153','154','168','169','170','171','176','177','178','181','183','185','187','190','194','195','200','210','211','212','213','215','218','219','221','222','223','224','225','226','227','231','232','233','234','235','236','237','238','239','249','250','251','252','261','271','275','290','291','295','300','301','302','308','310','314','322','325','329','330','331','335','336','359','360','370','400','402','404','406','411','416','417','419','421','425','427','429','431','434','435','442','465','483','484','490','495','496','499','508','510','515','522','523','527','529','530','534','541','553','564','566','568','570','576','586','587','588','593','598','599','600','603','607','609','615','618','620','650','680','690','700','703','706','707','712','714','716','720','730','740','748','750','765','768','770','776','782','785','795','799','800','803','808','811','814','815','820','821','822','825','841','850','899','900','901','902','903','904','907','913','914','917','918','919','920','922','924','925','927','929','931','935','937','939','940','983','994','995','996','997','998','999'),
    ANC2P::ENUM ('001','003','005','008','009','011','012','020','021','022','024','026','032','040','046','049','050','051','068','077','078','082','084','087','088','089','091','094','097','098','099','100','102','103','109','111','112','114','115','122','124','125','128','129','130','131','142','144','146','148','152','153','154','168','169','170','171','176','177','178','181','183','185','187','190','194','195','200','210','211','212','213','215','218','219','221','222','223','224','225','226','227','231','232','233','234','235','236','237','238','239','249','250','251','252','261','271','275','290','291','295','300','301','302','308','310','314','322','325','329','330','331','335','336','359','360','370','400','402','404','406','411','416','417','419','421','425','427','429','431','434','435','442','465','483','484','490','495','496','499','508','510','515','522','523','527','529','530','534','541','553','564','566','568','570','576','586','587','588','593','598','599','600','603','607','609','615','618','620','650','680','690','700','703','706','707','712','714','716','720','730','740','748','750','765','768','770','776','782','785','795','799','800','803','808','811','814','815','820','821','822','825','841','850','899','900','901','902','903','904','907','913','914','917','918','919','920','922','924','925','927','929','931','935','937','939','940','983','994','995','996','997','998','999'),
    DECADE::ENUM ('b','1','2','3','4','5','6','7','8'),
    DIS::ENUM ('1','2'),
    DRIVESP::VARCHAR,
    ESP::VARCHAR,
    ESR::ENUM ('b','1','2','3','4','5','6'),
    FOD1P::ENUM ('bbbb','1100','1101','1102','1103','1104','1105','1106','1199','1301','1302','1303','1401','1501','1901','1902','1903','1904','2001','2100','2101','2102','2105','2106','2107','2201','2300','2301','2303','2304','2305','2306','2307','2308','2309','2310','2311','2312','2313','2314','2399','2400','2401','2402','2403','2404','2405','2406','2407','2408','2409','2410','2411','2412','2413','2414','2415','2416','2417','2418','2419','2499','2500','2501','2502','2503','2504','2599','2601','2602','2603','2901','3202','3301','3302','3401','3402','3501','3600','3601','3602','3603','3604','3605','3606','3607','3608','3609','3611','3699','3700','3701','3702','3801','4000','4001','4002','4005','4006','4007','4101','4801','4901','5000','5001','5002','5003','5004','5005','5006','5007','5008','5098','5102','5200','5201','5202','5203','5205','5206','5299','5301','5401','5402','5403','5404','5500','5501','5502','5503','5504','5505','5506','5507','5599','5601','5701','5901','6000','6001','6002','6003','6004','6005','6006','6007','6099','6100','6102','6103','6104','6105','6106','6107','6108','6109','6110','6199','6200','6201','6202','6203','6204','6205','6206','6207','6209','6210','6211','6212','6299','6402','6403'),
    FOD2P::ENUM ('bbbb','1100','1101','1102','1103','1104','1105','1106','1199','1301','1302','1303','1401','1501','1901','1902','1903','1904','2001','2100','2101','2102','2105','2106','2107','2201','2300','2301','2303','2304','2305','2306','2307','2308','2309','2310','2311','2312','2313','2314','2399','2400','2401','2402','2403','2404','2405','2406','2407','2408','2409','2410','2411','2412','2413','2414','2415','2416','2417','2418','2419','2499','2500','2501','2502','2503','2504','2599','2601','2602','2603','2901','3202','3301','3302','3401','3402','3501','3600','3601','3602','3603','3604','3605','3606','3607','3608','3609','3611','3699','3700','3701','3702','3801','4000','4001','4002','4005','4006','4007','4101','4801','4901','5000','5001','5002','5003','5004','5005','5006','5007','5008','5098','5102','5200','5201','5202','5203','5205','5206','5299','5301','5401','5402','5403','5404','5500','5501','5502','5503','5504','5505','5506','5507','5599','5601','5701','5901','6000','6001','6002','6003','6004','6005','6006','6007','6099','6100','6102','6103','6104','6105','6106','6107','6108','6109','6110','6199','6200','6201','6202','6203','6204','6205','6206','6207','6209','6210','6211','6212','6299','6402','6403'),
    HICOV::VARCHAR,
    HISP::ENUM ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24'),
    INDP::ENUM ('bbbb','0170','0180','0190','0270','0280','0290','0370','0380','0390','0470','0490','0570','0580','0590','0670','0680','0690','0770','1070','1080','1090','1170','1180','1190','1270','1280','1290','1370','1390','1470','1480','1490','1570','1590','1670','1691','1770','1790','1870','1880','1890','1990','2070','2090','2170','2180','2190','2270','2280','2290','2370','2380','2390','2470','2480','2490','2570','2590','2670','2680','2690','2770','2780','2790','2870','2880','2890','2970','2980','2990','3070','3080','3095','3170','3180','3291','3365','3370','3380','3390','3470','3490','3570','3580','3590','3670','3680','3690','3770','3780','3790','3875','3895','3960','3970','3980','3990','4070','4080','4090','4170','4180','4195','4265','4270','4280','4290','4370','4380','4390','4470','4480','4490','4560','4570','4580','4585','4590','4670','4680','4690','4770','4780','4795','4870','4880','4890','4971','4972','4980','4990','5070','5080','5090','5170','5180','5190','5275','5280','5295','5370','5381','5391','5470','5480','5490','5570','5580','5593','5670','5680','5690','5790','6070','6080','6090','6170','6180','6190','6270','6280','6290','6370','6380','6390','6470','6480','6490','6570','6590','6670','6672','6680','6690','6695','6770','6780','6870','6880','6890','6970','6991','6992','7071','7072','7080','7181','7190','7270','7280','7290','7370','7380','7390','7460','7470','7480','7490','7570','7580','7590','7670','7680','7690','7770','7780','7790','7860','7870','7880','7890','7970','7980','7990','8070','8080','8090','8170','8180','8191','8192','8270','8290','8370','8380','8390','8470','8561','8562','8563','8564','8570','8580','8590','8660','8670','8680','8690','8770','8780','8790','8870','8891','8970','8980','8990','9070','9080','9090','9160','9170','9180','9190','9290','9370','9380','9390','9470','9480','9490','9570','9590','9670','9680','9690','9770','9780','9790','9870','9920'),
    JWAP::VARCHAR,
    JWDP::VARCHAR,
    LANP::VARCHAR,
    MIGPUMA::VARCHAR,
    MIGSP::ENUM ('bbb','001','002','004','005','006','008','009','010','011','012','013','015','016','017','018','019','020','021','022','023','024','025','026','027','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042','044','045','046','047','048','049','050','051','053','054','055','056','072','109','110','111','113','114','120','134','138','139','163','164','200','207','210','214','215','217','229','231','233','235','240','242','243','245','247','251','252','253','301','303','312','313','314','317','327','329','332','333','344','362','364','365','370','373','374','414','416','427','440','467','468','469','501','555'),
    MSP::ENUM ('b','1','2','3','4','5','6'),
    NAICSP::ENUM ('bbbbbbbb','111','112','1133','113M','114','115','211','2121','2122','2123','213','2211P','2212P','22132','2213M','221MP','22S','23','3113','3114','3115','3116','311811','3118Z','311M1','311M2','311S','3121','3122','3131','3132Z','3133','31411','314Z','315M','3162','316M','31M','3211','3212','32199M','3219ZM','3221','32221','3222M','3231','3241M','32411','3252','3253','3254','3255','3256','325M','3261','32621','3262M','32711','327120','3272','3279','327M','3313','3314','3315','331M','3321','3322','3327','3328','33299M','332M','332MZ','33311','3331M','3333','3335','3336','333MS','3341','3345','334M1','334M2','3352','335M','33641M1','33641M2','3365','3366','3369','336M','337','3391','3399M','3399ZM','33MS','3MS','4231','4232','4233','4234','4235','4236','4237','4238','42393','4239Z','4241','4243','4244','4245','4247','4248','42491','4249Z','424M','4251','42S','4411','4412','4413','442','443141','443142','44413','4441Z','4442','44511','44512','4452','4453','44611','446Z','447','44821','4483','4481','45113','45114','4511M','45121','45221','4523','4531','45321','45322','4533','4539','454110','4542','454310','45439','4MS','481','482','483','484','4853','485M','486','487','488','491','492','493','51111','5111Z','5112','5121','5122','515','517311','517Z','5182','51912','51913','5191ZM','5221M','522M','5241','5242','52M1','52M2','531M','5313','5321','532M2','53M','5411','5412','5413','5414','5415','5416','5417','5418','54194','5419Z','55','5613','5614','5615','5616','56173','5617Z','561M','562','6111','611M1','611M2','611M3','6211','6212','62131','62132','6213ZM','6214','6216','621M','622M','6222','6231','623M','6241','6242','6243','6244','7111','7112','711M','7115','712','71395','713Z','7211','721M','7224','722Z','811192','8111Z','8112','8113','8114','812111','812112','8121M','8122','8123','8129','8131','81393','8139Z','813M','814','92113','92119','9211MP','923','928110P1','928110P2','928110P3','928110P4','928110P5','928110P6','928110P7','928P','92M1','92M2','92MP','999920'),
    NATIVITY::ENUM ('1','2'),
    NOP::VARCHAR,
    OC::ENUM ('b','0','1'),
    OCCP::ENUM ('bbbb','0010','0020','0040','0051','0052','0060','0101','0102','0110','0120','0135','0136','0137','0140','0150','0160','0205','0220','0230','0300','0310','0335','0340','0350','0360','0410','0420','0425','0440','0500','0510','0520','0530','0540','0565','0600','0630','0640','0650','0700','0705','0710','0725','0726','0735','0750','0800','0810','0820','0830','0845','0850','0860','0900','0910','0930','0940','0960','1005','1006','1007','1010','1021','1022','1031','1032','1050','1065','1105','1106','1108','1200','1220','1240','1305','1306','1310','1320','1340','1350','1360','1400','1410','1420','1430','1440','1450','1460','1520','1530','1541','1545','1551','1555','1560','1600','1610','1640','1650','1700','1710','1720','1745','1750','1760','1800','1821','1822','1825','1840','1860','1900','1910','1920','1935','1970','1980','2001','2002','2003','2004','2005','2006','2011','2012','2013','2014','2015','2016','2025','2040','2050','2060','2100','2105','2145','2170','2180','2205','2300','2310','2320','2330','2350','2360','2400','2435','2440','2545','2555','2600','2631','2632','2633','2634','2635','2636','2640','2700','2710','2721','2722','2723','2740','2751','2752','2755','2770','2805','2810','2825','2830','2840','2850','2861','2862','2865','2905','2910','2920','3000','3010','3030','3040','3050','3090','3100','3110','3120','3140','3150','3160','3200','3210','3220','3230','3245','3250','3255','3256','3258','3261','3270','3300','3310','3321','3322','3323','3324','3330','3401','3402','3421','3422','3423','3424','3430','3500','3515','3520','3545','3550','3601','3602','3603','3605','3610','3620','3630','3640','3645','3646','3647','3648','3649','3655','3700','3710','3720','3725','3740','3750','3801','3802','3820','3840','3870','3900','3910','3930','3940','3945','3946','3960','4000','4010','4020','4030','4040','4055','4110','4120','4130','4140','4150','4160','4200','4210','4220','4230','4240','4251','4252','4255','4330','4340','4350','4400','4420','4435','4461','4465','4500','4510','4521','4522','4525','4530','4540','4600','4621','4622','4640','4655','4700','4710','4720','4740','4750','4760','4800','4810','4820','4830','4840','4850','4900','4920','4930','4940','4950','4965','5000','5010','5020','5040','5100','5110','5120','5140','5150','5160','5165','5220','5230','5240','5250','5260','5300','5310','5320','5330','5340','5350','5360','5400','5410','5420','5500','5510','5521','5522','5530','5540','5550','5560','5600','5610','5630','5710','5720','5730','5740','5810','5820','5840','5850','5860','5900','5910','5920','5940','6005','6010','6040','6050','6115','6120','6130','6200','6210','6220','6230','6240','6250','6260','6305','6330','6355','6360','6400','6410','6441','6442','6460','6515','6520','6530','6540','6600','6660','6700','6710','6720','6730','6740','6765','6800','6825','6835','6850','6950','7000','7010','7020','7030','7040','7100','7120','7130','7140','7150','7160','7200','7210','7220','7240','7260','7300','7315','7320','7330','7340','7350','7360','7410','7420','7430','7510','7540','7560','7610','7640','7700','7720','7730','7740','7750','7800','7810','7830','7840','7850','7855','7905','7925','7950','8000','8025','8030','8040','8100','8130','8140','8225','8250','8255','8256','8300','8310','8320','8335','8350','8365','8450','8465','8500','8510','8530','8540','8555','8600','8610','8620','8630','8640','8650','8710','8720','8730','8740','8750','8760','8800','8810','8830','8850','8910','8920','8930','8940','8950','8990','9005','9030','9040','9050','9110','9121','9122','9130','9141','9142','9150','9210','9240','9265','9300','9310','9350','9365','9410','9415','9430','9510','9570','9600','9610','9620','9630','9640','9645','9650','9720','9760','9800','9810','9825','9830','9920'),
    PAOC::VARCHAR,
    PERNP::VARCHAR,
    PINCP::VARCHAR,
    POBP::ENUM ('001','002','004','005','006','008','009','010','011','012','013','015','016','017','018','019','020','021','022','023','024','025','026','027','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042','044','045','046','047','048','049','050','051','053','054','055','056','060','066','069','072','078','100','102','103','104','105','106','108','109','110','116','117','118','119','120','126','127','128','129','130','132','134','136','137','138','139','140','142','147','148','149','150','151','152','154','156','157','158','159','160','161','162','163','164','165','166','167','168','169','200','202','203','205','206','207','209','210','211','212','213','214','215','216','217','218','219','222','223','224','226','228','229','231','233','235','236','238','239','240','242','243','245','246','247','248','249','253','254','300','301','303','310','311','312','313','314','315','316','321','323','324','327','328','329','330','332','333','338','339','340','341','343','344','360','361','362','363','364','365','368','369','370','372','373','374','399','400','407','408','412','414','416','417','420','421','423','425','427','429','430','436','440','442','444','447','448','449','451','453','454','457','459','460','461','462','463','464','467','468','469','501','508','511','512','515','523','527','554'),
    POVPIP::VARCHAR,
    POWPUMA::VARCHAR,
    POWSP::ENUM ('bbb','001','002','004','005','006','008','009','010','011','012','013','015','016','017','018','019','020','021','022','023','024','025','026','027','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042','044','045','046','047','048','049','050','051','053','054','055','056','072','166','254','303','399','555'),
    PRIVCOV::VARCHAR,
    PUBCOV::VARCHAR,
    QTRBIR::ENUM ('1','2','3','4'),
    RAC1P::ENUM ('1','2','3','4','5','6','7','8','9'),
    RAC2P::ENUM ('01','02','03','04','05','07','08','09','11','12','13','14','15','16','17','18','19','20','21','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68'),
    RAC3P::ENUM ('001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','017','018','019','020','021','022','023','024','025','026','027','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042','043','044','045','046','047','048','049','050','051','052','053','054','055','056','057','058','059','060','061','062','063','064','065','066','067','068','069','070','071','072','073','074','075','076','077','078','079','080','081','082','083','084','085','086','087','088','089','090','091','092','093','094','095','096','097','098','099','100'),
    RACAIAN::ENUM ('0','1'),
    RACASN::ENUM ('0','1'),
    RACBLK::ENUM ('0','1'),
    RACNH::ENUM ('0','1'),
    RACNUM::VARCHAR,
    RACPI::ENUM ('0','1'),
    RACSOR::ENUM ('0','1'),
    RACWHT::ENUM ('0','1'),
    RC::ENUM ('b','0','1'),
    SCIENGP::ENUM ('b','1','2'),
    SCIENGRLP::ENUM ('b','1','2'),
    SFN::VARCHAR,
    SFR::ENUM ('b','1','2','3','4','5','6'),
    SOCP::ENUM ('bbbbbb','1110XX','111021','112011','112021','112022','112030','113012','113013','113021','113031','113111','113121','113131','113051','113061','113071','119013','119021','119030','119041','119051','119070','119081','119111','119121','119141','119151','119161','1191XX','131011','131021','131022','131023','131030','131041','131051','131070','131081','131082','131111','131121','131131','131141','131151','131161','131199','132011','132020','132031','132041','132051','132052','132053','132061','132070','132081','132082','1320XX','151221','151211','151212','151251','151252','151253','151254','151255','151230','15124X','151244','151241','151299','152011','152031','1520XX','171011','171012','171020','172011','1720XX','172041','172051','172061','172070','172081','172110','172121','172131','172141','1721XX','1721YY','173011','17301X','173023','17302X','173031','191010','191020','191030','1910XX','192010','192021','192030','192041','19204X','192099','193011','193033','193034','19303X','193051','1930XX','194010','194021','194031','1940XX','1940YY','195010','211011','211012','211013','211014','211015','211019','211021','211022','211023','211029','211092','211093','21109X','212011','212021','212099','2310XX','231012','232011','232093','232099','251000','252010','252020','252030','252050','253041','2530XX','254010','254022','254031','259040','2590XX','271010','271021','271022','271023','271024','271025','271026','27102X','272011','272012','272021','272022','272023','272030','272041','272042','272091','272099','273011','273023','273031','273041','273042','273043','273091','273092','273099','2740XX','274021','274030','291011','291020','291031','291041','291051','291210','291240','291071','291081','291122','291123','291124','291125','291126','291127','29112X','291131','291141','291151','291181','2911XX','291291','291299','292010','291292','292031','292032','292034','292035','29203X','292042','292043','292052','292053','292055','292056','29205X','292061','292072','292081','292090','299000','311121','311122','311131','31113X','312010','312020','319011','319091','319092','319094','319095','319096','319097','31909X','331011','331012','331021','331090','332011','332020','333011','333012','333021','3330XX','333050','339011','339021','339030','339091','339093','339094','33909X','351011','351012','352010','352021','353011','353023','353031','353041','359011','359021','359031','359099','371011','371012','37201X','372012','372021','373011','373013','37301X','391000','392011','392021','393010','393031','3930XX','394031','3940XX','395011','395012','395092','395094','39509X','396010','397010','399011','399031','399032','399041','399099','411011','411012','412010','412021','412022','412031','413011','413021','413031','413041','413091','414010','419010','419020','419031','419041','419091','419099','431011','432011','432021','432099','433011','433021','433031','433051','433061','433071','4330XX','434031','434041','434051','434061','434071','434081','434111','434121','434131','434141','434XXX','434161','434171','434181','434YYY','435011','435021','435031','435032','435041','435051','435052','435053','435061','435071','435111','436011','436012','436013','436014','439021','439022','439041','439051','439061','439071','439081','439111','439XXX','451011','452011','452041','4520XX','453031','454011','454020','471011','472011','472031','472040','472050','472061','472070','472080','472111','472121','472130','472140','472151','472152','472161','472181','472211','472221','472231','472XXX','473010','474011','474021','474031','474041','474051','474061','4740XX','4750YY','475020','475032','475040','4750XX','491011','492011','492020','492091','492092','49209X','492097','492098','493011','493021','493022','493023','493031','493040','493050','493090','499010','499021','499031','49904X','499043','499044','499051','499052','499060','499071','499091','499094','499096','499098','4990XX','511011','512020','512031','512041','5120XX','513011','513020','513091','513092','513093','513099','519160','514020','514031','514033','51403X','514041','514050','5140XX','514111','514120','514XXX','515111','515112','515113','516011','516021','516031','516040','516050','516060','516093','51609X','517011','517021','517041','517042','5170XX','518010','518021','518031','518090','519010','519020','519030','519041','519051','519061','519071','519080','519111','519120','519151','519191','519194','519195','519196','519197','519198','5191XX','531000','532010','532020','532031','533011','533051','533052','533030','533053','533054','533099','534010','534031','5340XX','5350XX','535020','536021','536030','536051','536061','5360XX','537021','5370XX','537051','537061','537062','537063','537064','537065','537070','537081','5371XX','551010','552010','553010','559830','999920'),
    VPS::ENUM ('bb','01','02','03','04','05','06','07','08','09','10','11','12','13','14'),
    WAOB::ENUM ('1','2','3','4','5','6','7','8'),
    FAGEP::ENUM ('0','1'),
    FANCP::ENUM ('0','1'),
    FCITP::ENUM ('0','1'),
    FCITWP::ENUM ('0','1'),
    FCOWP::ENUM ('0','1'),
    FDDRSP::ENUM ('0','1'),
    FDEARP::ENUM ('0','1'),
    FDEYEP::ENUM ('0','1'),
    FDISP::ENUM ('0','1'),
    FDOUTP::ENUM ('0','1'),
    FDPHYP::ENUM ('0','1'),
    FDRATP::ENUM ('0','1'),
    FDRATXP::ENUM ('0','1'),
    FDREMP::ENUM ('0','1'),
    FENGP::ENUM ('0','1'),
    FESRP::ENUM ('0','1'),
    FFERP::ENUM ('0','1'),
    FFODP::ENUM ('0','1'),
    FGCLP::ENUM ('0','1'),
    FGCMP::ENUM ('0','1'),
    FGCRP::ENUM ('0','1'),
    FHICOVP::ENUM ('0','1'),
    FHIMRKSP::ENUM ('0','1'),
    FHINS1P::ENUM ('0','1'),
    FHINS2P::ENUM ('0','1'),
    FHINS3C::VARCHAR,
    FHINS3P::ENUM ('0','1'),
    FHINS4C::VARCHAR,
    FHINS4P::ENUM ('0','1'),
    FHINS5C::VARCHAR,
    FHINS5P::ENUM ('0','1'),
    FHINS6P::ENUM ('0','1'),
    FHINS7P::ENUM ('0','1'),
    FHISP::ENUM ('0','1'),
    FINDP::ENUM ('0','1'),
    FINTP::ENUM ('0','1'),
    FJWDP::ENUM ('0','1'),
    FJWMNP::ENUM ('0','1'),
    FJWRIP::ENUM ('0','1'),
    FJWTRNSP::ENUM ('0','1'),
    FLANP::ENUM ('0','1'),
    FLANXP::ENUM ('0','1'),
    FMARP::ENUM ('0','1'),
    FMARHDP::ENUM ('0','1'),
    FMARHMP::ENUM ('0','1'),
    FMARHTP::ENUM ('0','1'),
    FMARHWP::ENUM ('0','1'),
    FMARHYP::ENUM ('0','1'),
    FMIGP::ENUM ('0','1'),
    FMIGSP::ENUM ('0','1'),
    FMILPP::ENUM ('0','1'),
    FMILSP::ENUM ('0','1'),
    FOCCP::ENUM ('0','1'),
    FOIP::ENUM ('0','1'),
    FPAP::ENUM ('0','1'),
    FPERNP::ENUM ('0','1'),
    FPINCP::ENUM ('0','1'),
    FPOBP::ENUM ('0','1'),
    FPOWSP::ENUM ('0','1'),
    FPRIVCOVP::ENUM ('0','1'),
    FPUBCOVP::ENUM ('0','1'),
    FRACP::ENUM ('0','1'),
    FRELSHIPP::ENUM ('0','1'),
    FRETP::ENUM ('0','1'),
    FSCHGP::ENUM ('0','1'),
    FSCHLP::ENUM ('0','1'),
    FSCHP::ENUM ('0','1'),
    FSEMP::ENUM ('0','1'),
    FSEXP::ENUM ('0','1'),
    FSSIP::ENUM ('0','1'),
    FSSP::ENUM ('0','1'),
    FWAGP::ENUM ('0','1'),
    FWKHP::ENUM ('0','1'),
    FWKLP::ENUM ('0','1'),
    FWKWNP::ENUM ('0','1'),
    FWRKP::ENUM ('0','1'),
    FYOEP::ENUM ('0','1'),
    PWGTP1::VARCHAR,
    PWGTP2::VARCHAR,
    PWGTP3::VARCHAR,
    PWGTP4::VARCHAR,
    PWGTP5::VARCHAR,
    PWGTP6::VARCHAR,
    PWGTP7::VARCHAR,
    PWGTP8::VARCHAR,
    PWGTP9::VARCHAR,
    PWGTP10::VARCHAR,
    PWGTP11::VARCHAR,
    PWGTP12::VARCHAR,
    PWGTP13::VARCHAR,
    PWGTP14::VARCHAR,
    PWGTP15::VARCHAR,
    PWGTP16::VARCHAR,
    PWGTP17::VARCHAR,
    PWGTP18::VARCHAR,
    PWGTP19::VARCHAR,
    PWGTP20::VARCHAR,
    PWGTP21::VARCHAR,
    PWGTP22::VARCHAR,
    PWGTP23::VARCHAR,
    PWGTP24::VARCHAR,
    PWGTP25::VARCHAR,
    PWGTP26::VARCHAR,
    PWGTP27::VARCHAR,
    PWGTP28::VARCHAR,
    PWGTP29::VARCHAR,
    PWGTP30::VARCHAR,
    PWGTP31::VARCHAR,
    PWGTP32::VARCHAR,
    PWGTP33::VARCHAR,
    PWGTP34::VARCHAR,
    PWGTP35::VARCHAR,
    PWGTP36::VARCHAR,
    PWGTP37::VARCHAR,
    PWGTP38::VARCHAR,
    PWGTP39::VARCHAR,
    PWGTP40::VARCHAR,
    PWGTP41::VARCHAR,
    PWGTP42::VARCHAR,
    PWGTP43::VARCHAR,
    PWGTP44::VARCHAR,
    PWGTP45::VARCHAR,
    PWGTP46::VARCHAR,
    PWGTP47::VARCHAR,
    PWGTP48::VARCHAR,
    PWGTP49::VARCHAR,
    PWGTP50::VARCHAR,
    PWGTP51::VARCHAR,
    PWGTP52::VARCHAR,
    PWGTP53::VARCHAR,
    PWGTP54::VARCHAR,
    PWGTP55::VARCHAR,
    PWGTP56::VARCHAR,
    PWGTP57::VARCHAR,
    PWGTP58::VARCHAR,
    PWGTP59::VARCHAR,
    PWGTP60::VARCHAR,
    PWGTP61::VARCHAR,
    PWGTP62::VARCHAR,
    PWGTP63::VARCHAR,
    PWGTP64::VARCHAR,
    PWGTP65::VARCHAR,
    PWGTP66::VARCHAR,
    PWGTP67::VARCHAR,
    PWGTP68::VARCHAR,
    PWGTP69::VARCHAR,
    PWGTP70::VARCHAR,
    PWGTP71::VARCHAR,
    PWGTP72::VARCHAR,
    PWGTP73::VARCHAR,
    PWGTP74::VARCHAR,
    PWGTP75::VARCHAR,
    PWGTP76::VARCHAR,
    PWGTP77::VARCHAR,
    PWGTP78::VARCHAR,
    PWGTP79::VARCHAR,
    PWGTP80::VARCHAR,
FROM read_csv('/Users/me/data/american_community_survey/2022/1-Year/csv_pla/psam_p22.csv', 
              parallel=False,
              all_varchar=True,
              auto_detect=True)