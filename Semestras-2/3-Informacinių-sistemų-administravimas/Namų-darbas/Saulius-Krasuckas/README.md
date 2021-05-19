### Linux PROC failinė sistema: struktūra ir savybės

- Ši failinė sistema (FS) yra fantominė (diske neegzistuoja)
- Direktorijų hierarchijoje ji yra čia: `/proc`
- Ją kernelis sukuria atmintyje
- Pradžioj ji buvo sukurta talpinti informacijai apie procesus
- Vėliau pradėta talpinti informacija ir apie visą sistemą (konkrečią mašinos ir OS kombinaciją)
- Išsami informacija: `man proc`

Svarbesni failai ir direktorijos:

- `/proc/1` \
  Pagrindinio OS (`init`) proceso, turinčio `PID` numerį `1`, direktorija.
  
- `/proc/cpuinfo`
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
  Šiuo metu aptarnaujamų FS tipų (tiek fantominių, tiek tikrų) sąrašas.
  
- `/proc/interrupts` \
  I/O pertraukimų (IRQ) aktyvumo ltentelė pagal:
  - IRQ numerį,
  - aptarnaujamą I/O įrenginį,
  - aptarnaujantį CPU branduolį.
  
- `/proc/loadavg` \
  Sisteminė apkrova (angl. System load):
  - tai santykinis kieks procesų, kurie eilėje laukia savo kodo vykdymo;
  - jei ji < `1`, pvz. `0.8`, tada eilė nepilna, ir CPU turi `0.2` (20%) laisvo laiko;
  - jei ji > `1`, pvz. `1.8`, tada eilė užpildyta, ir `0.8` proceso laukia eilėje (CPU nespėja);
  - laukimas galimas dėl įv. priežasčių, pvz. CPU vykdo kitus procesus arba laukia I/O operacijos pabaigos.
  - Šiame faile:
    - 3 skaičiai tai **apkrovos dydis** integruojant pagal **1 min., 5 min. ir 15 min.** intervalus,
    - branduolio **aktyvių procesinių vienetų** (angl. Scheduling Entities) skaičius,
    - branduolio **bendras procesinių vienetų** (t. y. procesų ir gijų) skaičius.
  
- `/proc/meminfo` \
  Pati įvairiausia atminties (tiek fizinės, tiek `Swap`) naudojimo statistika. (Labai plati)
  
- `/proc/modules` \
  Branduolio įkeltų modulių (draiverių) sąrašas. (Maždaug atitinka `lsmod` parodymus)

- `/proc/net` \
  Direktorija su informacija apie tinklo protokolų naudojimą. (Labai platu)
  
- `/proc/self` \
  Simbolinė nuorodą į tą `/proc/$PID` direktoriją, kuri aprašo tą patį procesą, kuris ir kreipiasi į `/proc` duomenis.

