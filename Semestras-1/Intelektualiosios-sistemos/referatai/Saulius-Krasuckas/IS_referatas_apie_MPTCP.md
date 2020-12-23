TCP sukurtas patikimam duomenų perdavimui IP tinklais, jame:

* išlaikomas paketų eiliškumas,
* ištaisomos klaidos,
* pranešamas siuntimo rezultatas,

Vienos sesijos duomenims perduoti TCP įprastai naudoja tik vieną IP interfeisą.
Nuo ~2010 m. ėmė plisti galiniai tinklo įrenginiai su keletu interfeisų, veikiančių vienu metu (LAN, DSL, Wi-Fi, LTE tinkluose).
Kartu kilo ir poreikis TCP sesijos duomenis perduoti keliais interfeisais iš karto (pvz. pralaidumui ar patikimumui didinti).

Tam pradėtas kurti TCP standarto papildymas _Multipath TCP (MPTCP)_, suderinamas su esamais TCP/IP infrastruktūra.
Jis aplikacijai leidžia (tos pačios) TCP sesijos duomenis perduoti keletu lygiagrečių MPTCP posrūvių (angl. _Subflow_).
[[1]](#1)

Įprastai posrūvių paketai keliauja per skirtingus IP interfeisus.
Tačiau įmanoma kelis posrūvius užmegzti ir per tą patį interfeisą.

Vienas esminių tiek TCP, tiek MPTCP mechanizmų yra tinklo perkrovų valdymas (angl. _Congestion Control_).
Jis keičia srauto patekimą į tinklą ir leidžia šiame išvengti perkrovų (grūsčių).
Įprastai tam būna mažinama paketų išsiuntimo sparta.

    Apibrėžimai iš [1] ir Wiki:  
    - https://en.wikipedia.org/wiki/Transmission_Control_Protocol  
    - https://en.wikipedia.org/wiki/Network_congestion#Congestion_control  

<div style="page-break-after: always;"></div>


# Santrumpos

| Santrumpa                | Pilnas terminas                                                                                                                     | 
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------| 
| IP                       | (angl. Internet Protocol) TODO?
| TCP                      | (angl. Transmission Control Protocol) TODO?
| MPTCP                    | (angl. Multipath TCP) TODO?


# Terminai užsienio kalba

| Terminas                 | Vertimas į lietuvių k.                                                                                                              | 
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------| 
| Congestion               | Grūstis
| Congestion control       | Perkrovų valdymas
| Subflow                  | Posrūvis (nuo žodžio „srovė“) arba* Posrautis (nuo žodžio „srautas“), angl. _Flow_.
| Rate of packets          | Paketų išsiuntimo sparta

[*] – jei nesimaišys su angl. _Stream_


# Literatūra

## Straipsniai

<a id="1">**1.**</a>
LI, Wenzhong, et al. **SmartCC: A Reinforcement Learning Approach for Multipath TCP Congestion Control in Heterogeneous Networks**. IEEE Journal on Selected Areas in Communications, **2019**, 37.11: 2621-2633.  
https://doi.org/10.1109/JSAC.2019.2933761

    Google Scholar cites: 7   
    2019 JCR Impact Factor: 2/90 (Q1, Telecomunications)  
    2019 Journal Impact Factor: 11.420    
    5-Year impact factor: 9.803  

<a id="2">**2**.</a>
JI, Ruiwen, et al. **Multipath TCP-Based IoT Communication Evaluation: From the Perspective of Multipath Management with Machine Learning**. Sensors, **2020**, 20.22: 6573.  
https://doi.org/10.3390/s20226573

    Google Scholar cites: 0   
    2019 JCR Impact Factor: 77/266 (Q2, Engineering, electrical & electronic)  
    2019 Journal Impact Factor: 3.275  
    5-Year impact factor: 3.427  

<a id="3">**3**.</a>
WANG, Ting, et al. **Towards bandwidth guaranteed energy efficient data center networking**. Journal of Cloud Computing, **2015**, 4.1: 9.  
https://doi.org/10.1186/s13677-015-0035-7

    Google Scholar cites: 19   
    2019 JCR Impact Factor: 66/156 (Q2, Computer science, information systems)  
    2019 Journal Impact Factor: 2.788  
    5-Year impact factor: --  
    2018 JCR Impact Factor: 79/155 (Q3. Computer science, information systems)  
    2018 Journal Impact Factor: 2.140  

## Konferencijos

<a id="4">**4**.</a>
JIN, Heesang, et al. **CLEO: Machine learning for ECMP**. In: Proceedings of the 15th International Conference on emerging Networking EXperiments and Technologies. **2019**. p. 1-3.  
https://doi.org/10.1145/3360468.3366768

    Google Scholar cites: 0  
    Google Scholar H5-index: 13  
    Guide2Research Impact Score: 4.46  

<a id="5">**5**.</a>
SILVA, Fabio; TOGOU, Mohammed Amine; MUNTEAN, Gabriel-Miro. **AVIRA: Enhanced Multipath for Content-aware Adaptive Virtual Reality**. In: 2020 International Wireless Communications and Mobile Computing (IWCMC). IEEE, **2020**. p. 917-922.  
https://doi.org/10.1109/IWCMC48107.2020.9148293

    Google Scholar cites: 0  
    Google Scholar H5-index: 11  
    Guide2Research Impact Score: 3.96  

<a id="6">**6**.</a>
MAI, Tianle, et al. **Self-learning Congestion Control of MPTCP in Satellites Communications**. In: 2019 15th International Wireless Communications & Mobile Computing Conference (IWCMC). IEEE, **2019**. p. 775-780.  
https://doi.org/10.1109/IWCMC.2019.8766465

    Google Scholar cites: 2  
    Google Scholar H5-index: 11  
    Guide2Research Impact Score: 3.96  

<a id="7">**7**.</a>
HÖCHST, Jonas, et al. **Learning Wi-Fi Connection Loss Predictions for Seamless Vertical Handovers Using Multipath TCP**. In: 2019 IEEE 44th Conference on Local Computer Networks (LCN). IEEE, **2019**. p. 18-25.  
https://doi.org/10.1109/LCN44214.2019.8990753

    Google Scholar cites: 0  
    Google Scholar H5-index: 6  
    Guide2Research Impact Score: 2.31  

<a id="8">**8**.</a>
CHUNG, Jonghwan, et al. **Machine learning based path management for mobile devices over MPTCP**. In: 2017 IEEE International Conference on Big Data and Smart Computing (BigComp). IEEE, **2017**. p. 206-209.  
https://doi.org/10.1109/BIGCOMP.2017.7881739

    Google Scholar cites: 14  
    Google Scholar H5-index: 5  
    Guide2Research Impact Score: 1.65  

<a id="9">**9**.</a>
THAKUR, Neha Rupesh; KUNTE, Ashwini S. **Analysis of MPTCP Packet Scheduling, The Need of Data Hungry Applications**. In: Inventive Communication and Computational Technologies. Springer, Singapore, **2020**. p. 599-617.  
https://doi.org/10.1007/978-981-15-0146-3_57

    Google Scholar cites: 0  
    Google Scholar H5-index: --  
    Guide2Research Impact Score: --  

<a id="10">**10**.</a>
LIU, Peixiang. **Using Random Neural Network for Load Balancing in Data Centers**. In: Proceedings on the International Conference on Internet Computing (ICOMP). The Steering Committee of The World Congress in Computer Science, Computer Engineering and Applied Computing (WorldComp), **2015**. p. 3.  
https://www.semanticscholar.org/paper/Using-Random-Neural-Network-for-Load-Balancing-in-Liu/19b16c8d11beadcf95fbfecc5f8dd2117a130ba2

    Google Scholar cites: 2  
    Google Scholar H5-index: --  
    Guide2Research Impact Score: --  

<a id="11">**11**.</a>
WILSONPRAKASH, S.; DEEPALAKSHMI, P. **Artificial Neural Network Based Load Balancing On Software Defined Networking**. In: 2019 IEEE International Conference on Intelligent Techniques in Control, Optimization and Signal Processing (INCOS). IEEE, **2019**. p. 1-4.  
https://doi.org/10.1109/INCOS45849.2019.8951365

    Google Scholar cites: 0  
    Google Scholar H5-index: --  
    Guide2Research Impact Score: --  

