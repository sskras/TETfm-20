# 1. Kodėl 4G neužtenka

4G LTE yra labai pajėgi technologija (ir tebėra vystoma lygiagrečiai 5G NR).
Tačiau kai kurių reikalavimų patenkinti nepajėgi nei dabartinė LTE implementacija, nei jos naujos revizijos. [1]
Be to, nuo LTE specifikacijos pasirodymo praėjo jau 10 metų, per kuriuos atsirado ganėtinai pažengusių technologijų.

5G NR technologija pradėta kurti tiek norint išnaudoti pastarųjų potencialą, tiek ir patenkinti naujus, platesnius reikalavimus. 
Be to, atkrinta reikalavimas išlaikyti suderinamumą su 4G LTE.
Ir nors NR daug komponentų perima iš LTE bei geba dalį jos infrastruktūros išnaudoti savo pirminei įrengimo stadijai, visos aukščiau išvardintos aplinkybės (ypač NR kelti aukštesni reikalavimai) paskatino imtis kitokių techninių sprendimų.

![image](https://user-images.githubusercontent.com/74717106/100879529-369dc900-34b4-11eb-93a5-cb49377ed09a.png)  
`1 pav. Integralus radijo prieigos sprendimas pereinamuoju LTE ir NR vystymo laikotarpiu.` [1]

## LTE trūksta pralaidumo

Pagrindinis argumentas, kad nepakanka 4G LTE ryšio – augantys ir ateityje augsiantys UE duomenų srautai.
Cisco bendrovė savo kasmetinėje Interneto augimo ataskaitoje [2] prognozuoja, kad 4G LTE augimas pradedant 2021 ims truputį lėtėti:

![image](https://user-images.githubusercontent.com/74717106/101078210-81037080-35ae-11eb-9b3e-16f1a5451e69.png)  
`TODO pav. Pasaulinis mobiliųjų įrenginių ir jungčių augimas` [2]

O judriojo ryšio abonentų skaičiui numatomas tiesinis augimas:
![image](https://user-images.githubusercontent.com/74717106/101078730-3b937300-35af-11eb-968c-7668eed43f72.png)
`TODO pav. Pasaulinis judriojo ryšio abonentų skaičiaus augimas` [2]

Taip pat numatomas tiesinis ir tokių įrenginių spartos augimas:
![image](https://user-images.githubusercontent.com/74717106/101080752-d725e300-35b1-11eb-9d76-cde25d78f13d.png)  
`TODO pav. Pasaulinis judriojo ryšio įrenginių spartos augimas` [2]

Gi M2M (angl. Machine to Machine, mašinų komunikacijos su mašinomis) srautams nuo 2021 m. prognozuojamas net šiek tiek geometrinis augimas:
![image](https://user-images.githubusercontent.com/74717106/101078568-0850e400-35af-11eb-90d9-69676c5c178d.png)  
`TODO pav. Pasaulinis judriojo M2M srauto augimas` [2]

Natūralu, kad televizijai persikeliant į interneto platformas (pvz. Netflix), dažnas gyventojas įpranta žiūrėti video internetu.
Bendrovė ZTE prognozuoja 8K raiškos vaizdų įsigalėjimą nuo 2021 m.:

![image](https://user-images.githubusercontent.com/74717106/101082176-b78fba00-35b3-11eb-832a-534475038197.png)  
`TODO pav. Video paslaugų vystymosi prognoze 2015–2025 m.` [4]
 
O augantis judriojo ryšio įrenginių ir abonentų skaičius bei dabartinė judriojo ryšio sparta su minimais prognozavimais perša išvada, kad vis daugiau gyventojų šiuose įrenginiuose sieks aukštos raiškos vaizdo (bent jau 4K ar FHD, angl. Full High Definition), bet 4G LTE to nebespės užtikrinti.

## Architektūriniai stuburinio tinklo (EPC) trūkumai

4G LTE architektūroje stuburinis tinklas EPC atlieka labai svarbų vaidmenį (aprašomas penktame skyriuje).
Per jį keliauja visi naudotojų duomenys.

Tačiau planuojant keliaropai paspartinti ryšį išryškėjo esminiai architektūriniai trūkumai. 
Siauriausia EPC vieta pasirodė esant centralizuotas IP srauto maršrutizavimas [3].
Taip pat prisideda MME (Mobilumo valdymo subjektas), kurio ryšis su S-GW (Pristatančiu tinklų sietuvu) yra statinis ir prisideda prie neefektaus IP srauto kelio (4/1 pav.)

5G NR šį trūkumą turėjo pašalinti. Stuburinio tinklo architektūra yra daug lankstesnė (16/1 pav.).
Ji įgalina dinamiškus ryšius tarp MME atitikmens AMF (angl. Access and Mobility Management Function) ir 5GGW (angl. 5G Gateway), šitaip prisidėdama 5G tinklo dalinimo technologijos (pastaroji aprašoma šeštame skyriuje).

## C-RAN architektūra LTE tinkluose nėra pakankamai optimizuota

C-RAN architektūra (apibendrinanti dviejų angl. terminų Centralized-RAN ir Cloud-RAN santrumpa)
leistų dalį įprastinės bazinės stoties funkcionalumo, BBU {Baseband Unit} iš stoties perkelti į nuotolinį mazgą [5].
Taip stotyje liktų tik dalis įrangos, kurios funkcionalumas yra artimiausias radijo eteriui.
5G NR ryšyje ji dar vadinama RRH {Remote Radio Heads}.
Tai galimybė dalį RAN tinklo įrangos konsoliduoti įprastiniuose duomenų centruose, didžiulis privalumas.
Taupoma energija stočiai maitinti ir joje pakanka mažesnio ploto įrangai.

Žinoma, sprendimas turi ir trūkumų.
Atskyrus įrangą prireikia beprotiškai didelio pralaidumo priešakinėje magistralėje (angl. Fronthaul).
Kraštutinis 2016 m. pavyzdys iškėlus visas BBU funkcijas iš bazinės stoties į Debesį [5]: 
75 Mbps UE srautas sukurs 1 Gbps srautą priešakinėje magistralėje.
Naujesnė, 2020 m. ataskaita mini jau mažesnį, dešimties kartų srauto padidėjimą priešakinėje magistralėje lyginant su srautu transmisijos tinkle (angl. Backhaul), kurio prireiktų naudojant klasikinę LTE architektūrą. [6]

![image](https://user-images.githubusercontent.com/74717106/101022192-b6419b80-3579-11eb-90db-8fdc625aa37d.png)  
`1.b pav. Centralize-RAN architektūra: priešakinė magistralė ir transmisijos tinklas.` [6]

Be to, ne per daugiausiai nukrenta bazinės stoties kaina, mat joje liekanti įranga sudėtingėja dėl pasikeitusios komunikacijos su iškeltaja dalimi.
Taip pat žymiai brangesnis varinių priešakinės magistralės kabelių keitimas į optinius lyginant su kabelių keitimu transmisijos tinkle. [7]

Priešakinės magistralės atnaujinimas bus būtinas visose bazinėse stotyse, kuriose tai nebuvo atlikta įjungus LTE:

![image](https://user-images.githubusercontent.com/74717106/101021464-9f4e7980-3578-11eb-992d-e0fb003018e6.png)  
`1.c pav. Tradicinio mob. ryšio bokšto sandara su koaksialiniais vario kabeliais` [6]

Taip pat C-RAN sukelia ir programinius iššūkius valdant iškeltuosius BBU [9]. 
Pvz. duomenų centrų virtualizavimo technologijos grįstos resursų dalinimusi ir paskirstytuoju apdorojimu.
Gi BBU apkrova yra dinamiška ir realiame laike linkusi kisti staigiai, pagal aptarnaujamų ryšio celių aktyvumą.
Ir ji ganėtinai skiriasi nuo duomenų centro scenarijų.

Todėl C-RAN debesų architektūra turi būti kitokia nei DC debesų, ir irgi reikalauja tobulinimų.

C-RAN architektūra naudojama teoriškai jau nuo 3G, bet praktiškai pradėjo plisti tik 4G LTE tinkluose.
Tačiau ji nėra visiškai išbaigta ar nusistovėjusi: vyksta jos tyrinėjimai, optimizavimai ir kiti tobulinimo darbai: [8].

![image](https://user-images.githubusercontent.com/74717106/101074912-00427580-35aa-11eb-8d76-a53fcc054887.png)
`TODO pav. Tyrimų objektas – skirtingos galimos RRH ir BBU skiriamosios ribos (A, B, C, D, E).` [5]

Laikoma, kad būtent dėl 5G NR poreikių (didelio pralaidumo, mažos delsos) ir prasidėjusio įjungimo stipriai pasistūmės C-RAN masinis diegimas:

![image](https://user-images.githubusercontent.com/74717106/101058576-f31b8b80-3595-11eb-97db-c7b8a466e0e8.png)  
`1.d pav. Prognozuojama C-RAN rinkos plėtra 2106–2027 m.` [6]

## Neišpopuliarėjusi LTE + WLAN agregacija

Įvykius EM dažnio spektrų aukcionams ir įsibėgėjus 4G LTE diegimui, pradėta galvoti ryšio pralaidumo didinimą.
3GPP organizacija pasiūlė būdus judriajam ryšiui tam panaudoti nelicencinio radijo spektro ruožus [11].

Buvo akivaizdu, kad Wi-Fi įrangos gamintojai bus nusistatę prieš siekį išnaudoti 5 GHz ruožą [25]. 
Šis ruožas tuomet gamintojas žadėjo daug potencialo (2,40 GHz ruožas gyvenamoje aplinkoje jau tada buvo ganėtinai užimtas) ir kuriame dabar veikia žymi dalis dabartinių Wi-Fi įrenginių.

Tačiau 3GPP savo 4G LTE specifikacijoje buvo numačiusi ir galimybę apjungti LTE su WLAN tiesiogiai (populiariai kalbant Wi-Fi).
Taip būtų sukuriamas heterogeninis radijo tinklas.
Specifikacijos `Release-13` aprašytos dvi technologijos [10]:

* LWA {angl. LTE-WLAN aggregation} technologija.
* LWIP {angl. LTE WLAN Radio Level Integration with IPsec Tunnel} protokolas.

![image](https://user-images.githubusercontent.com/74717106/101068854-ea30b700-35a1-11eb-9553-ecbf9ae77194.png)  
`TODO pav. Alcatel-Lucent pasiūlyti du apjungimo būdai (su ateinančio srauto agregacija ir be jos) ` [12]

![image](https://user-images.githubusercontent.com/74717106/101069600-e5b8ce00-35a2-11eb-833a-d63d64db005c.png)  
`TODO pav. Du paprasčiausi LWA diegimo būdai` [11]

![image](https://user-images.githubusercontent.com/74717106/101069898-4c3dec00-35a3-11eb-9bec-bc4b9c47c75a.png)  
`TODO pav. Numatytieji skirtingi UE mobilumo scenarijai` [11]

![image](https://user-images.githubusercontent.com/74717106/101068235-1f88d500-35a1-11eb-92b4-4a4597230e1c.png)  
`TODO pav. Qualcomm pasiūlyto LWA sprendimo schema, apjungianti LTE ir Wi-Fi tinklą` [13]

Jos dar tobulinamos, bet tik ta prasme, kad jų pagrindu kuriami nauji atšakojimai: tiek LWA technologijai [14, 15, 16], tiek LWIP protokolui [17, 18].

Tačiau nei šios dvi, nei apskritai kitos technologijos, skirtos mobiliojo ryšio ir nelicencinio radijo spektro (2,4 GHz ir 5 GHz) apjungimui (sukurtos tiek 3GPP, tiek kitų organizacijų) nebuvo plačiai įgyvendintos ir kasdieniniam naudojimui nepaplito.  

Taip teigia Olandijos IKT {informacijos ir ryšių technologijų, angl. ICT, Information and Communication Technologies [19, 20, 21]} švietimo ir tyrimų asociacija SURF {olan. Samenwerkende Universitaire RekenFaciliteiten [23]} kartu su Olandijos IKT tyrimų bendrove Stratix [24] jų bendroje ataskaitoje apie galimybes panaudoti 4G ir 5G gyvenamosiose patalpose [22].

Pažymima, kad tiek čipų gamintojai Intel, Ericsson, Nokia ir Qualcomm, tiek ir mob. telefonų gamintojai atsilieka nuo kasdienybės (įskaitant Samsung) atsilieka nuo kasdienybės tiek teikdami šių technologijų palaikymą, tiek net ir implementuodami jas.

Ataskaitos autoriai neaptiko paaiškinimų, kodėl taip nutikę, tik spekuliacijas.
Jie spėja, kad apskritai visų nelicencinio spektro agregavimo technologijų vėlavimo priežastis yra per mažas rinkos poreikis.
Grindžiama tuo, kad beveik visos pagrindinės telekomunikacinės bendrovės (išskyrus nebent Samsung) nedalyvauja aljansuose, remiančiuose šias technologijas.

Internetinio leidinio "RCR Wireless News" straipsnelis [25] patvirtina, kad tokia pat situacija rinkoje buvo ir 2015 m.

5Genesis konsorciumo 2019 m. „5G standartizavimo ir reguliavimo“ ataskaitoje D7.5 teigiama, kad 3GPP pateiktos 4G LTE specifikacijos kitų radijo technologijų agregavimo temą paliečia tik iš dalies, ir 5G NR atveju nėra išsamios apskritai [26].

Rašant referatą rasti tik keli sėkmingi ar bent jau planuoti įdiegimai:

* 2017 m. vasaros pr. Singapūre, pas ryšio tiekėją "M1" [27, 28]
* 2017 m. vasario 23 d. Kinijoje, pas ryšio tiekėją "Chunghwa Telecom" [29]

Iš vėlesnių diegimų pavyko aptikti tik "Athens Technology Center S.A." (ATC) atliktą 4G LTE agreguoto tinklo tyrimą projektui Fed4FIRE+. [30]
Ataskaitoje pastebima, kad LWA ir jos naudojamas signalizacijos protokolas LWAAP nepalaiko vadinamosios Split architektūros bazinėse stotyse (RAN viduje).
O šis funkcionalumas 5G NR technologijai yra kertinis ir netgi (kaip paminėta aprašant C-RAN).

Graikijos bendrovės ATC atlikti mobiliojo ryšio agregavimo tyrimai iliustruoja 4G LTE trūkumus šioje srityje ir eksperimentų keliu atskleidžia praktiškus būdus efektyviai agreguoti radijo tinklus 5G NR atvejui.

O "Global mobile Suppliers Association" 2020 m. vidurio ataskaitoje teigė [31], kad šių technologijų vystymas sustojo.

Tuo tarpu 5G NR gaires 2017 m. nubrėžęs standartas IMT-2020 numatė lankstesnius ir net efektyvesnius RAN ir WLAN apjungimo scenarijus [32].

Akivaizdu, kad 4G LTE ir WLAN agregacija nėra nei paplitusi pasaulyje, nei suderinama su 5G NR siekiais.
Tai dar vienas 4G LTE aspektas, kurį 5G NR privalės tobulinti.
Ar pavyks šį sykį, didelis klausimas.

# Skyriaus santrumpos

| Santrumpa | Pilnas terminas                                                                                                                                    | 
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------| 
| C-RAN     | angl. terminų Centralized-RAN ir Cloud-RAN apibendrinanti santrumpa
| LWA       | angl. LTE-WLAN aggregation 
| LWIP      | angl. LTE WLAN Radio Level Integration with IPsec Tunnel
| AMF       | angl. Access and Mobility Management Function
| 5GGW      | angl. 5G Gateway

# Literatūra:

 [1] 5G NR: The Next Generation Wireless Access Technology, **2018**  
       https://www.elsevier.com/books/5g-nr-the-next-generation-wireless-access-technology/dahlman/978-0-12-814323-0  

 [2] Cisco Annual Internet Report (2018–2023), **March 2020**  
       https://www.cisco.com/c/en/us/solutions/collateral/executive-perspectives/annual-internet-report/white-paper-c11-741490.pdf  

 [3] Slice architecture for 5G core network, **July 2017**  
       https://ieeexplore.ieee.org/abstract/document/7993854  

 [4] Big Video Bright Future | ZTE Big Video white paper, **August 2016**  
      https://res-www.zte.com.cn/mediares/zte/Files/PDF/White-Skin-Book/2016big_video/ZTE_Big_Video_White_Paper0818.pdf#page=13

[5] Impact of packetization and functional split on C-RAN fronthaul performance, **May 2016**  
      https://ieeexplore.ieee.org/document/7511579

[6] C-RAN Market Size, Share & Trends Analysis Report By Architecture Type (Centralized-RAN, Virtual/Cloud-RAN), By Component, By Network Type, By Deployment Model, And Segment Forecasts, 2020 - 2027, **February 2020**  
      https://www.grandviewresearch.com/industry-analysis/cloud-ran-market

[7] Understanding the Basics of CPRI Fronthaul Technology, **February 2015**  
      http://www.equicom.hu/wp-content/uploads/EXFO_anote310_Understanding-Basics-CPRI-Fronthaul-Technology_en.pdf
    
[8] Resource Management in Cloud Radio Access Network: Conventional and New Approaches, **May 2020**  
      https://res.mdpi.com/d_attachment/sensors/sensors-20-02708/article_deploy/sensors-20-02708.pdf
    
[9] Cloud RAN: Basics, Advances and Challenges, **April 2016**  
      https://www.cse.wustl.edu/~jain/cse574-16/ftp/cloudran.pdf

[10] LTE-WLAN Aggregation (LWA) and LTE WLAN Radio Level Integration with IPsec Tunnel (LWIP), **March 2016**  
      https://www.3gpp.org/images/PDF/2016_03_LWA_LWIP_3GPPpresentation.pdf

[11] The Voice of 5G for the Americas, LTE Aggregation & Unlicensed Spectrum, **November 2015**  
      https://www.5gamericas.org/wp-content/uploads/2019/07/4G_Americas_LTE_Aggregation__Unlicensed_Spectrum_White_Paper_-_November_2015.pdf
    
[12] LTE unlicensed and Wi-Fi: Moving beyond coexistence (report), **2015**  
      https://ecfsapi.fcc.gov/file/60001076664.pdf
    
[13] Ruckus Wireless: Beyond LTE unlicensed, with LTE plus Wi-Fi link aggregation,  **2015**  
      https://www.commscope.com/globalassets/digizuite/1084-1074-senzafili-laa-ruckus.pdf

[14] SDN-assisted efficient LTE-WiFi aggregation in next generation IoT networks, **June 2020**  
      https://www.sciencedirect.com/science/article/abs/pii/S0167739X17310907
      
[15] Mitigation technique for LTE-LAA and LTE-LWA coexistence, **July 2020**  
       https://ieeexplore.ieee.org/abstract/document/9165524
    
[16] An efficient SDN‐based LTE‐WiFi spectrum aggregation system for heterogeneous 5G networks, **April 2020**  
       https://onlinelibrary.wiley.com/doi/abs/10.1002/ett.3943

[17] A Packet Level Steering Solution for Tightly Coupled LWIP Networks, ***June 2020**  
       https://ieeexplore.ieee.org/abstract/document/9118009
       
[18] Testbed to experiment with LTE WiFi Aggregation, **June 2019**
       https://ieeexplore.ieee.org/abstract/document/8802000

[19] Informacijos ir ryšių technologijos, Europos regioninės plėtros fondo prioritetai, (žiūrėta 2020 m. gruodžio 2 d.)  
       https://ec.europa.eu/regional_policy/lt/policy/themes/ict/

[20] Dėl Lietuvos Respublikos vyriausybės nutarimo projekto NR. 19-1690, **2019-02-13**  
       https://e-seimas.lrs.lt/rs/legalact/TAK/07fd9f6035b711e98893d5af47354b00/format/ISO_PDF/

[21] Inovacijų link - Informacijos ir ryšių technologijos 7-joje bendrojoje programoje, **2007 01 16**  
       https://ivpk.lrv.lt/lt/naujienos/inovaciju-link-informacijos-ir-rysiu-technologijos-7-joje-bendrojoje-programoje

[22] Strategische opties voor inpandig 4G en 5G connectiviteit, **April 2019**  
      https://www.surf.nl/files/2019-07/rapport_mobiele_technologie_op_de_campus_1.0.pdf#page=29:~:text=Geen%20van%20deze,toepassingen,%20ook%20Multefire,%20lijken%20succesvol%20te%20zijn

[23] SURF asociacijos tinklalapis, skyrelis "Research & ICT", (žiūrėta 2020 m. gruodžio 2 d.)  
       https://www.surf.nl/en/research-ict
  
[24] Stratix bendrovės tinklalapis, skyrelis "About us", (žiūrėta 2020 m. gruodžio 2 d.)  
       https://www.stratix.nl/over-ons/

[25] LWA: logical wireless alternative? **June 2015**  
       https://www.rcrwireless.com/20150625/network-infrastructure/wi-fi/lwa-logical-wireless-alternative-tag4

[26] D7.5 • Standardization and Regulation Report (Release A), **July 29th, 2019**  
       https://5genesis.eu/wp-content/uploads/2019/08/5GENESIS_D7.5-_v1.0.pdf

[27] M1, Nokia announce Singapore’s first commercial nationwide HetNet rollout, **19 August 2016** (žiūrėta 2020 m. gruodžio 2 d.)  
       https://web.archive.org/web/20160920143843/https://www.m1.com.sg/AboutM1/NewsReleases/2016/M1%20Nokia%20announce%20Singapore%20first%20commercial%20nationwide%20HetNet%20rollout.aspx

[28] M1, Nokia to deploy HetNet and NB-IoT networks in Singapore, **22 August 2016**  
       http://www.gtigroup.org/news/ind/2016-08-22/9257.html

[29] Chunghwa Telecom to launch LWA network, **21 February 2017**  
       http://digitimes.com/news/a20170220PD201.html

[30] Fed4FIRE+ Experiment Report: Cloud-RAN based LTE-WiFi Aggregation (F4F-LWA), **September 2018**  
       https://fed4fire.eu/wp-content/uploads/sites/10/2019/09/f4fp-02-stage2-06-report-f4f-lwa-athens-tc.pdf

[31] MEMBER REPORT: 5G & LTE in Unlicensed Spectrum. GSA Member Report, **August 2020**  
       https://gsacom.com/paper/5g-lte-in-unlicensed-spectrum-august-2020/#:~:text=development%20of%20the%20technology%20ecosystems%20around%20LTE-U%20and%20LWA%20have%20stalled

[32] ITU-T Focus Group IMT-2020 Deliverables, **2017**  
       https://www.itu.int/dms_pub/itu-t/opb/tut/T-TUT-IMT-2017-2020-PDF-E.pdf#page=29
