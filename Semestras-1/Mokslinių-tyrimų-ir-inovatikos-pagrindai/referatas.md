(juodraštis)

Planuojama iš peržvelgtųjų šaltinių – Cisco srautų prognozės ataskaitos [1.2], straipsnių [1.3-1.8] ir daktarinės disertacijos [1.9] ištraukti rastus 5G NR detalius skirtumus 4G LTE atžvilgiu ir juos apibendrinti. 
Pagrindinis dėmesys skiriamas augantiems ir ateityje augsiantiems [1.2] UE srautams.

# 1. Kodėl 4G neužtenka

`4G LTE` yra labai pajėgi technologija (ir tebėra vystoma lygiagrečiai `5G NR`).
Tačiau kai kurių reikalavimų nepajėgi nei dabartinė LTE implementacija, nei jos naujos revizijos. [1.1]
Be to, nuo LTE specifikacijos pasirodymo praėjo jau 10 metų, per kuriuos atsirado ganėtinai pažengusių technologijų.

5G NR technologija pradėta kurti tiek norint išnaudoti pastarųjų potencialą, tiek ir patenkinti naujus, platesnius reikalavimus. 
Be to, atkrinta reikalavimas išlaikyti suderinamumą su 4G LTE.
Ir nors NR daug komponentų perima iš LTE bei geba dalį jos infrastruktūros išnaudoti savo pirminei įrengimo stadijai, visos aukščiau išvardintos aplinkybės (ypač NR kelti aukštesni reikalavimai) paskatino imtis kitokių techninių sprendimų.

![image](https://user-images.githubusercontent.com/74717106/100879529-369dc900-34b4-11eb-93a5-cb49377ed09a.png)  
`1.1 pav. Integralus radijo prieigos sprendimas pereinamuoju LTE ir NR vystymo laikotarpiu.`

## 1.1. LTE trūksta pralaidumo

Scenarijus: kiekvienas gyventojas plašetėje žiūri Netflix aukšta raiška.  
[1.2]  
[1.9]  

## 1.2. LTE perduodama gana apribotą video srautą

[1.j] Big Video Bright Future | ZTE Big Video white paper, **August 2016**  
    https://res-www.zte.com.cn/mediares/zte/Files/PDF/White-Skin-Book/2016big_video/ZTE_Big_Video_White_Paper0818.pdf

## 1.x. LTE neatsparus tam tikroms atakoms (fizinio ryšio saugumo klausimai)

[1.k] Securing authentication for mobile networks, a survey on 4G issues and 5G answers, **July 2018**  
    https://ieeexplore.ieee.org/abstract/document/8401619  
    
[1.l] A Study of 4G Network for Security System, **November, 2015**  
    https://www.koreascience.or.kr/article/JAKO201502152089243.pdf  
    
[1.n] Overview of 5G Security and Vulnerabilities, **Spring 2020**
    https://cyberdefensereview.army.mil/Portals/6/Documents/CyConUS19%20ConferencePapers/Overview_of_5G_Security_and_Vulnerabilities.pdf?ver=2019-11-14-085032-807  
    https://cyberdefensereview.army.mil/Portals/6/CDR%20V5N1%20-%2008_%20Fonyi_WEB.pdf
    https://cyberdefensereview.army.mil/Portals/6/CDR%20V5N1%20-%20FULL_WEB.pdf
    
[1.m] The current state of affairs in 5G security and the main remaining security challenges, **April 2019**  
    https://arxiv.org/abs/1904.08394  
    http://rogerpiquerasjover.net/5G_ShmooCon_FINAL.pdf#page=8  

## 1.y. C-RAN architektūra nėra optimizuota LTE tinkluose

`C-RAN` architektūra (apibendrinanti dviejų angl. terminų `Centralized-RAN` ir `Cloud-RAN` santrumpa)
leistų dalį įprastinės bazinės stoties funkcionalumo, `BBU` {Baseband Unit} iš bokšto perkelti į nuotolinį mazgą [1.w].
Taip bokšte liktų tik dalis įrangos, kurios funkcionalumas yra artimiausias radijo eteriui.
`5G NR` ryšyje ji dar vadinama `RRH` {Remote Radio Heads}.
Atsiranda galimybė dalį RAN tinklo konsoliduoti įprastiniuose duomenų centruose.

Žinoma, toks sprendimas be privalumų turi ir trūkumų.
Taupoma energija stočiai maitinti ir užtenka mažesnio ploto.
Tačiau prireikia beprotiškai didelio pralaidumo priešakinėje magistralėje (angl. `Fronthaul`).
Kraštutinis 2016 m. pavyzdys iškėlus visas `BBU` funkcijas iš `BS` į debesį [1.w]: 75 Mbps `UE` srautas sukurs 1 Gbps srautą priešakinėje magistralėje.
Naujesnė, 2020 m. ataskaita mini 10 kartų srauto padidėjimą priešakinėje magistralėje lyginant su srautu transmisijos tinkle (angl. `Backhaul`), kurio prireiktų naudojant klasikinę LTE architektūrą. [1.v]

Be to, ne per daugiausiai nukrenta bazinės stoties kaina, mat joje liekanti įranga sudėtingėja dėl pasikeitusios komunikacijos su iškeltaja įrangos dalimi.
Taip pat žymiai brangesnis varinių priešakinės magistralės kabelių keitimas į optinius lyginant su kabelių keitimu transmisijoje. [1.u]

![image](https://user-images.githubusercontent.com/74717106/101022192-b6419b80-3579-11eb-90db-8fdc625aa37d.png)  
`1.b pav. Centralize-RAN architektūra: priešakinė magistralė ir transmisijos tinklas.` [1.v]

Prieaškinės magistralės atnaujinimas bus būtinas visose bazinėse stotyse, kuriose tai nebuvo atlikta paleidžiant LTE:

![image](https://user-images.githubusercontent.com/74717106/101021464-9f4e7980-3578-11eb-992d-e0fb003018e6.png)  
`1.c pav. Tradicinio mob. ryšio bokšto sandara su koaksialiniais vario kabeliais` [1.v]

Taip pat `C-RAN` sukelia ir programinius iššūkius valdant nuotolinius `BBU`. [1.s]
Pvz. duomenų centrų virtualizavimo technologijos grįstos resursų dalinimusi ir paskirstytuoju apdorojimu.
Gi `BBU` apkrova yra dinamiška ir realiame laike turi kisti staigiai, nes aptarnaujamų ryšio celių aktyvumas visą laiką kinta.
Ir ganėtinai skiriasi nuo duomenų centro scenarijaus.

Todėl C-RAN debesų architektūra turi būti kitokia ir irgi reikalauja tobulinimų.

`TODO`, skirtingi BS splitų tipai.

C-RAN architektūra naudojama teoriškai jau nuo `3G`, bet praktiškai paplito tik 4G LTE tinkluose.
Tačiau ji nėra visiškai išbaigta: vyksta jos tyrinėjimai, optimizavimas ir kiti tobulinimo darbai. [1.t]
Laikoma, kad būtent dėl 5G NR poreikių (didelio pralaidumo, mažos delsos) ir prasidėjusio įjungimo stipriai pasistūmės C-RAN masinis diegimas. [1.v]

[1.w] Impact of packetization and functional split on C-RAN fronthaul performance, **May 2016**  
    [https://ieeexplore.ieee.org/document/7511579]

[1.v] C-RAN Market Size, Share & Trends Analysis Report By Architecture Type (Centralized-RAN, Virtual/Cloud-RAN), By Component, By Network Type, By Deployment Model, And Segment Forecasts, 2020 - 2027, **February 2020**  
    https://www.grandviewresearch.com/industry-analysis/cloud-ran-market

[1.u] Understanding the Basics of CPRI Fronthaul Technology, **February 2015**  
    http://www.equicom.hu/wp-content/uploads/EXFO_anote310_Understanding-Basics-CPRI-Fronthaul-Technology_en.pdf
    
[1.t] Resource Management in Cloud Radio Access Network: Conventional and New Approaches, **May 2020**
    https://res.mdpi.com/d_attachment/sensors/sensors-20-02708/article_deploy/sensors-20-02708.pdf
    
[1.s] Cloud RAN: Basics, Advances and Challenges, **April 2016**
    https://www.cse.wustl.edu/~jain/cse574-16/ftp/cloudran.pdf

## 1.z. Neišpopuliarėjusi LTE + WLAN konvergencija

[Kam skirta?]

`3GPP` organizacija `4G LTE` specifikacijoje buvo numačiusi galimybę apjungti LTE ir WLAN (populiariai kalbant Wi-Fi).
Taip būtų sukuriamas heterogeninis radijo tinklas.
Specifikacijos `Release-13` aprašytos dvi technologijos:
[https://www.3gpp.org/images/PDF/2016_03_LWA_LWIP_3GPPpresentation.pdf]
* LWA {angl. LTE-WLAN aggregation} technologija.
* LWIP {LTE WLAN Radio Level Integration with IPsec Tunnel}

[papaišom pavyzdžių, diagramų apie tai, kaip veikia?]  
[https://www.5gamericas.org/wp-content/uploads/2019/07/4G_Americas_LTE_Aggregation__Unlicensed_Spectrum_White_Paper_-_November_2015.pdf]  
[https://ecfsapi.fcc.gov/file/60001076664.pdf]  **2015**
[https://www.commscope.com/globalassets/digizuite/1084-1074-senzafili-laa-ruckus.pdf]  **2015**
[ZTE2016]  

Šios dvi technologijos dar tobulinamos, bet tik ta prasme, kad jų pagrindu kuriami nauji atšakojimai:

* SDN-assisted efficient LTE-WiFi aggregation in next generation IoT networks, **June 2020**
  [https://www.sciencedirect.com/science/article/abs/pii/S0167739X17310907]  

* [https://scholar.google.lt/scholar?hl=lt&as_sdt=0%2C5&q=LWIP+LTE&btnG=]  
* [https://scholar.google.lt/scholar?hl=lt&as_sdt=0%2C5&q=LWA+LTE&btnG=]  

Tačiau nei šios dvi, nei apskritai kitos technologijos, skirtos mobiliojo ryšio ir nelicencinio radijo spektro (2,4 GHz ir 5 GHz) apjungimui (sukurtos tiek `3GPP`, tiek kitų organizacijų) nebuvo plačiai įgyvendintos ir kasdieniniam naudojimui nepaplito.  

Taip teigia Olandijos IKT {informacijos ir ryšių technologijų, angl. ICT, Information and Communication Technologies} švietimo ir tyrimų asociacija SURF {olan. Samenwerkende Universitaire RekenFaciliteiten} kartu su Olandijos IKT tyrimų bendrove Stratix jų bendroje ataskaitoje apie galimybes panaudoti 4G ir 5G vien patalpose.  
[https://www.surf.nl/files/2019-07/rapport_mobiele_technologie_op_de_campus_1.0.pdf#page=29:~:text=Geen%20van%20deze,toepassingen,%20ook%20Multefire,%20lijken%20succesvol%20te%20zijn] **April 2019**

[https://www.surf.nl/en/research-ict]  
[https://www.stratix.nl/over-ons/]  

Pažymima, kad tiek pas čipų gamintojus Intel, Ericsson, Nokia ir Qualcomm, tiek ir mob. telefonų gamintojus šių technologijų palaikymas ir net implementacijos atsilieka nuo kasdienybės.  
[https://ec.europa.eu/regional_policy/lt/policy/themes/ict/]  
[https://e-seimas.lrs.lt/rs/legalact/TAK/07fd9f6035b711e98893d5af47354b00/format/ISO_PDF/]  
[https://ivpk.lrv.lt/lt/naujienos/inovaciju-link-informacijos-ir-rysiu-technologijos-7-joje-bendrojoje-programoje]  

[Paminim Multefire su Samsungu?]  
[https://www.multefire.org/technology/specifications/]  

Ataskaitos autoriai neaptiko paaiškinimų, kodėl taip nutikę, tik spekuliacijas.
Jie spėja, kad apskritai visų nelicencinio spektro agregavimo technologijų vėlavimo priežastis yra per mažas rinkos poreikis.
Grindžiama tuo, kad beveik visos pagrindinės telekomunikacinės bendrovės nedalyvauja aljansuose, remiančiuose šias technologijas.

[Pavardiname aljansus?]

`5Genesis` konsorciumo 2019 m. „5G standartizavimo ir reguliavimo“ ataskaitoje D7.5 teigiama, kad `3GPP` pateiktos `4G LTE` specifikacijos kitų radijo technologijų agregavimo temą paliečia tik iš dalies, ir `5G NR` atveju nėra išsamios apskritai.  
[https://5genesis.eu/wp-content/uploads/2019/08/5GENESIS_D7.5-_v1.0.pdf] **July 29th, 2019**

[https://www.rcrwireless.com/20150625/network-infrastructure/wi-fi/lwa-logical-wireless-alternative-tag4]

Rašant referatą rasti tik keli sėkmingi ar bent jau planuoti įdiegimai:

* 2017 m. vasaros pr. Singapūre, pas ryšio tiekėją "M1" [https://web.archive.org/web/20160920143843/https://www.m1.com.sg/AboutM1/NewsReleases/2016/M1%20Nokia%20announce%20Singapore%20first%20commercial%20nationwide%20HetNet%20rollout.aspx] **19 August 2016**  
[http://www.gtigroup.org/news/ind/2016-08-22/9257.html] **22 August 2016**
* 2017 m. vasario 23 d. Kinijoje, pas ryšio tiekėją "Chunghwa Telecom" [http://digitimes.com/news/a20170220PD201.html] **21 February 2017**

Iš vėlesnių diegimų pavyko aptikti tik "Athens Technology Center S.A." (ATC) atliktą `4G LTE` agreguoto tinklo tyrimą projektui Fed4FIRE+:
[https://fed4fire.eu/wp-content/uploads/sites/10/2019/09/f4fp-02-stage2-06-report-f4f-lwa-athens-tc.pdf] **September 2018**

Ataskaitoje pastebima, kad `LWA` ir jos naudojamas signalizacijos protokolas `LWAAP` nepalaiko `Split` architektūros bazinėje stotyje (`RAN` viduje).

Šis funkcionalumas `5G NR` technologijai yra kertinis.

Graikijos bendrovės ATC atlikti mobiliojo ryšio agregavimo tyrimai iliustruoja `4G LTE` trūkumus šioje srityje ir eksperimentų keliu atskleidžia praktiškus būdus efektyviai agreguoti radijo tinklus `5G NR` atvejui.

O "Global mobile Suppliers Association" 2020 m. vidurio ataskaitoje teigė, kad šių technologijų vystymas sustojo.  
[https://gsacom.com/paper/5g-lte-in-unlicensed-spectrum-august-2020/#:~:text=development%20of%20the%20technology%20ecosystems%20around%20LTE-U%20and%20LWA%20have%20stalled] **August 2020**

`5G NR` gaires brėžiantis `IMT-2020` standartas numato lankstesnius ir net efektyvesnius RAN ir WLAN apjungimo scenarijus.
`TODO`  
[https://www.itu.int/dms_pub/itu-t/opb/tut/T-TUT-IMT-2017-2020-PDF-E.pdf#page=29]  

# Skyriaus santrumpos

| Santrumpa | Pilnas terminas                                                                                                                                    | 
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------| 
| LWA       | angl. LTE-WLAN aggregation                                                                                                                         | 

# Literatūra:

 [1.1] 5G NR: The Next Generation Wireless Access Technology, **2018**  
       https://www.elsevier.com/books/5g-nr-the-next-generation-wireless-access-technology/dahlman/978-0-12-814323-0  

 [1.2] Cisco Annual Internet Report (2018–2023), **March 2020**  
       https://www.cisco.com/c/en/us/solutions/executive-perspectives/annual-internet-report/index.html  
       https://www.cisco.com/c/en/us/solutions/executive-perspectives/annual-internet-report/infographic-c82-741491.html  
       https://www.cisco.com/c/en/us/solutions/collateral/executive-perspectives/annual-internet-report/white-paper-c11-741490.pdf  

 [1.3] Slice architecture for 5G core network, **July 2017**  
       https://ieeexplore.ieee.org/abstract/document/7993854  

 [1.4] Impact of network slicing on 5G Radio Access Networks, **June 2016**  
       https://ieeexplore.ieee.org/abstract/document/7561023  

 [1.5] What Will 5G Be? **June 2014**  
       https://ieeexplore.ieee.org/abstract/document/6824752  

 [1.6] On the Waveform for 5G, **November 2016**  
       https://ieeexplore.ieee.org/abstract/document/7744813  

 [1.7] Revolutionary direction for 5G mobile core network architecture, **December 2016**  
       https://ieeexplore.ieee.org/abstract/document/7763350  

 [1.8] Intelligence and security in big 5G-oriented IoNT: An overview, **January 2020**  
       https://www.sciencedirect.com/science/article/abs/pii/S0167739X19301074  

 [1.9] Destination-based Routing and Circuit Allocation for Future Traffic Growth, **2020**  
       https://books.google.lt/books/about/Destination_based_Routing_and_Circuit_Al.html?id=z6J3zQEACAAJ
