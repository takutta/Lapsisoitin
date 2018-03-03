Lapsisoitin
===========

Vaatii toimiakseen seuraavat ohjelmat:
  * [FlickFetch](http://flickfetch.bplaced.net/)
  * [VLC](http://www.videolan.org/vlc/)

Tällä ohjelmalla voit kätevästi valita useamman ohjelman, jonka jälkeen ne näytetään peräkkäin. Sitten kone menee unitilaan. Ohjelma samoja sivustoja mitä FlickFetchikin (Yle Areena, Yle Elävä Arkisto, Ruutu ja TV5), mutta näiden lisäksi myös [TV7](http://www.tv7.fi/vod/):aa. Ohjelmaa on testattu vain Yle Areenan ja TV7:n kanssa.

Kopioi videon osoitteet sivustolta ja liitä ne ohjelmaan. Voit liittää yhteensä 7 videon osoitteet. Kätevämpi ratkaisu on käyttää Google Chromen [Copy all Urls](https://chrome.google.com/webstore/detail/copy-all-urls/djdmadneanknadilpjiknlnanaolmbfk) -lisäosaa, ja kopioida osoitteet leikepöydälle. Siinä tapauksessa ei tarvitse lisätä kenttiin mitään, vaan voi painaa suoraan OK. Ohjelma hakee osoitteet suoraan leikepöydältä.

Ohjelmassa on muutamia asetuksia, joita voi vaihtaa lapsisoitin.ini -tiedostoa muokkaamalla:
  * FlickFetchin sijainti (käyttäjän nimi pakko vaihtaa!)
  * VLC playerin sijainti
  * Käytetäänkö oletusselainta
  * Oman selaimen valinta
  * Käynnistetäänkö Yle-Areena automaattisesti?
  * Mikä sivu silloin avataan (oletuksena Omat Suosikit)
  * Käynnistetäänkö TV7 automaattisesti?
  * Mikä sivu silloin avataan (oletuksena lasten ohjelmat)
  * Mennäänkö lopuksi unitilaan?

Ohjelma on tehty AutoHotkeyllä (hakemistossa alkuperäinen skripti).

Tekijä:
Jaakko Haavisto,
jaaxtra@gmail.com

Muutosloki:

1.3.1
- Viimeisin päivitys rikkoi TV7:n ohjelmien lataamisen. Nyt on korjattu.

1.3
- Ohjelma lataa nyt yhden videon kerrallaan ja jää taustalle lataamaan seuraavaa

1.2 
- TV7 -mahdollisuus lisätty
- Nimi ja kuvake vaihdettu

1.1
- Latausohjelma vaihdettu StreamDownloader --> Flickfetch
- Bugeja korjattu

1.0
- Ensimmäinen versio
