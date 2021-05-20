### Linux PROC failinė sistema: struktūra ir savybės

- Tai paprastas kelias programoms pasiekti daugelį branduolio vidinių struktūrų \
  (panaudojant Syscall `read()`)
- Ši failinė sistema (FS) yra fantominė, ji diske fiziškai neegzistuoja
- Direktorijų hierarchijoje jos vardas `/proc`
- Ją operacijų sistemos (OS) branduolys susikuria atmintyje
- Veikimo metu branduolys joje patalpina daugelį direktorijų ir failų
- Jai atsiradus ji buvo skirta talpinti informaciją **apie procesus**
- Vėliau pradėta talpinti informacija ir **apie visą sistemą** (konkrečią mašinos ir OS kombinaciją)
- Jos failai įprastai yra tekstiniai (ASCII), bet ne visada
- Net ir kai kurie jos tekstiniai duomenys nėra lengvai skaitomi \
  (pvz. ilgai eilė skaičių, atskirtų tarpais)
- Todėl nemažai komandų tik nuskaito šiuos duomenis iš `/proc`, juos performatuoja ir išveda į ekraną patogesniu pavidalu
- Dalis šių failų reaguoja ir į įrašymą,
- Tokiu būdu keičiami kai kurie procesų arba visos OS nustatymai
- Išsami informacija: `man proc`

#### Svarbesni failai ir direktorijos

#### Apie sistemą:

- `/proc/cpuinfo` \
  Mašinos (sisteminių) procesorių duomenys: 
  - gamintojas, 
  - modelis, 
  - mikrokodo revizija, 
  - taktinis dažnis, 
  - kešo dydis, 
  - adresų magistralės plotis, 
  - ir kiti, įsk. [_Feature_ bitus](https://en.wikipedia.org/wiki/CPUID#EAX.3D1:_Processor_Info_and_Feature_Bits):
  ![image](https://user-images.githubusercontent.com/74717106/118803122-a27dbd80-b8ab-11eb-8cc4-a0f45bd7ae60.png)
  
- `/proc/filesystems` \
  Šiuo metu aptarnaujamų FS tipų (tiek fantominių, tiek tikrų) sąrašas. \
  Sąrašą sudaro tiek į branduolį statiškai įkompiliuotos, tiek ir branduolio moduliais tvarkomos FS.
  
- `/proc/interrupts` \
  I/O pertraukimų (IRQ) aktyvumo ltentelė pagal:
  - IRQ numerį,
  - aptarnaujamą I/O įrenginį,
  - aptarnaujantį CPU branduolį.
  
- `/proc/loadavg` \
  Sisteminė apkrova (angl. _System load_):
  - tai santykinis kieks procesų, kurie eilėje laukia savo kodo vykdymo;
  - jei ji < `1`, pvz. `0.8`, tada eilė nepilna, ir CPU turi `0.2` (20%) laisvo laiko;
  - jei ji > `1`, pvz. `1.8`, tada eilė užpildyta, ir `0.8` proceso laukia eilėje (CPU nespėja);
  - laukimas galimas dėl įv. priežasčių, pvz. CPU vykdo kitus procesus arba laukia I/O operacijos pabaigos.
  - Šiame faile:
    - pirmi 3 skaičiai – **apkrovos dydis** integruojant pagal **1 min., 5 min. ir 15 min.** intervalus,
    - branduolio **aktyvių procesinių vienetų** (angl. _Scheduling Entities_) skaičius,
    - branduolio **bendras procesinių vienetų** (t. y. procesų ir gijų) skaičius.
  
  Maždaug atitinka pirmą komandos `w` eilutę

- `/proc/meminfo` \
  Pati įvairiausia atminties (tiek fizinės, tiek `Swap`) naudojimo statistika. (Labai plati)
  
- `/proc/modules` \
  Branduolio įkeltų modulių (draiverių) sąrašas. Maždaug atitinka komandą `lsmod`.

- `/proc/net/` \
  Direktorija su informacija apie tinklo protokolų naudojimą. (Labai platu)

- `/proc/stat` \
  Apibendrinta CPU, atminties, procesų vykdymo ir I/O statistika.

- `/proc/sys/` \
  Direktorija su dar detalesne informacija apie sistemą. (Labai platu)

- `/proc/uptime` \
  OS gyvavimo laikas (nuo paskutinio įjungimo) ir OS „snaudimo“ (angl. _Idle_) laikas. Maždaug atitinka komandą `uptime`.

- `/proc/version` \
  Šiuo metu veikiančio (įkelto) OS branduolio versija. Maždaug atitinka komandą `uname -a`.

#### Apie procesus:

- `/proc/1/` \
  Pagrindinio OS proceso aprašo direktorija:

  - _*unix_ sistemose šis procesas dar vadinamas `init`-procesu;
  - OS procesai identifikuojami nurodant jų `PID` numerį (angl. _Process ID_);
  - `init` proceso `PID` visada yra `1`.
  
- `/proc/self` \
  Simbolinė nuorodą į tą `/proc/$PID` direktoriją, kuri aprašo patį procesą, kuris ir vykdo kreipimąsi į `/proc` failus.

- `/proc/[0-9]*/`, kur simboliais `[0-9]*` žymimas skaitinis numeris.

  - Tokia direktorija sukuriama kiekvienam OS vykdomam procesui.
  - Jos varde nurodomas to proceso `PID`.
  - Jos įdomiausi failai:

    - `/proc/$PID/cmdline` \
      Pilna proceso omandinė eilutė.

    - `/proc/$PID/cwd` \
      Dabartinė proceso darbinė direktorija.

    - `/proc/$PID/environ` \
      Proceso _Environment_ kintamieji (angl. _Environment Variables_, pvz. **PATH**).

    - `/proc/$PID/fd/` \
      Direktorija su atvirų failų deskriptorių sąrašu (programinis terminas: tai failų, soketų, branduolio sinchronizacinių objektų identifikatoriai).

    - `/proc/$PID/io` \
      Proceso I/O statistika.

    - `/proc/$PID/limits` \
      Proceso vad. resursų ribos (angl. _Limits_):

      - ribos pavadinimas,
      - Soft Limit dydis,
      - Hard Limit dydis,
      - ribos vienetai.

    - `/proc/$PID/...`
