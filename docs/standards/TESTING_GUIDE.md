# TESTING_GUIDE.md

> HealthTracker Testing Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-TEST-001 |
| Dokumenttyp | Projektstandard |
| Kategorie | Qualitätssicherung |
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
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Einführung eines projektweiten Teststandards | HealthTracker Team |

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

Dieses Dokument definiert den verbindlichen Teststandard für das HealthTracker-Projekt.

Der Standard beschreibt:

- Teststrategie
- Testarten
- Testorganisation
- Qualitätsanforderungen
- Testabdeckung
- Testprozesse
- Reviewregeln
- Freigabekriterien

Ziel ist eine reproduzierbare und langfristig wartbare Qualitätssicherung.

---

# Ziele

Die Teststrategie verfolgt folgende Ziele:

- Fehler frühzeitig erkennen
- Regressionen verhindern
- Fachliche Regeln absichern
- Gesundheitsdaten korrekt verarbeiten
- Datenschutz sicherstellen
- Hohe Codequalität erreichen
- Sichere Releases ermöglichen
- Automatisierte Qualitätssicherung fördern

---

# Geltungsbereich

Dieser Standard gilt für sämtliche Tests des Projekts.

Insbesondere für:

- Domain
- Application Layer
- Infrastructure Layer
- Presentation Layer
- Riverpod Provider
- Riverpod Notifier
- Repositorys
- Use Cases
- Widgets
- APIs
- Datenmigrationen
- Releases

---

# Grundprinzipien

## Test First Mindset

Neue Funktionen werden grundsätzlich mit einer Teststrategie entwickelt.

Tests sind kein optionaler Bestandteil der Entwicklung.

---

## Automatisierung

Alle wiederholbaren Tests werden automatisiert.

Manuelle Tests sind nur zulässig,

wenn

- Benutzerinteraktionen geprüft werden müssen,
- Hardware erforderlich ist,
- gesetzliche Vorgaben dies verlangen.

---

## Reproduzierbarkeit

Jeder Test muss jederzeit reproduzierbar sein.

Ein Test darf nicht vom Zufall,

vom aktuellen Datum

oder von externen Systemen abhängen.

---

## Unabhängigkeit

Tests beeinflussen sich gegenseitig nicht.

Jeder Test kann einzeln ausgeführt werden.

---

## Verständlichkeit

Testfälle beschreiben eindeutig,

- was geprüft wird,
- warum geprüft wird,
- welches Ergebnis erwartet wird.

---

## Frühes Feedback

Fehler sollen möglichst früh erkannt werden.

Die Reihenfolge lautet:

```text
Unit Test

↓

Widget Test

↓

Integration Test

↓

Manueller Test
```

---

## Nachvollziehbarkeit

Jeder Test verweist auf mindestens eine Requirement.

Beispiel

```text
PRO-TC-001

↓

PRO-FR-001
```

Die Traceability ist verpflichtend.

---

# Teststrategie

HealthTracker verwendet eine mehrstufige Teststrategie.

```text
              Manuelle Tests
                     ▲
              Integration Tests
                     ▲
               Widget Tests
                     ▲
                 Unit Tests
```

Die Mehrheit aller Tests soll aus Unit Tests bestehen.

---

# Testpyramide

| Ebene | Ziel |
|--------|------|
| Unit Test | Fachliche Logik |
| Widget Test | UI-Komponenten |
| Integration Test | Modulübergreifende Abläufe |
| Manueller Test | Benutzererlebnis |

Grundsatz:

Viele schnelle Tests,

wenige langsame Tests.

---

# Testziele

Jeder Test verfolgt mindestens eines der folgenden Ziele.

- Korrektheit
- Stabilität
- Sicherheit
- Performance
- Regression
- Datenintegrität
- Benutzerfreundlichkeit

---

# Testebenen

## Domain

Prüfen:

- Entities
- Value Objects
- Business Rules
- Validation Rules
- Use Cases

---

## Application

Prüfen:

- Abläufe
- Orchestrierung
- Fehlerbehandlung

---

## Infrastructure

Prüfen:

- Repositorys
- Persistenz
- Import
- Export
- Backup

---

## Presentation

Prüfen:

- Widgets
- Navigation
- Riverpod
- Benutzerinteraktion

---

# Testarten (Überblick)

HealthTracker unterscheidet folgende Testarten.

| Testart | Ziel |
|----------|------|
| Unit Test | Fachliche Logik |
| Widget Test | Darstellung |
| Integration Test | Gesamtabläufe |
| Repository Test | Persistenz |
| Provider Test | Riverpod |
| Golden Test | UI-Stabilität |
| Performance Test | Geschwindigkeit |
| Sicherheitstest | Datenschutz |
| Migrationstest | Datenmigration |
| Manueller Test | Benutzererlebnis |

Die einzelnen Testarten werden in Teil 2 beschrieben.

---

# Rollen und Verantwortlichkeiten

## Entwickler

Verantwortlich für:

- Unit Tests
- Widget Tests
- Aktualisierung bestehender Tests
- Fehlerbehebung

---

## Tester

Verantwortlich für:

- Testdurchführung
- Testprotokolle
- Regressionstests
- Verifikation

---

## Reviewer

Prüft:

- Testqualität
- Testabdeckung
- Lesbarkeit
- Nachvollziehbarkeit

---

## Product Owner

Verantwortlich für:

- Fachliche Testabnahme
- Akzeptanzkriterien
- Freigabe fachlicher Funktionen

---

# Teststatus

Alle Tests verwenden dieselben Status.

| Status | Bedeutung |
|---------|-----------|
| Draft | Testfall erstellt |
| Ready | Bereit zur Ausführung |
| Running | Wird ausgeführt |
| Passed | Erfolgreich |
| Failed | Fehler gefunden |
| Blocked | Durchführung nicht möglich |
| Archived | Historisch |

---

# Testdokumentation

Jeder Testfall dokumentiert mindestens:

- Test-ID
- Requirement
- Testziel
- Voraussetzungen
- Eingaben
- Erwartetes Ergebnis
- Tatsächliches Ergebnis
- Status
- Tester
- Datum

---

# Testdaten

Testdaten müssen

- reproduzierbar,
- anonymisiert,
- dokumentiert

sein.

Produktivdaten dürfen niemals direkt für Tests verwendet werden.

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
- Teststrategie
- Testpyramide
- Testziele
- Testebenen
- Testarten (Überblick)
- Rollen und Verantwortlichkeiten
- Teststatus
- Testdokumentation
- Testdaten

---

## Teil 2

Der nächste Abschnitt behandelt:

- Unit Tests
- Widget Tests
- Integration Tests
- Golden Tests
- Repository Tests
- Riverpod-Tests
- Sicherheits- und Datenschutztests
- Medizinische Regeltests
- Migrationstests
- Plattformtests

# Unit Tests

Unit Tests prüfen die kleinste fachliche Einheit isoliert.

Sie bilden die Grundlage der Teststrategie und stellen den größten Anteil aller automatisierten Tests dar.

---

## Ziel

Unit Tests prüfen insbesondere:

- Business Rules
- Validation Rules
- Value Objects
- Entities
- Use Cases
- Domain Services
- Mapper
- Converter

---

## Regeln

Unit Tests

- laufen ohne Flutter UI,
- verwenden keine echte Datenbank,
- verwenden keine Netzwerkverbindungen,
- sind reproduzierbar,
- sind unabhängig voneinander.

---

## Beispiel

```text
CreateProfileUseCase
        │
        ▼
create_profile_use_case_test.dart
```

---

# Widget Tests

Widget Tests prüfen einzelne Flutter-Widgets isoliert.

---

## Ziel

Prüfen:

- Darstellung
- Benutzerinteraktionen
- Zustandsänderungen
- Fehleranzeigen
- Navigation innerhalb des Widgets

---

## Beispiele

```text
ProfileEditorPage

ProfileForm

DashboardTileWidget

MeasurementCardWidget
```

---

## Regeln

Widget Tests

- verwenden Testdaten,
- verwenden Mock-Provider,
- greifen nicht auf produktive Datenquellen zu.

---

# Integration Tests

Integration Tests prüfen das Zusammenspiel mehrerer Komponenten.

---

## Ziel

Prüfen:

- komplette Benutzerabläufe,
- Modulkommunikation,
- Repositorys,
- Persistenz,
- Navigation,
- Synchronisation.

---

## Beispiele

```text
Profil anlegen

↓

Messwert erfassen

↓

Dashboard aktualisieren
```

---

# Repository Tests

Repository Tests prüfen ausschließlich die Repository-Implementierung.

---

## Prüfen

- Speichern
- Lesen
- Aktualisieren
- Löschen
- Fehlerbehandlung
- Migration

---

## Nicht prüfen

Repository Tests prüfen keine Business Rules.

Diese gehören in Unit Tests.

---

# Riverpod Tests

Riverpod ist Bestandteil der Architektur.

Deshalb werden Provider und Notifier separat getestet.

---

## Provider Tests

Prüfen

- Dependency Injection
- Initialisierung
- Lebenszyklus
- Bereitstellung der Abhängigkeiten

---

## Notifier Tests

Prüfen

- Zustandswechsel
- Benutzeraktionen
- Fehlerzustände
- Interaktion mit Use Cases

---

## Regeln

Provider enthalten keine Business-Logik.

Business-Logik wird über Unit Tests der Use Cases geprüft.

---

# Golden Tests

Golden Tests prüfen die visuelle Stabilität der Benutzeroberfläche.

---

## Ziel

Erkennen unbeabsichtigter Layoutänderungen.

---

## Geeignete Komponenten

```text
Dashboard

ProfileCard

ProfileForm

MeasurementChart
```

---

## Regeln

Golden Tests werden durchgeführt bei

- neuen Widgets,
- größeren Layoutänderungen,
- Theme-Anpassungen.

---

# Sicherheits- und Datenschutztests

Gesundheitsdaten besitzen höchste Priorität.

---

## Sicherheitsprüfungen

Prüfen

- Passwortschutz
- Verschlüsselung
- Berechtigungen
- sichere Speicherung
- sichere Wiederherstellung

---

## Datenschutztests

Prüfen

- Export
- Löschung
- Backup
- Wiederherstellung
- Anonymisierung
- Datenminimierung

---

# Medizinische Regeltests

Alle medizinischen Berechnungen werden separat getestet.

---

## Prüfen

- BMI
- Bauchumfang
- Blutdruck
- Puls
- Trends
- Empfehlungen

---

## Anforderungen

Jede Berechnung besitzt

- Referenzwerte,
- dokumentierte Quelle,
- Grenzfälle,
- Negativtests,
- Regressionstests.

---

# Migrationstests

Migrationen werden vor jeder neuen Datenbankversion geprüft.

---

## Prüfen

- bestehende Daten bleiben erhalten,
- neue Felder korrekt angelegt,
- Standardwerte gesetzt,
- Rückwärtskompatibilität.

---

# Backup- und Restore-Tests

Backup und Wiederherstellung werden vollständig getestet.

---

## Prüfen

- vollständiges Backup
- verschlüsseltes Backup
- Wiederherstellung
- fehlerhafte Backup-Dateien
- Versionskompatibilität

---

# Import- und Exporttests

Prüfen

- CSV
- JSON
- zukünftige Formate

---

## Testfälle

- gültige Datei
- leere Datei
- beschädigte Datei
- falsches Format
- doppelte Datensätze

---

# Offline-Tests

HealthTracker ist Offline-First.

---

## Prüfen

- Arbeiten ohne Internet
- lokales Speichern
- Wiederaufnahme nach Neustart
- Synchronisation nach Verbindung

---

# Plattformtests

Die Anwendung wird auf allen unterstützten Plattformen getestet.

---

## Web

Prüfen

- Layout
- Navigation
- Browserkompatibilität

---

## Windows

Prüfen

- Fenstergrößen
- Tastaturbedienung
- Dateizugriffe

---

## iPad / iOS

Prüfen

- Touch-Bedienung
- Orientierung
- Darstellung
- Systemintegration

---

## Android (zukünftige Unterstützung)

Prüfen

- verschiedene Displaygrößen
- Berechtigungen
- Geräteintegration

---

# Accessibility-Tests

Die Benutzeroberfläche wird auf Barrierefreiheit geprüft.

---

## Prüfen

- Kontrast
- Schriftgrößen
- Screenreader
- Fokusreihenfolge
- Touch-Ziele
- Farbunabhängigkeit

---

# Performance-Tests

Performance wird regelmäßig überprüft.

---

## Prüfen

- Startzeit
- Renderzeit
- Speicherverbrauch
- Datenbankzugriffe
- Listenperformance
- Diagrammdarstellung

---

# Fehler- und Grenzfalltests

Jede Requirement besitzt Negativtests.

---

## Beispiele

- leere Eingaben
- ungültige Werte
- Maximalwerte
- Minimalwerte
- doppelte Daten
- fehlende Berechtigungen

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Unit Tests
- Widget Tests
- Integration Tests
- Repository Tests
- Riverpod-Tests
- Golden Tests
- Sicherheits- und Datenschutztests
- Medizinische Regeltests
- Migrationstests
- Backup-Tests
- Restore-Tests
- Import-/Exporttests
- Offline-Tests
- Plattformtests
- Accessibility-Tests
- Performance-Tests
- Fehler- und Grenzfalltests

---

## Teil 3

Der nächste Abschnitt behandelt:

- Teststruktur
- Benennung
- Testdatenverwaltung
- Mocks
- Fakes
- Stubs
- Arrange–Act–Assert
- Testabdeckung
- CI/CD-Integration
- Qualitätsmetriken

# Teststruktur

Alle Tests folgen einer einheitlichen Projektstruktur.

Die Teststruktur spiegelt die Struktur des Produktivcodes wider.

---

## Verzeichnisstruktur

```text
test/

├── unit/
│   ├── domain/
│   ├── application/
│   ├── repositories/
│   └── services/
│
├── widget/
│   ├── profile/
│   ├── dashboard/
│   ├── measurements/
│   └── settings/
│
├── integration/
│
├── golden/
│
├── performance/
│
├── security/
│
├── migration/
│
└── test_data/
```

---

# Testorganisation

Jedes Modul besitzt seine eigenen Tests.

Beispiel

```text
profile/

profile_test.dart

profile_repository_test.dart

create_profile_use_case_test.dart

profile_notifier_test.dart

profile_page_test.dart
```

Tests verschiedener Module werden nicht vermischt.

---

# Benennung

Alle Testdateien enden auf

```text
_test.dart
```

---

## Beispiele

```text
profile_repository_test.dart

profile_notifier_test.dart

create_profile_use_case_test.dart

dashboard_page_test.dart
```

---

## Testgruppen

Tests werden logisch gruppiert.

Beispiel

```dart
group("CreateProfileUseCase", () {

});
```

Untergruppen

```dart
group("Valid Input", () {

});

group("Invalid Input", () {

});
```

---

# Testmethoden

Die Beschreibung eines Testfalls erfolgt verständlich.

Beispiel

```dart
test(
  "creates a new profile successfully",
  () {

});
```

Nicht zulässig

```dart
test("Test 1", () {});
```

---

# Arrange – Act – Assert (AAA)

Alle Tests folgen dem AAA-Prinzip.

---

## Arrange

Vorbereitung

- Testdaten
- Mocks
- Initialisierung

---

## Act

Ausführen der eigentlichen Aktion.

---

## Assert

Überprüfung des erwarteten Ergebnisses.

---

## Beispiel

```text
Arrange

↓

Act

↓

Assert
```

---

# Testdatenverwaltung

Testdaten werden zentral verwaltet.

---

## Regeln

Testdaten

- reproduzierbar
- anonymisiert
- dokumentiert
- versioniert

---

## Test Fixtures

Wiederverwendbare Testdaten werden als Fixtures gespeichert.

Beispiele

```text
profile_fixture.dart

measurement_fixture.dart

nutrition_fixture.dart
```

---

# Test Doubles

Zur Isolation von Komponenten werden Test Doubles verwendet.

---

## Mock

Verhalten wird vollständig simuliert.

Geeignet für:

- Repositorys
- Services
- APIs

---

## Fake

Einfache Implementierung für Tests.

Beispiel

```text
FakeProfileRepository
```

---

## Stub

Liefert vorbereitete Antworten.

Geeignet für

- Konfiguration
- Provider
- Services

---

## Spy

Erfasst Aufrufe einer Komponente.

Geeignet für

- Logging
- Event-Überprüfung
- Callback-Tests

---

# Dependency Injection im Test

Produktivcode und Testcode verwenden dieselben Interfaces.

Im Test werden Implementierungen ersetzt.

```text
Repository

↓

Fake Repository
```

Dadurch bleiben Tests unabhängig von technischen Komponenten.

---

# Testabdeckung (Coverage)

Die Testabdeckung wird regelmäßig gemessen.

---

## Zielwerte

| Bereich | Ziel |
|----------|------|
| Domain | ≥ 95 % |
| Application | ≥ 90 % |
| Infrastructure | ≥ 85 % |
| Presentation | ≥ 80 % |
| Gesamtprojekt | ≥ 90 % |

Die Testabdeckung dient als Qualitätsindikator, ersetzt jedoch keine inhaltliche Testbewertung.

---

# Regressionstests

Jeder behobene Fehler erhält mindestens einen Regressionstest.

Ziel:

Ein bereits behobener Fehler darf nicht erneut auftreten.

---

# Kontinuierliche Integration (CI)

Alle automatisierten Tests werden vor jedem Merge ausgeführt.

---

## Reihenfolge

```text
dart format

↓

flutter analyze

↓

Unit Tests

↓

Widget Tests

↓

Integration Tests

↓

Golden Tests

↓

Coverage

↓

Build
```

Ein Fehler beendet die Pipeline.

---

# Testprotokolle

Jeder Testlauf erzeugt ein Protokoll.

Mindestens enthalten:

- Datum
- Version
- Plattform
- Anzahl Tests
- Erfolgreiche Tests
- Fehlgeschlagene Tests
- Laufzeit

---

# Testberichte

Vor jedem Release wird ein Testbericht erstellt.

Der Bericht enthält:

- Testabdeckung
- Regressionsergebnisse
- offene Fehler
- bekannte Einschränkungen
- Performance-Ergebnisse
- Sicherheitsprüfung
- Empfehlung zur Freigabe

---

# Qualitätsmetriken

Folgende Kennzahlen werden regelmäßig erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Erfolgreiche Tests | 100 % |
| Fehlgeschlagene Tests | 0 |
| Blockierte Tests | 0 |
| Testabdeckung | ≥ 90 % |
| Regressionen | 0 |
| Kritische Fehler | 0 |
| Sicherheitsfehler | 0 |

---

# Testwartung

Tests werden gemeinsam mit dem Produktivcode gepflegt.

Änderungen an

- Requirements,
- Business Rules,
- Use Cases,
- Datenmodellen,
- APIs

erfordern eine Überprüfung der zugehörigen Tests.

---

# Testversionierung

Tests unterliegen derselben Versionsverwaltung wie der Produktivcode.

Ein Test wird niemals unabhängig von der implementierten Funktion versioniert.

---

# Review der Tests

Vor der Freigabe werden Tests geprüft.

Prüfkriterien:

- Lesbarkeit
- Verständlichkeit
- Vollständigkeit
- Nachvollziehbarkeit
- Traceability
- Wartbarkeit

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Teststruktur
- Modulorganisation
- Benennung
- AAA-Prinzip
- Testdatenverwaltung
- Test Fixtures
- Mock
- Fake
- Stub
- Spy
- Dependency Injection
- Testabdeckung
- Regressionstests
- CI-Integration
- Testprotokolle
- Testberichte
- Qualitätsmetriken
- Testwartung
- Testversionierung
- Testreview

---

## Teil 4

Der letzte Abschnitt behandelt:

- Definition of Ready
- Definition of Done
- Test-Freigabekriterien
- Anti-Patterns
- Best Practices
- Review-Checkliste
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Definition of Ready (DoR)

Ein Testfall darf erst erstellt bzw. zur Implementierung freigegeben werden, wenn alle folgenden Voraussetzungen erfüllt sind.

## Anforderungen

- Functional Requirement vorhanden
- Requirement-ID vergeben
- Akzeptanzkriterien definiert
- Business Rules dokumentiert
- Validation Rules dokumentiert

---

## Dokumentation

Vorhanden sind:

- Use Case
- Traceability
- Datenmodell
- API (falls erforderlich)
- UI-Spezifikation (falls erforderlich)

---

## Testplanung

Für jede Requirement wurden definiert:

- Testart
- Testumfang
- Testdaten
- erwartetes Ergebnis
- Verantwortlicher

---

# Definition of Done (DoD)

Eine Funktion gilt erst als abgeschlossen, wenn sämtliche Testanforderungen erfüllt wurden.

## Pflichtkriterien

- Alle Unit Tests erfolgreich
- Alle Widget Tests erfolgreich
- Alle Integration Tests erfolgreich
- Alle Golden Tests erfolgreich (falls vorhanden)
- Alle Regressionstests erfolgreich

---

## Qualität

- Keine fehlgeschlagenen Tests
- Keine blockierten Tests
- Keine offenen kritischen Fehler
- Testabdeckung erfüllt

---

## Dokumentation

- Testfälle dokumentiert
- Traceability vollständig
- Testbericht erstellt
- Changelog aktualisiert

---

# Test-Freigabekriterien

Vor einem Release müssen mindestens folgende Kriterien erfüllt sein.

| Kriterium | Ziel |
|-----------|------|
| Erfolgreiche Tests | 100 % |
| Kritische Fehler | 0 |
| Offene Blocker | 0 |
| Regressionen | 0 |
| Sicherheitsfehler | 0 |
| Medizinische Testfälle erfolgreich | 100 % |
| Traceability vollständig | 100 % |

Ein Release darf erst erfolgen, wenn alle Pflichtkriterien erfüllt sind.

---

# Test-Governance

Der Testprozess ist Bestandteil des Qualitätsmanagements.

## Verantwortlichkeiten

### Entwickler

- erstellt Tests
- pflegt Tests
- behebt Fehler

---

### Reviewer

- bewertet Testqualität
- prüft Testabdeckung
- kontrolliert Traceability

---

### Tester

- führt Tests durch
- dokumentiert Ergebnisse
- bestätigt Regressionen

---

### Product Owner

- bestätigt Akzeptanz
- bewertet fachliche Ergebnisse

---

# Anti-Patterns

Folgende Vorgehensweisen sind unzulässig.

---

## TP-001 – Kein Test zur Requirement

Eine Requirement ohne Testfall ist unzulässig.

---

## TP-002 – Test ohne Requirement

Ein Test ohne fachliche Grundlage darf nicht existieren.

---

## TP-003 – Instabile Tests

Tests dürfen nicht vom aktuellen Datum, Zufallswerten oder externen Diensten abhängig sein.

---

## TP-004 – Gemeinsame Testzustände

Tests dürfen sich nicht gegenseitig beeinflussen.

Jeder Test muss isoliert ausführbar sein.

---

## TP-005 – Überladene Tests

Ein Testfall prüft genau eine fachliche Aussage.

---

## TP-006 – Produktivdaten im Test

Produktive Gesundheitsdaten dürfen niemals als Testdaten verwendet werden.

---

## TP-007 – Ignorierte Fehler

Fehlgeschlagene Tests dürfen nicht dauerhaft deaktiviert oder ignoriert werden.

---

# Best Practices

Folgende Vorgehensweisen werden empfohlen.

---

## Kleine Tests

Tests bleiben übersichtlich und prüfen genau einen Sachverhalt.

---

## Aussagekräftige Namen

Testnamen beschreiben:

- Ausgangssituation
- Aktion
- erwartetes Ergebnis

Beispiel

```text
creates_profile_with_valid_input
```

---

## Wiederverwendbare Fixtures

Gemeinsame Testdaten werden zentral verwaltet.

---

## Test First

Bereits während der Planung wird die Teststrategie berücksichtigt.

---

## Kontinuierliche Ausführung

Tests werden regelmäßig lokal und in der CI-Pipeline ausgeführt.

---

## Dokumentierte Grenzfälle

Für jede fachliche Regel werden Grenz- und Fehlerfälle getestet.

---

# Review-Checkliste

Vor der Freigabe werden mindestens folgende Punkte geprüft.

## Allgemein

- [ ] Requirement referenziert
- [ ] Test-ID vorhanden
- [ ] Testziel dokumentiert

---

## Qualität

- [ ] AAA-Prinzip eingehalten
- [ ] Lesbarkeit
- [ ] Verständlichkeit
- [ ] Keine Duplikate

---

## Fachlichkeit

- [ ] Business Rules getestet
- [ ] Validation Rules getestet
- [ ] Grenzfälle getestet
- [ ] Fehlerfälle getestet

---

## Technik

- [ ] Mocks korrekt eingesetzt
- [ ] Keine Produktivdaten
- [ ] Keine externen Abhängigkeiten
- [ ] Reproduzierbar

---

## Traceability

- [ ] Requirement vorhanden
- [ ] Use Case referenziert
- [ ] Testfall dokumentiert
- [ ] Release referenziert

---

# Test-KPIs

Zur Bewertung der Testqualität werden folgende Kennzahlen erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Erfolgreiche Tests | 100 % |
| Fehlgeschlagene Tests | 0 |
| Testabdeckung | ≥ 90 % |
| Regressionen | 0 |
| Kritische Fehler | 0 |
| Sicherheitslücken | 0 |
| Medizinische Testabdeckung | 100 % |
| Traceability-Abdeckung | 100 % |

---

# Kontinuierliche Verbesserung

Der Testprozess wird regelmäßig überprüft.

Verbesserungen stammen aus:

- Retrospektiven
- Code Reviews
- Test Reviews
- Release Reviews
- Fehleranalysen
- Nutzerfeedback

Änderungen erfolgen ausschließlich über eine neue Dokumentversion.

---

# Referenzen

Dieser Standard baut auf folgenden Projektdokumenten auf:

- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REVIEW_GUIDE.md
- TRACEABILITY_GUIDE.md
- ARCHITECTURE_GUIDE.md
- REQUIREMENTS_GUIDE.md
- SECURITY_GUIDE.md

Alle genannten Dokumente sind gemeinsam anzuwenden.

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-TEST-001 |
| Version | 1.0.0 |
| Status | **Approved** |
| Freigegeben am | 2026-07-31 |
| Gültig ab | 2026-07-31 |
| Nächstes Review | Vor dem nächsten Major Release |

---

# Änderungsstopp

Mit der Freigabe der Version **1.0.0** gilt dieses Dokument als abgeschlossen.

Änderungen erfolgen ausschließlich durch:

1. Erstellung einer neuen Dokumentversion.
2. Aktualisierung der Dokumenthistorie.
3. Anpassung des Änderungsverlaufs.
4. Erneutes Review und Freigabe.
5. Dokumentation wesentlicher Änderungen über den Review- und Traceability-Prozess.

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.

---

# Status

**Dokument:** `docs/standards/TESTING_GUIDE.md`

**Version:** 1.0.0

**Status:** ✅ Ready for Repository