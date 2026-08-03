# Health Tracker – UI Guide

**Status:** Verbindliche Designgrundlage  
**Version:** 1.3  
**Stand:** 2. August 2026

## 1. Zweck

Dieser Guide beschreibt die verbindlichen visuellen und funktionalen UI-Regeln des Health Trackers. Er dient Design, Architektur und Entwicklung als gemeinsame Grundlage.

Bei neuen oder geänderten Oberflächen gilt:

- vorhandene Regeln dieses Guides wiederverwenden,
- Abweichungen bewusst dokumentieren,
- bereichsspezifische Farben nicht mit Profil- oder Statusfarben vermischen,
- Inhalte gegenüber Dekoration priorisieren,
- alle Oberflächen responsiv und barrierearm umsetzen.

Konkrete Abläufe und Bildschirmdetails können in ergänzenden Spezifikationen beschrieben werden. Bei Widersprüchen gilt die jüngste ausdrücklich freigegebene Entscheidung.

## 2. Designziel

Der Health Tracker wirkt **modern, freundlich, hell und aufgeräumt**. Die App soll Vertrauen schaffen, ohne klinisch oder technisch kühl zu erscheinen.

Grundprinzipien:

- warmer, beinahe weißer Hintergrund statt hartem Reinweiß,
- helle Flächen und Karten mit sanften Rundungen,
- klare dunkle Schrift und gut erkennbare Hierarchien,
- großzügige Abstände,
- freundliche, helle Bereichsfarben,
- einfache und konsistente Symbole,
- nur aktuell relevante Informationen auf der Startseite,
- Farbe immer mit Bedeutung, nicht nur als Dekoration,
- wenige, klar gegliederte Elemente statt vieler kleiner Dashboard-Karten.

## 3. Informationsarchitektur

### 3.1 Hauptnavigation

Die Hauptnavigation besteht aus fünf Bereichen:

1. **Start**
2. **Meine Gesundheit**
3. **Ernährung**
4. **Training**
5. **Meine Entwicklung**

Ein Menüpunkt **Mehr** und ein eigener Menüpunkt **Erfassen** existieren nicht.

#### Responsive Darstellung

Die Hauptnavigation bleibt auf allen Seiten und in allen Erscheinungsbildern in Aufbau, Reihenfolge und Verhalten einheitlich. Ausschließlich ihre visuelle Darstellung passt sich an die tatsächlich verfügbare Breite an:

- Bei geringer verfügbarer Breite werden nur die fünf festgelegten Icons angezeigt.
- Bei ausreichender verfügbarer Breite werden dieselben Icons zusammen mit ihren vollständigen Bezeichnungen angezeigt.
- Die Umschaltung richtet sich nach der verfügbaren Breite, nicht pauschal nach dem Gerätetyp.
- Es werden keine Bezeichnungen gekürzt oder abgeschnitten und auch in sehr breiten Ansichten keine weiteren Navigationspunkte ergänzt.
- Reihenfolge, Symbolzuordnung, Navigationsziele und Bedienverhalten bleiben in beiden Darstellungen identisch.
- Der aktive Bereich ist mindestens durch Farbe und eine zusätzliche visuelle Hervorhebung eindeutig erkennbar.
- In der reinen Icon-Darstellung besitzen alle Ziele vollständige zugängliche Bezeichnungen für Screenreader und bei Mausbedienung Tooltips.
- Icons und Touchflächen erfüllen die festgelegten Anforderungen an Erkennbarkeit, Kontrast und Bediengröße.

Profilwechsel und Einstellungen bleiben unabhängig von der Darstellungsform der Hauptnavigation oben rechts im Kopfbereich. **Schnellerfassen** ist kein zusätzlicher Navigationspunkt.

### 3.2 Bereichsinhalte

| Bereich | Zentrale Inhalte |
|---|---|
| Start | aktuelle Aufgaben, Erinnerungen, dynamischer Eyecatcher, Schnellerfassen |
| Meine Gesundheit | Messwerte, Medikamente, Erkrankungen, Gesundheitsnotizen, Vorsorge und Termine |
| Ernährung | Mahlzeiten, Getränke, Ernährungsplanung, Rezepte und Nährwerte |
| Training | Trainingspläne, Übungen, absolvierte Einheiten und Ziele |
| Meine Entwicklung | Dashboards, Trends, Auswertungen, Empfehlungen, Profilvergleiche und Meilensteine |

**Dashboards** sind ausschließlich Teil von **Meine Entwicklung**.  
**Medikamente** gehören zu **Meine Gesundheit**.  
**Rezepte** gehören zu **Ernährung**.  
**Meilensteine** liegen dauerhaft unter **Meine Entwicklung → Meilensteine**.

### 3.3 Globale Aktionen

- **Schnellerfassen** bleibt eine zentrale Aktion auf der Startseite, ist aber kein Navigationsbereich.
- Bereichsspezifisches Erfassen wird in **Meine Gesundheit**, **Training** und bei fehlenden Daten auch in **Meine Entwicklung** angeboten.
- Der Profilwechsel befindet sich oben rechts.
- Der Einstellungsbutton mit Zahnrad befindet sich oben rechts neben der Profilauswahl.
- Profile werden direkt gewechselt, aber unter **Einstellungen → Profile** angelegt, bearbeitet oder gelöscht.

### 3.4 Einstellungen

Der Einstellungsbereich enthält:

- Profile verwalten,
- Geräte und Datenquellen,
- Benachrichtigungen,
- Datenschutz und Profilschutz,
- Darstellung und Barrierefreiheit,
- Backup, Import und Export,
- allgemeine App-Einstellungen,
- Informationen zur App.

## 4. Globales Farbsystem

### 4.1 Neutrale Grundfarben

| Token | Wert | Verwendung |
|---|---:|---|
| `background` | `#F7F8FA` | warmer App-Hintergrund |
| `surface` | `#FFFFFF` | Karten, Dialoge, Eingabeflächen |
| `textPrimary` | `#263238` | Überschriften und Haupttext |
| `textSecondary` | `#68757D` | ergänzende Informationen |
| `divider` | `#E7EBEE` | Trennlinien und dezente Konturen |
| `primary` | `#42A5A5` | globale primäre Aktion, wenn keine Bereichsfarbe gilt |
| `secondary` | `#81B9E6` | globaler ergänzender Akzent |

### 4.2 Bereichspaletten

Jeder Hauptbereich besitzt eine eigene Identität aus Hauptfarbe und heller Flächenfarbe.

| Bereich | Hauptfarbe | Helle Fläche | Typische Verwendung |
|---|---:|---:|---|
| Start | `#68757D` | `#F7F8FA` | ruhige neutrale Grundfläche |
| Meine Gesundheit | `#2F8F8B` | `#DDF3F1` | Messwerte, Medikamente, Termine |
| Ernährung | `#C9784A` | `#FBE8DC` | Mahlzeiten, Getränke, Rezepte |
| Training | `#4F7FBF` | `#E3EEFA` | Trainingspläne und Übungen |
| Meine Entwicklung | `#7A68B3` | `#ECE8F7` | Dashboards, Trends, Meilensteine |
| Einstellungen | `#687078` | `#EDF0F2` | technische und globale Funktionen |

Bereichsfarben werden auf der Startseite wiederverwendet, damit die Herkunft einer Aufgabe oder eines Meilensteins sofort erkennbar ist.

### 4.3 Drei getrennte Farbebenen

Die folgenden Farbsysteme dürfen nicht miteinander verwechselt werden:

1. **Bereichsfarben** kennzeichnen die fachliche Herkunft eines Inhalts.
2. **Profilfarben** kennzeichnen ausschließlich das aktive oder zugeordnete Profil.
3. **Statusfarben** kommunizieren Bewertung, Dringlichkeit oder Systemzustand.

Eine Profilfarbe darf deshalb niemals allein bedeuten, dass ein Wert gut, kritisch oder fehlerhaft ist.

### 4.4 Statusfarben

- Grün: positiver beziehungsweise unkritischer Status
- Gelb oder Orange: Hinweis beziehungsweise Aufmerksamkeit erforderlich
- Rot: Warnung, Fehler oder kritischer Status

Status darf nie nur durch Farbe vermittelt werden. Ergänzend sind verständlicher Text, Symbol oder Statusbezeichnung erforderlich.

## 5. Startseite

Die Startseite ist **kein Dashboard**. Sie zeigt nur Informationen, die jetzt relevant sind.

### 5.1 Inhalt

Die Startseite enthält:

- Begrüßung und Tagesbezug,
- Profilwechsel und Einstellungen oben rechts,
- einen dynamischen Eyecatcher,
- heutige Aufgaben und Erinnerungen,
- den zentralen Button **Schnellerfassen**,
- die Hauptnavigation.

Sie enthält keine dauerhaften Messwertkarten, Diagramme oder vollständigen Verläufe.

### 5.2 Dynamischer Eyecatcher

Der Eyecatcher besitzt zwei Zustände:

**Normalzustand**

- zeigt die nächste wichtige Aufgabe oder den nächsten Termin,
- nutzt eine helle, freundliche, aber ruhige Gestaltung,
- bietet bei Bedarf eine eindeutige kontextbezogene Aktion.

**Meilensteinzustand**

- ersetzt den Normalzustand vorübergehend nach einem neuen Erfolg,
- ist deutlich farbenfroher und feierlicher als die übrige Startseite,
- verwendet die zum Erfolg gehörende Bereichspalette; bei bereichsübergreifenden Erfolgen dürfen mehrere Paletten kombiniert werden,
- zeigt die Erfolgszahl groß, kontrastreich und exakt mittig im zentralen Medaillen- oder Kreiselement,
- nennt Titel, Bedeutung und Datum des Erfolgs,
- kann als gesehen markiert oder geschlossen werden,
- bleibt dauerhaft in der Meilenstein-Sammlung erhalten.

### 5.3 Tägliche Aufgaben

Tägliche Aufgaben bleiben bewusst zurückhaltend:

- weiße oder sehr helle Grundfläche,
- dezente Trennlinien,
- kleine Symbole,
- schmaler Farbakzent oder farbiges Symbol aus der zugehörigen Bereichspalette,
- keine großflächig bunten Aufgabenkarten,
- eindeutige Aktion und verständliche Zeitangabe, sofern relevant.

Die bunte, feierliche Gestaltung bleibt besonderen Erfolgen vorbehalten.

### 5.4 Schnellerfassen

**Schnellerfassen** ist auf der Startseite gut sichtbar, ohne mit dem Eyecatcher zu konkurrieren. Die Aktion öffnet eine kompakte Auswahl, zum Beispiel:

- Messwert,
- Medikamenteneinnahme,
- Gesundheitsnotiz,
- Training.

Nach der Auswahl führt die App direkt in die passende bereichsspezifische Eingabe.

## 6. Meine Entwicklung und Meilensteine

Unter **Meine Entwicklung → Meilensteine** gibt es zwei Ansichten:

- **Timeline:** chronologische Darstellung aller Erfolge,
- **Sammlung:** Gruppierung nach Meine Gesundheit, Ernährung, Training, Regelmäßigkeit und persönlichen Zielen.

Ein Meilenstein zeigt:

- Datum,
- Symbol,
- Titel,
- zugehörigen Bereich,
- kurze Beschreibung,
- erreichten Wert,
- optional den Fortschritt zum nächsten Meilenstein.

Sensible Erfolge können ausgeblendet werden.

## 7. Layout und Komponenten

### 7.1 Flächen und Karten

- Karten nur einsetzen, wenn sie Inhalte sinnvoll gruppieren.
- Zusammengehörige Werte lieber in einer gemeinsamen strukturierten Fläche als in vielen Einzelkarten darstellen.
- Karten haben einen hellen Hintergrund, sanfte Rundungen und höchstens einen dezenten Schatten.
- Tiefe visuelle Verschachtelungen vermeiden.
- Abstände und Trennlinien sollen die Struktur stärker tragen als Schatten.

### 7.2 Typografie

- Systemnahe, gut lesbare serifenlose Schrift verwenden.
- Überschriften klar, aber nicht überdimensioniert gestalten.
- Fließtext nicht unnötig klein setzen.
- Zahlen und Einheiten als gemeinsame Information behandeln; die Zahl darf visuell dominieren, die Einheit muss eindeutig bleiben.
- Fachbegriffe möglichst durch allgemein verständliche Bezeichnungen ersetzen oder erklären.

### 7.3 Symbole

- ein einheitliches Icon-System verwenden,
- bekannte Symbole bevorzugen,
- Icons immer mit zugänglicher Beschriftung oder Semantik versehen,
- dekorative Icons nicht wie Schaltflächen aussehen lassen,
- das Zahnrad ausschließlich für Einstellungen verwenden.

### 7.4 Aktionen und Eingaben

- pro Ansicht eine klar erkennbare primäre Aktion,
- destruktive Aktionen deutlich kennzeichnen und bestätigen lassen,
- Eingaben mit Beschriftung, Hilfetext und verständlichen Fehlermeldungen versehen,
- Werteingaben zeigen Einheit und gültigen Bereich,
- häufige Eingaben mit sinnvollen Standardwerten oder zuletzt verwendeten Optionen beschleunigen,
- erfolgreiche Speicherung sichtbar, aber unaufdringlich bestätigen.

### 7.5 Systemweite Hinweismeldungen

Für Hinweismeldungen gilt in allen Bereichen und auf allen Seiten dieselbe zentrale Bedien- und Zustandslogik. Fachbereiche dürfen keine abweichenden Regeln für das Schließen oder zeitweise Unterdrücken von Hinweisen einführen.

- **Schließen** blendet den aktuell angezeigten Hinweis aus.
- **Später erinnern** unterdrückt ausschließlich den konkreten Hinweis wahlweise für eine Woche, für zwei Wochen oder bis zu einem ausgewählten Datum.
- Schließen und Unterdrücken gelten ausschließlich für das aktive Profil.
- Beide Aktionen verändern, bestätigen, korrigieren oder löschen weder die zugrunde liegenden Daten noch deren Prüfstatus.
- Neue oder wesentlich veränderte Daten dürfen einen neuen Hinweis auslösen. Das gilt auch während eines zuvor gewählten Unterdrückungszeitraums, wenn sich Relevanz oder Dringlichkeit wesentlich erhöht.
- Eine zeitweise Unterdrückung kann in den Einstellungen vorzeitig aufgehoben werden.
- Akute Sicherheitshinweise können geschlossen, aber nicht für einen längeren Zeitraum unterdrückt werden. Bei erneut kritischen Daten werden sie erneut angezeigt.
- Die Anwendung speichert nachvollziehbar, welcher Hinweis bis wann unterdrückt wurde und wodurch eine vorzeitige erneute Anzeige ausgelöst wurde.
- Hinweise und alle zugehörigen Aktionen müssen per Touch, Tastatur und Screenreader vollständig bedienbar sein.

Die einheitlichen Aktionsbezeichnungen lauten **Schließen** und **Später erinnern**. Nach Auswahl von **Später erinnern** werden mindestens **In einer Woche**, **In zwei Wochen** und **Datum auswählen** angeboten.

## 8. Erscheinungsbilder

Der Health Tracker bietet auswählbare **Erscheinungsbilder**, aber keine unterschiedlichen Bedienoberflächen. Navigation, Informationsarchitektur, Position und Bedeutung zentraler Bedienelemente sowie sämtliche fachlichen Abläufe bleiben in allen Erscheinungsbildern gleich.

### 8.1 Auswahl und Speicherung

- Die Auswahl befindet sich unter **Einstellungen → Darstellung → Erscheinungsbild**.
- Das gewählte Erscheinungsbild wird pro Profil gespeichert.
- Eine Vorschau zeigt die Wirkung vor der Übernahme.
- Die Systemeinstellung für Hell- oder Dunkeldarstellung kann optional übernommen werden.
- Ein Wechsel des Erscheinungsbildes verändert keine Gesundheitsdaten oder fachlichen Einstellungen.

### 8.2 Veränderbare Eigenschaften

Ein Erscheinungsbild darf kontrolliert verändern:

- Farben, Hintergründe und Oberflächenhelligkeit,
- Kartenformen, Rundungen und dezente Schatten,
- Abstände innerhalb der festgelegten responsiven Regeln,
- Illustrationen und dekorative Elemente,
- Intensität nicht notwendiger Animationen,
- Schrift- und Elementgröße innerhalb der Barrierefreiheitsregeln.

Nicht verändert werden dürfen:

- Hauptnavigation und Bereichszuordnung,
- Reihenfolge und Bedeutung zentraler Aktionen,
- fachliche Abläufe und Validierungsregeln,
- Semantik von Profil-, Bereichs- und Statusfarben,
- Datenschutz- und Sicherheitsverhalten,
- Mindestanforderungen an Kontrast, Lesbarkeit und Bedienbarkeit.

### 8.3 Geplante Erscheinungsbilder

Für Version 1.0 sind vorgesehen:

1. **Hell:** das moderne, freundliche und helle Standard-Erscheinungsbild.
2. **Dunkel:** eine kontrastreiche Darstellung für dunkle Umgebungen.
3. **Hoher Kontrast:** besonders deutliche Konturen, Zustände und Bedienelemente.
4. **Systemeinstellung:** automatische Wahl von Hell oder Dunkel entsprechend dem Betriebssystem, sofern technisch unterstützt.

Spätere Erweiterungen können beispielsweise **Ruhig** oder **Playful Wellness** anbieten. Sie werden erst nach eigener Design-, Barrierefreiheits- und Komponentprüfung freigegeben. Steampunk-, Hip-Hop- und Hundertwasser-inspirierte Entwürfe bleiben Stiltests und sind keine regulären Erscheinungsbilder.

### 8.4 Technische Umsetzung

- Alle Erscheinungsbilder verwenden dieselben gemeinsamen Komponenten.
- Unterschiede werden zentral über Theme-Tokens und Varianten gesteuert; fachliche Widgets enthalten keine designspezifische Geschäftslogik.
- Jedes Erscheinungsbild muss auf Smartphone, Tablet und Desktop sowie mit großer Schrift geprüft werden.
- Neue Erscheinungsbilder benötigen definierte Tokens, Vorschau, Barrierefreiheitsprüfung und visuelle Regressionstests.
- Ist ein gespeichertes Erscheinungsbild nicht verfügbar, verwendet die App sicher das Standard-Erscheinungsbild, ohne die gespeicherte Präferenz ungefragt zu löschen.

## 9. Responsive Navigation

Die fünf Hauptbereiche bleiben auf allen Zielgeräten erreichbar.

### Smartphone

- kompakte untere Navigation,
- kurze, eindeutige Beschriftungen,
- Profil und Einstellungen im oberen Bereich,
- bei Platzmangel darf die Darstellung angepasst werden, aber kein Hauptbereich darf hinter einem allgemeinen **Mehr**-Menü verschwinden.

### Tablet und iPad

- je nach Breite untere Navigation oder Navigation Rail,
- Inhalte dürfen mehrspaltig werden, sofern die Lesereihenfolge eindeutig bleibt,
- Touch-Ziele bleiben ausreichend groß.

### Laptop und Desktop

- Navigation Rail oder Seitenleiste,
- Profilwechsel und Einstellungen bleiben oben rechts,
- zusätzliche Breite dient besserer Gruppierung und nicht der bloßen Vermehrung von Karten.

## 10. Barrierefreiheit

- ausreichende Kontraste für Text und interaktive Elemente,
- Mindestgröße von ungefähr 44 × 44 logischen Pixeln für Touch-Ziele,
- Unterstützung größerer Systemschrift ohne abgeschnittene Inhalte,
- vollständige Bedienbarkeit per Tastatur auf Web und Desktop,
- sichtbarer Fokuszustand,
- semantische Bezeichnungen für Screenreader,
- keine Information ausschließlich durch Farbe, Position oder Animation,
- reduzierte Bewegung berücksichtigen,
- Diagramme zusätzlich textlich zusammenfassen,
- klare Fehlermeldungen mit konkreter Korrekturmöglichkeit.

## 11. Sprache und Ton

- freundlich, ruhig und direkt formulieren,
- die Person mit **du** ansprechen,
- nicht belehren oder beschämen,
- medizinische Bewertungen vorsichtig und nachvollziehbar formulieren,
- Warnungen sachlich beschreiben und eine nächste sinnvolle Handlung anbieten,
- Erfolge positiv würdigen, ohne zu übertreiben,
- Schaltflächen mit konkreten Verben benennen, zum Beispiel **Messwert speichern** statt **OK**.

## 12. Datenschutz in der Oberfläche

- immer deutlich zeigen, welches Profil aktiv ist,
- sensible Daten nicht unnötig in Benachrichtigungen oder Übersichten offenlegen,
- geschützte Profile und ausgeblendete Erfolge respektieren,
- Profilwechsel darf nie unbemerkt erfolgen,
- vor Löschen, Überschreiben, Import und Wiederherstellung die Auswirkungen verständlich erklären.

## 13. Verbindliche Regeln für die Entwicklung

- Farben zentral als Design-Tokens beziehungsweise im Flutter-Theme definieren; keine verstreuten Hexwerte in Widgets.
- Neutrale, Bereichs-, Profil- und Statusfarben technisch getrennt modellieren.
- Erscheinungsbilder zentral über Theme-Tokens und gemeinsame Komponenten umsetzen.
- Wiederkehrende Elemente als gemeinsame Komponenten umsetzen.
- Komponenten müssen mit langen deutschen Texten und großer Schrift funktionieren.
- Beispieldaten in Entwürfen und Tests klar als solche kennzeichnen.
- Bildschirmgrößen nicht über einzelne Gerätemodelle, sondern über verfügbare Breite behandeln.
- Neue UI-Entscheidungen in diesem Guide oder einer verlinkten Spezifikation dokumentieren.
- Vor der Implementierung eines Bildschirms prüfen, ob eine konkrete Screen-Spezifikation existiert.

## 14. Prüfliste für neue Bildschirme

Vor Freigabe eines neuen oder geänderten Bildschirms prüfen:

- Gehört jeder Inhalt zum richtigen Hauptbereich?
- Ist die wichtigste Information zuerst erkennbar?
- Gibt es unnötige Karten oder dauerhaft sichtbare Details?
- Wird die richtige Bereichspalette verwendet?
- Funktioniert der Bildschirm in allen freigegebenen Erscheinungsbildern?
- Bleiben Profil-, Bereichs- und Statusfarben getrennt?
- Ist die primäre Aktion eindeutig?
- Funktioniert das Layout auf Smartphone, Tablet und Desktop?
- Funktioniert es mit großer Schrift, Tastatur und Screenreader?
- Sind leere, ladende, erfolgreiche und fehlerhafte Zustände berücksichtigt?
- Sind sensible Daten angemessen geschützt?
- Entspricht der Text dem freundlichen, ruhigen Ton der App?

## 15. Noch separat zu spezifizieren

Dieser Guide legt das gemeinsame Designsystem fest. Folgende Themen erhalten bei Bedarf eigene Dokumente:

- detaillierter Aufbau und Zustände der Startseite,
- Navigation und fachliche Modulgrenzen als Architekturentscheidung,
- konkrete Komponentenbibliothek und Flutter-Tokens,
- Bildschirmabläufe für Meine Gesundheit, Ernährung, Training und Meine Entwicklung,
- Diagramm- und Datenvisualisierungsregeln,
- Formulare, Validierung und Fehlermeldungen.
