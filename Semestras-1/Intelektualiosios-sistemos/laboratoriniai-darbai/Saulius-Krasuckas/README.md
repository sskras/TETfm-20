Bandysiu čia kelti savo failus.

(jeigu nepatiks, perkelsiu į https://github.com/Saulius-Krasuckas)

# IS-Lab2 (LT)
Intelektualiosios sistemos. Antrojo laboratorinio darbo užduotis.

### Tikslas
Išmokti savarankiškai suprogramuoti paprasto netiesinio aproksimatoriaus mokymo (parametrų skaičiavimo) algoritmą.

### Užduotys (maks. 8 balai)
1. Sukurkite daugiasluoksnio perceptrono koeficientams apskaičiuoti skirtą programą. Daugiasluoksnis perceptronas turi atlikti aproksimatoriaus funkciją. Daugiasluoksnio perceptrono struktūra:
- vienas įėjimas (įėjime paduodamas 20 skaičių vektorius X, su reikšmėmis intervale nuo 0 iki 1, pvz., x = 0.1:1/22:1; ).
- vienas išėjimas (pvz., išėjime tikimasi tokio norimo atsako, kurį galima būtų apskaičiuoti pagal formulę: y = (1 + 0.6\*sin(2\*pi\*x/0.7)) + 0.3\*sin(2\*pi\*x))/2; - kuriamas neuronų tinklas turėtų "modeliuoti/imituoti šios formulės elgesį" naudodamas visiškai kitokią matematinę išraišką nei ši);
- vienas paslėptasis sluoksnis su hiperbolinio tangento arba sigmoidinėmis aktyvavimo funkcijomis neuronuose (neuronų skaičius: 4-8);
- tiesine aktyvavimo funkcija išėjimo neurone;
- mokymo algoritmas - Backpropagation (atgalinio sklidimo).

### Papildoma užduotis (papildomi 2 balai)
2. Išspręskite paviršiaus aproksimavimo uždavinį, kai tinklas turi du įėjimus ir vieną išėjimą.

### Rekomenduojama literatūra
- Neural Networks and Learning Machines (3rd Edition), <...> psl., <...> lentelė

## Sprendimas

Pasirenku [šią funkciją](https://www.desmos.com/calculator/ydjfscafzm): y = 5 sin(x) + 4 cos(2x + 3π)

![image](https://user-images.githubusercontent.com/74717106/104397405-6b8e4880-5555-11eb-9c86-ac6ed781197f.png)
