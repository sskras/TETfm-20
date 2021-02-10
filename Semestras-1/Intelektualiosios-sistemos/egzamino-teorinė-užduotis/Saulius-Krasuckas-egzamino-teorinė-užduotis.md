
# IS :: Egzamino teorinė užduotis

`Data: 2021-02-10`  
`Grupė: TETfm-20`  
`Autorius: Saulius Krasuckas`  

Viena įmonė nori pasamdyti kelis duomenų analitikus, gebančius taikyti mašininio mokymo metodus duomenims analizuoti. 

Tuo tikslu įmonė suorganizavo nemokamus kursus, kurie baigiami egzaminu ir į šiuos kursus užsiregistravo nemažai žmonių, kurių didžioji dauguma dirba kitose įmonėse. 

Registracijos metu buvo surinkti kiekvieno dalyvio asmeniniai duomenys: 
miestas, kuriame gyvena; 
lytis; 
darbo srityje patirtis; 
išsilavinimas (pvz.,
 aukštosios mokyklos tipas,
 studijų kryptis ir
 kvalifikacinis lygis/laipsnis: bakalauras/magistras/daktaras); 
bendrasis darbo stažas; 
įmonės, kurioje dabar dirba dydis; 
darbdavio tipas; 
laikas, po paskutinio darbovietės pakeitimo; 
mokymų, kuriuos žmogus praėjo valandų skaičius; 
o taip pat atsakymas į klausimą, ar ieško naujo/kito darbo ar ne.

Kokius intelektualiuosius metodus galima būtų čia pritaikyti, norint apskaičiuoti, nuspėti, kiek tikėtina, jog konkretus kandidatas norės pakeisti darbo vietą, jei prognozavimui (sprendimo priėmimo modulio įėjime) naudoti visus duomenis išskyrus atsakymą į klausimą, ar kandidatas ieško naujo/kito darbo ar ne?

## Teorinės užduoties sprendimo žingsniai

### 1. Gebėjimas suformuluoti uždavinį (-ius) pagal pateiktą problemą.

  1. **Suprasti problemą**  (0,25)  
  |  
  (įvardinti/paaiškinti,  
   kur gali atsirasti neaiškumai kuriant/įgyvendinant problemos sprendimo algoritmą,  
   kur galimi keli būdai spręsti uždavinį ir neaišku, kuris būdas yra geresnis,  
   jei matyti, kad kažkokia komercinė sistema tokio pobūdžio problemą sprendžia,  
   įžvelgti, kokius neapibrėžtumus šis komercinis įrankis sugebėjo išspręsti).  
  |  
  Turi būti aprašytos probleminės vietos, reikalaujančios sprendimo.  
  Įvardinti, kame yra sunkumai sprendžiant pateiktą problemą.  
  Kurios problemos sprendimo dalys nėra akivaizdžios.  
  
Problema siejasi su psichologijos (turbūt socialinės psichologijos) sritimi: nuspėti asmens polinkį keisti darbą (ar įsidarbinti, jei šiuo metu asmuo nedirba) pagal ribotą duomenų rinkinį. 

Angl. terminai, kuriais rėmiausi ieškodamas sprendimo būdų:

* _Job offer acceptance_
* _Job offer turndown_
* _Job acceptance decisions_
* _Job search behaviour_
* _Career decision making process_
* _Staff turnover_
* _Voluntary employee turnover_

Probleminės vietos:

* turimi ne visi duomenys apie asmenį. Tiek fiziniai (pvz. šeimyninė padėtis, ilgalaikė stresinė būsena, pvz. kortizolio „šaltinių“ aktyvavimasis / išsekimas), tiek ir psichologiniai (etinės/moralinės nuostatos, pvz. stabilumas yra vertybė; charakterio modelis, pvz. nesėkmės vengimas ar per didelis pasitikėjimas savimi) nuo kurių priklauso polinkis / galutinis sprendimas;
* dalis turimų duomenų nėra pilni / pateikiami netiksliai (pvz. įmonės dydis);
* dalis turimų duomenų neturi vienareikšmiško mato, nėra nešališkai išreiškiami / pamatuojami (pvz. darbo srityje patirtis, nurodoma metais, o ne įvardnant specifiką).
* nėra žinoma, kiek turimi duomenys atspindi momentinę asmens būseną, pvz. išsekimas, „perdegimas (angl. _Job burnout_), noras supaprastinti gyvenamąją aplinką (angl. _Career downshift_). Šią būseną laikau ypač svarbia akimirką, kai asmuo gauna darbo pasiūlymą.

[Iš šaltinių](https://www.indeed.com/lead/science-behind-job-search) matyti, kad darbo keitimo procesas susideda iš 7 nuoseklių sprendimų. Ši užduotis atitinka tik pirmąjį – angl. _Considering a change_ sprendimą:

![](https://d341ezm4iqaae0.cloudfront.net/assets/2020/02/16233227/Decision-Making-Process-1024x548.png)

Jis laikomas pačiu sun

Laikau, kad sprendimo priėmimas kardinaliai skiriasi priklausomai nuo to, ar asmuo šiuo metu dirba. O kadangi neradau straipsnių, kurie spręstų šį uždavinį tiesiogiai, skeliu jį į dvi dalis: 

* ar ieško darbo nedirbantysis;
* ar ieško naujo darbo dirbantysis.

Kadangi pirmajai daliai sprendimų neradau, dėl laiko stokos ir sprendžiu antrąją ją truputį pageneralizuodamas: 

Kiek tikėtina, jog konkretus **darbuotojas** apskritai (nebe tik kursų dalyvis) norės pakeisti darbo vietą.

  2. **Išskaidyti į dalis, uždavinius**, kuriuos išsprendus galima išspręsti ir problemą.  (0,25)

  3. Aiškiai ir suprantamai įvairių sričių **specialistams pateikti uždavinių formuluotes**  (0,5)  
  |  
  (turima omenyje ne suformuluoti užduotis skirtingiems specialistams,  
   o paaiškinti uždavinius taip, kad jų prasmę, poreikį šiuos uždavinius spręsti matytų  
   projektų vadovas, finansininkas, vadybininkas ir, pavyzdžiui, personalo vadybininkas).  

### 2. Gebėjimas argumentuotai pateikti kelis galimus problemos uždavinių sprendimus.

  1. **Įvardinti 2-4** uždavinių sprendimo **būdai**  (0,5)  
  |  
  (įvardinti, kokius metodus ar algoritmus galima būtų pritaikyti anksčiau išvardintiems uždaviniams spręsti; 
   reikia pasirinkti tik tuos uždavinius, kur reikalingas/galimas intelektualiosios sistemos taikymas).  

  2. Pateikti argumentą (pvz., nuorodą į literatūrą), **kodėl įvardintas sprendimo būdas tiktų**  (1,5)  
  |  
  (pateikti argumentus, kodėl tokio tipo uždaviniui spręsti parinkote būtent šį metodą.  
   Pavyzdžiui, gal galima rasti nuorodą į mokslo straipsnį,  
   kuriame aprašytas gėlių klasifikavimas su SOM tinklu,  
   o jūsų uždavinys yra taip pat klasifikavimo uždavinys,  
   turintis panašų požymių (įėjimų) ir klasių (išėjimų) skaičių.  
   Nuorodą galima pateikti įvardinant autorių ir metus.  
   Geriausia būtų pateikti DOI.).  

### 3. Gebėjimas įtikinti, kad jūsų priimtas sprendimas yra geriausias.

  1. Iš alternatyvų **išrinkti geriausią, optimalų sprendimą**.  (0,5)

  2. **Pateikti išskirtinius** pasirinkto sprendimo būdo **privalumus**, lyginant su alternatyviaisiais  (2,5)  
  |  
  (pateikti argumentus, kodėl jūsų pasirinktas sprendimas geresnis nei kiti.  
   Kuo kiti sprendimai yra blogesni ar mažiau tinkami problemai spręsti).  

### 4. Aiškiai pateikti sprendimą, kad būtų aišku ką turi įgyvendinti programuotojas.

  1. **Įvardinti įvestį, išvestį**  (0,5)  
  |  
  (formuluojant užduotį reikia numatyti, kokio tipo ir kokie duomenys bus pateikiami sprendimo įėjime  
   ir kokie duomenys bus gaunami išėjime,  
   bei kaip tuos išėjimo duomenis reikia interpretuoti.  
   Pavyzdžiui, sprendžiant pirmojo LD uždavinį įėjime pateikėme ne vaizdą,  
   o du iš vaizdo apskaičiuotus požymius.  
   Išėjimą turėjome vieną, o jo reikšmės 0 arba 1 nurodė,  
   kokiai klasei priklauso vaizdas, kurio požymius siuntėme į įėjimą).  

  2. **Veiksmų**, kuriuos reikia atlikti **eiliškumą**  (1)  
  |  
  (čia reiktų parašyti ar nubraižyti kažką panašaus į algoritmo schemą, kad ir ne 100% detalizuotą).  
  
  3. **Formules**, kurias reikia įgyvendinti kartu su paaiškinimu, kas įeina į formulę  (2,5)  
  |  
  (pvz., kas per kintamasis ir iš kur jį paimti.  
   Reiktų pabandyti surašyti (ar išsikopijuoti iš interneto) formules, kurios matematine kalba aprašo tai,  
   ką intelektualioji sistema turi atlikti su įėjimo duomenimis tam,  
   kad gautų išėjimo duomenis.  
   Mokymo procese naudojamas formules galima praleisti, jei mokymas atliekamas tik vieną kartą.).  

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTkyNTM4NTY2NCwtNTU4NTQ3Njc1LDk4MT
M4Mjc3MiwtMjMzMTUyNjgzLC00NTg0MDIyMiw5NDY0NDgwMDQs
LTcwOTQwMzQ4OV19
-->