[Pradžia](#1)

<a id="1"></a>
---
1

## Linux PROC failinė sistema: struktūra ir savybės
### Kas tai?

- **Interfeisas į daugelį vidinių duomenų struktūrų** Linux branduolyje
- Ją turi daugelis ***nix** operacijų sistemų (OS), bet ne visos. Pvz. šios neturi:
  - _HP-UX_
  - _OpenBSD_ (nuo v5.7, 2015-05)
- Leidžia lengvai pasiekti OS informaciją (ir kai ką joje net pakeisti)
- Tam pakanka paprasčiausių failo skaitymo ar rašymo operacijų:
  - komandą `cat(1)` arba _Syscall_ `read(2)`. Pvz.:
    
    ```
    $ TODO 
    ```
  - _Shell_ nukreipimą `>` arba _Syscall_ `write(2)`.
    
    ```
    $ TODO 
    ```
- Sukūrus `/proc` failinę sistemą (FS), ji buvo skirta talpinti informaciją **apie procesus**
- Taip atspindėta pradinė Unix idėja: **_"Everything is a file"_** \
  (įskaitant procesus)
- Vėliau / Linukse pradėta talpinti informacija ir **apie visą sistemą** \
  (konkrečią mašinos ir OS kombinaciją)


[Kita](#2)

<a id="2"></a>
---
2

## Linux PROC failinė sistema: struktūra ir savybės
### Kas tai?

- Tikslus direktorijų ir failų rinkinys priklauso nuo:
  - branduolio Source kodo versijos ir revizijos (turinio);
  - tikslios branduolio konfigūracijos (daug ką įmanoma atjungti).
- Ši FS yra fantominė: 
  - ji diske fiziškai neegzistuoja;
  - dar vadinama pseudofailų sistema;
  - ją OS branduolys susikuria atmintyje.
- Direktorijų hierarchijoje ji talpinama čia: `/proc`
- Veikimo metu branduolys joje patalpina daugelį direktorijų ir failų
- Visi failai, išskyrus `/proc/kcore` ir `/proc/bus/pci/*/*`, yra 0B dydžio
- nes talpinami ne įprastoje talpykloje, o kinta kartais labai dinamiškai \
  (ir dydžių apskaičiavimas sukeltų papildomą CPU apkrovą be didesnės naudos)
- Jos failai įprastai yra tekstiniai (ASCII), bet ne visada
- Net ir kai kurie tekstiniai jos duomenys nėra lengvai skaitomi \
  (pvz. ilgai eilė skaičių, atskirtų tarpais)
- Todėl nemažai komandų tik nuskaito šiuos duomenis iš `/proc`, juos performatuoja ir išveda į ekraną patogesniu pavidalu
- Dauguma jos failų turi tik skaitymo režimą
- Tačiau daliai failų galioja ir įrašymas
- Tokiu būdu keičiami kai kurie procesų arba visos OS (branduolio) nustatymai
- Šitaip įgalinamas dinaminis keitimas: be branduolio perkompiliavimo ir be perkrovimo (kol OS veikia)
- Išsami informacija: `man proc`, 
- aprašo kiekvieną čią talpinamą failą ir tikslią jo struktūrą
- Visų šių duomenų apibendrinimui yra programa `procinfo`

#### Svarbesni failai ir direktorijos

#### Apie visą sistemą:

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

- `/proc/locks` \
  \
  Failų rakinimo sąrašas, kuriame matyti pvz.:
  - Užrakto tipas: `ADVISORY`, `MANDATORY`
  - Rakinamos prieigos tipas: `READ`, `WRITE`
  - Failą užrakinusio proceso `PID`
  - Failo identifikatorius, sudarytas iš:
    - `MAJOR-DEVICE`:
    - `MINOR-DEVICE`:
    - `INODE-NUMBER`
  - Rakinamo ruožo pradžia
  - Rakinamo ruožo pabaiga

- `/proc/meminfo` \
  Pati įvairiausia atminties (tiek fizinės, tiek `Swap`) naudojimo statistika. (Labai plati)
  
- `/proc/modules` \
  Branduolio įkeltų modulių (draiverių) sąrašas. Maždaug atitinka komandą `lsmod`.

- `/proc/net/` \
  Direktorija su informacija apie tinklo protokolų naudojimą. (Labai platu)

- `/proc/scsi/` \
  Direktorija su SCSI pasistemės informacija:
  - SCSI įrenginių sąrašas;
  - SCSI hostų ir draiverių konfigūracijas;
  - SCSI statistika.

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

  - Tokia direktorija sukuriama kiekvienam OS tuo metu vykdomam procesui.
  - Jos varde nurodomas to proceso `PID`.
  - Įdomiausi failai:

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

#### Reziume

- `/proc` FS leidžia „pjaustyti“ sistemos (ypač branduolio) būseną pačiais įvairiausiais pjūviais
- Privalumas, kad programoms (angl. _Userspace_) nebereikia kreiptis į branduolį ir naudoti „brangius“ _Syscall_ kvietimus, pvz. `ioctl(2)`.
- Trūkumas, kad sunkiau užtikrinti tarpprocesinį saugumą, informacijos nutekėjimą ir net išvengti atakų:
  - [CS 6431. Security Issues in Web Applications](https://present5.com/cs-6431-security-issues-in-web-applications-vitaly/#:~:text=What%20Can%20Be%20Learned%20from%20Proc) \
    Bent tam tikrose versijose / distribucijose (iki `2014-10-09`):
    - "Peeping Tom" ataka
    - "Memento" ataka
    - klavišų paspaudimų sekimas
    - TCP Sequence numerių nustatymas
  - [Linux Internals: How /proc/self/mem writes to unwritable memory](https://offlinemark.com/2021/05/12/an-obscure-quirk-of-proc/) \
    `2021-05` mėnesio naujiena: Proceso R/O _Virtual Memory_ puslapių pakeitimas per `/proc/*/mem`
- 
