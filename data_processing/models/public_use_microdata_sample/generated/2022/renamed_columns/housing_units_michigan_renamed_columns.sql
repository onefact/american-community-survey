-- SQL transformation for psam_h26.csv generated by generate_sql_with_renamed_columns.py
{{ config(materialized='external', location=var('output_path') + '/housing_units_michigan.parquet') }}
SELECT
    RT AS "Record Type",
    SERIALNO AS "Housing unit/GQ person serial number",
    DIVISION AS "Division code based on 2010 Census definitions Division code based on 2020 Census definitions",
    PUMA AS "Public use microdata area code (PUMA) based on 2020 Census definition (areas with population of 100,000 or more, use with ST for unique code)",
    REGION AS "Region code based on 2020 Census definitions",
    ST AS "State Code based on 2020 Census definitions",
    ADJHSG AS "Adjustment factor for housing dollar amounts (6 implied decimal places)",
    ADJINC AS "Adjustment factor for income and earnings dollar amounts (6 implied decimal places)",
    WGTP AS "Housing Unit Weight",
    NP AS "Number of persons in this household",
    TYPEHUGQ AS "Type of unit",
    ACCESSINET AS "Access to the Internet",
    ACR AS "Lot size",
    AGS AS "Sales of Agriculture Products (yearly sales, no adjustment factor is applied)",
    BATH AS "Bathtub or shower",
    BDSP AS "Number of bedrooms",
    BLD AS "Units in structure",
    BROADBND AS "Cellular data plan for a smartphone or other mobile device",
    COMPOTHX AS "Other computer equipment",
    CONP AS "Condominium fee (monthly amount, use ADJHSG to adjust CONP to constant dollars)",
    DIALUP AS "Dial-up service",
    ELEFP AS "Electricity cost flag variable",
    ELEP AS "Electricity cost (monthly cost, use ADJHSG to adjust ELEP to constant dollars)",
    FS AS "Yearly food stamp/Supplemental Nutrition Assistance Program (SNAP) recipiency",
    FULFP AS "Fuel cost flag variable",
    FULP AS "Fuel cost (yearly cost for fuels other than gas and electricity, use ADJHSG to adjust FULP to constant dollars)",
    GASFP AS "Gas cost flag variable",
    GASP AS "Gas cost (monthly cost, use ADJHSG to adjust GASP to constant dollars)",
    HFL AS "House heating fuel",
    HISPEED AS "Broadband (high speed) Internet service such as cable, fiber optic, or DSL service",
    HOTWAT AS "Water heater (Puerto Rico only)",
    INSP AS "Fire/hazard/flood insurance (yearly amount, use ADJHSG to adjust INSP to constant dollars)",
    LAPTOP AS "Laptop or desktop",
    MHP AS "Mobile home costs (yearly amount, use ADJHSG to adjust MHP to constant dollars)",
    MRGI AS "First mortgage payment includes fire/hazard/flood insurance",
    MRGP AS "First mortgage payment (monthly amount, use ADJHSG to adjust MRGP to constant dollars)",
    MRGT AS "First mortgage payment includes real estate taxes",
    MRGX AS "First mortgage status",
    OTHSVCEX AS "Other Internet service",
    REFR AS "Refrigerator",
    RMSP AS "Number of rooms",
    RNTM AS "Meals included in rent",
    RNTP AS "Monthly rent (use ADJHSG to adjust RNTP to constant dollars)",
    RWAT AS "Hot and cold running water",
    RWATPR AS "Running water",
    SATELLITE AS "Satellite Internet service",
    SINK AS "Sink with a faucet",
    SMARTPHONE AS "Smartphone",
    SMP AS "Total payment on all second and junior mortgages and home equity loans (monthly amount, use ADJHSG to adjust SMP to constant dollars)",
    STOV AS "Stove or range",
    TABLET AS "Tablet or other portable wireless computer",
    TEL AS "Telephone service",
    TEN AS "Tenure",
    VACDUR AS "Vacancy duration",
    VACOTH AS "Other vacancy status",
    VACS AS "Vacancy status",
    VALP AS "Property value",
    VEH AS "Vehicles (1 ton or less) available",
    WATFP AS "Water cost flag variable",
    WATP AS "Water cost (yearly cost, use ADJHSG to adjust WATP to constant dollars)",
    YRBLT AS "When structure first built",
    CPLT AS "Couple Type",
    FINCP AS "Family income (past 12 months, use ADJINC to adjust FINCP to constant dollars)",
    FPARC AS "Family presence and age of related children",
    GRNTP AS "Gross rent (monthly amount, use ADJHSG to adjust GRNTP to constant dollars)",
    GRPIP AS "Gross rent as a percentage of household income past 12 months",
    HHL AS "Household language",
    HHLANP AS "Detailed household language",
    HHLDRAGEP AS "Age of the householder",
    HHLDRHISP AS "Recoded detailed Hispanic origin of the householder",
    HHLDRRAC1P AS "Recoded detailed race code of the householder",
    HHT AS "Household/family type",
    HHT2 AS "Household/family type (includes cohabiting)",
    HINCP AS "Household income (past 12 months, use ADJINC to adjust HINCP to constant dollars)",
    HUGCL AS "Household with grandparent living with grandchildren",
    HUPAC AS "HH presence and age of children",
    HUPAOC AS "HH presence and age of own children",
    HUPARC AS "HH presence and age of related children",
    KIT AS "Complete kitchen facilities",
    LNGI AS "Limited English speaking household",
    MULTG AS "Multigenerational household",
    MV AS "When moved into this house or apartment",
    NOC AS "Number of own children in household (unweighted)",
    NPF AS "Number of persons in family (unweighted)",
    NPP AS "Grandparent headed household with no parent present",
    NR AS "Presence of nonrelative in household",
    NRC AS "Number of related children in household (unweighted)",
    OCPIP AS "Selected monthly owner costs as a percentage of household income during the past 12 months",
    PARTNER AS "Unmarried partner household",
    PLM AS "Complete plumbing facilities",
    PLMPRP AS "Complete plumbing facilities for Puerto Rico",
    PSF AS "Presence of subfamilies in household",
    R18 AS "Presence of persons under 18 years in household (unweighted)",
    R60 AS "Presence of persons 60 years and over in household (unweighted)",
    R65 AS "Presence of persons 65 years and over in household (unweighted)",
    RESMODE AS "Response mode",
    SMOCP AS "Selected monthly owner costs (use ADJHSG to adjust SMOCP to constant dollars)",
    SMX AS "Second or junior mortgage or home equity loan status",
    SRNT AS "Specified rental unit",
    SVAL AS "Specified owner unit",
    TAXAMT AS "Property taxes (yearly real estate taxes)",
    WIF AS "Workers in family during the past 12 months",
    WKEXREL AS "Work experience of householder and spouse",
    WORKSTAT AS "Work status of householder or spouse in family households",
    FACCESSP AS "Access to the Internet allocation flag",
    FACRP AS "Lot size allocation flag",
    FAGSP AS "Sales of Agricultural Products allocation flag",
    FBATHP AS "Bathtub or shower allocation flag",
    FBDSP AS "Number of bedrooms allocation flag",
    FBLDP AS "Units in structure allocation flag",
    FBROADBNDP AS "Cellular data plan for a smartphone or other mobile device allocation flag",
    FCOMPOTHXP AS "Other computer equipment allocation flag",
    FCONP AS "Condominium fee (monthly amount) allocation flag",
    FDIALUPP AS "Dial-up service allocation flag",
    FELEP AS "Electricity cost (monthly cost) allocation flag",
    FFINCP AS "Family income (past 12 months) allocation flag",
    FFSP AS "Yearly food stamp/Supplemental Nutrition Assistance Program (SNAP) recipiency allocation flag",
    FFULP AS "Fuel cost (yearly cost for fuels other than gas and electricity) allocation flag",
    FGASP AS "Gas cost (monthly cost) allocation flag",
    FGRNTP AS "Gross rent (monthly amount) allocation flag",
    FHFLP AS "House heating fuel allocation flag",
    FHINCP AS "Household income (past 12 months) allocation flag",
    FHISPEEDP AS "Broadband (high speed) Internet service such as cable, fiber optic, or DSL service allocation flag",
    FHOTWATP AS "Water heater allocation flag (Puerto Rico only)",
    FINSP AS "Fire, hazard, flood insurance (yearly amount) allocation flag",
    FKITP AS "Complete kitchen facilities allocation flag",
    FLAPTOPP AS "Laptop or desktop allocation flag",
    FMHP AS "Mobile home costs (yearly amount) allocation flag",
    FMRGIP AS "First mortgage payment includes fire, hazard, flood insurance allocation flag",
    FMRGP AS "First mortgage payment (monthly amount) allocation flag",
    FMRGTP AS "First mortgage payment includes real estate taxes allocation flag",
    FMRGXP AS "First mortgage status allocation flag",
    FMVP AS "When moved into this house or apartment allocation flag",
    FOTHSVCEXP AS "Other Internet service allocation flag",
    FPLMP AS "Complete plumbing facilities allocation flag",
    FPLMPRP AS "Complete plumbing facilities allocation flag for Puerto Rico",
    FREFRP AS "Refrigerator allocation flag",
    FRMSP AS "Number of rooms allocation flag",
    FRNTMP AS "Meals included in rent allocation flag",
    FRNTP AS "Monthly rent allocation flag",
    FRWATP AS "Hot and cold running water allocation flag",
    FRWATPRP AS "Running water allocation flag for Puerto Rico",
    FSATELLITEP AS "Satellite Internet service allocation flag",
    FSINKP AS "Sink with a faucet allocation flag",
    FSMARTPHONP AS "Smartphone allocation flag",
    FSMOCP AS "Selected monthly owner cost allocation flag",
    FSMP AS "Total payment on second and junior mortgages and home equity loans (monthly amount) allocation flag",
    FSMXHP AS "Home equity loan status allocation flag",
    FSMXSP AS "Second mortgage status allocation flag",
    FSTOVP AS "Stove or range allocation flag",
    FTABLETP AS "Tablet or other portable wireless computer allocation flag",
    FTAXP AS "Property taxes (yearly amount) allocation flag",
    FTELP AS "Telephone service allocation flag",
    FTENP AS "Tenure allocation flag",
    FVACDURP AS "Vacancy duration allocation flag",
    FVACOTHP AS "Other vacancy allocation flag",
    FVACSP AS "Vacancy status allocation flag",
    FVALP AS "Property value allocation flag",
    FVEHP AS "Vehicles available allocation flag",
    FWATP AS "Water cost (yearly cost) allocation flag",
    FYRBLTP AS "When structure first built allocation flag",
    WGTP1 AS "Housing Weight replicate 1",
    WGTP2 AS "Housing Weight replicate 2",
    WGTP3 AS "Housing Weight replicate 3",
    WGTP4 AS "Housing Weight replicate 4",
    WGTP5 AS "Housing Weight replicate 5",
    WGTP6 AS "Housing Weight replicate 6",
    WGTP7 AS "Housing Weight replicate 7",
    WGTP8 AS "Housing Weight replicate 8",
    WGTP9 AS "Housing Weight replicate 9",
    WGTP10 AS "Housing Weight replicate 10",
    WGTP11 AS "Housing Weight replicate 11",
    WGTP12 AS "Housing Weight replicate 12",
    WGTP13 AS "Housing Weight replicate 13",
    WGTP14 AS "Housing Weight replicate 14",
    WGTP15 AS "Housing Weight replicate 15",
    WGTP16 AS "Housing Weight replicate 16",
    WGTP17 AS "Housing Weight replicate 17",
    WGTP18 AS "Housing Weight replicate 18",
    WGTP19 AS "Housing Weight replicate 19",
    WGTP20 AS "Housing Weight replicate 20",
    WGTP21 AS "Housing Weight replicate 21",
    WGTP22 AS "Housing Weight replicate 22",
    WGTP23 AS "Housing Weight replicate 23",
    WGTP24 AS "Housing Weight replicate 24",
    WGTP25 AS "Housing Weight replicate 25",
    WGTP26 AS "Housing Weight replicate 26",
    WGTP27 AS "Housing Weight replicate 27",
    WGTP28 AS "Housing Weight replicate 28",
    WGTP29 AS "Housing Weight replicate 29",
    WGTP30 AS "Housing Weight replicate 30",
    WGTP31 AS "Housing Weight replicate 31",
    WGTP32 AS "Housing Weight replicate 32",
    WGTP33 AS "Housing Weight replicate 33",
    WGTP34 AS "Housing Weight replicate 34",
    WGTP35 AS "Housing Weight replicate 35",
    WGTP36 AS "Housing Weight replicate 36",
    WGTP37 AS "Housing Weight replicate 37",
    WGTP38 AS "Housing Weight replicate 38",
    WGTP39 AS "Housing Weight replicate 39",
    WGTP40 AS "Housing Weight replicate 40",
    WGTP41 AS "Housing Weight replicate 41",
    WGTP42 AS "Housing Weight replicate 42",
    WGTP43 AS "Housing Weight replicate 43",
    WGTP44 AS "Housing Weight replicate 44",
    WGTP45 AS "Housing Weight replicate 45",
    WGTP46 AS "Housing Weight replicate 46",
    WGTP47 AS "Housing Weight replicate 47",
    WGTP48 AS "Housing Weight replicate 48",
    WGTP49 AS "Housing Weight replicate 49",
    WGTP50 AS "Housing Weight replicate 50",
    WGTP51 AS "Housing Weight replicate 51",
    WGTP52 AS "Housing Weight replicate 52",
    WGTP53 AS "Housing Weight replicate 53",
    WGTP54 AS "Housing Weight replicate 54",
    WGTP55 AS "Housing Weight replicate 55",
    WGTP56 AS "Housing Weight replicate 56",
    WGTP57 AS "Housing Weight replicate 57",
    WGTP58 AS "Housing Weight replicate 58",
    WGTP59 AS "Housing Weight replicate 59",
    WGTP60 AS "Housing Weight replicate 60",
    WGTP61 AS "Housing Weight replicate 61",
    WGTP62 AS "Housing Weight replicate 62",
    WGTP63 AS "Housing Weight replicate 63",
    WGTP64 AS "Housing Weight replicate 64",
    WGTP65 AS "Housing Weight replicate 65",
    WGTP66 AS "Housing Weight replicate 66",
    WGTP67 AS "Housing Weight replicate 67",
    WGTP68 AS "Housing Weight replicate 68",
    WGTP69 AS "Housing Weight replicate 69",
    WGTP70 AS "Housing Weight replicate 70",
    WGTP71 AS "Housing Weight replicate 71",
    WGTP72 AS "Housing Weight replicate 72",
    WGTP73 AS "Housing Weight replicate 73",
    WGTP74 AS "Housing Weight replicate 74",
    WGTP75 AS "Housing Weight replicate 75",
    WGTP76 AS "Housing Weight replicate 76",
    WGTP77 AS "Housing Weight replicate 77",
    WGTP78 AS "Housing Weight replicate 78",
    WGTP79 AS "Housing Weight replicate 79",
    WGTP80 AS "Housing Weight replicate 80"
FROM read_csv_auto('/Users/me/data/american_community_survey/2022/1-Year/csv_hmi/psam_h26.csv')