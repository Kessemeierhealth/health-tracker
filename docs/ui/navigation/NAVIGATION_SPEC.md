# ADR-006: Navigation und fachliche Bereichsgrenzen

**Status:** Angenommen  
**Datum:** 2. August 2026  
**Entscheidungsträger:** Health-Tracker-Projekt  
**Bezug:** `../UI_GUIDE.md`, `../pages/HOME_PAGE_SPEC.md`

## 1. Kontext

Der Health Tracker bündelt Gesundheitsdaten, Medikamente, Ernährung, Training, Analysen, Profile, Geräte und Einstellungen. Ohne klar definierte Bereichsgrenzen könnten Funktionen mehrfach umgesetzt, Daten uneindeutig zugeordnet und Navigationspunkte mit technischen oder fachfremden Inhalten überladen werden.

Insbesondere mussten folgende Fragen verbindlich geklärt werden:

- Welche Bereiche gehören in die Hauptnavigation?
- Wem gehören Medikamente, Rezepte, Dashboards und Meilensteine?
- Ist Erfassen ein eigener Bereich oder eine kontextbezogene Aktion?
- Wie werden Profile, Geräte, Backup und allgemeine Einstellungen erreicht?
- Welche Verantwortung besitzt die Startseite, wenn sie Inhalte mehrerer Bereiche anzeigt?

Die Entscheidung betrifft Informationsarchitektur, fachliche Modulgrenzen, Navigation und die Richtung zulässiger Abhängigkeiten. Visuelle Einzelheiten werden im `../UI_GUIDE.md` und konkrete Regeln der Startseite in `../pages/HOME_PAGE_SPEC.md` beschrieben.

## 2. Entscheidung

### 2.1 Hauptnavigation

Die Hauptnavigation besteht aus genau fünf fachlichen Bereichen:

1. **Start**
2. **Meine Gesundheit**
3. **Ernährung**
4. **Training**
5. **Meine Entwicklung**

Es gibt weder einen Hauptbereich **Mehr** noch einen Hauptbereich **Erfassen**. Alle fünf Bereiche bleiben auf Smartphone, Tablet und Desktop unmittelbar erreichbar.

Die Hauptnavigation wird einmal als gemeinsame App-Navigation umgesetzt und bleibt auf allen Seiten und in allen Erscheinungsbildern in Reihenfolge, Symbolzuordnung, Zielen und Verhalten identisch. Nur ihre Darstellung reagiert auf die tatsächlich verfügbare Breite:

- Bei geringer verfügbarer Breite zeigt sie ausschließlich die fünf festgelegten Icons.
- Bei ausreichender verfügbarer Breite zeigt sie dieselben Icons mit den vollständigen Bezeichnungen.
- Die Umschaltung ist breitenabhängig und nicht an einen bestimmten Gerätetyp gebunden.
- Bezeichnungen werden weder gekürzt noch abgeschnitten; zusätzliche Navigationspunkte sind auch bei großer Breite unzulässig.
- Die reine Icon-Darstellung stellt vollständige zugängliche Namen für Screenreader und bei Mausbedienung Tooltips bereit.
- Aktiver Zustand, Kontrast und Bedienflächen bleiben in beiden Darstellungen eindeutig und barrierearm.

Profilwechsel und Einstellungen bleiben oben rechts im Kopfbereich. **Schnellerfassen** bleibt eine globale Aktion und wird nicht als sechster Navigationspunkt dargestellt.

### 2.2 Fachliche Eigentümerschaft

| Bereich | Verantwortet | Verantwortet ausdrücklich nicht |
|---|---|---|
| **Start** | profilbezogene Zusammenführung aktuell relevanter Inhalte, Priorisierung, heutige Aufgaben, dynamischer Eyecatcher, Einstieg in Schnellerfassen | dauerhafte Gesundheitsdaten, fachliche Validierung, Dashboards, eigene Erfassungs- oder Analysemodelle |
| **Meine Gesundheit** | Messwerte, Medikamente und Einnahmen, Erkrankungen, Gesundheitsnotizen, Vorsorge und Gesundheitstermine | Mahlzeiten, Rezepte, Trainingsplanung, bereichsübergreifende Analyse |
| **Ernährung** | Mahlzeiten, Getränke, Ernährungsplanung, Rezepte, Zutaten und Nährwerte | Medikamente, allgemeine Messwerte, Trainingspläne |
| **Training** | Trainingspläne, Übungen, absolvierte Einheiten und Trainingsziele | allgemeine Gesundheitsmessungen, Ernährung, bereichsübergreifende Dashboards |
| **Meine Entwicklung** | Dashboards, Trends, Auswertungen, Empfehlungen, Profilvergleiche sowie Erzeugung und dauerhafte Verwaltung von Meilensteinen | originäre Erfassung oder Änderung der Quelldaten anderer Bereiche |

Die Zuordnung gilt unabhängig davon, von welchem Bildschirm eine Funktion geöffnet wird.

### 2.3 Globale App-Funktionen

Folgende Funktionen sind keinem fachlichen Hauptbereich zugeordnet:

- Profilwechsel,
- Profile anlegen, bearbeiten und löschen,
- Geräte und Datenquellen,
- Benachrichtigungen,
- Datenschutz und Profilschutz,
- Darstellung und Barrierefreiheit,
- Backup, Import und Export,
- allgemeine App-Einstellungen,
- Informationen zur App.

Der Profilwechsel bleibt oben rechts direkt erreichbar. Ein Einstellungsbutton mit Zahnrad öffnet den Einstellungsbereich. Profilverwaltung erfolgt unter **Einstellungen → Profile**. Einstellungen sind eine globale App-Funktion und kein sechster Hauptbereich.

### 2.4 Erfassen und Schnellerfassen

**Erfassen ist eine Funktion, kein fachliches Modul und kein Navigationsziel.**

- In **Meine Gesundheit** werden Gesundheitswerte, Medikamenteneinnahmen und Gesundheitsnotizen erfasst.
- In **Ernährung** werden Mahlzeiten, Getränke und zugehörige Ernährungsdaten erfasst.
- In **Training** werden Trainings und Übungen erfasst.
- In **Meine Entwicklung** darf eine fehlende Datengrundlage auf eine passende Erfassung hinweisen; die Eingabe selbst bleibt Eigentum des zuständigen Quellbereichs.

**Schnellerfassen** ist ein globaler Einstieg auf der Startseite. Die Funktion zeigt eine kompakte Auswahl und delegiert anschließend an den zuständigen Bereich. Sie besitzt keine eigene fachliche Validierung, Speicherung oder parallelen Datenmodelle.

Die erste Version von Schnellerfassen umfasst mindestens:

- Messwert,
- Medikamenteneinnahme,
- Gesundheitsnotiz,
- Training.

Ernährungsdaten werden zunächst innerhalb von **Ernährung** erfasst. Eine spätere Aufnahme in Schnellerfassen erfordert eine bewusste Spezifikationsänderung, aber keinen neuen Hauptbereich.

### 2.5 Dashboards und Meilensteine

Dashboards sind ausschließlich Bestandteil von **Meine Entwicklung**. Die Startseite ist kein Dashboard und zeigt keine dauerhaften Messwertkarten, Diagramme oder vollständigen Verläufe.

Meilensteine werden fachlich durch **Meine Entwicklung** erzeugt und dauerhaft unter **Meine Entwicklung → Meilensteine** verwaltet. Dort bestehen zwei Ansichten:

- **Timeline** für die chronologische Darstellung,
- **Sammlung** für die Gruppierung nach Bereichen und Zielarten.

Ein neuer, ungesehener Meilenstein darf vorübergehend als Eyecatcher auf der Startseite erscheinen. Das Schließen entfernt nur diese Präsentation; der Meilenstein bleibt in **Meine Entwicklung** erhalten. Bereichsspezifische Oberflächen dürfen passende Meilensteine kontextuell anzeigen, werden dadurch aber nicht deren Eigentümer.

### 2.6 Rolle der Startseite

Die Startseite ist eine lesende und koordinierende Komposition über mehrere Bereiche. Sie darf:

- freigegebene Darstellungsmodelle der Fachbereiche zusammenführen,
- Inhalte für das aktive Profil priorisieren und sortieren,
- zur zuständigen Funktion navigieren,
- Aktionen an den fachlichen Eigentümer delegieren.

Sie darf nicht:

- fachliche Regeln eines anderen Bereichs duplizieren,
- Quelldaten eigenständig interpretieren oder verändern,
- Daten verschiedener Profile vermischen,
- eigene persistente Kopien fachlicher Datensätze anlegen.

Die detaillierte Prioritätslogik und die Bildschirmzustände sind in `../pages/HOME_PAGE_SPEC.md` festgelegt.

## 3. Abhängigkeitsregeln

Die fachlichen Bereiche bleiben voneinander abgegrenzt. Bereichsübergreifende Abläufe verwenden definierte Anwendungsfälle, Schnittstellen oder lesende Darstellungsmodelle statt direkter Zugriffe auf interne Implementierungen.

Verbindlich gilt:

1. Ein Bereich besitzt seine fachlichen Daten, Regeln und Schreiboperationen.
2. Andere Bereiche dürfen Schreiboperationen nur über die öffentliche Anwendungsschnittstelle des Eigentümers auslösen.
3. Start und **Meine Entwicklung** dürfen freigegebene, profilbezogene Lesemodelle aggregieren.
4. **Meine Entwicklung** darf aus Quelldaten Erkenntnisse und Meilensteine ableiten, verändert aber nicht stillschweigend die Quelldaten.
5. Globale Funktionen wie aktives Profil, Navigation und Einstellungen werden über gemeinsame App-Schnittstellen bereitgestellt und nicht in einem Fachbereich nachgebaut.
6. Gemeinsame technische Bausteine dürfen keine fachliche Eigentümerschaft übernehmen.
7. Jede Operation muss das aktive beziehungsweise ausdrücklich gewählte Profil berücksichtigen.

Zyklische Abhängigkeiten zwischen den Fachbereichen sind nicht zulässig. Muss ein Bereich auf ein Ergebnis eines anderen reagieren, erfolgt die Kopplung über eine abstrahierte Schnittstelle, ein Ereignis oder eine koordinierende Anwendungsschicht.

## 4. Navigations- und Routingfolgen

Jedes fachliche Ziel besitzt genau einen kanonischen Bereich:

| Inhalt oder Aktion | Kanonisches Ziel |
|---|---|
| Messung, Medikament, Erkrankung, Gesundheitsnotiz, Vorsorge | Meine Gesundheit |
| Mahlzeit, Getränk, Ernährungsplanung, Rezept | Ernährung |
| Trainingsplan, Übung, Einheit, Trainingsziel | Training |
| Dashboard, Trend, Empfehlung, Profilvergleich | Meine Entwicklung |
| Meilenstein-Details, Timeline, Sammlung | Meine Entwicklung → Meilensteine |
| Profile, Geräte, Datenschutz, Backup, Darstellung | Einstellungen |

Deep Links, Hinweise, Schnellerfassen und Startseitenaktionen dürfen direkt zu einem konkreten Unterziel führen. Sie verändern dessen fachliche Eigentümerschaft nicht. Die Zurück-Navigation soll in den vorherigen Kontext zurückführen, sofern dessen Datenzustand noch gültig ist.

## 5. Erwogene Alternativen

### 5.1 Eigener Hauptbereich „Erfassen“

**Verworfen**, weil dadurch fachlich unterschiedliche Eingaben gebündelt und Validierungs- sowie Speicherlogik leicht dupliziert würden. Kontextbezogene Erfassung verkürzt Wege, ohne die Bereichsgrenzen aufzulösen.

### 5.2 Hauptbereich „Mehr“

**Verworfen**, weil er fachlich unklare Restkategorien erzeugt und wichtige Funktionen versteckt. Globale Verwaltungsfunktionen werden stattdessen über den klar erkennbaren Einstellungsbutton erreicht.

### 5.3 Dashboards als eigener Hauptbereich

**Verworfen**, weil Dashboards eine Darstellungsform von **Meine Entwicklung** sind und kein eigenständiges Fachgebiet bilden.

### 5.4 Medikamente als eigener Bereich oder unter „Mehr“

**Verworfen**, weil Medikamente, Einnahmen und zugehörige Erinnerungen unmittelbar zur persönlichen Gesundheit gehören und dort gemeinsam mit anderen Gesundheitsinformationen behandelt werden müssen.

### 5.5 Meilensteine im jeweiligen Quellbereich speichern

**Verworfen**, weil Meilensteine bereichsübergreifend entstehen können und eine gemeinsame Timeline benötigen. **Meine Entwicklung** bleibt deshalb der zentrale Eigentümer; andere Bereiche zeigen nur kontextuelle Ausschnitte.

### 5.6 Einstellungen als sechster Hauptbereich

**Verworfen**, weil Einstellungen nicht zur täglichen fachlichen Nutzung gehören. Sie bleiben global erreichbar, ohne die Hauptnavigation zu belasten.

## 6. Konsequenzen

### 6.1 Positive Folgen

- Die Hauptnavigation bleibt auf tägliche Aufgaben konzentriert.
- Jede Funktion und jeder Datensatz besitzt einen eindeutigen fachlichen Eigentümer.
- Erfassungs- und Validierungslogik muss nicht mehrfach implementiert werden.
- Neue Einstiegspunkte können ergänzt werden, ohne neue Fachmodule zu erzeugen.
- Startseite und **Meine Entwicklung** können bereichsübergreifend arbeiten, ohne die Quellbereiche zu entmachten.
- Navigation, Architektur und UI-Spezifikationen verwenden dieselben Begriffe.

### 6.2 Nachteile und Aufwand

- Bereichsübergreifende Ansichten benötigen stabile Lesemodelle und Anwendungsschnittstellen.
- Ereignisse wie Profilwechsel, neue Messwerte oder erreichte Meilensteine müssen zuverlässig zwischen Bereichen koordiniert werden.
- Direkte Abkürzungen zwischen Implementierungen sind auch dann zu vermeiden, wenn sie kurzfristig einfacher erscheinen.
- Änderungen an der fachlichen Zuordnung erfordern die abgestimmte Aktualisierung von ADR, UI-Dokumentation, Routing und Tests.

### 6.3 Risiken

- **Meine Entwicklung** könnte schleichend fachliche Regeln der Quellbereiche übernehmen.
- Schnellerfassen könnte zu einer parallelen Erfassungsimplementierung anwachsen.
- Einstellungen könnten als unspezifische Ablage für fachliche Funktionen missbraucht werden.
- Gemeinsame technische Module könnten zu einem verdeckten Sammelmodul für Geschäftslogik werden.

Diese Risiken werden durch öffentliche Bereichsschnittstellen, Architekturtests beziehungsweise Abhängigkeitsprüfungen, Code Reviews und die Akzeptanzkriterien der zugehörigen Spezifikationen begrenzt.

## 7. Umsetzungsvorgaben

- Routen und sichtbare Navigationsbezeichnungen verwenden die in diesem ADR festgelegten kanonischen Bereiche.
- Bereichsinterne Modelle und Anwendungsfälle werden nicht direkt aus Widgets eines anderen Bereichs aufgerufen, sofern keine ausdrücklich öffentliche Schnittstelle vorgesehen ist.
- Startseite und **Meine Entwicklung** erhalten eigene Koordinationslogik für Aggregation, aber keine Kopien fachlicher Schreiblogik.
- Neue Funktionen müssen vor Umsetzung einem Eigentümerbereich oder den globalen App-Funktionen zugeordnet werden.
- Tests prüfen mindestens Routing, Delegation, Profilbezug und das Fehlen doppelter Speicherung.
- Der `../UI_GUIDE.md` bleibt für Darstellung und responsive Navigation maßgeblich.
-- `../pages/HOME_PAGE_SPEC.md` bleibt für Aufbau, Zustände und Priorisierung der Startseite maßgeblich.

## 8. Prüffragen für neue Funktionen

Vor Aufnahme einer neuen Funktion ist zu beantworten:

1. Welcher Bereich besitzt die fachlichen Daten und Regeln?
2. Ist die Funktion ein eigener fachlicher Inhalt oder nur ein weiterer Einstiegspunkt?
3. Werden bestehende Validierung und Speicherung des Eigentümerbereichs wiederverwendet?
4. Benötigt Start oder **Meine Entwicklung** nur ein Lesemodell statt eines direkten Datenzugriffs?
5. Bleibt die Funktion eindeutig einem Profil zugeordnet?
6. Verändert sie die fünf Hauptbereiche oder nur deren interne Struktur?
7. Müssen dieses ADR, der UI-Guide oder eine Bildschirmspezifikation angepasst werden?

## 9. Gültigkeit und Änderung

Dieses ADR ist angenommen und gilt für Architektur, Navigation und neue Implementierungen des Health Trackers. Kleinere Präzisierungen dürfen ergänzt werden, solange sie die Entscheidung nicht verändern.

Eine Änderung der fünf Hauptbereiche, der fachlichen Eigentümerschaft oder der Rolle von Erfassen, Einstellungen, Dashboards beziehungsweise Meilensteinen erfordert ein neues ADR. Das neue ADR ersetzt dieses Dokument ganz oder teilweise und verweist ausdrücklich darauf.
