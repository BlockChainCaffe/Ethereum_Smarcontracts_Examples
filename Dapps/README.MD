# Responsible Box Kit

## Elenco dei file ##
 * **ResponsibleBox.sol** codice dello smart contract
 * **Infura_Ridef.txt** parametri per la connessione al Gateway
 * **gettrcount.sh** script per la determinazione del nonce
 * **send.sh** script per l'invio
 * **sign.py** script python per la firma delle transazioni
 * **config.py** file di configurazione di sign.py
 * DevNotes.txt :solo appunti



## Prerequisiti

 * python3
 * web3, web3utils
 * browser chrome con estensione metamask ( https://metamask.io/ )
 * CURL

### Librerie python
Instalare le seguenti dipendenze di python come utenza root:
(l'esempio è fatto su una distro Ubuntu/Debian/Mint ma analoghe operazioni si possono fare su macchine basate su RedHat/CentOS con yum)

```
apt-get install python3-dev
pip3 install setuptools
pip3 install ethtoken
pip3 web3 web3utils
```

## Configurazione

### Configurazione smart Contracts

una volta deployato con remix lo smart-cotract si dovranno abilitare i singoli indirizzi dei singoli scada per permettere loro l'invio

### Configurazione Scada

Nel file **config.py** devono essere presenti solo 3 righe con tre variabili in questo formato

```
contract   = "0x5E4fC9D07Fe54F3f0D79C8af1A87a7E6dcDDD6BD"

myaddress  = "0x0E33CaF70A010039450cFdc5C7D101b50E2cb6E2"
privatekey = "f61cbe045ddab94d6c224fdcc9f1d57a52d39c9eb1455cfcc6981f5780bc0552"
```

Ogni Scada avrà diversi valori per *myaddress* e *privatekey*, ma avranno tutti il medesimo *contract*

 * **contract** si riferisce all'indirizzo dello smart contract deployato su Ethereum.
 * **myaddress** è l'indirizzo ethereum associato ad un singolo Scada
 * **privatekey** è la chiave privata dell'indirizzo

E' possibile generare nuovi indirizzi per nuovi Scada da metamask.
Una volta creato il nuovo indirizzo e salvati i parametri, è opportuno trasferire 0,01 ether all'inidirizzo

## Utilizzo

Dalla cartella in cui è scaricato il pacchetto lanciare il comando

```
send.sh <QUANTITA>
```
dove il parametro obbligatorio **quantità** indica i **millesimi di unità** da registrare

Il risultato (in caso di successo) sarà una stringa JSON di questo tipo

```
{"jsonrpc":"2.0","id":1,"result":"0xcbd4633a03939b8743a9704f7f34f17c70d1bf9d733567239bdc03c3fce496b6"}
```
 * i primi due campi del JSON (jsonrpc e id) si possono ignorare
 * il campo **result** contiene l'id della transazione lanciata
 * è possibile usare l'id della transazione su https://ropsten.etherscan.io per valutare l'andamento
 * quando la transazione entra nello stato **Success** si potrà verificare l'aggiornamento dei dati all'interno dello smart contract con remix

### Come funzionaeri numerodi di operazioni già effettuate da quell'inidirizzo

* successivamente chiama sign.py per creare e firmare la transazione

* infine la transazione firmata viene mandata alla rete tramite il gateway infura con una chiamata curl

* la chiamata curl termina restituendo un json con il numero della transizione che si può monitorare da etherscam
