# Dviejų radijo ryšio linijų elektromagnetinės interferencijos tyrimas panaudojant SEAMCAT
## Radijo komunikacijos ir jų taikymai <br /> <br /> Elektronikos fakultetas <br /> VILNIUS TECH <br /> <br /> Kursinio darbo ataskaita

**Data:** 2021-02-05  
**Atliko:** Saulius Krasuckas  
**Grupė:** TETfm-20  
**Užduotis:** 11  

### Užduoties sąlygos

![image](https://user-images.githubusercontent.com/74717106/103891375-64e57880-50f2-11eb-9270-1948213ee201.png)

### 1. Teorinis tiriamųjų radijo sistemų veikimo aprašymas
(Iš kokių elementų jos susideda, kokie pagrindiniai veikimo principai)

Abi užduoties sistemos yra **LTE**. LTE – _ketvirtos kartos (4G) belaidžio plačiajuosčio ryšio standartas_, sukurtas organizacijų projekto **3GPP**.

Bet formaliai LTE (LTE Advanced) atitiktų **3.95G** ryšį, o tikrosios 4G belaidžio ryšio technologijos dėl to 2012 m. ITU buvo pervadintos į "True 4G".

Fizinių atžvilgiu LTE naudoja du komunikavimo būdus (dupleksus):

- FDD (angl. Frequency-division duplexing)
- TDD (angl. Time-division duplexing)

FDD tai Full-duplex ryšys, kuomet Uplink ir Downlink srautams naudojami skirtingi (gana artimi) radijo kanalai.
TDD ryšys naudoja tą patį radijo kanalą, todėl yra Half-duplex. Bet jis emuliuoja Full-duplex veikimą išskaidydamas priėmimą ir siuntimą į trumpus laikinius intervalus ir naudodamas juos laikinėje ašyje pakaitomis (alternuodamas).

Taip pat LTE naudoja ir šias technologijas:

- Carrier Aggregation – kelių radijo kanalų apjungimas vieno vartotojo ryšiui.
- Antenna Diversity – kelių signalo dedamųjų (atspindžių) apjungimas.
- MIMO (ang. Multiple-Input Multiple-Output) – kelių radijo signalų perdavimas (su keletu antenų) ir srautų apjungimas vienu metu.
- Beamforming – spinduliuotės kryptingumo siaurinimas.

LTE sistema veikia tik paketų komutavimo pagrindu (angl. _Packet Switching_; nebelieka jokio _Circuit Switching_).

LTE tinklą sudaro:

| Komponentas | Terminas anglų k.                         | Prasmė
|-------------|-------------------------------------------|----------------------------
| UE          | User Equipment                            | Naudotojo įranga
| E-UTRA      | Evolved Universal Terrestial Radio Access | Antžeminė radijo prieiga
| EPC         | Evolved Packet Core                       | Paketinio tinklo branduolys

LTE [radijo / belaidės dalies](https://www.researchgate.net/profile/Liljana_Gavrilovska/publication/277215242/figure/fig4/AS:669299148603409@1536584760155/LTE-RAN-architecture-including-femtocells-HeNBs-and-network-management.png) (E-UTRAN) architektūra:

<p align="center">
<img src="https://user-images.githubusercontent.com/74717106/107157338-480bc180-698c-11eb-9a96-148d7b50d648.png" width="75%">
</p>

| Komponentas  | Terminas anglų k.                         | Prasmė
|--------------|-------------------------------------------|---------------------------
| eNB, eNodeB  | Evolved Node B                            | Bazinė stotis
| HeNB         | Home eNodeB                               | Femtocelės bazinė stotis
| OMC          | Operation and Maintenance Center          | RAN valdymo centras

LTE [kabelinės / paketinės / IP dalies](https://www.netmanias.com/en/?m=attach&no=23081) (EPC) architektūra:

<p align="center">
<img src="https://user-images.githubusercontent.com/74717106/107157437-c7999080-698c-11eb-9879-1597843e37ab.png" width="85%">
</p>

| Komponentas  | Terminas anglų k.                         | Prasmė
|--------------|-------------------------------------------|---------------------------
| MME          | Mobility Management Entity                | Radijo prieigos valdymo mazgas
| HSS          | Home Subscriber Server                    | Operatoriaus abonentų DB servisas
| Serving GW   | Serving Gateway                           | UE prisijungimo šliuzas
| DPI          | Deep Packet Inspection                    | Paketų (L7) inspektavimas
| PDN          | Packet Data Network                       | Išorinis paketinis tinklas, internetas
| PGW          | PDN Gateway                               | Internetinis šliuzas
| PCRF         | Policy Control and Charging Rules Function| Veiklos valdymas (įsk. QoS) ir apmokestinimas
| SPR          | Subscriber Profile Repositories           | Abonentų profilių saugykla
| OCS          | Online Charging System                    | Apmokestinimo ir kreditingumo valdymo mazgas
| OFCS         | Offline Charging system                   | CDR generatorius
| CDR          | Charging Data Records                     | Apmokestinimo (įvykių) įrašai


### 2. Kokios dažnių juostos yra priskirtos ir naudojamos tiriamųjų radijo ryšio sistemų

Dažnius pasirinkau pagal **3GPP TS 36.101** version 15.9.0 Release 15:  
[https://www.etsi.org/deliver/etsi_ts/136100_136199/136101/15.09.00_60/ts_136101v150900p.pdf](https://www.etsi.org/deliver/etsi_ts/136100_136199/136101/15.09.00_60/ts_136101v150900p.pdf#page=4)

> Table 5.5-1 E-UTRA operating bands

| E-UTRA Operating Band | Uplink (UL) operating band<br/>BS receive<br/>UE transmit | Downlink (DL) operating band<br/>BS transmit<br/>UE receive | Duplex Mode |
| :-------------------: | :-------------------------------------------------------: | :---------------------------------------------------------: |-------------|
|                       | **F_UL_low – F_UL_high**                                  | **F_DL_low – F_DL_high**                                    |             |
| 38                    | 2570 MHz – 2620 MHz                                       | 2570 MHz – 2620 MHz                                         | TDD         |
| 7                     | 2500 MHz – 2570 MHz                                       | 2620 MHz – 2690 MHz                                         | FDD         |

Ir pagal LR **RRT** įsakymą:  

**DĖL NACIONALINĖS RADIJO DAŽNIŲ PASKIRSTYMO LENTELĖS IR RADIJO DAŽNIŲ NAUDOJIMO PLANO PATVIRTINIMO IR KAI KURIŲ LIETUVOS RESPUBLIKOS RYŠIŲ REGULIAVIMO TARNYBOS DIREKTORIAUS ĮSAKYMŲ PRIPAŽINIMO NETEKUSIAIS GALIOS**  

Priėmimo data: 2016 m. birželio 21 d. Nr. 1V-698  
Galiojanti suvestinė redakcija (nuo 2020-09-15)  
[https://www.e-tar.lt/portal/lt/legalAct/6e718fd037a011e69101aaab2992cbcd/asr](https://www.e-tar.lt/portal/lt/legalAct/6e718fd037a011e69101aaab2992cbcd/asr#:~:text=2570)

![image](https://user-images.githubusercontent.com/74717106/107042269-3d093380-67ca-11eb-8960-5c4132b32fbd.png)

Tai 38-ta ir 7-ta **E-UTRA** juostos.

### 3. Pagrindiniai radijo ryšio sistemų parametrai

Dažnius, kadangi juostos nepersidengia, parinkau tarpusavyje pačius artimiausius:
- TDD DL juosta: 2570 MHz – 2620 MHz
- FDD UL juosta: 2500 MHz – 2570 MHz

_Worst-case_ bus, kai vieno TDD DL kanalo „apačia“ sutaps su FDD kanalo viršumi: **2570 MHz**.  
Prie šios ribos pridėjus ir iš jos atėmus po pusę kanalo pločio (10 MHz), gaunu **2580** ir **2560** MHz.  

Trukdančiosios BS galia ir antenų aukščiai imti iš realios Telia įrangos (Huawei) specifikacijų.  
Trukdomosios UE galia imta iš ETSI ataskaitos:  
[ETSI TS 136 101 V14.3.0 (2017-04)](https://www.etsi.org/deliver/etsi_ts/136100_136199/136101/14.03.00_60/ts_136101v140300p.pdf)

| Parametras      | Interfering Link Tx <br/> TDD BS   | Interfering Link Rx <br/> TDD UE   | Victim Link Tx <br/> FDD UE   | Victim Link Rx <br/> FDD BS   |
|-----------------|------------------------------------|------------------------------------|-------------------------------|-------------------------------|
| Dažnis          | 2580 MHz                           | t. p.                              | 2560 MHz                      | t. p.                         |
| Galia           | 2\*40 W = ~49 dBm                  | -                                  | 23 dBm                        | -                             |
| Antenos aukštis | 67 m                               | 1.5 m                              | 1.5 m                         | 31.5 m                        |

### 4. Modeliavimo scenarijaus aprašymas
(kaip išdėstomos radijo ryšio sistemų Tx ir Rx, kokie atstumai, padengimo zonos ir t.t.)

Mėginu modeliuoti judrųjį ryšį savo tėviškėje, vienkiemyje Katlėriuose (Utenos raj.)

Interfering Link naudoja LTE-2600 TDD ryšį:
- Tx yra bazinė stotis (Telia 624_Pramones_11_Utena, tarkime, nes neturiu tikslių Mezon duomenų)
- Rx yra judrioji stotis (Saulius, nešiojamas modemas Huawei E5573s-606)
- atstumas 7460 m.
- skersinis atstumas kambaryje: 3 m.
- Padengimo zona: 8 km.

Victim Link naudoja LTE-2600 FDD ryšį: 
- Tx yra judrioji stotis (Kazys, Nokia 3310 4G)
- Rx yra bazinė stotis (Telia 7AF_Medeniai_VB)
- atstumas 3970 km.
- skersinio judėjimo atstumas kambaryje: 3 m.

Atstumas tarp Interfering Tx ir Victim Rx: 3510 m.  
Victim Link bazinė stotis atsiduria beveik Interfering Link viduryje.

Kitus parametrus pasirenku pagal literatūrą ir Seamcat instrukcijas:
- [ECC Report 187](https://docdb.cept.org/download/d8623f8a-1ff1/CEPTREP063.pdf)
- [CEPT Report 63](https://docdb.cept.org/download/090b56ac-eee8/ECCREP187.PDF)

| Parametras             | Interfering Link Tx <br/> TDD BS   | Interfering Link Rx <br/> TDD UE   | Victim Link Tx <br/> FDD UE   | Victim Link Rx <br/> FDD BS |
|------------------------|------------------------------------|------------------------------------|-------------------------------|-----------------------------|
| Azimuth ref., °        | 50                                 | 0                                  | 0                             | 20                          |
| Noise floor, dBm       | -                                  | -92                                | -                             | -96                         |
| Sensitivity Floor, dBm | -                                  | -94                                | -                             | -101.5                      |
| Reception Bandw., kHz  | -                                  | 18.000                             | -                             | 18.000                      |
| Interference Crit., dB | -                                  | C/I = 9                            | -                             | C/I = 9                     |
| Path azimuth, °        | -                                  | 0 – 0.0230412                      | -                             | 0 - 0.04329656              |
| Coverage Radius, m.    | 8000                               | -                                  | -                             | 6000                        |
| Path Distance Factor   | -                                  | 0.9325                             | -                             | 0.661666667                 |
| Propagation Model      | -                                  | Extended Hata                      | -                             | Extended Hata               |
| Local environment      | Outdoor                            | Indoor                             | Indoor                        | Outdoor                     |
| General enironment     | -                                  | Rural                              | -                             | Rural                       |


Taip pat pagal [ECC Report 249](https://docdb.cept.org/download/32604bf0-7ac0/ECCRep249.pdf)
tikslinu Interfering Link Tx _Unwanted Emission Mask_:  
![Screenshot from 2021-02-08 20-09-58](https://user-images.githubusercontent.com/74717106/107262738-9763f780-6a49-11eb-9112-5402b00c3a20.png)

Aproksimuoju šiais taškais:

![image](https://user-images.githubusercontent.com/74717106/107297738-a021f100-6a7c-11eb-8c37-5302673dd44e.png)

Priešingu atveju būna klaida ("Emissions range [...] does not match [...] victim receiver frequency range").

### 5. Interferencijos kriterijaus, sklidimo modelio pasirinkimo logika.

Renkuosi C/I kriterijų, nes abi sistemos yra judriojo ryšio. Reikšmę parenku gana žemą, 9 dB, nes ryšiui nelabai palankios sąlygos (iš asm. patirties).

Sklidimo modelį Victim ir Interfering sistemoms parinkau **Extendeda Hata** pagal kaimišką vietovę (be didesnių užstatymų) bei dažnių ir atstumų ruožus: 30 MHz – 3 GHz, ir iki 40 km.  

Sklidimo modelis tarp trukdančiojo siųstuvo ir trukdomojo imtuvo – "ITU-R P.1546-4 land", nes abi BS įrengtos pakankamai aukštai, apie 50 m. 
Taip pat ir dažnis bei atstumas.  

Šį modelį dėl kalvotos vietovės būčiau išmėginęs ir abiems tiesioginiams linkams (Victim ir Interfering), tačiau pritrūkau duomenų apie kalvotumą bei miškų aukščius.  

**Relative positioning of Interfering Link** nustatymai:  

Kadangi trukdo bazinė stotis bazinei stočiai (nejudantys objektai), čia pasirinkau:
- _Mode_ = "None"
- _Number of active transmitters_ = 1


### 6. Pirminio modeliavimo rezultato (Probability of interference) pristatymas.

![image](https://user-images.githubusercontent.com/74717106/107299417-fcd2db00-6a7f-11eb-967e-f614f64bdb84.png)

iRSS vektorius:  
<p align="center" float="middle" width="100%">
  <img src="https://user-images.githubusercontent.com/74717106/107299567-65ba5300-6a80-11eb-88ed-cfe4e5a8e06b.png" width="45%">
  <img src="https://user-images.githubusercontent.com/74717106/107299588-7074e800-6a80-11eb-87d2-b326f6bf82c1.png" width="45%">
</p>

Deja, interferencijos tikimybė labai aukšta, apie 99%:  
![image](https://user-images.githubusercontent.com/74717106/107302014-44a83100-6a85-11eb-9bf3-f079ad454207.png)


### 7. Pasiūlymai, kaip galima koreguoti radijo ryšio sistemas

Atlikti pakeitimai:

- FDD VL-Tx MS padidinau antenos stiprinimą nuo 2 iki 7 dBi (tariame, kad naudosime išorinę LTE anteną).
- TDD IL-Tx BS perkėliau toliau nuo VL-Rx BS, atstumas išaugo nuo 3.9 iki 8.8 km (iš esmės į gretimą miestelį).
- TDD IL-Tx BS sumažinau antenos aukštį nuo 67 iki 25 m.
- TDD IL-Tx BS palenkiau anteną (Elevation pasikeitė nuo 0 iki -20°).
- TDD IL-Tx BS sumažinau siųstumo galią nuo 49 iki 43 dBi.
- FDD VL-Tx BS sumažinau imtuvo jautrumą nuo -101.5 iki -91 dBm.

Interferencijos tikimybė esant C/I = 9 nukrito iki **0.92%**:  
![image](https://user-images.githubusercontent.com/74717106/107306578-c8661b80-6a8d-11eb-9655-7921a3104884.png)


### 8. Išvados

(a) Pirminė, visiškai mėgėjiška RAN konfigūracija lėmė stiprią radijo sistemų interferenciją.  
(b) Pakeitus dalį parametrų, interferencijos tikimybės nukrito iki 1%, kai C/I = 9.  

(c) Kai C/I = 12, intererencijos tikimybė tampa tik 3%.  
(d) Nėra aišku, ar visi iš eilės šie pakeitimai būtini teigiamam rezultatui pasiekti. Papildomų keitimo iteracijų nebeatlikau.  
(e) Dalis šių pakeitimų galimai pakenkė pirminėms funkcijoms (Interfering Link ir Victim Link ryšio kokybei). Šių tyrimų irgi nebeatlikau.  
(f) Programoje neradau būdo nurodyti tikslaus BS ir MS tarpusavio išsidėstymo, kaip matyti iš pav. poskyryje 6.  

Kadangi nagrinėjau iš esmės nejudančias MS, vėliau kortelėse **Transmitter to Receiver Path** ėmiau atkreipti dėmesį į **Relative Location** nustatymą **Correlated Distance**.  
Pasinaudojus **Delta X** ir **Delta Y** parametrais čia ir **Transmitter to Victim Link Receiver Path** kortelėje galimai būtų pavykę gauti tikslų topologinį išsidėstymą ir realistiškesnę interferencijos tikimybę.
