[Pradžia](#1)

<a id="1"></a>
---
1 [Kita](#2)

## Linux PROC failinė sistema: struktūra ir savybės
### Kas tai?

- **Interfeisas į daugelį vidinių duomenų struktūrų** Linux branduolyje
- Ją turi daugelis ***nix** operacijų sistemų (OS), bet ne visos. Pvz. šios neturi:
  - _HP-UX_
  - _OpenBSD_ (nuo v5.7, 2015-05)
- Leidžia lengvai pasiekti OS informaciją (ir kai ką joje net pakeisti)
- Pakanka paprasčiausių failo skaitymo ar rašymo operacijų:
  - komandos `cat(1)` arba _Syscall_ `read(2)`. Pvz.:
    ```
    $ cat /proc/cpuinfo | egrep '^(model name|core|cpu MHz)' | sort | uniq -c
          2 core id		: 0
          2 core id		: 1
          1 cpu MHz		: 1293.945
          1 cpu MHz		: 1486.358
          1 cpu MHz		: 1548.461
          1 cpu MHz		: 1768.035
          4 model name	: Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
    ```
  - _Shell_ srauto nukreipimo `>` arba _Syscall_ `write(2)`. Pvz.:
    ```
    $ free -h
                  total        used        free      shared  buff/cache   available
    Mem:           3.6G        953M        2.0G        118M        652M        2.3G
    Swap:          8.1G          0B        8.1G
    $ sudo bash -c "echo 1 > /proc/sys/vm/drop_caches"
    $ free -h
                  total        used        free      shared  buff/cache   available
    Mem:           3.6G        953M        2.3G        116M        398M        2.3G
    Swap:          8.1G          0B        8.1G
    ```

<a id="2"></a>
---
2 [Kita](#3)

## Linux PROC failinė sistema: struktūra ir savybės
### Struktūra

- Sukūrus PROC failinę sistemą (FS), ji buvo skirta talpinti informaciją **apie procesus**
- Taip atspindėta pradinė Unix idėja: **_"Everything is a file"_** (įskaitant procesus)
- Vėliau / Linukse pradėta talpinti informacija ir **apie visą sistemą** (konkrečią mašinos ir OS kombinaciją)
- Tikslus direktorijų ir failų rinkinys priklauso nuo:
  - branduolio Source kodo versijos ir revizijos (turinio);
  - tikslios branduolio konfigūracijos (daug ką įmanoma atjungti);
  - vykdomų procesų.
- Direktorijų hierarchijoje ji talpinama čia: `/proc`
  ```
  $ ls -Al /proc
  total 0
  dr-xr-xr-x.  9 root           root                         0 May 24 14:46 1
  dr-xr-xr-x.  9 root           root                         0 May 24 14:47 10
  dr-xr-xr-x.  9 root           root                         0 May 24 11:48 1018
    ...
  dr-xr-xr-x.  4 root           root                         0 May 24 15:28 tty
  -r--r--r--.  1 root           root                         0 May 24 15:28 uptime
  -r--r--r--.  1 root           root                         0 May 24 15:28 version
  -r--------.  1 root           root                         0 May 24 15:28 vmallocinfo
  -r--r--r--.  1 root           root                         0 May 24 15:28 vmstat
  -r--r--r--.  1 root           root                         0 May 24 15:28 zoneinfo
  ```
- Ši FS yra fantominė: 
  - ji diske fiziškai neegzistuoja;
  - ją OS branduolys susikuria atmintyje;
  - dar vadinama pseudofailų sistema.

<a id="3"></a>
---
3 [Kita](#4)

## Linux PROC failinė sistema: struktūra ir savybės
### Struktūra, pratęsimas

- Veikimo metu branduolys joje patalpina daugelį direktorijų ir failų
- Visi failai, išskyrus `/proc/kcore` ir `/proc/bus/pci/*/*`, yra 0B dydžio:
  ```
  $ sudo du -hs /proc
  0	/proc
  ```
- ... nes talpinami ne įprastame kaupiklyje, o kinta dinamiškai, kartais itin staigai \
  (dydžių apskaičiavimas sukeltų papildomą CPU apkrovą be didesnės naudos, todėl neatliekamas)
- Jos failai įprastai yra tekstiniai (ASCII), bet ne visada
  ```
  $ cat /proc/loadavg 
  0.14 0.16 0.15 1/909 24928
  ```
- Net ir kai kurie tekstiniai jos duomenys nėra lengvai skaitomi \
  (pvz. ilgai eilė skaičių, atskirtų tarpais)
- Todėl nemažai komandų tik nuskaito šiuos duomenis iš `/proc`, juos performatuoja ir išveda į ekraną patogesniu pavidalu
- Dauguma jos failų turi tik skaitymo režimą
- Tačiau daliai failų galioja ir įrašymas
- Tokiu būdu keičiami kai kurie procesų arba visos OS (branduolio) nustatymai
- Ir įgalinamas dinaminis keitimas: be branduolio perkompiliavimo ir be perkrovimo (kol OS veikia)
- Išsami informacija: `man proc`, 
- aprašo kiekvieną čią talpinamą failą ir tikslią jo struktūrą
- Visų šių duomenų apibendrinimui yra programa `procinfo`

<p>&nbsp;</p>

<a id="4"></a>
---
4 [Kita](#5)

## Linux PROC failinė sistema: struktūra ir savybės
### Svarbesni failai ir direktorijos
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
  
<a id="5"></a>
---
5 [Kita](#6)

## Linux PROC failinė sistema: struktūra ir savybės
### Svarbesni failai ir direktorijos, patęsimas
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
  - tai santykinis kiekis procesų, kurie eilėje laukia savo kodo vykdymo;
  - jei ji < `1`, pvz. `0.8`, tada eilė nepilna, ir CPU turi `0.2` (20%) laisvo laiko;
  - jei ji > `1`, pvz. `1.8`, tada eilė užpildyta, ir `0.8` proceso laukia eilėje (CPU nespėja);
  - laukimas galimas dėl įv. priežasčių, pvz. CPU vykdo kitus procesus arba laukia I/O operacijos pabaigos.
  - Šiame faile:
    - pirmi 3 skaičiai – **apkrovos dydis** integruojant pagal **1 min., 5 min. ir 15 min.** intervalus,
    - branduolio **aktyvių procesinių vienetų** (angl. _Scheduling Entities_) skaičius,
    - branduolio **bendras procesinių vienetų** (t. y. procesų ir gijų) skaičius.
  
  Maždaug atitinka pirmą komandos `w` išvestą eilutę

<p>&nbsp;</p>

<a id="6"></a>
---
6 [Kita](#7)

## Linux PROC failinė sistema: struktūra ir savybės
### Svarbesni failai ir direktorijos, patęsimas

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

<p>&nbsp;</p>
<p>&nbsp;</p>

<a id="7"></a>
---
7 [Kita](#8)

## Linux PROC failinė sistema: struktūra ir savybės
### Svarbesni failai ir direktorijos, patęsimas

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

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

<a id="8"></a>
---
8 [Kita](#9)

## Linux PROC failinė sistema: struktūra ir savybės
### Svarbesni failai ir direktorijos, patęsimas
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

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

<a id="9"></a>
---
9 [Kita](#10)

## Linux PROC failinė sistema: struktūra ir savybės
### Svarbesni failai ir direktorijos, pabaiga
#### Apie procesus:

- ...
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

<p>&nbsp;</p>

<a id="10"></a>
---
10 [Kita](#11)

### Apibendrinimas

- `/proc` FS leidžia „pjaustyti“ sistemos (ypač branduolio) būseną pačiais įvairiausiais pjūviais
- Privalumas, kad programoms (angl. _Userspace_) nebereikia kreiptis į branduolį ir naudoti „brangius“ _Syscall_ kvietimus, pvz. `ioctl(2)`.
- Trūkumas, kad sunkiau užtikrinti tarpprocesinį saugumą, informacijos nutekėjimą ir išvengti atakų:
  - [CS 6431. Security Issues in Web Applications](https://present5.com/cs-6431-security-issues-in-web-applications-vitaly/#:~:text=What%20Can%20Be%20Learned%20from%20Proc) \
    Bent tam tikrose versijose / distribucijose (iki `2014-10-09`):
    - "Peeping Tom" ataka
    - "Memento" ataka
    - klavišų paspaudimų sekimas
    - TCP Sequence numerių nustatymas
  - [Linux Internals: How /proc/self/mem writes to unwritable memory](https://offlinemark.com/2021/05/12/an-obscure-quirk-of-proc/) \
    `2021-05` mėnesio naujiena: Proceso R/O _Virtual Memory_ puslapių pakeitimas per `/proc/*/mem`
- Trūkumas #2: nuo branduolio konfigūracijos priklausanti ir evoliuciškai besikeičianti struktūra.

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

<a id="11"></a>
---
11 (paskutinė skaidrė)

## Linux PROC failinė sistema: struktūra ir savybės
### Literatūra

- `2001-12-03` https://tldp.org/LDP/sag/html/proc-fs.html  
- `2004-07-30` https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html
- `2009-06-09` https://www.kernel.org/doc/html/latest/filesystems/proc.html
- `2014-10-09` https://present5.com/cs-6431-security-issues-in-web-applications-vitaly/
- `2018-10-10` https://ops.tips/blog/a-month-of-proc/
- `2018-10-25` https://ops.tips/blog/what-is-that-proc-thing/
- `2019-01-31` https://www.geeksforgeeks.org/proc-file-system-linux/
- `2019-04-27` https://speakerdeck.com/samuelkarp/linux-container-primitives-cgroups-namespaces-and-more-linuxfest-northwest-2019
- `2020-03-16` https://www.redhat.com/sysadmin/linux-proc-filesystem
- `2020-04-02` https://opensource.com/article/20/4/proc-filesystem
- `2020-06-24` https://www.journaldev.com/41537/proc-file-system-in-linux
- `2021-01-14` https://en.wikipedia.org/wiki/Procfs

<p>&nbsp;</p>

# Labai dėkoju Jums už dėmesį :)

### Ir laukiu klausimų (nuo pačių paprasčiausių)

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
