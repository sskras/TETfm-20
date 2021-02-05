# Dviejų radijo ryšio linijų elektromagnetinės interferencijos tyrimas panaudojant SEAMCAT
## Radijo komunikacijos ir jų taikymai <br /> <br /> Elektronikos fakultetas <br /> VILNIUS TECH <br /> <br /> Kursinio darbo ataskaita

**Data:** 2021-0x-yy  
**Atliko:** Saulius Krasuckas  
**Grupė:** TETfm-20  
**Užduotis:** 11  

### Užduoties sąlygos

![image](https://user-images.githubusercontent.com/74717106/103891375-64e57880-50f2-11eb-9270-1948213ee201.png)

### (a) Teorinis tiriamųjų radijo sistemų veikimo aprašymas
(Iš kokių elementų jos susideda, kokie pagrindiniai veikimo principai)

### (b) Kokios dažnių juostos yra priskirtos ir naudojamos tiriamųjų radijo ryšio sistemų

Dažnius pasirinkau pagal **3GPP TS 36.101** version 15.9.0 Release 15:  
https://www.etsi.org/deliver/etsi_ts/136100_136199/136101/15.09.00_60/ts_136101v150900p.pdf#page=43

> Table 5.5-1 E-UTRA operating bands
> 
> | E-UTRA Operating Band | Uplink (UL) operating band<br/>BS receive<br/>UE transmit | Downlink (DL) operating band<br/>BS transmit<br/>UE receive | Duplex Mode |
> | :-------------------: | :-------------------------------------------------------: | :---------------------------------------------------------: |-------------|
> |                       | **F_UL_low – F_UL_high**                                  | **F_DL_low – F_DL_high**                                    |             |
> | 38                    | 2570 MHz – 2620 MHz                                       | 2570 MHz – 2620 MHz                                         | TDD         |
> | 7                     | 2500 MHz – 2570 MHz                                       | 2620 MHz – 2690 MHz                                         | FDD         |

Ir pagal LR **RRT** įsakymą:  

**DĖL NACIONALINĖS RADIJO DAŽNIŲ PASKIRSTYMO LENTELĖS IR RADIJO DAŽNIŲ NAUDOJIMO PLANO PATVIRTINIMO IR KAI KURIŲ LIETUVOS RESPUBLIKOS RYŠIŲ REGULIAVIMO TARNYBOS DIREKTORIAUS ĮSAKYMŲ PRIPAŽINIMO NETEKUSIAIS GALIOS**  

Priėmimo data: 2016 m. birželio 21 d. Nr. 1V-698  
Galiojanti suvestinė redakcija (nuo 2020-09-15)  
https://www.e-tar.lt/portal/lt/legalAct/6e718fd037a011e69101aaab2992cbcd/asr#:~:text=2570

![image](https://user-images.githubusercontent.com/74717106/107042269-3d093380-67ca-11eb-8960-5c4132b32fbd.png)

Tai 38-ta ir 7-ta E-UTRA juostos.

### (c) Pagrindiniai radijo ryšio sistemų parametrai

Mėginu modeliuoti judrųjį ryšį savo tėviškėje, vienkiemyje Katlėriuose (Utenos raj.)

Victim Link naudoja LTE-2600 FDD ryšį: 
- Tx yra judrioji stotis (Kazys, Nokia 3310 4G)
- Rx yra bazinė stotis (Telia 7AF_Medeniai_VB)

Interfering Link naudoja LTE-2600 TDD ryšį:
- Tx yra bazinė stotis (Telia 612_Tauragnai, tarkime, nes neturiu Mezon duomenų)
- Rx yra judrioji stotis (Saulius, nešiojamas modemas Huawei E5573s-606)

TDD: 2570 MHz – 2620 MHz  
FDD: 2500 MHz – 2570 MHz  

| Parametras      | Interfering Link Tx<br/>LTE TDD BS | Interfering Link Rx<br/>LTE TDD UE | Victim Link Tx<br/>LTE TDD US | Victim Link Rx<br/>LTE TDD BS |
|-----------------|------------------------------------|------------------------------------|-------------------------------|-------------------------------|
| Dažnis          | 2560 MHz                           | t. p.                              | 2580 MHz                      | t. p.                         |
| Galia           | 2\*40 W = ~49 dBm                  | -                                  | 49 dBm                        | -                             |
| Antenos aukštis | 67 m                               | 1.5 m                              | 31.5 m                        | 1.5 m                         |

(dažniai, galios, antenų aukščiai su pagrindimu, kokiu šaltiniu remtasi)



### (d) Modeliavimo scenarijaus aprašymas
(kaip išdėstomos radijo ryšio sistemų Tx ir Rx, kokie atstumai, padengimo zonos ir t.t.)

### (e) Interferencijos kriterijaus, sklidimo modelio pasirinkimo logika.

### (f) Pirminio modeliavimo rezultato (Probability of interference) pristatymas.

### (g) Pasiūlymai, kaip galima koreguoti radijo ryšio sistemas
(kad sumažintume probability of interference, pvz., nuo 100% iki 5% ar 0%)

### (h) Išvados
(ar sistemos yra elektromagnetiškai suderinamos, ir kokia konfigūracija būtina)

