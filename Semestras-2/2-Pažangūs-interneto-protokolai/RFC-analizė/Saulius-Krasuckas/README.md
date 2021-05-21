### RFC 813 apžvalga

- Aprašo data: **1982**, galimai dalinai pasenęs.

#### 1. Įžanga

- TCP protokole naudojami skirtingi mechanizmai (strategijos)
- Čia specifikuojami du:
  - 1. **Acknowledgement (Patvirtinimo)** mechanizmas
  - 2. **Window (Lango)** mechanizmas
- Visgi remiantis juo įmanomos prastos implementacijos.
- Tačiau trūkumų išvengti lengva.
- Daug sunkiau patikrinti specifikacijos _įgalinamą spartą_ nei specifikacijos _korektiškumą_.
- Pateikiamas rinkinys algoritmų, kurie buvo testuoti.
- Juos kombinuojant sparta nenukenčia.

#### 2. Mechanizmai

**Patvirtinimo** mechanizmas:
- yra TCP protokolui kertinis;
- reikalauja, kai duomenys pasiekia gavėją, kad atgal būtų išsiųstas patvirtinimas;
- numeruoja duomenų baitus iš eilės,
- patvirtinimui įvardija didžiausią numerį iš visų gautų baitų + `1`;
- taip patvirtinama, kad gauti baitai ir su visais mažesniais numeriais;
- prašo tai patvirtinti greitai,
- tačiau nenurodo nei kaip greitai, nei po kiekos naujų duomenų.

**Lango** mechanizmas:
- yra srauto valdymo įrankis;
- ir nurodo duomenų gavėjui pasitaikius progai pranešti dar vieną skaičių:
- tai daugmaž dydis laisvos buferio dalies, kurioje tilptų papildomi duomenys.
- Šio skaičiaus dimensija yra baitai,
- o jis pats vadinamas **langu**
- ir siuntėjui nurodo didžiausią duomenų porciją, leidžiamą išsiųsti gavėjui, 
- kol pastarasis nepranešė apie naujai atidarytą _langą_.
- Kartais gavėjo buferyje laisvos vietos nėra visai,
- tuomet jis praneša apie nulinio dydžio _langą_.
- Taip nutikus siuntėjo reikalaujama kartais siųsti gavėjui po mažą duomenų segmentą
- ir taip patikrinti, ar jau priimami nauji duomenys.
- Jeigu _langas_ lieka uždarytas (ties 0 B) pakankamai ilgą laiką, 
- o siuntėjas nustoja gauti atsakymus iš gavėjo,
- tada siuntėjo reikalaujama laikyti, kad gavėjas sugedo,
- ir uždaryti šį ryšį.
- Šiame mechanizme taip pat neapibrėžiama sparta, kuri nurodytų:
- (a) kokiose situacijose gavėjui vertėtų praplėsti _langą_,
- (b) ir kaip siuntėjas turėtų reaguot į tokią pasikeitusią info.
