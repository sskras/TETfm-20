
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
  
Problemą sieju su psichologijos (turbūt socialinės psichologijos) sritimi: nuspėti asmens polinkį keisti darbą (ar įsidarbinti, jei šiuo metu asmuo nedirba) pagal ribotą duomenų rinkinį. 

Angl. terminai, kuriais rėmiausi ieškodamas sprendimo būdų:

* _Job offer acceptance_
* _Job offer turndown_
* _Job acceptance decisions_
* _Job search behaviour_
* _Career decision making process_
* _Staff turnover_
* _Voluntary employee turnover_

Probleminės-informacinės vietos:

* turimi ne visi duomenys apie asmenį. Tiek fiziniai (pvz. šeimyninė padėtis, ilgalaikė stresinė būsena, pvz. kortizolio „šaltinių“ aktyvavimasis / išsekimas), tiek ir psichologiniai (etinės/moralinės nuostatos, pvz. stabilumas yra vertybė; charakterio modelis, pvz. nesėkmės vengimas ar per didelis pasitikėjimas savimi) nuo kurių priklauso polinkis / galutinis sprendimas;
* dalis turimų duomenų nėra pilni / pateikiami netiksliai (pvz. įmonės dydis);
* dalis turimų duomenų neturi savo metro / tikslaus mato, t. y. nėra nešališkai išreiškiami / pamatuojami (pvz. darbo srityje patirtis, nurodoma metais, o ne įvardnant specifiką).
* nėra žinoma, kiek turimi duomenys atspindi momentinę asmens būseną, pvz. išsekimas, „perdegimas (angl. _Job burnout_), noras supaprastinti gyvenamąją aplinką (angl. _Career downshift_). Šią būseną laikau ypač svarbia akimirką, kai asmuo gauna darbo pasiūlymą.

[Iš šaltinių](https://www.indeed.com/lead/science-behind-job-search) matyti, kad darbo keitimo procesas susideda iš 7 nuoseklių sprendimų. Ši užduotis mano interpretavimu atitinka patį pirmąjį – angl. _Considering a change_ sprendimą:

![image](https://user-images.githubusercontent.com/74717106/107552178-cb6f2200-6bdb-11eb-8139-f0bfba2ed833.png)

Iš visų septynių jis, *sprendimas priimti pokytį* laikomas asmeniui pačiu sunkiausiu. Apskritai karjeriniai sprendimai yra vieni iš sunkiausių gyvenimo pokyčių, ir Holmes-Rache streso skalėje perkopia vidurį (36):

![image](https://user-images.githubusercontent.com/74717106/107552209-d45ff380-6bdb-11eb-980c-591d8edb205b.png)

Pagal literatūros paieškos rezultatus panašu, kad šį sprendimą sunku ne tik priimti, bet ir prognozuoti.

Laikau, kad sprendimo priėmimas keičiasi iš esmės priklausomai nuo to, ar asmuo šiuo metu dirba. Kadangi neradau šaltinių kaip spręsti šį uždavinį tiesiogiai, skeliu jį į dvi dalis:

* ar ieško darbo nedirbantysis;
* ar ieško naujo darbo dirbantysis.

Ir dėl laiko stokos bei dabartinės epidemi-socio-ekonominės situacijos (kai bedarbis turi labai stiprių stimulų įsidarbinti), sprendžiu tik antrąją, ją truputį pageneralizuodamas:

Kiek tikėtina, jog konkretus **darbuotojas** apskritai (nebe tik kursų dalyvis) norės pakeisti darbo vietą?

(Galutiniais angl. raktiniais terminais pasirinkau _Voluntary employee turnover_ ir _Career path prediction_)

---
  2. **Išskaidyti į dalis, uždavinius**, kuriuos išsprendus galima išspręsti ir problemą.  (0,25)

* Mato (metrikos) aprašymas / sukūrimas kiekvienam duomenų tipui, kurį paduosime modeliui;  
  (pvz. kaip skaičiumi aprašyti darbdavio tipą – konstantų enumeracija?)
* Anketos duomenų suskaitmeninimas;
* Paieška intelektualiųjų metodų, kurie apskritai tinka karjeros pasikeitimų prognozėms;
* Kelių metodų turimam duomenų (angl. _Features_) rinkiniui apdroti parinkimas. Į tai įeina
  * įėjimų filtravimo būdo parinkimas (jei išvis priimtina, angl. _Feature selection_);
  * klasifikavimo metodo parinkimas;
* Tikslumo kriterijau pasirinkimas (Accuracy, Precision, Recall, F_1, AUC);
* Tiksliausiai prognozuojančios kombinacijos išrinkimas (sparta čia nesvarbu).
* Apmokymo duomenų rinkinio paieška;
* Intelektualiosios sistemos prototipo programavimas;
* Intelektualiosios sistemos apmokymas;
* Intelektualiosios sistemos tikslumo įvertinimas.
* Intelektualiosios sistemos tikslumo testavimas ir produkcija.
* Frontendo šiai sistemai sukūrimas.

---
  3. Aiškiai ir suprantamai įvairių sričių **specialistams pateikti uždavinių formuluotes**  (0,5)  

* Analizuoti ir paruošti anketų duomenis;
* Atlikti intelekualiojo metodo parinkimą;
* Sukurti intelektualiąją sistemą;
* Ištestuoti ją ir paruošti naudojimui.

### 2. Gebėjimas argumentuotai pateikti kelis galimus problemos uždavinių sprendimus.

  1. **Įvardinti 2-4** uždavinių sprendimo **būdai**  (0,5)  

* Daugiasluoksnis perceptronas (angl. MLP)
* Random Forest (RF)
* XGBoost (XGB)
* Gradient Boosting Decision Tree (GBDT)
* Dynamic Bipartite Graph Embedding (DBGE)

---
  2. Pateikti argumentą (pvz., nuorodą į literatūrą), **kodėl įvardintas sprendimo būdas tiktų**  (1,5)  
  |  
  (pateikti argumentus, kodėl tokio tipo uždaviniui spręsti parinkote būtent šį metodą.  
   Pavyzdžiui, gal galima rasti nuorodą į mokslo straipsnį,  
   kuriame aprašytas gėlių klasifikavimas su SOM tinklu,  
   o jūsų uždavinys yra taip pat klasifikavimo uždavinys,  
   turintis panašų požymių (įėjimų) ir klasių (išėjimų) skaičių.  
   Nuorodą galima pateikti įvardinant autorių ir metus.  
   Geriausia būtų pateikti DOI.).  

[Zhao, Y., Hryniewicki, M. K., Cheng, F., Fu, B., & Zhu, X. (2018, September). Employee turnover prediction with machine learning: A reliable approach. In _Proceedings of SAI intelligent systems conference_ (pp. 737-758). Springer, Cham.](https://doi.org/10.1007/978-3-030-01057-7_56)

Remdamasis šia publikacija pasirinkau **MLP** ir **RF**. Jie ir mano nepasirinktas ADT metodas duoda aukštus rezultatus:
![image](https://user-images.githubusercontent.com/74717106/107560615-3c1b3c00-6be6-11eb-95c7-976db6640d71.png)

(ADT, angl. _Alternating decision tree_ nesirinkau kaip labiau statistinio, o ne intelektualiojo metodo)

[Cai, X., Shang, J., Jin, Z., Liu, F., Qiang, B., Xie, W., & Zhao, L. (2020). DBGE: employee turnover prediction based on dynamic bipartite graph embedding.  _IEEE Access_,  _8_, 10390-10402.](https://doi.org/10.1109/ACCESS.2020.2965544)

O pagal šios publikacijos aukščiausius rezultatus pasirinkau

![image](https://user-images.githubusercontent.com/74717106/107560048-8b14a180-6be5-11eb-8500-d39745f61ab9.png)

![image](https://user-images.githubusercontent.com/74717106/107560090-98319080-6be5-11eb-8ff6-38d32702374e.png)


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
eyJoaXN0b3J5IjpbMTkwMzc3MDA0OSwtMTE4Mjc3MzMwOCwtMT
c4NTU1MDc4NywtMTYyOTA3MjYxNiw1ODAxMDc4MzcsLTQ3NzM4
OTM5OSwtMTUwNTk4NTIxMCwtOTMwNjE1MDE1LDY2ODY5NDc2LD
ExMTYxNDYxMjksLTU1NzA2NzY4OSwtMTg3ODg2NDk5Myw3MTE5
Mzg5OTUsMTE4MDk0NjY3NSwxOTUyMDMxOTk5LC0xMTIzODgzOT
MxLDk5MjY1NjExMSwtOTI1Mzg1NjY0LC01NTg1NDc2NzUsOTgx
MzgyNzcyXX0=
-->