--from clickbench table hits
CREATE TABLE IF NOT EXISTS  orc_s3_case6 (
    COUNTERID INT NOT NULL, 
    EVENTDATE INT NOT NULL, 
    USERID BIGINT NOT NULL, 
    EVENTTIME INT NOT NULL, 
    WATCHID BIGINT NOT NULL, 
    JAVAENABLE SMALLINT NOT NULL,
    TITLE STRING NOT NULL,
    GOODEVENT SMALLINT NOT NULL,
    CLIENTIP INT NOT NULL,
    REGIONID INT NOT NULL,
    COUNTERCLASS SMALLINT NOT NULL,
    OS SMALLINT NOT NULL,
    USERAGENT SMALLINT NOT NULL,
    URL STRING NOT NULL,
    REFERER STRING NOT NULL,
    ISREFRESH SMALLINT NOT NULL,
    REFERERCATEGORYID SMALLINT NOT NULL,
    REFERERREGIONID INT NOT NULL,
    URLCATEGORYID SMALLINT NOT NULL,
    URLREGIONID INT NOT NULL,
    RESOLUTIONWIDTH SMALLINT NOT NULL,
    RESOLUTIONHEIGHT SMALLINT NOT NULL,
    RESOLUTIONDEPTH SMALLINT NOT NULL,
    FLASHMAJOR SMALLINT NOT NULL,
    FLASHMINOR SMALLINT NOT NULL,
    FLASHMINOR2 STRING NOT NULL,
    NETMAJOR SMALLINT NOT NULL,
    NETMINOR SMALLINT NOT NULL,
    USERAGENTMAJOR SMALLINT NOT NULL,
    USERAGENTMINOR VARCHAR(255) NOT NULL,
    COOKIEENABLE SMALLINT NOT NULL,
    JAVASCRIPTENABLE SMALLINT NOT NULL,
    ISMOBILE SMALLINT NOT NULL,
    MOBILEPHONE SMALLINT NOT NULL,
    MOBILEPHONEMODEL STRING NOT NULL,
    PARAMS STRING NOT NULL,
    IPNETWORKID INT NOT NULL,
    TRAFICSOURCEID SMALLINT NOT NULL,
    SEARCHENGINEID SMALLINT NOT NULL,
    SEARCHPHRASE STRING NOT NULL,
    ADVENGINEID SMALLINT NOT NULL,
    ISARTIFICAL SMALLINT NOT NULL,
    WINDOWCLIENTWIDTH SMALLINT NOT NULL,
    WINDOWCLIENTHEIGHT SMALLINT NOT NULL,
    CLIENTTIMEZONE SMALLINT NOT NULL,
    CLIENTEVENTTIME INT NOT NULL,
    SILVERLIGHTVERSION1 SMALLINT NOT NULL,
    SILVERLIGHTVERSION2 SMALLINT NOT NULL,
    SILVERLIGHTVERSION3 INT NOT NULL,
    SILVERLIGHTVERSION4 SMALLINT NOT NULL,
    PAGECHARSET STRING NOT NULL,
    CODEVERSION INT NOT NULL,
    ISLINK SMALLINT NOT NULL,
    ISDOWNLOAD SMALLINT NOT NULL,
    ISNOTBOUNCE SMALLINT NOT NULL,
    FUNIQID BIGINT NOT NULL,
    ORIGINALURL STRING NOT NULL,
    HID INT NOT NULL,
    ISOLDCOUNTER SMALLINT NOT NULL,
    ISEVENT SMALLINT NOT NULL,
    ISPARAMETER SMALLINT NOT NULL,
    DONTCOUNTHITS SMALLINT NOT NULL,
    WITHHASH SMALLINT NOT NULL,
    HITCOLOR CHAR NOT NULL,
    LOCALEVENTTIME INT NOT NULL,
    AGE SMALLINT NOT NULL,
    SEX SMALLINT NOT NULL,
    INCOME SMALLINT NOT NULL,
    INTERESTS SMALLINT NOT NULL,
    ROBOTNESS SMALLINT NOT NULL,
    REMOTEIP INT NOT NULL,
    WINDOWNAME INT NOT NULL,
    OPENERNAME INT NOT NULL,
    HISTORYLENGTH SMALLINT NOT NULL,
    BROWSERLANGUAGE STRING NOT NULL,
    BROWSERCOUNTRY STRING NOT NULL,
    SOCIALNETWORK STRING NOT NULL,
    SOCIALACTION STRING NOT NULL,
    HTTPERROR SMALLINT NOT NULL,
    SENDTIMING INT NOT NULL,
    DNSTIMING INT NOT NULL,
    CONNECTTIMING INT NOT NULL,
    RESPONSESTARTTIMING INT NOT NULL,
    RESPONSEENDTIMING INT NOT NULL,
    FETCHTIMING INT NOT NULL,
    SOCIALSOURCENETWORKID SMALLINT NOT NULL,
    SOCIALSOURCEPAGE STRING NOT NULL,
    PARAMPRICE BIGINT NOT NULL,
    PARAMORDERID STRING NOT NULL,
    PARAMCURRENCY STRING NOT NULL,
    PARAMCURRENCYID SMALLINT NOT NULL,
    OPENSTATSERVICENAME STRING NOT NULL,
    OPENSTATCAMPAIGNID STRING NOT NULL,
    OPENSTATADID STRING NOT NULL,
    OPENSTATSOURCEID STRING NOT NULL,
    UTMSOURCE STRING NOT NULL,
    UTMMEDIUM STRING NOT NULL,
    UTMCAMPAIGN STRING NOT NULL,
    UTMCONTENT STRING NOT NULL,
    UTMTERM STRING NOT NULL,
    FROMTAG STRING NOT NULL,
    HASGCLID SMALLINT NOT NULL,
    REFERERHASH BIGINT NOT NULL,
    URLHASH BIGINT NOT NULL,
    CLID INT NOT NULL
)
DUPLICATE KEY (CounterID, EventDate, UserID, EventTime, WatchID) 
DISTRIBUTED BY HASH(UserID) BUCKETS 16
PROPERTIES ("replication_num"="1");
