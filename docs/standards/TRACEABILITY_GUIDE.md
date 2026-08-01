# TRACEABILITY_GUIDE.md

> HealthTracker Traceability Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-TRACE-001 |
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
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Einführung eines projektweiten Traceability-Standards | HealthTracker Team |

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

Dieses Dokument definiert den verbindlichen Standard zur Rückverfolgbarkeit (Traceability) aller Projektartefakte innerhalb des HealthTracker-Projekts.

Traceability stellt sicher, dass jederzeit nachvollzogen werden kann,

- warum eine Funktion existiert,
- welche Anforderungen sie erfüllt,
- welche Architekturentscheidungen sie beeinflusst,
- welche Implementierung sie umsetzt,
- welche Tests sie verifizieren,
- und in welchem Release sie ausgeliefert wurde.

---

# Ziele

Der Traceability-Prozess verfolgt folgende Ziele:

- Vollständige Nachvollziehbarkeit aller Anforderungen
- Unterstützung der Qualitätssicherung
- Auswirkungen von Änderungen sichtbar machen
- Konsistente Dokumentation sicherstellen
- Unterstützung von Reviews
- Vereinfachung von Wartung und Erweiterung
- Unterstützung automatisierter Qualitätsprüfungen
- Erfüllung von Datenschutz- und Dokumentationsanforderungen

---

# Geltungsbereich

Dieser Standard gilt für sämtliche Projektartefakte.

Insbesondere für:

- Product Vision
- Requirements
- Non Functional Requirements
- Use Cases
- Business Rules
- Validation Rules
- Datenmodelle
- UI-Spezifikationen
- APIs
- Architektur
- ADRs
- Quellcode
- Tests
- Releases

---

# Grundprinzipien

## Vollständigkeit

Jede fachliche Anforderung muss vollständig nachvollziehbar sein.

Es darf keine implementierte Funktion ohne dokumentierte Requirement geben.

---

## Eindeutigkeit

Jedes Artefakt besitzt genau eine eindeutige Kennung.

Beispiele:

```text
PRO-FR-001

PRO-UC-003

PRO-BR-005

PRO-TC-014
```

---

## Konsistenz

Alle Referenzen müssen gültig sein.

Verweise auf gelöschte oder unbekannte Artefakte sind unzulässig.

---

## Aktualität

Traceability wird bei jeder fachlichen Änderung aktualisiert.

Veraltete Referenzen gelten als Qualitätsmangel.

---

## Versionierung

Traceability gehört zur Version eines Artefakts.

Ändert sich eine Requirement wesentlich, müssen auch alle abhängigen Artefakte überprüft werden.

---

## Transparenz

Jede Entscheidung muss nachvollziehbar sein.

Dies gilt insbesondere für:

- Architekturentscheidungen
- Sicherheitsentscheidungen
- medizinische Regeln
- Datenschutzentscheidungen

---

# Definition der Traceability

Traceability beschreibt die nachvollziehbare Beziehung zwischen Projektartefakten.

Sie beantwortet unter anderem folgende Fragen:

- Welche Requirement beschreibt diese Funktion?
- Welche Business Rule wird umgesetzt?
- Welche Validierung ist erforderlich?
- Welcher Use Case nutzt diese Funktion?
- Welche Architekturentscheidung ist betroffen?
- Welche Klassen implementieren die Funktion?
- Welche Tests prüfen die Funktion?
- In welchem Release wurde sie ausgeliefert?

---

# Traceability-Ebenen

HealthTracker unterscheidet mehrere Ebenen der Rückverfolgbarkeit.

## Fachliche Ebene

Verknüpft:

- Product Vision
- Functional Requirements
- Non Functional Requirements
- Use Cases
- Business Rules
- Validation Rules

---

## Architekturebene

Verknüpft:

- Requirements
- Architektur
- ADRs
- Module
- Schnittstellen

---

## Implementierungsebene

Verknüpft:

- Requirements
- Quellcode
- Repositorys
- Services
- Use Cases
- Provider

---

## Testebene

Verknüpft:

- Requirements
- Test Cases
- Unit Tests
- Widget Tests
- Integration Tests

---

## Releaseebene

Verknüpft:

- Features
- Releases
- Changelog
- Versionen

---

# Traceability-Arten

## Vorwärtsgerichtete Traceability

Beschreibt den Weg

```text
Requirement
    │
    ▼
Implementierung
    │
    ▼
Test
    │
    ▼
Release
```

---

## Rückwärtsgerichtete Traceability

Beschreibt den Weg

```text
Release
    │
    ▼
Test
    │
    ▼
Implementierung
    │
    ▼
Requirement
```

---

## Bidirektionale Traceability

HealthTracker verwendet grundsätzlich eine bidirektionale Traceability.

Jede Beziehung muss in beide Richtungen nachvollziehbar sein.

---

# Rollen und Verantwortlichkeiten

## Product Owner

Verantwortlich für die fachliche Rückverfolgbarkeit.

---

## Modulverantwortlicher

Verantwortlich für:

- Pflege der Traceability
- Aktualisierung bei Änderungen
- Vollständigkeit der Referenzen

---

## Entwickler

Verantwortlich für:

- Referenzen im Quellcode
- Zuordnung zu Requirements
- Aktualisierung der Testreferenzen

---

## Tester

Verantwortlich für:

- Zuordnung der Testfälle
- Prüfung der Testabdeckung
- Pflege der Traceability zwischen Tests und Requirements

---

## Reviewer

Prüft:

- Vollständigkeit
- Konsistenz
- Gültigkeit aller Referenzen

---

# Medizinische Traceability

Für medizinische Funktionen gelten zusätzliche Anforderungen.

Jede medizinische Berechnung muss referenzieren:

- Functional Requirement
- Business Rule
- medizinische Quelle
- Test Cases
- Version der Berechnungsregel

Beispiel:

```text
BMI-Berechnung
      │
      ▼
PRO-FR-021
      │
      ▼
PRO-BR-008
      │
      ▼
Medizinische Quelle
      │
      ▼
PRO-TC-031
```

---

# Datenschutz-Traceability

Für personenbezogene Daten wird zusätzlich dokumentiert:

- Zweck der Verarbeitung
- Speicherort
- Aufbewahrungsdauer
- Export
- Löschung
- Backup
- Wiederherstellung

Dadurch bleibt die Verarbeitung personenbezogener Gesundheitsdaten jederzeit nachvollziehbar.

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
- Definition der Traceability
- Traceability-Ebenen
- Traceability-Arten
- Rollen und Verantwortlichkeiten
- Medizinische Traceability
- Datenschutz-Traceability

---

## Teil 2

Der nächste Abschnitt behandelt:

- Traceability-Matrix
- Requirement → Use Case
- Requirement → Business Rule
- Requirement → Validation Rule
- Requirement → Datenmodell
- Requirement → Architektur
- Requirement → API
- Requirement → UI
- Traceability-Tabellen
- Referenzregeln

# Traceability-Matrix

Die Traceability-Matrix bildet das zentrale Instrument zur Rückverfolgbarkeit aller Projektartefakte.

Sie dokumentiert sämtliche Beziehungen zwischen Anforderungen, Architektur, Implementierung, Tests und Releases.

---

# Ziel

Die Matrix beantwortet unter anderem folgende Fragen:

- Welche Use Cases gehören zu einer Requirement?
- Welche Business Rules werden umgesetzt?
- Welche Validierungen gelten?
- Welche Datenmodelle sind betroffen?
- Welche UI implementiert die Funktion?
- Welche APIs stellen die Funktion bereit?
- Welche Klassen implementieren sie?
- Welche Tests prüfen sie?
- In welchem Release wurde sie ausgeliefert?

---

# Grundregel

Jede Functional Requirement bildet den Ursprung der fachlichen Traceability.

```text
Functional Requirement
        │
        ├─────────────► Use Case
        ├─────────────► Business Rule
        ├─────────────► Validation Rule
        ├─────────────► Data Model
        ├─────────────► UI
        ├─────────────► API
        ├─────────────► Architektur
        ├─────────────► Implementierung
        ├─────────────► Test Cases
        └─────────────► Release
```

---

# Traceability-Matrix (Standard)

| Requirement | UC | BR | VR | DM | UI | API | ADR | Code | Test | Release |
|-------------|----|----|----|----|----|-----|-----|------|------|---------|
| PRO-FR-001 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | – | ✅ | ✅ | v1.0.0 |

---

# Requirement → Use Case

Jede Functional Requirement muss mindestens einem Use Case zugeordnet werden.

## Beispiel

Requirement

```text
PRO-FR-001
Profil anlegen
```

Use Case

```text
PRO-UC-001
Profil erstellen
```

Traceability

```text
PRO-FR-001
        │
        ▼
PRO-UC-001
```

---

# Requirement → Business Rule

Business Rules beschreiben fachliche Regeln.

Jede Rule verweist mindestens auf eine Functional Requirement.

## Beispiel

```text
PRO-FR-001
        │
        ▼
PRO-BR-003
```

Business Rule

```text
Ein Profil muss einen Namen besitzen.
```

---

# Requirement → Validation Rule

Validation Rules konkretisieren Eingaberegeln.

## Beispiel

```text
PRO-FR-001
        │
        ▼
PRO-VR-001
```

Validation Rule

```text
Der Profilname darf nicht leer sein.
```

---

# Requirement → Datenmodell

Jede Requirement verweist auf die betroffenen Entitäten.

## Beispiel

```text
PRO-FR-001
        │
        ▼
Profile
```

Betroffene Objekte

- Profile
- ProfileSettings

---

# Requirement → Architektur

Requirements werden auf die Architektur abgebildet.

## Beispiel

```text
PRO-FR-001
        │
        ▼
Profile Module
```

Betroffene Schichten

```text
Domain

Application

Infrastructure

Presentation
```

---

# Requirement → API

Jede öffentlich verfügbare Funktion wird dokumentiert.

Beispiel

```text
PRO-FR-001
        │
        ▼
PRO-API-001
```

API

```text
createProfile()
```

---

# Requirement → UI

Die Oberfläche wird ebenfalls referenziert.

Beispiel

```text
PRO-FR-001
        │
        ▼
ProfileEditorPage
```

Zusätzlich:

```text
ProfileForm

ProfileAvatarWidget

SaveButton
```

---

# Requirement → State

Für zustandsabhängige Funktionen wird zusätzlich das Zustandsmodell referenziert.

Beispiel

```text
PRO-FR-001
        │
        ▼
ProfileState
```

---

# Requirement → Events

Falls Events verwendet werden:

```text
PRO-FR-001
        │
        ▼
PRO-EV-001
ProfileCreated
```

---

# Requirement → Interfaces

Schnittstellen werden ebenfalls dokumentiert.

```text
PRO-FR-001
        │
        ▼
PRO-IF-001
```

---

# Requirement → Module API

Module APIs besitzen eigene Referenzen.

```text
PRO-FR-001
        │
        ▼
PRO-API-001
```

---

# Referenzregeln

Eine Referenz muss

- eindeutig,
- gültig,
- aktuell,
- nachvollziehbar

sein.

---

# Pflichtreferenzen

Mindestens folgende Beziehungen müssen existieren.

| Artefakt | Pflicht |
|-----------|:-------:|
| Use Case | ✅ |
| Business Rule | ✅ |
| Validation Rule | ✅ |
| Datenmodell | ✅ |
| UI | ✅ |
| API | ✅ |
| Implementierung | ✅ |
| Test Case | ✅ |

Fehlt eine Pflichtreferenz, gilt die Requirement als unvollständig.

---

# Optionale Referenzen

Je nach Modul können zusätzlich existieren:

- ADR
- Event
- State Model
- Interface
- Sequence Diagram
- Activity Diagram
- Security Rule
- Performance Requirement

---

# Referenznotation

Referenzen erfolgen ausschließlich über eindeutige IDs.

Beispiele

```text
PRO-FR-001

PRO-UC-004

PRO-BR-003

PRO-VR-008

PRO-TC-021
```

Nicht zulässig

```text
Requirement 1

Use Case A

Business Rule X
```

---

# Traceability-Tabelle eines Moduls

Jedes Modul besitzt eine eigene Traceability-Tabelle.

Beispiel

| Requirement | UC | BR | VR | DM | UI | API | Test |
|-------------|----|----|----|----|----|-----|------|
| PRO-FR-001 | PRO-UC-001 | PRO-BR-001 | PRO-VR-001 | Profile | ProfileEditorPage | PRO-API-001 | PRO-TC-001 |

---

# Cross-Modul-Traceability

Requirements dürfen andere Module referenzieren.

Beispiel

```text
Profile
    │
    ▼
Settings
```

```text
PRO-FR-017
        │
        ▼
SET-FR-004
```

Solche Abhängigkeiten müssen ausdrücklich dokumentiert werden.

---

# Traceability bei Modulgrenzen

Werden mehrere Module betroffen,

müssen sämtliche Beziehungen dokumentiert werden.

Beispiel

```text
Dashboard

↓

Measurements

↓

Analysis

↓

Recommendations
```

Jedes Modul verweist auf die beteiligten Requirements.

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Traceability-Matrix
- Requirement → Use Case
- Requirement → Business Rule
- Requirement → Validation Rule
- Requirement → Datenmodell
- Requirement → Architektur
- Requirement → API
- Requirement → UI
- Requirement → State
- Requirement → Event
- Requirement → Interface
- Referenzregeln
- Pflichtreferenzen
- Optionale Referenzen
- Cross-Modul-Traceability

---

## Teil 3

Der nächste Abschnitt behandelt:

- Requirement → Implementierung
- Requirement → Repository
- Requirement → Use Case (Code)
- Requirement → Provider
- Requirement → Test Cases
- Requirement → Releases
- Änderungsverfolgung
- Versionierung
- Review der Traceability
- Automatische Konsistenzprüfungen

# Requirement → Implementierung

Jede Functional Requirement muss auf ihre technische Umsetzung zurückgeführt werden können.

Die Implementierung umfasst sämtliche Quellcode-Artefakte, die zur Realisierung einer Anforderung beitragen.

---

## Ziel

Für jede Requirement muss eindeutig nachvollziehbar sein:

- welche Klassen beteiligt sind,
- welche Use Cases die Funktion umsetzen,
- welche Repositorys verwendet werden,
- welche Services beteiligt sind,
- welche Provider den Zustand verwalten,
- welche UI-Komponenten die Funktion bereitstellen.

---

## Beispiel

```text
PRO-FR-001
Profil anlegen

        │
        ├────────► CreateProfileUseCase
        ├────────► ProfileRepository
        ├────────► ProfileService
        ├────────► ProfileNotifier
        ├────────► ProfileEditorPage
        └────────► ProfileForm
```

---

# Requirement → Domain

Requirements werden zunächst der fachlichen Domäne zugeordnet.

Beispiel

```text
PRO-FR-001
        │
        ▼
domain/profile/
```

Betroffene Artefakte

```text
Profile

ProfileRepository

CreateProfileUseCase
```

---

# Requirement → Repository

Jede persistente Anforderung verweist auf mindestens ein Repository.

Beispiel

```text
PRO-FR-001
        │
        ▼
ProfileRepository
```

Implementierung

```text
IsarProfileRepository
```

---

# Requirement → Use Case (Implementierung)

Use Cases bilden die fachliche Umsetzung einer Requirement.

Beispiel

```text
PRO-FR-001
        │
        ▼
CreateProfileUseCase
```

Mehrere Use Cases sind zulässig, wenn eine Requirement verschiedene fachliche Prozesse umfasst.

---

# Requirement → Services

Technische oder fachliche Dienste werden ebenfalls referenziert.

Beispiel

```text
PRO-FR-001
        │
        ▼
ProfileService
```

Weitere Beispiele

```text
AuthenticationService

BackupService

ImportExportService
```

---

# Requirement → Provider

Jede UI-nahe Requirement verweist auf die beteiligten Riverpod-Provider.

Beispiel

```text
PRO-FR-001
        │
        ▼
profileNotifierProvider
```

Weitere Referenzen

```text
profileRepositoryProvider

activeProfileProvider
```

---

# Requirement → Widgets

Neben Pages werden auch wiederverwendbare Widgets dokumentiert.

Beispiel

```text
PRO-FR-001
        │
        ▼
ProfileCardWidget

ProfileAvatarWidget

ProfileForm
```

---

# Requirement → Test Cases

Jede Functional Requirement besitzt mindestens einen Test Case.

## Grundregel

Es darf

- keine Requirement ohne Test Case
- keinen Test Case ohne Requirement

geben.

---

## Beispiel

```text
PRO-FR-001
        │
        ▼
PRO-TC-001
```

---

# Testarten

Die Traceability umfasst sämtliche Testarten.

## Unit Test

```text
PRO-FR-001
        │
        ▼
profile_repository_test.dart
```

---

## Widget Test

```text
PRO-FR-001
        │
        ▼
profile_editor_page_test.dart
```

---

## Integration Test

```text
PRO-FR-001
        │
        ▼
profile_flow_test.dart
```

---

## Manuelle Tests

Falls erforderlich

```text
PRO-TC-021
```

mit

```text
Testprotokoll
```

---

# Requirement → Release

Jede Requirement wird einem Release zugeordnet.

Beispiel

```text
PRO-FR-001
        │
        ▼
v1.0.0
```

---

# Release Traceability

Ein Release dokumentiert

- neue Requirements
- geänderte Requirements
- entfernte Requirements
- neue APIs
- neue Tests
- Migrationen

---

# Änderungsverfolgung

Änderungen an einer Requirement müssen nachvollziehbar dokumentiert werden.

Für jede Änderung werden mindestens festgehalten:

- Datum
- Version
- Verantwortlicher
- Grund
- betroffene Artefakte

---

## Beispiel

| Requirement | Version | Änderung |
|-------------|----------|----------|
| PRO-FR-001 | 1.1 | Passwortschutz ergänzt |

---

# Versionierung

Traceability wird versioniert.

Eine neue Version entsteht beispielsweise bei

- neuer Requirement
- geänderter Requirement
- neuer Architektur
- neuer API
- geändertem Datenmodell
- neuem Release

---

# Impact Analysis

Vor jeder fachlichen Änderung wird eine Auswirkungsanalyse durchgeführt.

Mindestens folgende Artefakte werden geprüft:

| Artefakt | Prüfung |
|-----------|----------|
| Requirements | betroffen? |
| Use Cases | betroffen? |
| Business Rules | betroffen? |
| Validation Rules | betroffen? |
| Datenmodell | betroffen? |
| API | betroffen? |
| UI | betroffen? |
| Repository | betroffen? |
| Tests | betroffen? |
| Dokumentation | betroffen? |

---

# Review der Traceability

Jede Änderung wird im Review überprüft.

Geprüft werden insbesondere:

- vollständige Referenzen
- gültige IDs
- keine verwaisten Artefakte
- vollständige Testabdeckung
- vollständige Dokumentation

---

# Automatische Konsistenzprüfung

Die Traceability soll soweit möglich automatisiert geprüft werden.

Prüfungen:

- fehlende Requirement-IDs
- doppelte IDs
- ungültige Referenzen
- fehlende Test Cases
- fehlende Use Cases
- fehlende Business Rules
- fehlende Validation Rules

---

# Traceability-Bericht

Vor jedem Release wird ein Traceability-Bericht erzeugt.

Der Bericht enthält:

- Anzahl Requirements
- Anzahl Test Cases
- Testabdeckung
- fehlende Referenzen
- Cross-Modul-Abhängigkeiten
- offene Traceability-Lücken

---

# Traceability-Abdeckung

Zielwerte

| Kennzahl | Ziel |
|-----------|------|
| Requirement → Test | 100 % |
| Requirement → Use Case | 100 % |
| Requirement → Business Rule | 100 % |
| Requirement → Validation Rule | 100 % |
| Requirement → API | 100 % |
| Requirement → Datenmodell | 100 % |
| Requirement → Release | 100 % |

Eine Abdeckung unter 100 % ist vor einer Freigabe zu begründen.

---

# Traceability-Warnungen

Folgende Situationen gelten als Qualitätsmängel:

- Requirement ohne Use Case
- Requirement ohne Test
- Requirement ohne Datenmodell
- Requirement ohne API (falls erforderlich)
- Test ohne Requirement
- Implementierung ohne Requirement
- Ungültige Referenzen
- Verwaiste IDs

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Requirement → Implementierung
- Requirement → Domain
- Requirement → Repository
- Requirement → Use Case (Code)
- Requirement → Service
- Requirement → Provider
- Requirement → Widgets
- Requirement → Test Cases
- Requirement → Release
- Änderungsverfolgung
- Versionierung
- Impact Analysis
- Review der Traceability
- Automatische Konsistenzprüfung
- Traceability-Berichte
- Qualitätskennzahlen

---

## Teil 4

Der letzte Abschnitt behandelt:

- Vollständigkeitsregeln
- Anti-Patterns
- Best Practices
- Beispiele vollständiger Traceability
- Review-Checkliste
- KPIs
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Vollständigkeitsregeln

Ein Artefakt gilt nur dann als vollständig tracebar, wenn alle verpflichtenden Beziehungen vorhanden und gültig sind.

## Functional Requirements

Jede Functional Requirement besitzt mindestens folgende Referenzen:

```text
Functional Requirement
        │
        ├── Use Case
        ├── Business Rule
        ├── Validation Rule
        ├── Datenmodell
        ├── UI
        ├── API
        ├── Implementierung
        ├── Test Case
        └── Release
```

Fehlt eine dieser Pflichtbeziehungen, gilt die Requirement als **nicht vollständig**.

---

# Traceability-Qualitätsregeln

Folgende Regeln gelten projektweit:

## Regel T-001

Keine Implementierung ohne Functional Requirement.

---

## Regel T-002

Keine Functional Requirement ohne Use Case.

---

## Regel T-003

Keine Functional Requirement ohne Business Rule.

---

## Regel T-004

Keine Functional Requirement ohne Validation Rule.

---

## Regel T-005

Keine Functional Requirement ohne Test Case.

---

## Regel T-006

Kein Test Case ohne Requirement.

---

## Regel T-007

Keine veröffentlichte API ohne Requirement.

---

## Regel T-008

Keine Architekturentscheidung ohne ADR.

---

## Regel T-009

Keine medizinische Berechnung ohne dokumentierte Quelle.

---

## Regel T-010

Keine personenbezogenen Daten ohne dokumentierte Datenschutz-Traceability.

---

# Anti-Patterns

Folgende Situationen gelten als schwerwiegende Qualitätsmängel.

## Verwaiste Implementierung

Code existiert,

aber keine Requirement beschreibt ihn.

---

## Tote Requirement

Requirement existiert,

aber keine Implementierung verweist darauf.

---

## Verwaister Test

Test existiert,

aber keine Requirement referenziert ihn.

---

## Fehlende Business Rule

Requirement vorhanden,

aber keine fachliche Regel definiert.

---

## Fehlende Validation

Eingaben vorhanden,

aber keine Validation Rule.

---

## Fehlendes Release

Requirement umgesetzt,

aber keinem Release zugeordnet.

---

## Ungültige Referenzen

Verweise zeigen auf

- gelöschte Artefakte
- unbekannte IDs
- falsche Versionen

---

# Best Practices

## Kleine Requirements

Requirements möglichst klein halten.

Dadurch bleiben

- Traceability
- Tests
- Reviews

einfach.

---

## Eine Verantwortung

Jede Requirement besitzt genau eine fachliche Verantwortung.

---

## Bidirektionale Referenzen

Alle Referenzen müssen in beide Richtungen nachvollziehbar sein.

---

## Frühzeitige Pflege

Traceability wird nicht am Projektende ergänzt.

Sie wird parallel zur Entwicklung gepflegt.

---

## Automatisierung

Soweit möglich werden Konsistenzprüfungen automatisiert.

---

# Beispiel einer vollständigen Traceability

```text
Product Vision
      │
      ▼
PRO-FR-001
      │
      ├────────► PRO-UC-001
      ├────────► PRO-BR-001
      ├────────► PRO-VR-001
      ├────────► Profile
      ├────────► ProfileEditorPage
      ├────────► PRO-API-001
      ├────────► CreateProfileUseCase
      ├────────► ProfileRepository
      ├────────► profileNotifierProvider
      ├────────► PRO-TC-001
      └────────► v1.0.0
```

Damit lässt sich jede Funktion vollständig nachvollziehen.

---

# Review-Checkliste

Vor jedem Review wird geprüft:

## Allgemein

- [ ] Requirement vorhanden
- [ ] ID eindeutig
- [ ] Version aktuell

---

## Fachlich

- [ ] Use Case vorhanden
- [ ] Business Rule vorhanden
- [ ] Validation Rule vorhanden

---

## Architektur

- [ ] Datenmodell referenziert
- [ ] Architektur dokumentiert
- [ ] ADR vorhanden (falls erforderlich)

---

## Implementierung

- [ ] Use Case implementiert
- [ ] Repository vorhanden
- [ ] Service vorhanden (falls erforderlich)
- [ ] Provider dokumentiert
- [ ] UI referenziert

---

## Tests

- [ ] Test Case vorhanden
- [ ] Unit Test vorhanden
- [ ] Widget Test vorhanden (falls erforderlich)
- [ ] Integration Test vorhanden (falls erforderlich)

---

## Release

- [ ] Changelog aktualisiert
- [ ] Release dokumentiert
- [ ] Version korrekt

---

# KPIs

Zur Bewertung der Traceability werden folgende Kennzahlen erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Requirements mit vollständiger Traceability | 100 % |
| Testabdeckung der Requirements | 100 % |
| Verwaiste Implementierungen | 0 |
| Verwaiste Testfälle | 0 |
| Ungültige Referenzen | 0 |
| Fehlende ADRs | 0 |
| Medizinische Quellen ohne Referenz | 0 |
| Datenschutzfelder ohne Dokumentation | 0 |

---

# Ausnahmen

Abweichungen von diesem Standard sind ausschließlich zulässig,

wenn

- sie dokumentiert wurden,
- fachlich begründet sind,
- im Review genehmigt wurden,
- keine Sicherheits- oder Datenschutzanforderungen verletzen.

Architekturrelevante Ausnahmen sind zusätzlich über einen ADR zu dokumentieren.

---

# Referenzen

Dieser Standard baut auf folgenden Projektdokumenten auf:

- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REVIEW_GUIDE.md
- REQUIREMENTS_GUIDE.md
- ARCHITECTURE_GUIDE.md
- TESTING_GUIDE.md
- SECURITY_GUIDE.md

Diese Dokumente sind gemeinsam anzuwenden.

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-TRACE-001 |
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
5. Dokumentation architekturrelevanter Änderungen über einen Architecture Decision Record (ADR).

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.

---

# Status

**Dokument:** `docs/standards/TRACEABILITY_GUIDE.md`

**Version:** 1.0.0

**Status:** ✅ Ready for Repository