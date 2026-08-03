# Health Tracker – Seitenspezifikation „Meine Gesundheit“

**Status:** Verbindliche Bildschirmspezifikation  
**Version:** 1.0  
**Stand:** 2. August 2026  
**Übergeordnete Grundlagen:** `../UI_GUIDE.md`, `../navigation/NAVIGATION_SPEC.md`

## 1. Zweck und Geltungsbereich

Dieses Dokument beschreibt Aufbau, Inhalte, Verhalten und Zustände der Bereichsseite **Meine Gesundheit**. Es ist die verbindliche Grundlage für UX, Architektur, Flutter-Implementierung und Tests.

Der `../UI_GUIDE.md` definiert die globalen Design- und Sprachregeln. Die `../navigation/NAVIGATION_SPEC.md` definiert Navigation und fachliche Zuständigkeiten. Diese Spezifikation konkretisiert beide Dokumente für **Meine Gesundheit**.

## 2. Ziel der Seite

Die Seite beantwortet in dieser Reihenfolge:

1. Was wurde heute bereits dokumentiert?
2. Was könnte heute noch relevant sein?
3. Wie kann eine häufige Information schnell erfasst werden?
4. Wie erreiche ich meine Gesundheitsdaten, Medikamente, Erkrankungen und Termine?

Die Seite unterstützt persönliche Entscheidungen. Sie fordert, bewertet oder bevormundet nicht.

## 3. Fachliche Abgrenzung

**Meine Gesundheit** ist zuständig für:

- aktuelle gesundheitsbezogene Tagesinformationen,
- Messwerte und ihre Erfassung,
- Medikamente und dokumentierte Einnahmen,
- Erkrankungen, Beschwerden, Allergien und Unverträglichkeiten,
- Kalender, Vorsorge, Termine, Ereignisse und wiederkehrende Gesundheitsaufgaben,
- bereichsübergreifende Gesundheitsnotizen,
- sichtbare Herkunft automatisch, manuell oder durch Import erfasster Daten.

Nicht Bestandteil dieser Seite sind:

- umfangreiche Diagramme und langfristige Trends,
- Dashboards,
- Profilvergleiche,
- ausführliche Empfehlungen,
- Meilenstein-Timeline und Meilenstein-Sammlung,
- Geräteverwaltung und Zugriffsberechtigungen.

Auswertungen gehören zu **Meine Entwicklung**. Geräte und Datenquellen werden unter **Einstellungen → Geräte und Datenquellen** verwaltet.

## 4. Verbindlicher Seitenaufbau

Die Seite enthält in dieser Reihenfolge:

1. globale Hauptnavigation,
2. Kopfbereich mit Seitentitel, aktivem Profil und Einstellungen,
3. persönliche Tageszusammenfassung,
4. Schnellzugriffe,
5. Bereich **Heute für dich**,
6. die vier Gesundheitsbereiche,
7. kontextbezogene Hinweise und Sicherheitsinformationen.

Die Reihenfolge darf responsiv angeordnet, fachlich aber nicht verändert werden.

## 5. Globale Navigation und Kopfbereich

### 5.1 Hauptnavigation

Die globale Hauptnavigation ist identisch mit allen anderen App-Seiten und enthält genau:

1. **Start**
2. **Meine Gesundheit**
3. **Ernährung**
4. **Training**
5. **Meine Entwicklung**

**Meine Gesundheit** ist aktiv markiert. Bei geringer verfügbarer Breite werden ausschließlich die festgelegten Icons angezeigt; bei ausreichender Breite dieselben Icons mit vollständigen Bezeichnungen. Reihenfolge, Ziele, Symbole und Verhalten ändern sich nicht.

### 5.2 Kopfbereich

Der Kopfbereich zeigt:

- den Seitentitel **Meine Gesundheit**,
- das aktive Profil,
- die Profilfarbe ausschließlich als Profilkennzeichnung,
- den Einstellungsbutton neben der Profilauswahl.

Der Profilwechsel wechselt die dargestellten Daten auf das gewählte Profil. Der aktuelle Bereich bleibt nach Möglichkeit geöffnet.

## 6. Persönliche Tageszusammenfassung

Die Zusammenfassung beginnt mit einer tageszeitabhängigen Begrüßung und nennt höchstens die wichtigsten heutigen Inhalte.

Beispiel mit bereits dokumentiertem Inhalt:

> **Guten Abend, Götz**  
> Deine morgendliche Medikamenteneinnahme hast du bereits festgehalten. Möchtest du später noch deinen Blutdruck dokumentieren?

Beispiel ohne vorherige Aktivität:

> **Guten Abend, Götz**  
> Möchtest du heute eine Medikamenteneinnahme oder einen Blutdruckwert festhalten?

Die Formulierung **„Schön, dass du dir Zeit für deine Gesundheit nimmst“** wird nicht verwendet.

### 6.1 Sprachregeln

- Möglichkeiten statt Forderungen: **„Du kannst …“** statt **„Du musst …“**.
- Freiwillige Frage statt Anweisung: **„Möchtest du …?“**.
- Dokumentierte Erfolge und bereits Festgehaltenes zuerst nennen.
- **„Noch nicht dokumentiert“** statt **„nicht erledigt“** oder **„überfällig“**.
- **„Für heute vorgesehen“** statt einer verpflichtenden Formulierung.
- **„Zur Erinnerung“** statt **„Achtung“**, sofern keine echte Gefahr besteht.
- Hinweise dürfen, soweit fachlich zulässig, ausgeblendet oder auf später verschoben werden.
- Keine künstlichen Lobfloskeln, Schuldzuweisungen oder Gesundheitsnoten.

Sicherheitsrelevante Inhalte bleiben trotz unterstützender Sprache klar und eindeutig.

## 7. Schnellzugriffe

Direkt im oberen Seitenbereich stehen vier kompakte Aktionen:

1. **Messwert erfassen**
2. **Medikament dokumentieren**
3. **Notiz hinzufügen**
4. **Termin oder Ereignis eintragen**

Alle Aktionen müssen mit wenigen Schritten erreichbar und per Tastatur, Touch sowie Screenreader bedienbar sein. Der zuletzt oder häufig verwendete Zugriff darf dezent priorisiert werden, ohne andere Zugriffe zu verstecken.

### 7.1 Messwert erfassen

Der Schnellzugriff öffnet direkt die Auswahl der Messwertart. Häufig oder zuletzt verwendete Arten dürfen zuerst erscheinen, beispielsweise:

- Blutdruck,
- Gewicht,
- Bauchumfang,
- Blutzucker,
- Temperatur.

Nach Auswahl öffnet das gemeinsame Messwertformular gemäß Abschnitt 11.

### 7.2 Medikament dokumentieren

Der Schnellzugriff zeigt bevorzugt die für den aktuellen Tag vorgesehenen Medikamente. Eine Einnahme wird ausschließlich nach ausdrücklicher Dokumentation als erfolgt markiert.

### 7.3 Notiz hinzufügen

Notizen sind eine bereichsübergreifende Funktion und keine eigene Hauptkachel. Eine Notiz kann optional verknüpft werden mit:

- einem Kalendertag,
- einem Messwert,
- einem Medikament oder einer Einnahme,
- einer Erkrankung oder Beschwerde,
- einem Termin oder Ereignis.

### 7.4 Termin oder Ereignis eintragen

Der Zugriff öffnet das gemeinsame Formular für Termine, Ereignisse und wiederkehrende Aufgaben. Der Eintrag wird dem aktiven Profil zugeordnet.

## 8. Bereich „Heute für dich“

Der Bereich ist eine kompakte Vorschau der heutigen Kalendereinträge. Er zeigt relevante Inhalte chronologisch; bereits dokumentierte Inhalte werden positiv und visuell zurückgenommen zuerst oder in einer klaren Gruppe dargestellt.

Beispiel:

| Status | Beispiel | Bedeutung |
|---|---|---|
| Häkchen | 08:00 – Medikamenteneinnahme | erfolgreich dokumentiert |
| Leerer Kreis | Blutdruck messen | für heute vorgesehen, noch nicht dokumentiert |
| Uhr | 20:00 – Medikamenteneinnahme | für später geplant |
| Halb gefüllter Kreis | Medikament, 1 von 2 Einnahmen | teilweise dokumentiert |
| Durchgestrichener Kreis | Einnahme heute ausgelassen | bewusst ausgelassen |
| Kalendersymbol | 15:30 – Hausarzt | Termin ohne einfachen Aufgabenstatus |

Zulässige kontextbezogene Aktionen sind:

- **Dokumentieren**,
- **Später erinnern**,
- **Heute auslassen**,
- **Öffnen**,
- **Verschieben**, soweit fachlich zulässig.

Das Schließen einer Erinnerung dokumentiert niemals automatisch die Durchführung.

## 9. Gesundheitsbereiche

Die Seite enthält genau vier große Bereichskacheln.

### 9.1 Messwerte

Enthält:

- zuletzt dokumentierte Werte,
- Messwertarten,
- Herkunft und Zeitpunkt,
- Aktion **Messwert hinzufügen**,
- Zugang zur Messwertübersicht.

Die Kachel darf eine kompakte Vorschau, aber keine umfangreichen Diagramme zeigen.

### 9.2 Medikamente

Enthält:

- regelmäßige und bedarfsweise Medikamente,
- geplante und dokumentierte Einnahmen,
- Vorräte und ruhige Erinnerungen,
- Zugang zur Medikamentenübersicht.

Ein Medikamentenplan ist nicht mit einer tatsächlich dokumentierten Einnahme gleichzusetzen.

### 9.3 Erkrankungen

Enthält:

- Vorerkrankungen,
- aktuelle Beschwerden,
- Allergien,
- Unverträglichkeiten,
- zugehörige Hinweise und Notizen.

Die App stellt keine Diagnose und leitet aus Einträgen keine unangekündigte medizinische Bewertung ab.

### 9.4 Kalender

Enthält:

- Arzt- und Vorsorgetermine,
- Medikamenteneinnahmen,
- geplante Messungen,
- frei erstellte Ereignisse und Erinnerungen,
- optional verknüpfte Trainings- und Ernährungsereignisse,
- Tages-, Wochen- und Monatsansicht.

**Vorsorge & Termine** ist vollständig in den Kalender integriert und keine zusätzliche Hauptkachel.

## 10. Kalenderverhalten

### 10.1 Eintragstypen

Beim Anlegen eines Eintrags kann festgelegt werden:

- einmalig oder wiederkehrend,
- Datum und optionale Uhrzeit,
- optionale Erinnerung,
- fachliche Zuordnung,
- mit oder ohne Erledigungsstatus,
- optionale Notiz oder Vorbereitungsliste.

### 10.2 Terminstatus

Termine ohne Aufgabencharakter verwenden standardmäßig keinen binären Erledigungsstatus. Optional sind:

- **Wahrgenommen**,
- **Verschoben**,
- **Abgesagt**.

### 10.3 Profilbezug

Jeder Kalendereintrag gehört zu genau einem Profil. Standardmäßig werden ausschließlich die Einträge des aktiven Profils angezeigt. Eine profilübergreifende Ansicht ist nur nach ausdrücklicher Aktivierung zulässig.

## 11. Gemeinsame Messwerterfassung

Messwerte können über zwei gleichwertige Wege erfasst werden:

1. Schnellzugriff **Messwert erfassen** → direkte Auswahl der Messwertart,
2. Kachel **Messwerte** → Messwertübersicht → **Messwert hinzufügen**.

Beide Wege verwenden:

- dieselbe Messwertauswahl,
- dasselbe Eingabeformular,
- dieselben Validierungsregeln,
- dieselbe Speicherung,
- dieselben Fehler- und Erfolgsmeldungen.

Nach dem Speichern kehrt die Person zum jeweiligen Ausgangspunkt zurück. Unterschiede in Validierung oder Datenstruktur zwischen beiden Wegen sind nicht zulässig.

## 12. Automatisierung und Datenherkunft

### 12.1 Grundprinzip

Die Erfassung läuft so weit wie möglich automatisch ab. Die Herkunft eines Wertes bleibt jederzeit transparent und nachvollziehbar.

Manuelle Angaben werden nur verlangt, wenn sie nicht zuverlässig vorliegen oder eine ausdrückliche Entscheidung erforderlich ist. Vorbelegungen dürfen geändert werden.

### 12.2 Erfassungsquellen

Jeder Messwert besitzt genau eine erkennbare Quelle:

- manuell erfasst,
- automatisch von einem externen Gerät oder Dienst übertragen,
- importiert,
- aus anderen Daten berechnet.

Die Oberfläche verwendet einheitliche Bezeichnungen, beispielsweise:

- **Automatisch · Smartwatch**,
- **Automatisch · Blutdruckmessgerät**,
- **Manuell eingetragen**,
- **Importiert**,
- **Aus anderen Werten berechnet**.

### 12.3 Verbindliche Metadaten

Soweit anwendbar, werden gespeichert:

- Erfassungsquelle,
- konkretes Gerät oder konkreter Dienst,
- Messzeitpunkt,
- Übertragungs- beziehungsweise Importzeitpunkt,
- Synchronisationsstatus,
- externe eindeutige Kennung,
- Information über eine nachträgliche manuelle Änderung.

### 12.4 Automatisch übertragene Werte

- Zulässige Werte werden ohne erneute manuelle Bestätigung übernommen.
- Die Herkunft wird direkt am Wert angezeigt.
- Eine ruhige Information darf erscheinen: **„Neuer Wert übernommen – dein Blutdruckmessgerät hat einen Wert übertragen.“**
- Automatisch übertragene Werte werden nicht als manuell erfasst gekennzeichnet.
- Die externe Kennung und weitere fachliche Merkmale verhindern Doppeleinträge.
- Originalwert und ursprüngliche Herkunft bleiben bei einer Korrektur nachvollziehbar.
- Widersprüchliche, unvollständige oder ungewöhnliche Daten führen zu einer verständlichen Rückfrage oder Kennzeichnung.
- Manuelle Erfassung bleibt auch ohne verbundenes Gerät möglich.

Die Seite verwaltet keine Geräteberechtigungen. Sie verlinkt bei Bedarf zu **Einstellungen → Geräte und Datenquellen**.

## 13. Hinweise und Sicherheit

Hinweise erscheinen nahe am betreffenden Inhalt und nicht pauschal als dominante Warnfläche.

Beispiel:

> **Zur Sicherheit**  
> Dein letzter Blutdruckwert liegt außerhalb deines persönlichen Bereichs. Möchtest du erneut messen oder den Verlauf ansehen?

Zulässige Aktionen:

- **Erneut messen**,
- **Verlauf ansehen**,
- **Hinweis schließen**, sofern fachlich vertretbar.

Bei möglicherweise akuten Situationen ist die Formulierung klar und nennt eine angemessene nächste Handlung. Die App darf keine Diagnose behaupten. Status wird niemals ausschließlich über Farbe vermittelt.

## 14. Responsive Darstellung

### 14.1 Große und mittlere Breiten

- Die persönliche Zusammenfassung nutzt die verfügbare Breite.
- **Heute für dich** und **Schnellzugriffe** können nebeneinander stehen.
- Die vier Gesundheitsbereiche erscheinen bevorzugt in einem 2×2-Raster.
- Die Hauptnavigation zeigt bei ausreichender Breite Icons und vollständige Bezeichnungen.

### 14.2 Kleine Breiten

- Alle Inhaltsbereiche stehen in einer klaren linearen Reihenfolge untereinander.
- Schnellzugriffe dürfen als gut erreichbares Raster angeordnet werden.
- Bereichskacheln bleiben vollständig beschriftet.
- Die Hauptnavigation zeigt bei geringer Breite ausschließlich Icons mit zugänglichen Bezeichnungen.

Der Wechsel richtet sich nach der tatsächlich verfügbaren Breite, nicht nach einer festen Geräteklasse.

## 15. Visuelle Gestaltung

- warmer sehr heller Hintergrund,
- überwiegend weiße Inhaltsflächen,
- Hauptfarbe **Meine Gesundheit:** `#2F8F8B`,
- unterstützende Fläche: `#DDF3F1`,
- sanft abgerundete, ruhige Komponenten,
- Profilfarbe nur zur Kennzeichnung des aktiven Profils,
- Statusfarben nur für echte Status- und Sicherheitsinformationen,
- keine dekorative Farbe ohne nachvollziehbare Bedeutung,
- Erscheinungsbilder verändern keine Informationsarchitektur oder Bedienabläufe.

## 16. Lade-, Leer-, Fehler- und Offline-Zustände

### 16.1 Laden

Die Grundstruktur bleibt stabil. Platzhalter vermitteln keinen vermeintlichen Gesundheitsstatus und werden nicht als echte Werte gelesen.

### 16.2 Leerzustand

Fehlende Daten werden neutral erklärt und mit einer optionalen passenden Aktion verbunden, zum Beispiel **„Noch keine Blutdruckwerte vorhanden – Messwert hinzufügen“**.

### 16.3 Fehler

- verständliche Meldung ohne technische Details,
- sicher verfügbare Inhalte bleiben sichtbar,
- erneutes Laden oder Synchronisieren wird angeboten,
- unbekannte Zustände werden nicht als erledigt, ausgelassen oder unauffällig interpretiert.

### 16.4 Offline

Lokal verfügbare Inhalte bleiben sichtbar. Lokale Erfassungen sind nach Möglichkeit weiterhin möglich und werden für die spätere Synchronisation vorgemerkt. Nicht aktuelle externe Daten erhalten eine sichtbare, ruhige Kennzeichnung.

## 17. Datenschutz und Profilschutz

- Alle Inhalte werden dem aktiven Profil zugeordnet.
- Ein Profilwechsel darf keine Daten des vorherigen Profils stehen lassen.
- Geschützte Profildaten werden erst nach erfolgreicher Freigabe angezeigt.
- Benachrichtigungen und Vorschauen respektieren die Datenschutzeinstellungen des Profils.
- Eine profilübergreifende Kalenderansicht ist standardmäßig deaktiviert.

## 18. Barrierefreiheit

- Status wird durch Text oder Symbol zusätzlich zur Farbe vermittelt.
- Alle interaktiven Elemente besitzen ausreichend große Touchflächen.
- Icons besitzen eindeutige zugängliche Namen.
- Reine Icon-Navigation bietet bei Mausbedienung Tooltips.
- Kontraste erfüllen die festgelegten Anforderungen des gewählten Erscheinungsbilds.
- Textvergrößerung darf Inhalte und Aktionen nicht abschneiden.
- Fokusreihenfolge folgt der fachlichen Seitenreihenfolge.
- Animationen sind nicht erforderlich und respektieren reduzierte Bewegung.

## 19. Navigation zu Unterseiten

| Ausgangspunkt | Ziel |
|---|---|
| Schnellzugriff „Messwert erfassen“ | Messwertart auswählen und gemeinsames Formular öffnen |
| Kachel „Messwerte“ | Messwertübersicht |
| „Messwert hinzufügen“ | gemeinsames Messwertformular |
| Kachel „Medikamente“ | Medikamentenübersicht |
| Kachel „Erkrankungen“ | Erkrankungsübersicht |
| Kachel „Kalender“ | Kalender, standardmäßig in der zuletzt verwendeten Ansicht |
| „Verlauf ansehen“ | passender Verlauf unter Meine Entwicklung |
| Gerätehinweis | Einstellungen → Geräte und Datenquellen |

Unterseiten ersetzen oder verändern die globale Hauptnavigation nicht.

## 20. Verbindliche Akzeptanzkriterien

1. Die Seite zeigt genau vier Hauptkacheln: Messwerte, Medikamente, Erkrankungen und Kalender.
2. Notizen sind als Schnellzugriff und verknüpfbare Funktion verfügbar, aber keine Hauptkachel.
3. Vorsorge und Termine sind in den Kalender integriert.
4. **Heute für dich** zeigt Kalenderereignisse mit verständlichem Status.
5. Das Schließen einer Erinnerung markiert keine Aufgabe als durchgeführt.
6. Messwerte lassen sich über Schnellzugriff und Messwerte-Kachel erfassen.
7. Beide Erfassungswege verwenden dasselbe Formular und dieselben Regeln.
8. Automatische und manuelle Werte werden zuverlässig unterschieden und sichtbar gekennzeichnet.
9. Automatisch übertragene Daten enthalten eine nachvollziehbare Quelle.
10. Doppeleinträge aus derselben externen Übertragung werden verhindert.
11. Änderungen an importierten Werten löschen weder Originalwert noch Herkunft unbemerkt.
12. Die Sprache bleibt unterstützend, freiwillig und frei von Schuldzuweisungen.
13. Sicherheitsrelevante Hinweise bleiben klar und handlungsorientiert.
14. Umfangreiche Auswertungen führen zu **Meine Entwicklung**.
15. Profil-, Bereichs- und Statusfarben bleiben getrennt.
16. Die Navigation entspricht auf jeder Breite dem `../UI_GUIDE.md` und der `../navigation/NAVIGATION_SPEC.md`.
17. Inhalte und Kalendereinträge gehören standardmäßig ausschließlich zum aktiven Profil.
18. Lade-, Fehler- und Offline-Zustände erzeugen keinen falschen Gesundheitsstatus.

## 21. Nachgelagerte Spezifikationen

Diese Seitenspezifikation legt das übergreifende Verhalten fest. Weitere Detaildokumente konkretisieren anschließend:

- Messwertübersicht und gemeinsames Messwertformular,
- Medikamentenübersicht und Einnahmedokumentation,
- Erkrankungsübersicht,
- Kalender mit Monats-, Wochen- und Tagesansicht,
- Notizerfassung und Verknüpfungen,
- Geräteintegration, Synchronisation und Duplikaterkennung.

