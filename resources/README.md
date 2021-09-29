# Technische Aspekte der Edition #

In diesem Verzeichnis `resources` befinden sich Dateien, die für die
technische Realisierung der Edition nötig sind.

## Unterverzeichnisse und Dateien

- `catalog.xml`: ein XML-Katalog zur Umleitung von Dateipfaden und
  URLs. Wird ausgewertet von oXygen und Maven.
- `ci_settings.xml`: Einstellungen für die CI/CD-Pipeline von gitlab
- `css`: CSS-Dateien und Schriften für den Autor-Modus von oXygen
- `exist-db`: Dateien, die für die Erstellung eines XAR-Pakets für
  eXist-db/TEI-publisher benötigt werden. In der CI/CD-Pipleline wird
  per Maven (vgl. [pom.xml](../pom.xml)) ein TEI-Publisher-Datenpaket
  erzeugt.
- `schema`: Schema zur Validierung der TEI-Dateien
- `xsl`: XSL-Transformationen für Transformationsszenarien in oXygen
  oder für die CI/CD-Pipeline
- `README.md`: dieser Text hier

## Maven ##

Maven wird verwendet, um

- Tests gegen die TEI-Dokumente zu fahren (continuous quality control)
- Test-Reports auf Gitlab-Pages zu erzeugen
- bei erfolgreich absolvierten Tests ein Expath-Package für die
  eXist-db/TEI-Publisher zu bauen und in der Gitlab-registry zu
  speichern

Dieses Package wird dann durch die CI/CD-Pipeline in der eXist-db
bzw. TEI-Publisher ausgebracht (deploy).

Die Datei [`pom.xml`](../pom.xml) ist die Maven-Datei des
Projekts. Sie sollte im Wurzelverzeichnis des Repository
liegen. Andernfalls verkompliziert sich das Setup erheblich. Das
Projekt wird mit dem Befehl

```{shell}
mvn PHASE
```

im Wurzelverzeichnis des Repository getestet, gebaut etc. Die
Build-Artefakte liegen anschließend im Verzeichnis `target`. Werte von
`PHASE` siehe unten. Um Test-Reports in HTML zu erzeugen, ist der
komplexere, zweistufige Befehl (siehe unten) auszuführen.


### Tests und Test-Reports ###

Zu testen sind die syntaktische Wohlgeformtheit, die Konformität
gegenüber dem TEI-Schema sowie einige Schematron-Tests.

Für das Feedback der Tests an die Herausgeber der Edition sind
zugängliche Test-Reports erforderlich.

Die Herausforderung besteht nicht im Testen, sondern in der
Generierung von Reports. Das `maven-xml-plugin` generiert beim
Validieren leider nicht direkt Reports. Dasselbe gilt für das
`ph-schematron-maven-plugin`. Die Lösung besteht darin,
- a) für schematron-Tests zunächst svrl-Reports zu erzeugen,
- b) die Maven-Logs, die das `maven-xml-plugin` generiert, zu parsen
  und
- c) beides in einer HTML-Summary gemeinsam darzustellen, die auf
  Gitlab-Pages ausgebracht wird.

Der Punkt b) ist ein bisschen 'hacky', jedoch ist die Alternative,
nämlich ein Umwandeln aller verwendeter Schema-Sprachen nach
Schematron (per
[XSLT](https://github.com/Schematron/schematron/tree/master/trunk/xsd2sch/code)
oder per [dtdschematron](https://github.com/ncbi/DtdAnalyzer)) und die
anschließende Gewinnung von svrl-Reports technisch nicht
ausgereift. Zur Realisation wird zweimal ausgeführt, wobei das erste
Mal in eine Datei geloggt werden muss, die beim zweiten Mal gelesen
wird. Die Reports werden bei der zweiten Ausführung bis zur Phase
`compile` generiert. Mit den folgenden Befehlen werden die Reports
erzeugt in `target/index.html` erzeugt:

```{shell}
mkdir target
mvn test -l target/mvn.log || mvn compile
```

In der Phase `test` werden noch Tests mit dem `maven-xml-plugin` und
dem `ph-schematron-maven-plugin` gefahren. Maven wird mit einem
Exit-Code ungleich 0 beendet, wenn ein Test fehlschlägt, so dass das
Package in diesem Fall nicht gebaut und ausgebracht (deploy) wird.


### Phasen ###

Die Abfolge der [Phasen von
Maven](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html)
folgt einem festgelegten Schema. Sie werden folgendermaßen verwendet:

- `generate-sources`: Touch `target/mvn.log`, um Vorhandensein dieser
  Datei sicherzustellen. Plugin: `maven-antrun-plugin`; ID: `mvn.log`
- `generate-sources`: Erzeugen von Kopien der TEI-Dokumente, bei denen
  XInclude aufgelöst ist. Außerdem werden Metadaten-Dateien des
  Expath-Packages mit Secrets aus den Umgebungsvariablen
  erzeugt. Plugin: `xml-maven-plugin`; ID: `transform`
- `generate-resources`: Erzeugen von XSLT aus den Schematron-Dateien
  in `resources/schema`. Plugin: `ph-schematron-maven-plugin`; ID:
  `sch2xslt`
- `generate-resources`: Erzeugen von `target/mvnlog.xml` aus
  `target/mvn.log` per XSLT. Plugin: `exec-maven-plugin`; ID:
  `mvnlog.xml`
- `compile`: Erzeugen von SVRL-Reports. Plugin: `xml-maven-plugin`;
  ID: `svrl-tei_all` und `svrl-witness`
- `compile`: Erzeugen von HTML-Reports aus den SVRL-Reports:
  `xml-maven-plugin`; ID `svrl2html`
- `compile`: Erzeugen des HTML-Überblick-Reports `target/index.html`
  aus den SVRL-Reports und aus `target/mvnlog.xml`:
  `exec-maven-plugin`; ID `errors.html`
- `test`: Schematron-Test in `resources/schema/witness.sch`. Plugin:
  `ph-schematron-maven-plugin`; ID `witness`
- `test`: Syntaktiche Wohlgeformtheit und Schema-Validität gegen
  `resources/schema/tei_all.rng`. Plugin: `xml-maven-plugin`; ID:
  `validate`
- `package`: Erzeugen des Expath-Package. Plugin:
  `maven-assembly-plugin`
- `package`: Umbenennen der vom Assembly-Plugin erzeugten zip-Datei in
  eine xar-Datei. Plugin `maven-antrun-plugin`; ID: `copy`

  

## eXist-db / TEI-publisher

Edition (Daten) und App sind getrennt. Aus dem vorliegenden git-Archiv
wird eine Daten-Kollektion für die eXist-db bzw. TEI-publisher
erzeugt, d.h. ein XAR-Archiv.

```
mvn package
```

erzeugt das Paket, das anschließend unter
`target/edition-data-template-cqc-<VERSION>.xar` zu finden ist. Die Version
kann in der Datei [`pom.xml`](../pom.xml) eingestellt werden.

Welche TEI-Dateien in dieser Kollektion enthalten sind und welche
nicht, kann in der Datei
[`resources/exist-db/assembly.xml`](exist-db/assembly.xml) festgelegt
werden.
