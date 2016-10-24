Lapsisoitin v1.2
**********************

Vaatii toimiakseen seuraavat ohjelmat:
  * [FlickFetch](http://flickfetch.bplaced.net/)
  * [VLC](http://www.videolan.org/vlc/)

Tällä ohjelmalla voit kätevästi valita useamman ohjelman, jonka jälkeen ne näytetään peräkkäin. Sitten kone menee unitilaan. Ohjelma samoja sivustoja mitä FlickFetchikin (Yle Areena, Yle Elävä Arkisto, Ruutu ja TV5), mutta näiden lisäksi myös [TV7](http://www.tv7.fi/vod/):aa. Ohjelma on kehitetty vain Yle Areenan ja TV7:n kanssa, ja niille varta vasten kehitetty.

Kopioi videon osoitteet sivustolta ja liitä ne ohjelmaan. Voit liittää yhteensä 7 videon osoitteet. Kätevämpi ratkaisu on käyttää Google Chromen [Copy all Urls](https://chrome.google.com/webstore/detail/copy-all-urls/djdmadneanknadilpjiknlnanaolmbfk) -lisäosaa, ja kopioida osoitteet leikepöydälle. Siinä tapauksessa ei tarvitse lisätä kenttiin mitään, vaan voi painaa suoraan OK. Ohjelma hakee osoitteet suoraan leikepöydältä.

Ohjelmassa on muutamia asetuksia, joita voi vaihtaa yle-areena-lapsisoitin.ini -tiedostoa muokkaamalla:
  * FlickFetchin hakemisto (etsii automaattisesti oletushakemistosta)
  * Tiedostojen latauspaikka (oletuksena 'lataukset')
  * Käynnistetäänkö Yle-Areena automaattisesti?
  * Mikä sivu silloin avataan (oletuksena Omat Suosikit)
  * Käynnistetäänkö TV7 automaattisesti?
  * Mikä sivu silloin avataan (oletuksena lasten ohjelmat)
  * VLC playerin hakemisto
  * Mennäänkö lopuksi unitilaan?

Ohjelma on tehty AutoHotkeyllä (hakemistossa alkuperäinen skripti).

Tekijä:
[Jaakko Haavisto](jaaxtra@gmail.com)

Muutosloki:

1.2 
- TV7 -mahdollisuus lisätty
- Nimi ja kuvake vaihdettu

1.1
- Latausohjelma vaihdettu StreamDownloader --> Flickfetch
- Bugeja korjattu

1.0
- Ensimmäinen versio
