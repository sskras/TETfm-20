

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
* Tikslumo kriterijaus pasirinkimas (Accuracy, Precision, Recall, F_1, AUC);
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

---
### 2. Gebėjimas argumentuotai pateikti kelis galimus problemos uždavinių sprendimus.

  1. **Įvardinti 2-4** uždavinių sprendimo **būdai**  (0,5)  

* Daugiasluoksnis perceptronas (angl. MLP)
* Random Forest (RF)
* Alternating Decision Tree (ADT)
* Gradient Boosting Decision Tree (GBDT)

Ir priedas jiems:

* Dynamic Bipartite Graph Embedding (DBGE)

---
  2. Pateikti argumentą (pvz., nuorodą į literatūrą), **kodėl įvardintas sprendimo būdas tiktų**  (1,5)  

[Zhao, Y., Hryniewicki, M. K., Cheng, F., Fu, B., & Zhu, X. (2018, September). Employee turnover prediction with machine learning: A reliable approach. In _Proceedings of SAI intelligent systems conference_ (pp. 737-758). Springer, Cham.](https://doi.org/10.1007/978-3-030-01057-7_56)

Remdamasis šia publikacija pasirinkau **ADT**, **MLP** ir **RF**. Jie duoda aukščiausius rezultatus:
![image](https://user-images.githubusercontent.com/74717106/107560615-3c1b3c00-6be6-11eb-95c7-976db6640d71.png)  
(Tikslumo kriterijumi pasirinkau AUC (klasių išsibalansavimui įvertinti)

O pagal šios publikacijos aukščiausius rezultatus pasirinkau jau minėtą RF bei **GBDT**:  
[Cai, X., Shang, J., Jin, Z., Liu, F., Qiang, B., Xie, W., & Zhao, L. (2020). DBGE: employee turnover prediction based on dynamic bipartite graph embedding.  _IEEE Access_,  _8_, 10390-10402.](https://doi.org/10.1109/ACCESS.2020.2965544)

![image](https://user-images.githubusercontent.com/74717106/107560048-8b14a180-6be5-11eb-8500-d39745f61ab9.png)

Tačiau šis straipsnis pasiūlė susieti kandidato darbo patirtį (buvusių darbdavių keitimo laikus) su darbdavių įmonėmis specifiniu grafu:
![image](https://user-images.githubusercontent.com/74717106/107562084-0a0ad980-6be8-11eb-98a3-4d052a3eb6bc.png)

Turint tokią informaciją (jei tiksliai užpildyti tokie duomenys) padidėja visų metodų tikslumas:
![image](https://user-images.githubusercontent.com/74717106/107561899-c57f3e00-6be7-11eb-901e-f45b19ceaedb.png)

----
### 3. Gebėjimas įtikinti, kad jūsų priimtas sprendimas yra geriausias.

  1. Iš alternatyvų **išrinkti geriausią, optimalų sprendimą**.  (0,5)

Iš **ADT**, **MLP**, **RF** ir **GBDT** rinkčiausi **MLT** kaip praktiškai pažįstamą metodą, bet neturiu duomenų, kaip jo tikslumą keičia **DBGE**.

Tad renkuosi intelektualųjį **RF** metodą. Taip pat siūlau jį kombinuoti su **DBGE** metodu.

Taip pat **RF** „laimi“ ir šioje, kiek senesnėje publikacijoje:  
[Ribes, E., Touahri, K., & Perthame, B. (2017). Employee turnover prediction and retention policies design: a case study.  _arXiv preprint arXiv:1707.01377_.](https://arxiv.org/abs/1707.01377)

![image](https://user-images.githubusercontent.com/74717106/107563709-12641400-6bea-11eb-8bc5-f4cb9bde5eb0.png)

---
  2. **Pateikti išskirtinius** pasirinkto sprendimo būdo **privalumus**, lyginant su alternatyviaisiais  (2,5)  

Pagal **AUC** kriterijų **RF** „laimi“ visose trijose apžvelgtose publikacijose. Bet to, jis yra gan paprastas, jau klasikinis metodas vadinamojoje (angl.) _Ensemble Learning_ srityje.

**DBGE** algoritmas yra naujovė. Jis patikslina visus tirtus _Tree-based_ metodus 1–6 procentais. Todėl jei anketose atsispindi pakankamai daug darbdavių keitimo dinamikos, jį irgi naudočiau.  

![image](https://user-images.githubusercontent.com/74717106/107560090-98319080-6be5-11eb-8ff6-38d32702374e.png)

---
### 4. Aiškiai pateikti sprendimą, kad būtų aišku ką turi įgyvendinti programuotojas.

  1. **Įvardinti įvestį, išvestį**  (0,5)  

Įvestis yra slankaus kablelio tipo vektorius, sudarytas iš anketoje pateikiamų duomenų. Tiesa, metrikos aprašyti darbo srityje patirčiai nesugalvojau – reikėtų atskiro tyrimo, galbūt eksperimentinio.

Išvestis yra slankaus kablelio skaliaras, AUC-ROC rodiklis (angl. _Area under the receiver operating characteristic curve_).

Bet prototipavimo fazei siūlyčiau išėjime skaičiuoti visus 5 skaliarus:

* Accuracy, 
* Precision, 
* Recall, 
* F_1, 
* AUC-ROC
| AA | BB |
|----|----|

O po testų palikti produkcijai tik vieną.

---
  2. **Veiksmų**, kuriuos reikia atlikti **eiliškumą**  (1)  

Čia tektų konstruoti _Decision Trees_:  
![image](https://user-images.githubusercontent.com/74717106/107565706-9fa86800-6bec-11eb-8d42-1b366d940e73.png)

Tam pradėtume nuo vieno mazgo (_Node_) ir jį dalintume:  
![image](https://user-images.githubusercontent.com/74717106/107566021-0299ff00-6bed-11eb-9285-2fcb56b3d631.png)

Iki galutinio rezultato:  
![image](https://user-images.githubusercontent.com/74717106/107565776-b77fec00-6bec-11eb-9be7-25ce35e41f92.png)

---
  3. **Formules**, kurias reikia įgyvendinti kartu su paaiškinimu, kas įeina į formulę  (2,5)  

Tam naudotume statistinį Gini kriterijų:

![image](https://user-images.githubusercontent.com/74717106/107566178-3aa14200-6bed-11eb-9b49-c45cf5487502.png)

(Daugiau trūksta)

---
(Pabaiga)
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTQ5NjI0NDE2Myw4NDAzMDI3NTUsMTc1ND
U3NzI3MSwxODY2MDQ5Mjg4LDEwOTQyMjU5NDMsMTU4ODk3MjA5
NiwtMTI3NDU1MDg0OCwxNDc3MjI2MTEyLC00OTY3OTQyMjAsMj
gzNDU3Myw0OTQ3OTExODMsLTEwMTA1ODUxOCwtMTE4Mjc3MzMw
OCwtMTc4NTU1MDc4NywtMTYyOTA3MjYxNiw1ODAxMDc4MzcsLT
Q3NzM4OTM5OSwtMTUwNTk4NTIxMCwtOTMwNjE1MDE1LDY2ODY5
NDc2XX0=
-->