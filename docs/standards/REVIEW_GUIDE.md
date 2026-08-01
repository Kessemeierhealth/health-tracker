# REVIEW_GUIDE.md

> HealthTracker Review Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-REVIEW-001 |
| Dokumenttyp | Projektstandard |
| Kategorie | Qualitätsmanagement |
| Version | 1.0.0 |
| Status | In Bearbeitung |
| Owner | HealthTracker Team |
| Reviewer | HealthTracker Team |
| Freigegeben | — |
| Letzte Änderung | 2026-07-31 |
| Reviewintervall | Vor jedem Major Release |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|---------|-------|----------|-------|-------|
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Einführung eines projektweiten Reviewstandards | HealthTracker Team |

---

# Dokumentqualität

| Kriterium | Status |
|-----------|:------:|
| Vollständigkeit | ⏳ |
| Konsistenz | ✅ |
| Verständlichkeit | ✅ |
| Beispiele | ✅ |
| Review | ⏳ |
| Freigabe | ⏳ |

**Qualitätsindex:** 30 %

Der Qualitätsindex wird nach Abschluss aller vier Teile auf mindestens **95 %** angehoben.

---

# Zweck

Dieser Standard definiert den verbindlichen Reviewprozess für das gesamte HealthTracker-Projekt.

Er beschreibt die Regeln zur Qualitätssicherung für

- Dokumentation,
- Architektur,
- Anforderungen,
- Quellcode,
- Tests,
- Benutzeroberfläche,
- Datenschutz,
- medizinische Inhalte
- und Releases.

Der Reviewprozess stellt sicher, dass alle Projektartefakte vor ihrer Freigabe überprüft und dokumentiert werden.

---

# Ziele

Der Reviewprozess verfolgt folgende Ziele:

- Hohe Softwarequalität sicherstellen
- Fehler frühzeitig erkennen
- Einheitliche Standards durchsetzen
- Fachliche Konsistenz gewährleisten
- Architektur schützen
- Wartbarkeit verbessern
- Dokumentation aktuell halten
- Risiken minimieren
- Datenschutz sicherstellen
- Medizinische Korrektheit gewährleisten

---

# Geltungsbereich

Dieser Standard gilt verbindlich für alle Bestandteile des Projekts.

Insbesondere für

- Projektdokumentation
- Standarddokumente
- Moduldokumentation
- Functional Requirements
- Non-Functional Requirements
- Use Cases
- Business Rules
- Validation Rules
- Datenmodelle
- Architektur
- ADRs
- Quellcode
- Tests
- UI
- Releases

---

# Grundprinzipien

## Qualität vor Geschwindigkeit

Kein Artefakt wird freigegeben, bevor das erforderliche Review erfolgreich abgeschlossen wurde.

Ein schneller Release rechtfertigt niemals den Verzicht auf ein Review.

---

## Vier-Augen-Prinzip

Jede fachlich relevante Änderung wird von mindestens einer zweiten Person geprüft.

Ist kein zweiter Reviewer verfügbar (z. B. Einzelentwickler), erfolgt das Review zeitlich getrennt anhand der definierten Checklisten.

---

## Sachlichkeit

Reviews beziehen sich ausschließlich auf Inhalte.

Bewertet werden

- Qualität,
- Verständlichkeit,
- Konsistenz,
- Risiken
- und Einhaltung der Standards.

Persönliche Bewertungen sind unzulässig.

---

## Nachvollziehbarkeit

Jedes Review muss dokumentiert werden.

Mindestens festzuhalten sind

- Reviewer
- Datum
- Ergebnis
- offene Punkte
- erforderliche Maßnahmen

---

## Reproduzierbarkeit

Zwei Reviewer sollen bei identischer Grundlage zum gleichen Ergebnis gelangen.

Dazu werden standardisierte Checklisten verwendet.

---

## Kontinuierliche Verbesserung

Festgestellte Schwächen fließen in die Weiterentwicklung der Projektstandards ein.

Änderungen erfolgen ausschließlich versioniert.

---

## Dokumentation als Qualitätsbestandteil

Ein Artefakt gilt nur dann als vollständig,

wenn

- Dokumentation,
- Tests,
- Traceability
- und Changelog

ebenfalls aktuell sind.

---

# Reviewarten

Für HealthTracker werden folgende Reviewarten unterschieden.

| Review | Zweck |
|---------|-------|
| Dokumentenreview | Prüfung aller Dokumente |
| Requirements Review | Prüfung fachlicher Anforderungen |
| Architekturreview | Prüfung der Softwarearchitektur |
| Datenmodellreview | Prüfung des Datenmodells |
| Codereview | Prüfung des Quellcodes |
| Testreview | Prüfung der Testfälle und Testergebnisse |
| UI-/UX-Review | Prüfung der Benutzeroberfläche |
| Sicherheitsreview | Datenschutz und IT-Sicherheit |
| Medizinisches Review | Fachliche Prüfung medizinischer Inhalte |
| Release Review | Letzte Prüfung vor einer Veröffentlichung |

Jede Reviewart besitzt eigene Prüfkriterien.

Diese werden in den folgenden Kapiteln definiert.

---

# Rollen und Verantwortlichkeiten

## Owner

Der Owner ist verantwortlich für

- Erstellung,
- Pflege,
- Aktualität
- und fachliche Richtigkeit

des Artefakts.

---

## Reviewer

Der Reviewer prüft

- Einhaltung der Standards,
- fachliche Qualität,
- Konsistenz,
- Vollständigkeit,
- Risiken.

Der Reviewer darf keine Freigabe erteilen, wenn wesentliche Mängel bestehen.

---

## Approver

Der Approver entscheidet über die Freigabe.

Die Freigabe darf nur erfolgen,

wenn

- alle Reviewpunkte erfüllt sind,
- keine offenen kritischen Mängel bestehen,
- alle Pflichtdokumente aktuell sind.

---

## Entwickler

Entwickler

- beheben Reviewkommentare,
- aktualisieren Dokumentation,
- ergänzen Tests,
- dokumentieren Änderungen.

---

## Tester

Tester prüfen

- Testfälle,
- Testergebnisse,
- Regressionen,
- Nachvollziehbarkeit.

---

## Product Owner

Der Product Owner verantwortet

- fachliche Prioritäten,
- Anforderungen,
- Freigabe fachlicher Änderungen.

---

# Reviewstatus

Alle Reviews verwenden dieselben Status.

| Status | Bedeutung |
|---------|-----------|
| Draft | Noch nicht bereit für ein Review |
| Ready for Review | Artefakt ist vollständig vorbereitet |
| In Review | Review läuft |
| Changes Requested | Änderungen erforderlich |
| Approved | Fachlich freigegeben |
| Verified | Umsetzung erfolgreich geprüft |
| Rejected | Review nicht bestanden |
| Archived | Historisch archiviert |

---

# Reviewer-Kodex

Alle Reviews erfolgen nach folgenden Grundsätzen.

- respektvoll
- sachlich
- nachvollziehbar
- konstruktiv
- lösungsorientiert
- standardbasiert

Persönliche Meinungen dürfen niemals die fachliche Bewertung ersetzen.

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Dokumenthistorie
- Dokumentqualität
- Zweck
- Ziele
- Geltungsbereich
- Grundprinzipien
- Reviewarten
- Rollen und Verantwortlichkeiten
- Reviewstatus
- Reviewer-Kodex

---

## Teil 2

Der nächste Abschnitt behandelt:

- Dokumentenreview
- Requirements Review
- Architekturreview
- Datenmodellreview
- UI-/UX-Review
- Sicherheitsreview
- Medizinisches Review
- Datenschutz-Review
- Performance-Review

# Dokumentenreview

Alle Projektdokumente müssen vor ihrer Freigabe einem Dokumentenreview unterzogen werden.

## Ziel

Das Dokumentenreview stellt sicher, dass Dokumente

- vollständig,
- verständlich,
- konsistent,
- aktuell,
- widerspruchsfrei
- und versioniert

sind.

---

## Prüfkriterien

Folgende Punkte sind mindestens zu prüfen.

### Allgemein

- Dokument-ID vorhanden
- Version aktuell
- Dokumenthistorie gepflegt
- Status korrekt
- Owner eingetragen

---

### Inhalt

- Zweck eindeutig
- Geltungsbereich vollständig
- Struktur vollständig
- Kapitel logisch aufgebaut
- Beispiele vorhanden
- Referenzen korrekt

---

### Qualität

- Rechtschreibung
- Verständlichkeit
- Konsistenz
- Wiederholungen vermeiden
- Einheitliche Terminologie

---

### Traceability

Prüfen:

- Referenzen vorhanden
- Dokumente gegenseitig verlinkt
- IDs korrekt
- Artefakte nachvollziehbar

---

# Requirements Review

Requirements werden fachlich überprüft.

Das Ziel ist sicherzustellen, dass jede Requirement

- eindeutig,
- vollständig,
- testbar,
- nachvollziehbar

ist.

---

## Prüfkriterien

### Functional Requirements

Prüfen:

- eindeutige ID
- Beschreibung vollständig
- Akzeptanzkriterien vorhanden
- Priorität definiert
- Traceability vollständig

---

### Non Functional Requirements

Prüfen:

- Qualitätsmerkmal eindeutig
- Messbarkeit gegeben
- Zielwert definiert
- Testbarkeit vorhanden

---

### Use Cases

Prüfen:

- Ziel eindeutig
- Akteure vollständig
- Vorbedingungen vorhanden
- Nachbedingungen definiert
- Alternativabläufe dokumentiert

---

### Business Rules

Prüfen:

- fachlich korrekt
- widerspruchsfrei
- nachvollziehbar
- referenziert

---

### Validation Rules

Prüfen:

- Eingaben vollständig
- Fehlermeldungen definiert
- Grenzwerte dokumentiert
- Beispiele vorhanden

---

# Architekturreview

Das Architekturreview schützt die langfristige Qualität des Projekts.

Es verhindert Architekturverletzungen.

---

## Prüfkriterien

### Schichten

Prüfen:

- Clean Architecture eingehalten
- Abhängigkeiten korrekt
- Domain unabhängig
- Infrastruktur getrennt

---

### Module

Prüfen:

- Verantwortlichkeiten eindeutig
- Schnittstellen sauber
- geringe Kopplung
- hohe Kohäsion

---

### Erweiterbarkeit

Prüfen:

- Module erweiterbar
- keine zyklischen Abhängigkeiten
- Technologien austauschbar

---

### ADRs

Prüfen:

- Architekturentscheidung dokumentiert
- ADR aktuell
- Auswirkungen beschrieben

---

# Datenmodellreview

Das Datenmodell wird auf fachliche und technische Qualität geprüft.

---

## Prüfkriterien

### Entitäten

Prüfen:

- eindeutige Identität
- Attribute vollständig
- Beziehungen korrekt

---

### Value Objects

Prüfen:

- immutable
- fachlich korrekt
- validiert

---

### Datenqualität

Prüfen:

- Datentypen passend
- Constraints definiert
- Standardwerte dokumentiert

---

### Persistenz

Prüfen:

- Mapping vollständig
- Migration berücksichtigt
- Rückwärtskompatibilität

---

# UI-/UX-Review

Die Benutzeroberfläche wird hinsichtlich Bedienbarkeit und Konsistenz geprüft.

---

## Bedienbarkeit

Prüfen:

- Navigation verständlich
- Bedienung intuitiv
- Eingaben nachvollziehbar
- Fehlermeldungen verständlich

---

## Konsistenz

Prüfen:

- Farben einheitlich
- Icons konsistent
- Typografie einheitlich
- Komponenten wiederverwendet

---

## Accessibility

Prüfen:

- ausreichende Kontraste
- Mindestschriftgröße
- Screenreader-Unterstützung
- Fokussteuerung
- Touch-Ziele ausreichend groß

---

## Responsivität

Prüfen:

- verschiedene Displaygrößen
- Hoch- und Querformat
- Tablet-Unterstützung
- Web-Darstellung

---

# Sicherheitsreview

Gesundheitsdaten besitzen höchste Priorität.

Vor jeder Freigabe erfolgt ein Sicherheitsreview.

---

## Authentifizierung

Prüfen:

- Passwortschutz
- Sperrmechanismen
- Sitzungsverwaltung

---

## Datenschutz

Prüfen:

- DSGVO eingehalten
- Datensparsamkeit
- Einwilligungen dokumentiert
- Exportmöglichkeiten vorhanden
- Löschfunktionen vorhanden

---

## Verschlüsselung

Prüfen:

- lokale Daten verschlüsselt
- Backups geschützt
- Passwörter niemals im Klartext
- sichere Schlüsselverwaltung

---

## Berechtigungen

Prüfen:

- notwendige Berechtigungen
- keine überflüssigen Rechte
- Zugriffskontrolle korrekt

---

# Medizinisches Review

Alle medizinischen Funktionen werden fachlich geprüft.

Dieses Review ist verpflichtend für Module mit gesundheitsbezogenen Berechnungen oder Empfehlungen.

---

## Prüfkriterien

### Referenzwerte

Prüfen:

- medizinisch korrekt
- Quellen dokumentiert
- Aktualität gewährleistet

---

### Berechnungen

Prüfen:

- BMI
- Bauchumfang
- Blutdruck
- Puls
- weitere Kennzahlen

Alle Formeln müssen nachvollziehbar dokumentiert sein.

---

### Empfehlungen

Prüfen:

- medizinisch vertretbar
- eindeutig formuliert
- keine Diagnosen
- Hinweise auf ärztliche Beratung, wenn erforderlich

---

# Datenschutz-Review

Zusätzlich zum Sicherheitsreview erfolgt ein Datenschutz-Review.

---

## Prüfkriterien

Prüfen:

- Zweckbindung
- Datenminimierung
- Speicherfristen
- Datenexport
- Datenlöschung
- Backup
- Wiederherstellung
- Protokollierung

---

# Performance-Review

Vor jedem Release wird die Performance überprüft.

---

## Prüfkriterien

Prüfen:

- Startzeit
- Speicherverbrauch
- CPU-Auslastung
- Datenbankzugriffe
- Rendering
- Scroll-Performance
- Synchronisation
- Netzwerkzugriffe

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Dokumentenreview
- Requirements Review
- Architekturreview
- Datenmodellreview
- UI-/UX-Review
- Accessibility-Review
- Sicherheitsreview
- Medizinisches Review
- Datenschutz-Review
- Performance-Review

---

## Teil 3

Der nächste Abschnitt behandelt:

- Codereview
- Testreview
- Automatisierte Reviews
- CI/CD-Qualitätsprüfungen
- Review-Checklisten
- Qualitätsmetriken
- Reviewprotokolle
- Reviewberichte

# Codereview

Jede Änderung am Quellcode muss vor dem Merge in den Hauptbranch einem Codereview unterzogen werden.

Ziel des Codereviews ist es,

- Fehler frühzeitig zu erkennen,
- Architekturverletzungen zu vermeiden,
- Lesbarkeit zu verbessern,
- Wartbarkeit sicherzustellen,
- Projektrichtlinien einzuhalten.

---

# Grundregeln

Ein Codereview bewertet

- den Code,
- niemals den Entwickler.

Alle Kommentare sind

- sachlich,
- konstruktiv,
- nachvollziehbar
- lösungsorientiert.

---

# Prüfkriterien

## Architektur

Prüfen:

- Clean Architecture eingehalten
- Verantwortlichkeiten sauber getrennt
- Abhängigkeiten korrekt
- keine zyklischen Abhängigkeiten
- keine Architekturverletzungen

---

## Benennung

Prüfen:

- Naming Conventions eingehalten
- Klassen eindeutig
- Methoden verständlich
- Variablen sprechend
- Dateien korrekt benannt

---

## Lesbarkeit

Prüfen:

- Methoden kurz
- Klassen übersichtlich
- keine Duplikate
- keine unnötige Komplexität

---

## Wartbarkeit

Prüfen:

- Erweiterbarkeit
- Wiederverwendbarkeit
- lose Kopplung
- hohe Kohäsion

---

## Sicherheit

Prüfen:

- keine sensiblen Daten im Log
- Eingaben validiert
- Exceptions behandelt
- Berechtigungen korrekt

---

## Performance

Prüfen:

- unnötige Datenbankzugriffe
- unnötige Rebuilds
- unnötige Schleifen
- Speicherverbrauch
- asynchrone Verarbeitung

---

## Dokumentation

Prüfen:

- Kommentare sinnvoll
- DartDoc vorhanden
- Changelog aktualisiert
- Traceability gepflegt

---

# Flutter-Review

Zusätzlich werden Flutter-spezifische Aspekte geprüft.

## Widgets

Prüfen:

- kleine Widgets
- Wiederverwendung
- const verwendet
- Stateless bevorzugt
- State nur wenn notwendig

---

## Riverpod

Prüfen:

- Provider korrekt verwendet
- Notifier sauber getrennt
- keine Business-Logik im Widget
- Provider eindeutig benannt

---

## UI

Prüfen:

- Theme verwendet
- Hardcodierte Farben vermeiden
- Hardcodierte Texte vermeiden
- Responsive Layout

---

# Testreview

Alle Tests werden ebenfalls reviewed.

---

## Unit Tests

Prüfen:

- fachlich korrekt
- verständlich
- unabhängig
- reproduzierbar

---

## Widget Tests

Prüfen:

- Benutzerinteraktion getestet
- Zustände getestet
- Navigation geprüft

---

## Integration Tests

Prüfen:

- reale Abläufe getestet
- Module integriert
- Fehlerfälle berücksichtigt

---

## Testabdeckung

Prüfen:

- neue Funktion getestet
- Randfälle getestet
- Fehlerfälle getestet
- Regression berücksichtigt

---

# Automatisierte Reviews

Vor jedem Merge werden automatische Prüfungen ausgeführt.

---

## Dart Analyzer

Muss fehlerfrei sein.

```text
flutter analyze
```

---

## Formatierung

Muss aktuell sein.

```text
dart format
```

---

## Tests

Alle Tests müssen erfolgreich sein.

```text
flutter test
```

---

## Linter

Alle Lint-Regeln müssen erfüllt sein.

Neue Warnungen sind nicht zulässig.

---

# CI/CD-Qualitätsprüfung

Vor dem Merge werden mindestens folgende Prüfungen durchgeführt.

- Projekt baut erfolgreich
- Analyzer fehlerfrei
- Tests erfolgreich
- Dokumentation aktuell
- Changelog gepflegt
- Version korrekt
- keine Merge-Konflikte

---

# Review-Checkliste

## Dokumentation

- [ ] README aktuell
- [ ] Dokumentation vollständig
- [ ] Traceability gepflegt
- [ ] Changelog aktualisiert

---

## Architektur

- [ ] Schichten korrekt
- [ ] Module korrekt
- [ ] Abhängigkeiten korrekt

---

## Code

- [ ] Naming Conventions eingehalten
- [ ] keine Duplikate
- [ ] keine toten Klassen
- [ ] keine ungenutzten Imports
- [ ] keine Debug-Ausgaben

---

## Flutter

- [ ] Widgets klein
- [ ] const verwendet
- [ ] Theme verwendet
- [ ] Provider korrekt

---

## Tests

- [ ] Unit Tests
- [ ] Widget Tests
- [ ] Integration Tests
- [ ] Fehlerfälle

---

## Sicherheit

- [ ] Validierung
- [ ] Datenschutz
- [ ] Logging geprüft

---

# Qualitätsmetriken

Folgende Kennzahlen werden regelmäßig erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Analysefehler | 0 |
| Lint-Warnungen | 0 |
| Testfehler | 0 |
| Buildfehler | 0 |
| Kritische Bugs | 0 |
| Dokumentationslücken | 0 |

---

# Reviewprotokoll

Jedes Review wird dokumentiert.

Ein Reviewprotokoll enthält mindestens:

- Review-ID
- Artefakt
- Version
- Reviewer
- Datum
- Ergebnis
- Feststellungen
- Maßnahmen
- Freigabestatus

---

## Beispiel

| Feld | Wert |
|------|------|
| Review-ID | REV-2026-001 |
| Artefakt | ProfileRepository |
| Version | 1.0.0 |
| Reviewer | Max Mustermann |
| Datum | 2026-07-31 |
| Ergebnis | Approved with minor comments |

---

# Reviewbericht

Bei umfangreichen Reviews wird zusätzlich ein Reviewbericht erstellt.

Der Bericht enthält:

- Zusammenfassung
- Risiken
- offene Punkte
- Empfehlungen
- Entscheidung
- Nachverfolgung

---

# Umgang mit Reviewkommentaren

Reviewkommentare werden klassifiziert.

| Kategorie | Bedeutung |
|-----------|-----------|
| Blocker | Muss vor Freigabe behoben werden |
| Major | Wesentlicher Mangel |
| Minor | Verbesserung empfohlen |
| Suggestion | Optionale Verbesserung |
| Question | Klärungsbedarf |

Blocker und Major-Kommentare verhindern eine Freigabe.

---

# Eskalation

Kann zwischen Owner und Reviewer keine Einigung erzielt werden, erfolgt die Eskalation an den Approver.

Bei Architekturentscheidungen ist zusätzlich ein ADR zu erstellen.

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Codereview
- Flutter-Review
- Riverpod-Review
- Testreview
- Automatisierte Reviews
- CI/CD-Qualitätsprüfungen
- Review-Checklisten
- Qualitätsmetriken
- Reviewprotokolle
- Reviewberichte
- Umgang mit Reviewkommentaren
- Eskalationsprozess

---

## Teil 4

Der letzte Abschnitt behandelt:

- Definition of Ready
- Definition of Done
- Freigabekriterien
- Reviewworkflow
- Ausnahmen
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Definition of Ready (DoR)

Ein Artefakt gilt als **Ready for Review**, wenn alle folgenden Kriterien erfüllt sind.

## Allgemein

- Zweck eindeutig beschrieben
- Verantwortlicher (Owner) benannt
- Dokument bzw. Quellcode vollständig
- Version vergeben
- Dokumenthistorie aktualisiert

---

## Dokumentation

Prüfen:

- Struktur vollständig
- Format gemäß DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md eingehalten
- NAMING_CONVENTIONS.md eingehalten
- Referenzen vorhanden

---

## Requirements

Prüfen:

- Functional Requirements vollständig
- Non Functional Requirements vollständig
- Use Cases dokumentiert
- Business Rules vorhanden
- Validation Rules vorhanden
- Traceability vorbereitet

---

## Quellcode

Prüfen:

- Code kompiliert fehlerfrei
- Analyzer fehlerfrei
- Formatierung durchgeführt
- Linter fehlerfrei
- Architektur eingehalten

---

## Tests

Prüfen:

- Unit Tests erstellt
- Widget Tests erstellt (falls erforderlich)
- Integration Tests ergänzt (falls erforderlich)
- Testdaten vorhanden

---

Ein Artefakt darf erst in den Status **Ready for Review** wechseln, wenn sämtliche Pflichtkriterien erfüllt sind.

---

# Definition of Done (DoD)

Ein Artefakt gilt erst dann als abgeschlossen, wenn sämtliche fachlichen, technischen und organisatorischen Anforderungen erfüllt wurden.

## Dokumentation

- Dokument vollständig
- Review abgeschlossen
- Version aktualisiert
- Changelog gepflegt
- Traceability vollständig

---

## Code

- Build erfolgreich
- Analyzer fehlerfrei
- Keine Lint-Warnungen
- Keine bekannten Blocker
- Keine Debug-Ausgaben
- Keine TODOs ohne Referenz

---

## Tests

- Alle Tests erfolgreich
- Neue Funktion getestet
- Fehlerfälle getestet
- Regression erfolgreich

---

## Architektur

- Clean Architecture eingehalten
- Abhängigkeiten geprüft
- Architekturreview bestanden

---

## Sicherheit

- Datenschutzreview bestanden
- Sicherheitsreview bestanden
- Keine bekannten Sicherheitslücken

---

## Medizinische Inhalte

Falls das Modul medizinische Berechnungen oder Empfehlungen enthält:

- Medizinisches Review bestanden
- Quellen dokumentiert
- Berechnungen validiert

---

## Freigabe

- Reviewstatus **Approved**
- Approver hat freigegeben
- Merge durchgeführt

---

# Freigabekriterien

Eine Freigabe darf nur erfolgen, wenn:

- keine offenen Blocker existieren,
- keine offenen Major-Mängel bestehen,
- alle Pflichtreviews erfolgreich abgeschlossen wurden,
- alle automatischen Qualitätsprüfungen erfolgreich waren,
- Dokumentation aktuell ist,
- Changelog gepflegt wurde,
- Traceability vollständig ist.

---

# Reviewworkflow

Der Reviewprozess folgt einem standardisierten Ablauf.

```text
Erstellung
      │
      ▼
Self Review
      │
      ▼
Ready for Review
      │
      ▼
Review
      │
      ▼
Änderungen erforderlich?
      │
 ┌────┴────┐
 │         │
Nein      Ja
 │         │
 ▼         ▼
Approved  Überarbeitung
 │         │
 └────┬────┘
      ▼
Verification
      ▼
Merge / Freigabe
```

Jede Phase muss dokumentiert werden.

---

# Reviewhäufigkeit

| Artefakt | Review |
|-----------|--------|
| Standarddokumente | Vor jeder Freigabe |
| Moduldokumente | Bei jeder fachlichen Änderung |
| Architektur | Bei jeder Architekturänderung |
| Requirements | Bei jeder Erweiterung |
| Quellcode | Vor jedem Merge |
| Tests | Vor jedem Release |
| Sicherheitsrelevanter Code | Immer zusätzliches Sicherheitsreview |
| Medizinische Regeln | Immer zusätzliches medizinisches Review |

---

# Ausnahmen

Abweichungen vom Reviewprozess sind nur zulässig,

wenn

- sie dokumentiert wurden,
- begründet sind,
- vom Approver genehmigt wurden,
- keine Sicherheits- oder Datenschutzanforderungen verletzt werden.

Architekturentscheidungen sind zusätzlich über einen ADR zu dokumentieren.

---

# Kontinuierliche Verbesserung

Der Reviewprozess wird regelmäßig überprüft.

Verbesserungsvorschläge stammen insbesondere aus:

- Retrospektiven
- Code Reviews
- Release Reviews
- Fehleranalysen
- Architekturreviews
- Nutzerfeedback

Änderungen werden ausschließlich über eine neue Dokumentversion eingeführt.

---

# Kennzahlen (KPIs)

Zur Bewertung des Reviewprozesses werden folgende Kennzahlen erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Reviewdurchlaufzeit | ≤ 2 Arbeitstage |
| Blocker nach Freigabe | 0 |
| Kritische Produktionsfehler | 0 |
| Erfolgreiche Builds | 100 % |
| Erfolgreiche Tests | 100 % |
| Dokumentationsabdeckung | ≥ 95 % |
| Traceability-Abdeckung | 100 % |

---

# Rollen im Reviewworkflow

| Rolle | Verantwortung |
|--------|---------------|
| Owner | Erstellung und Pflege des Artefakts |
| Reviewer | Fachliche und technische Prüfung |
| Approver | Endgültige Freigabe |
| Entwickler | Umsetzung der Reviewkommentare |
| Tester | Verifikation der Umsetzung |
| Product Owner | Fachliche Freigabe bei Anforderungen |

---

# Referenzen

Dieser Standard baut auf folgenden Projektdokumenten auf:

- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REQUIREMENTS_GUIDE.md
- TRACEABILITY_GUIDE.md
- ARCHITECTURE_GUIDE.md
- TESTING_GUIDE.md
- SECURITY_GUIDE.md

Alle genannten Dokumente sind verbindlich anzuwenden.

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-REVIEW-001 |
| Version | 1.0.0 |
| Status | **Approved** |
| Freigegeben am | 2026-07-31 |
| Gültig ab | 2026-07-31 |
| Nächstes Review | Vor dem nächsten Major Release |

---

# Änderungsstopp

Mit der Freigabe der Version **1.0.0** gilt dieses Dokument als abgeschlossen.

Änderungen an diesem Dokument erfolgen ausschließlich durch:

1. Erstellung einer neuen Dokumentversion.
2. Aktualisierung der Dokumenthistorie.
3. Anpassung des Änderungsverlaufs.
4. Erneutes Review und Freigabe.
5. Dokumentation wesentlicher Architekturänderungen über einen Architecture Decision Record (ADR).

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.

---

# Status

**Dokument:** `docs/standards/REVIEW_GUIDE.md`

**Version:** 1.0.0

**Status:** ✅ Ready for Repository