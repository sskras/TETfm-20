### RFC 813 apžvalga

- Aprašo data: **1982**, galimai dalinai pasenęs.

#### 1. Įžanga

- TCP protokole naudojami skirtingi mechanizmai (strategijos)
- Čia specifikuojami du:
  - 1. **Acknowledgement** (patvirtinimo) mechanizmas
  - 2. **Window** (lango) mechanizmas
- Visgi remiantis juo įmanomos prastos implementacijos.
- Tačiau trūkumų išvengti lengva.
- Daug sunkiau patikrinti specifikacijos _įgalinamą spartą_ nei specifikacijos _korektiškumą_.
- Pateikiamas rinkinys algoritmų, kurie buvo testuoti.
- Juos kombinuojant sparta nenukenčia.

#### 2. Mechanizmai

- **Patvirtinimo** mechanizmas:
- yra TCP protokolui kertinis;
- reikalauja, kai duomenys pasiekia gavėją, kad atgal būtų išsiųstas patvirtinimas;
- numeruoja duomenų baitus iš eilės,
- gavimo patvirtinimui įvardija nuskaitytą baitą su didžiausiu numeriu;
- taip patvirtinama, kad gauti baitai ir su visais mažesniais numeriais;
- prašo tai patvirtinti greitai,
- tačiau nenurodo nei kaip greitai, nei po kiekos naujų duomenų.
