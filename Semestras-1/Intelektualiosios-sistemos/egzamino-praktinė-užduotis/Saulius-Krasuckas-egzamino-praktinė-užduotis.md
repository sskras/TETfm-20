# IS :: Egzamino praktinė užduotis

`Data: 2021-01-11`

`Grupė: TETfm-20`

`Autorius: Saulius Krasuckas`

## 1. Diagrama ir koeficientų sužymėjimas

![image](https://user-images.githubusercontent.com/74717106/104259545-50a2d200-548a-11eb-9851-e76888a90504.png)

Duotosios aktyvavimo funkcijos:

$$
\varphi_1(v) = v \;;
$$

$$
\varphi_2(v) = \frac{1}{1+e^{-v}} \;;
$$

$$
\varphi_3(v) = \tanh(v) \;;
$$
___

## 2. Tinklo atsako skaičiavimas

### Pirmas paslėptasis sluoksnis:

$$
v_1^{(1)}(n) = x \cdot w_{11}^{(1)}(n) + b_1^{(1)}(n) ;
$$
$$
v_2^{(1)}(n) = x \cdot w_{21}^{(1)}(n) + b_2^{(1)}(n) ;
$$
$$
v_3^{(1)}(n) = x \cdot w_{31}^{(1)}(n) + b_3^{(1)}(n) ;
$$

Išėjimai:

$$
y_1^{(1)}(n) = \varphi_1(v_1^{(1)}) = v_1^{(1)}(n) ;
$$
$$
y_2^{(1)}(n) = \varphi_1(v_2^{(1)}) = v_2^{(1)}(n) ;
$$
$$
y_3^{(1)}(n) = \varphi_1(v_3^{(1)}) = v_3^{(1)}(n) ;
$$

### Antras paslėptasis sluoksnis:

$$
v_1^{(2)}(n) = y_1^{(1)}(n) \cdot w_{11}^{(2)}(n) + y_2^{(1)}(n) \cdot w_{12}^{(2)}(n) + b_1^{(2)}(n) ;
$$
$$
v_2^{(2)}(n) = y_2^{(1)}(n) \cdot w_{22}^{(2)}(n) + y_3^{(1)}(n) \cdot w_{23}^{(2)}(n) + b_2^{(2)}(n) ;
$$

Išėjimai:

$$
y_1^{(2)}(n) = \varphi_2(v_1^{(2)}) = \frac{1}{1+e^{-v_1^{(2)}(n)}} ;
$$
$$
y_2^{(2)}(n) = \varphi_2(v_2^{(2)}) = \frac{1}{1+e^{-v_2^{(2)}(n)}} ;
$$

### Išėjimo (trečias) sluoksnis:

$$
v_1^{(3)}(n) = y_1^{(2)}(n) \cdot w_{11}^{(3)}(n) + b_1^{(3)}(n) ;
$$
$$
v_2^{(3)}(n) = y_1^{(2)}(n) \cdot w_{21}^{(3)}(n) + y_2^{(2)}(n) \cdot w_{22}^{(3)}(n) + b_2^{(3)}(n) ;
$$
$$
v_3^{(3)}(n) = y_2^{(2)}(n) \cdot w_{32}^{(3)}(n) + b_3^{(3)}(n) ;
$$

Išėjimai:

$$
y_1(n) = \varphi_1(v_1^{(3)}) = \tanh(v_1^{(1)}(n)) ;
$$
$$
y_2(n) = \varphi_1(v_2^{(3)}) = \tanh(v_2^{(3)}(n)) ;
$$
$$
y_3(n) = \varphi_1(v_3^{(3)}) = \tanh(v_3^{(3)}(n)) ;
$$
___

## 3. Koeficientų tikslinimas

### Išėjimo sluoksnyje

Paklaidos:

$$
e_{rr1}(n) = d_1 - y_1(n) \;;
$$
$$
e_{rr2}(n) = d_2 - y_2(n) \;;
$$
$$
e_{rr3}(n) = d_3 - y_3(n) \;;
$$

Parenku kiek nestandartinę tikslo funkciją:

$$
\xi = \frac{1}{2}e_{rr1}^2 +  \frac{1}{3}e_{rr2}^3 +  \frac{1}{4}e_{rr3}^4 \;;
$$

Jos išvestinės:

$$
\xi'|_{e_{rr1}} = e_{rr1} \;;
$$

$$
\xi'|_{e_{rr2}} = e_{rr2}^2 \;;
$$

$$
\xi'|_{e_{rr3}} = e_{rr3}^3 \;;
$$

Gradientai:

$$
\delta_1^{(3)}(n) = \varphi_3'(v_1^{(3)}) \cdot \xi'|_{e_{rr1}} = \tanh'(v_1^{(3)})|_{v_1^{(3)}} \cdot e_{rr1} = \Big[1 - y_1^2(n) \Big] \cdot e_{rr1}(n) \;;
$$

$$
\delta_2^{(3)}(n) = \varphi_3'(v_2^{(3)}) \cdot \xi'|_{e_{rr2}} = \tanh'(v_2^{(3)})|_{v_2^{(3)}} \cdot e_{rr2} = \Big[1 - y_2^2(n) \Big] \cdot e_{rr2}^2(n) \;;
$$

$$
\delta_3^{(3)}(n) = \varphi_3'(v_3^{(3)}) \cdot \xi'|_{e_{rr3}} = \tanh'(v_3^{(3)})|_{v_3^{(3)}} \cdot e_{rr3} = \Big[1 - y_3^2(n) \Big] \cdot e_{rr3}^3(n) \;;
$$


### Koregavimas

Pirmajam neuronui:

$$
w_{11}^{(3)}(n+1) = w_{11}^{(3)}(n) + \eta \cdot \delta_1^{(3)}(n) \cdot y_1^{(2)}(n) \;;
$$

$$
b_1^{(3)}(n+1) = b_1^{(3)}(n) + \eta \cdot \delta_1^{(3)}(n) \;;
$$

Antrajam neuronui:

$$
w_{21}^{(3)}(n+1) = w_{21}^{(3)}(n) + \eta \cdot \delta_2^{(3)}(n) \cdot y_1^{(2)}(n) \;;
$$

$$
w_{22}^{(3)}(n+1) = w_{22}^{(3)}(n) + \eta \cdot \delta_2^{(3)}(n) \cdot y_2^{(2)}(n) \;;
$$

$$
b_2^{(3)}(n+1) = b_2^{(3)}(n) + \eta \cdot \delta_2^{(3)}(n) \cdot y_2^{(2)}(n) \;;
$$

Trečiajam neuronui:

$$
w_{32}^{(3)}(n+1) = w_{32}^{(3)}(n) + \eta \cdot \delta_3^{(3)}(n) \, y_2^{(2)}(n) \;;
$$

$$
b_3^{(3)}(n+1) = b_3^{(3)}(n) + \eta \cdot \delta_3^{(3)}(n) \cdot y_2^{(2)}(n) \;;
$$

### Antrame paslėptajame sluoksnyje

Gradientai:

$$
\delta_1^{(2)}(n) 
= \varphi_2'(v_1^{(2)}) \cdot \sum \delta_k^{(3)} w_{k1}^{(3)} 
= y_1^{(2)}(n) \cdot (1-y_1^{(2)}(n)) \cdot \Big[ \delta_1^{(3)}(n) \cdot w_{11}^{(3)}(n) + \delta_2^{(3)}(n) \cdot w_{21}^{(3)}(n) \Big] \;;
$$

$$
\delta_2^{(2)}(n) 
= \varphi_2'(v_2^{(2)}) \cdot \sum \delta_k^{(3)} w_{k2}^{(3)} 
= y_2^{(2)}(n) \cdot (1-y_2^{(2)}(n)) \cdot \Big[ \delta_2^{(3)}(n) \cdot w_{22}^{(3)}(n) + \delta_3^{(3)}(n) \cdot w_{32}^{(3)}(n) \Big] \;;
$$

### Koregavimas

Pirmajam neuronui:

$$
w_{11}^{(2)}(n+1) = w_{11}^{(2)}(n) + \eta \cdot \delta_1^{(2)}(n) \cdot y_1^{(1)}(n) \;;
$$

$$
w_{12}^{(2)}(n+1) = w_{12}^{(2)}(n) + \eta \cdot \delta_1^{(2)}(n) \cdot y_2^{(1)}(n) \;;
$$

$$
b_1^{(2)}(n+1) = b_1^{(2)}(n) + \eta \cdot \delta_1^{(2)}(n) \;;
$$

Antrajam neuronui:

$$
w_{22}^{(2)}(n+1) = w_{22}^{(2)}(n) + \eta \cdot \delta_2^{(2)}(n) \cdot y_2^{(1)}(n) \;;
$$

$$
w_{23}^{(2)}(n+1) = w_{23}^{(2)}(n) + \eta \cdot \delta_2^{(2)}(n) \cdot y_3^{(1)}(n) \;;
$$

$$
b_2^{(2)}(n+1) = b_2^{(2)}(n) + \eta \cdot \delta_2^{(2)}(n) \;;
$$

### Pirmame paslėptajame sluoksnyje

Gradientai:

$$
\delta_1^{(1)}(n) 
= \varphi_1'(v_1^{(1)}) \cdot \sum \delta_k^{(2)} w_{k1}^{(2)} 
= 1 \cdot \Big[ \delta_1^{(2)}(n) \cdot w_{11}^{(2)}(n) \Big] 
= \delta_1^{(2)}(n) \cdot w_{11}^{(2)}(n) \;;
$$

$$
\delta_2^{(1)}(n) 
= \varphi_1'(v_2^{(1)}) \cdot \sum \delta_k^{(2)} w_{k2}^{(2)} 
= 1 \cdot \Big[ \delta_1^{(2)}(n) \cdot w_{12}^{(2)}(n) 
+ \delta_2^{(2)}(n) \cdot w_{22}^{(2)}(n) \Big] \;;
$$

$$
\delta_3^{(1)}(n) 
= \varphi_1'(v_3^{(1)}) \cdot \sum \delta_k^{(2)} w_{k3}^{(2)} 
= 1 \cdot \Big[ \delta_2^{(2)}(n) \cdot w_{23}^{(2)}(n) \Big]
= \delta_2^{(2)}(n) \cdot w_{23}^{(2)}(n) \;;
$$

### Koregavimas

Pirmajam neuronui:

$$
w_{11}^{(1)}(n+1) = w_{11}^{(1)}(n) + \eta \cdot \delta_1^{(1)}(n) \cdot x \;;
$$

$$
b_1^{(1)}(n+1) = b_1^{(1)}(n) + \eta \cdot \delta_1^{(1)}(n) \;;
$$

Antrajam neuronui:

$$
w_{21}^{(1)}(n+1) = w_{21}^{(1)}(n) + \eta \cdot \delta_2^{(1)}(n) \cdot x \;;
$$

$$
b_2^{(1)}(n+1) = b_2^{(1)}(n) + \eta \cdot \delta_2^{(1)}(n) \;;
$$

Trečiajam neuronui:

$$
w_{31}^{(1)}(n+1) = w_{31}^{(1)}(n) + \eta \cdot \delta_3^{(1)}(n) \cdot x \;;
$$

$$
b_3^{(1)}(n+1) = b_3^{(1)}(n) + \eta \cdot \delta_3^{(1)}(n) \;;
$$
___

## Užduoties 1-3 punktų pabaiga.
