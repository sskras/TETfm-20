(juodraštis)

# 1. Kodėl 4G neužtenka

4G/LTE yra labai pajėgi technologija (ir tebėra vystoma lygiagrečiai 5G/NR).
Tačiau yra reikalavimų, kurių patenkinti nepajėgi nei dabartinė LTE implementacija, nei jos naujos revizijos. 
Be to, nuo LTE specifikacijos pasirodymo praėjo jau 10 metų, per kuriuos atsirado ganėtinai pažengusių technologijų.

NR technologija pradėta kurti tiek norint išnaudoti pastarųjų potencialą, tiek ir patenkinti naujus, platesnius reikalavimus. 
Be to, pradingsta reikalavimas išlaikyti suderinamumą su 4G. 
Ir nors NR daug komponentų perima iš LTE bei geba išnaudoti dalį jos infrastruktūros savo pirminei įrengimo stadijai, visos aukščiau išvardintos aplinkybės (ypač NR kelti aukštesni reikalavimai) paskatino naudoti kitokius techninius sprendimus.

![image](https://user-images.githubusercontent.com/74717106/100879529-369dc900-34b4-11eb-93a5-cb49377ed09a.png)  
`1.1 pav. Integralus radio prieigos sprendimas pereinamuoju LTE ir NR vystymo laikotarpiu.`

## 1.z. LTE + WLAN konvergencija

[Kam skirta?]

`3GPP` organizacija `4G LTE` specifikacijoje buvo numačiusi galimybę apjungti LTE ir WLAN (populiariai kalbant Wi-Fi).
Taip būtų sukuriamas heterogeninis radio tinklas.
Specifikacijos `Release-13` aprašytos dvi technologijos:
[https://www.3gpp.org/images/PDF/2016_03_LWA_LWIP_3GPPpresentation.pdf]
* LWA {angl. LTE-WLAN aggregation} technologija.
* LWIP {LTE WLAN Radio Level Integration with IPsec Tunnel}

Jos vis dar tobulinamos ta prasme, kad jų pagrindu kuriamos naujos technologijos:
[scholar list]

Tačiau nei šios, nei kitų organizacijų sukurtos `4G LTE` agregavimo technologijos nebuvo plačiai įgyvendintos ir nepaplito.
[https://www.surf.nl/files/2019-07/rapport_mobiele_technologie_op_de_campus_1.0.pdf#page=29:~:text=Geen%20van%20deze,toepassingen,%20ook%20Multefire,%20lijken%20succesvol%20te%20zijn]

Olandų IKT {informacinių komunikacinių technologijų} švietimo ir tyrimų asociacija SURF {olan. Samenwerkende Universitaire RekenFaciliteiten} teigia, kad tiek pas čipų gamintojus Intel, Ericsson, Nokia ir Qualcomm, tiek ir mob. telefonų gamintojus šių technologijų palaikymas ir net implementacijos atsilieka nuo kasdienybės.
SURF nerado paaiškinimų, kodėl taip nutiko, tik spekuliacijas. 
Jie spėja, kad apskritai visų nelicencinio spektro agregavimo technologijų (apimančių daugiau nei LWA ir LWP) vėlavimo priežastis yra per mažas poreikis.
Spėjimas grindžiamas tuo, kad beveik visos pagrindinės telekomunikacinės bendrovės nedalyvauja aljansuose, remiančiuose šias technologijas.

Rašant referatą rasti tik keli sėkmingi ar bent jau planuoti įdiegimai:

* 2017 m. vasaros pr. Singapūre, pas ryšio tiekėją "M1" [https://web.archive.org/web/20160920143843/https://www.m1.com.sg/AboutM1/NewsReleases/2016/M1%20Nokia%20announce%20Singapore%20first%20commercial%20nationwide%20HetNet%20rollout.aspx] **19 August 2016**
[http://www.gtigroup.org/news/ind/2016-08-22/9257.html] **2016-08-22**
* 2017 m. vasario 23 d. Kinijoje, pas ryšio tiekėją "Chunghwa Telecom" [http://digitimes.com/news/a20170220PD201.html] **21 February 2017**

"Global mobile Suppliers Association" teigia, kad jų vystymas sustojo.
[https://gsacom.com/paper/5g-lte-in-unlicensed-spectrum-august-2020/#:~:text=development%20of%20the%20technology%20ecosystems%20around%20LTE-U%20and%20LWA%20have%20stalled]

`5G NR` gaires nurodantis `IMT-2020` standartas numato 
[https://www.itu.int/dms_pub/itu-t/opb/tut/T-TUT-IMT-2017-2020-PDF-E.pdf#page=29]

Šis skyrius pradėtas remiantis knyga [1.1] (ne straipsniu, kaip reikalaujama iš referato apskritai). 
Planuojama iš peržvelgtųjų šaltinių – Cisco srautų prognozės ataskaitos [1.2], straipsnių [1.3–1.8] ir daktarinės disertacijos [1.9] – ištraukti rastus 5G NR detalius skirtumus 4G LTE atžvilgiu ir juos apibendrinti. 
Pagrindinis dėmesys skiriamas augantiems ir ateityje augsiantiems [1.2] UE srautams.

# Skyriaus santrumpos

LWA {angl. LTE-WLAN aggregation}

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
       https://books.google.lt/books/about/Destination_based_Routing_and_Circuit_Al.html
