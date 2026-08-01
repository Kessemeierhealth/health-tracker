# ARCHITECTURE_GUIDE.md

> HealthTracker Architecture Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-ARCH-001 |
| Dokumenttyp | Projektstandard |
| Kategorie | Softwarearchitektur |
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
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Einführung eines projektweiten Architekturstandards | HealthTracker Team |

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

Dieses Dokument definiert die verbindliche Softwarearchitektur des HealthTracker-Projekts.

Es beschreibt die grundlegenden Architekturprinzipien, Schichten, Verantwortlichkeiten und Qualitätsziele, nach denen alle Module entwickelt werden.

Der Architekturstandard gewährleistet:

- eine konsistente Projektstruktur,
- klare Verantwortlichkeiten,
- hohe Wartbarkeit,
- Erweiterbarkeit,
- Testbarkeit,
- langfristige Stabilität.

---

# Ziele

Die Architektur verfolgt folgende Ziele:

- Fachliche und technische Verantwortlichkeiten trennen
- Clean Architecture konsequent anwenden
- Hohe Modularität erreichen
- Abhängigkeiten minimieren
- Wiederverwendbarkeit fördern
- Testbarkeit aller Komponenten sicherstellen
- Erweiterungen ohne grundlegende Umstrukturierungen ermöglichen
- Gesundheitsdaten sicher und konsistent verarbeiten

---

# Geltungsbereich

Dieser Standard gilt für sämtliche Softwarebestandteile des Projekts.

Insbesondere für:

- Domain Layer
- Application Layer
- Infrastructure Layer
- Presentation Layer
- Fachmodule
- Riverpod-State-Management
- Persistenz
- Externe Schnittstellen
- Tests
- Architekturentscheidungen (ADR)

---

# Architekturprinzipien

## Fachlichkeit vor Technik

Die Architektur orientiert sich an fachlichen Anforderungen und nicht an technischen Frameworks.

Die Domäne beschreibt die Geschäftslogik unabhängig von Flutter, Datenbanken oder externen Diensten.

---

## Clean Architecture

HealthTracker basiert auf den Prinzipien der Clean Architecture.

Die Kernidee lautet:

- Geschäftslogik ist unabhängig von technischen Details.
- Abhängigkeiten zeigen immer nach innen.
- Frameworks sind austauschbar.
- Die Domäne bleibt stabil.

---

## Separation of Concerns

Jede Komponente besitzt genau eine klar definierte Verantwortung.

Beispiele:

- Domain: Fachliche Regeln
- Use Cases: Geschäftsprozesse
- Repositorys: Datenzugriff
- UI: Darstellung
- Provider: Zustandsbereitstellung

---

## Modularität

Das System besteht aus unabhängigen Fachmodulen.

Beispiele:

```text
Profile
Dashboard
Measurements
Medication
Nutrition
Analysis
Devices
Settings
```

Jedes Modul kann unabhängig entwickelt, getestet und dokumentiert werden.

---

## Erweiterbarkeit

Neue Funktionen sollen ohne Änderungen bestehender Module ergänzt werden können.

Beispiele:

- Neue Messwerte
- Zusätzliche Analyseverfahren
- Neue Geräteanbindungen
- Cloud-Synchronisation
- Mehrsprachigkeit

---

## Testbarkeit

Alle fachlichen Komponenten müssen unabhängig testbar sein.

Die Architektur unterstützt insbesondere:

- Unit Tests
- Widget Tests
- Integration Tests

Technische Abhängigkeiten werden abstrahiert.

---

# Qualitätsattribute

Die Architektur optimiert folgende Qualitätsmerkmale.

| Qualitätsmerkmal | Ziel |
|------------------|------|
| Wartbarkeit | Hoch |
| Erweiterbarkeit | Hoch |
| Lesbarkeit | Hoch |
| Testbarkeit | Hoch |
| Sicherheit | Hoch |
| Performance | Hoch |
| Modularität | Hoch |
| Wiederverwendbarkeit | Hoch |

Diese Qualitätsattribute dienen als Leitlinien für Architekturentscheidungen.

---

# Architekturübersicht

Die Gesamtarchitektur folgt einem mehrschichtigen Aufbau.

```text
+-------------------------------------------+
|           Presentation Layer              |
+-------------------------------------------+
|          Application Layer                |
+-------------------------------------------+
|             Domain Layer                  |
+-------------------------------------------+
|         Infrastructure Layer              |
+-------------------------------------------+
```

Abhängigkeiten verlaufen ausschließlich von außen nach innen.

---

# Clean Architecture im Projekt

Die Architektur orientiert sich an folgendem Prinzip:

```text
UI
 │
 ▼
Riverpod Provider
 │
 ▼
Notifier
 │
 ▼
Use Case
 │
 ▼
Repository
 │
 ▼
Datasource
```

Die Geschäftslogik befindet sich ausschließlich in der Domain und den Use Cases.

---

# Gesundheitsdaten als Domänenobjekte

Gesundheitsdaten werden ausschließlich als fachliche Domänenobjekte modelliert.

Beispiele:

```text
Profile

Measurement

Medication

NutritionEntry

HealthRecommendation
```

Diese Klassen dürfen keine Abhängigkeiten zu Flutter oder Persistenztechnologien besitzen.

---

# Architekturziele für Gesundheitsdaten

Die Verarbeitung sensibler Gesundheitsdaten folgt folgenden Grundsätzen:

- Trennung von Fachmodell und Datenhaltung
- Keine Speicherung technischer Details in Domänenobjekten
- Validierung auf Domänenebene
- Sichere Verarbeitung personenbezogener Daten
- Erweiterbarkeit für zukünftige medizinische Funktionen

---

# Rollen und Verantwortlichkeiten

## Architekt

Verantwortlich für:

- Gesamtarchitektur
- Architekturentscheidungen
- Einhaltung der Architekturprinzipien

---

## Modulverantwortlicher

Verantwortlich für:

- Architektur seines Moduls
- Konsistenz mit der Gesamtarchitektur
- Dokumentation der Modulstruktur

---

## Entwickler

Verantwortlich für:

- Einhaltung der Architekturregeln
- Umsetzung gemäß Architekturleitfaden
- Dokumentation relevanter Änderungen

---

## Reviewer

Prüft:

- Einhaltung der Architektur
- Verletzungen der Schichten
- Abhängigkeitsregeln
- Architekturkonformität

---

# Architekturentscheidungen

Grundlegende Architekturentscheidungen werden als Architecture Decision Records (ADR) dokumentiert.

Ein ADR beschreibt mindestens:

- Problemstellung
- Entscheidungsalternativen
- getroffene Entscheidung
- Begründung
- Auswirkungen

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Dokumenthistorie
- Dokumentqualität
- Zweck
- Ziele
- Geltungsbereich
- Architekturprinzipien
- Qualitätsattribute
- Architekturübersicht
- Clean Architecture
- Gesundheitsdaten als Domänenobjekte
- Rollen und Verantwortlichkeiten
- Architecture Decision Records (ADR)

---

## Teil 2

Der nächste Abschnitt behandelt:

- Schichtenmodell
- Domain Layer
- Application Layer
- Infrastructure Layer
- Presentation Layer
- Modulstruktur
- Riverpod-Integration
- Persistenz
- Externe Schnittstellen
- Abhängigkeitsregeln

# Schichtenmodell

HealthTracker verwendet eine vierstufige Architektur nach den Prinzipien der Clean Architecture.

Jede Schicht besitzt eine klar definierte Verantwortung.

```text
Presentation Layer
        │
        ▼
Application Layer
        │
        ▼
Domain Layer
        │
        ▼
Infrastructure Layer
```

Abhängigkeiten dürfen ausschließlich von außen nach innen verlaufen.

---

# Domain Layer

Der Domain Layer bildet den fachlichen Kern der Anwendung.

Er enthält ausschließlich Geschäftslogik.

Der Domain Layer kennt weder Flutter noch Riverpod, Datenbanken oder externe Frameworks.

---

## Verantwortlichkeiten

Der Domain Layer enthält:

- Entities
- Value Objects
- Repository-Schnittstellen
- Use Cases
- Domain Services
- Business Rules
- Validation Rules

---

## Struktur

```text
domain/
└── profile/
    ├── entities/
    ├── value_objects/
    ├── repositories/
    ├── use_cases/
    ├── services/
    └── rules/
```

---

## Entities

Entities besitzen eine dauerhafte Identität.

Beispiele

```text
Profile

Measurement

Medication

NutritionEntry

HealthRecommendation
```

Entities dürfen ausschließlich fachliche Logik enthalten.

---

## Value Objects

Value Objects besitzen keine Identität.

Beispiele

```text
BodyHeight

BodyWeight

BloodPressure

WaistCircumference

BirthYear
```

Eigenschaften:

- immutable
- validiert
- vergleichbar über ihren Wert

---

## Repository-Schnittstellen

Repositorys definieren ausschließlich fachliche Operationen.

Beispiel

```dart
abstract interface class ProfileRepository {

  Future<List<Profile>> getProfiles();

  Future<void> save(Profile profile);

}
```

Die technische Umsetzung erfolgt außerhalb der Domain.

---

## Use Cases

Use Cases bilden die fachlichen Prozesse ab.

Beispiele

```text
CreateProfileUseCase

UpdateProfileUseCase

DeleteProfileUseCase

SelectProfileUseCase
```

Ein Use Case besitzt genau eine Verantwortung.

---

## Domain Services

Domain Services kapseln fachliche Abläufe,

die keiner einzelnen Entity zugeordnet werden können.

Beispiele

```text
HealthRiskService

RecommendationService
```

---

# Application Layer

Der Application Layer verbindet UI und Domain.

Er koordiniert Anwendungsabläufe.

---

## Verantwortlichkeiten

- Aufruf von Use Cases
- Koordination mehrerer Prozesse
- Fehlerbehandlung
- Transaktionen
- Mapping zwischen Schichten

---

## Enthält

```text
Application Services

Application Facades

DTO Mapper
```

Business-Regeln gehören nicht in diese Schicht.

---

# Infrastructure Layer

Der Infrastructure Layer enthält sämtliche technischen Implementierungen.

---

## Verantwortlichkeiten

- Datenbank
- Dateisystem
- Verschlüsselung
- Netzwerk
- Cloud
- Gerätekommunikation
- Import/Export

---

## Beispiele

```text
IsarProfileRepository

EncryptedBackupService

CsvExportService

HealthConnectAdapter
```

---

## Datasources

Datasource-Klassen kapseln den konkreten Zugriff auf technische Systeme.

Beispiele

```text
LocalDatasource

SecureStorageDatasource

CloudDatasource
```

Repositorys verwenden Datasources.

Die UI kennt Datasources nicht.

---

# Presentation Layer

Der Presentation Layer enthält ausschließlich Darstellung und Interaktion.

---

## Verantwortlichkeiten

- Widgets
- Pages
- Dialoge
- Navigation
- Formulare
- Riverpod Provider
- Riverpod Notifier

---

## Struktur

```text
features/
└── profiles/
    ├── pages/
    ├── widgets/
    ├── dialogs/
    ├── forms/
    └── providers/
```

---

## Regeln

Die Presentation Layer

- kennt Flutter,
- kennt Riverpod,
- kennt Theme,
- kennt Navigation.

Sie enthält keine Geschäftslogik.

---

# Modulstruktur

HealthTracker wird in unabhängige Fachmodule aufgeteilt.

```text
features/

domain/

repositories/

services/
```

Jedes Modul besitzt dieselbe innere Struktur.

---

## Beispiel

```text
profile/

measurement/

dashboard/

medication/

nutrition/

analysis/

devices/

settings/
```

---

## Modulbestandteile

Jedes Modul besitzt:

- README
- Requirements
- Use Cases
- Business Rules
- Validation Rules
- Datenmodell
- UI-Spezifikation
- API
- Tests
- Traceability

---

# Riverpod-Integration

Riverpod ist das verbindliche State-Management.

---

## Architekturfluss

```text
Widget
      │
      ▼
Provider
      │
      ▼
Notifier
      │
      ▼
Use Case
      │
      ▼
Repository
      │
      ▼
Datasource
```

Widgets greifen niemals direkt auf Repositorys zu.

---

## Provider

Provider stellen Abhängigkeiten bereit.

Beispiele

```text
profileRepositoryProvider

authenticationServiceProvider
```

---

## Notifier

Notifier verwalten UI-Zustände.

Sie koordinieren Use Cases,

enthalten jedoch keine komplexe Geschäftslogik.

---

# Persistenz

Persistenz ist vollständig vom Domain Layer getrennt.

Der Domain Layer kennt keine Datenbank.

---

## Repository Pattern

```text
Domain

↓

Repository Interface

↓

Infrastructure

↓

Repository Implementation

↓

Datasource
```

Dadurch bleibt die Persistenz austauschbar.

---

# Externe Schnittstellen

Externe Systeme werden ausschließlich über Adapter angebunden.

Beispiele

```text
Apple Health

Health Connect

CSV Import

CSV Export

Backup

Cloud Sync
```

Adapter kapseln externe APIs vollständig.

---

# Dependency Rule

Die zentrale Regel lautet:

```text
Abhängigkeiten zeigen ausschließlich nach innen.
```

Beispiel

```text
Presentation

↓

Application

↓

Domain
```

Nicht zulässig

```text
Domain

↓

Flutter

↓

Datasource
```

---

# Zulässige Abhängigkeiten

| Schicht | Darf kennen |
|----------|-------------|
| Presentation | Application |
| Application | Domain |
| Infrastructure | Domain |
| Domain | niemanden |

Der Domain Layer besitzt keinerlei technische Abhängigkeiten.

---

# Unzulässige Abhängigkeiten

Nicht zulässig:

- Domain → Flutter
- Domain → Riverpod
- Domain → Datenbank
- Domain → HTTP
- Domain → UI
- Application → Widgets
- Repository → Widget

---

# Modulkommunikation

Module kommunizieren ausschließlich über definierte Schnittstellen.

Direkte Zugriffe auf interne Klassen anderer Module sind unzulässig.

Beispiel

```text
Dashboard

↓

MeasurementRepository

↓

Measurements
```

Nicht

```text
Dashboard

↓

MeasurementPage
```

---

# Architekturdiagramm

```text
Presentation
     │
     ▼
Application
     │
     ▼
Domain
     ▲
     │
Infrastructure
```

Die Domain bildet den stabilen Kern der Anwendung.

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Schichtenmodell
- Domain Layer
- Application Layer
- Infrastructure Layer
- Presentation Layer
- Entities
- Value Objects
- Repository-Schnittstellen
- Use Cases
- Domain Services
- Modulstruktur
- Riverpod-Integration
- Persistenz
- Datasources
- Externe Schnittstellen
- Dependency Rule
- Zulässige und unzulässige Abhängigkeiten
- Modulkommunikation

---

## Teil 3

Der nächste Abschnitt behandelt:

- Repository Pattern
- Use-Case Pattern
- Entity Design
- Value Objects
- Fehlerbehandlung
- State Management
- Navigation
- Logging
- Performance
- Sicherheit
- Architekturregeln

# Repository Pattern

HealthTracker verwendet konsequent das Repository Pattern zur Trennung von fachlicher Logik und technischer Persistenz.

Repositorys definieren ausschließlich fachliche Operationen.

Die konkrete Datenhaltung erfolgt in der Infrastructure Layer.

---

## Ziel

Repositorys ermöglichen

- Austauschbarkeit der Datenquelle
- Testbarkeit
- Entkopplung
- Wiederverwendbarkeit

---

## Struktur

```text
Domain
    │
    ▼
ProfileRepository
    │
    ▼
Infrastructure
    │
    ▼
IsarProfileRepository
```

---

## Regeln

Repositorys

- enthalten keine UI
- enthalten keine Widgets
- enthalten keine Riverpod-Abhängigkeiten
- enthalten keine Geschäftslogik

---

# Use-Case Pattern

Use Cases bilden sämtliche fachlichen Prozesse ab.

Ein Use Case besitzt genau eine fachliche Verantwortung.

---

## Beispiele

```text
CreateProfileUseCase

UpdateProfileUseCase

DeleteProfileUseCase

AuthenticateProfileUseCase

CreateBackupUseCase
```

---

## Regeln

Ein Use Case

- kapselt genau einen fachlichen Ablauf,
- verwendet Repositorys,
- kennt keine UI,
- kennt keine Widgets,
- kennt keine Flutter-Klassen.

---

## Datenfluss

```text
Widget
      │
      ▼
Notifier
      │
      ▼
Use Case
      │
      ▼
Repository
```

---

# Entity Design

Entities repräsentieren fachliche Objekte mit eigener Identität.

---

## Eigenschaften

Entities

- besitzen eine eindeutige Identität,
- enthalten fachliche Regeln,
- sind unabhängig von Frameworks.

---

## Beispiele

```text
Profile

Measurement

Medication

NutritionEntry

HealthRecommendation
```

---

## Regeln

Entities enthalten

- keine Widgets,
- keine Datenbankannotation,
- keine JSON-Serialisierung,
- keine Riverpod-Abhängigkeiten.

---

# Value Objects

Value Objects modellieren unveränderliche fachliche Werte.

---

## Beispiele

```text
BodyHeight

BodyWeight

BloodPressure

WaistCircumference

BirthYear

Password
```

---

## Eigenschaften

Value Objects sind

- immutable,
- validiert,
- vergleichbar über ihren Wert,
- ohne eigene Identität.

---

# Fehlerbehandlung

Fehler werden zentral und einheitlich behandelt.

---

## Grundprinzipien

Technische Fehler und fachliche Fehler werden getrennt modelliert.

---

## Exceptions

Technische Fehler

```text
StorageException

BackupException

AuthenticationException
```

---

## Failures

Fachliche Fehler

```text
ValidationFailure

PermissionFailure

NetworkFailure
```

---

## Regeln

Use Cases geben keine technischen Exceptions an die UI weiter.

Technische Fehler werden in fachliche Failures übersetzt.

---

# State Management

Riverpod ist verbindlicher Bestandteil der Architektur.

---

## Aufgaben der Provider

Provider

- stellen Abhängigkeiten bereit,
- liefern Daten,
- koordinieren Zustände.

---

## Aufgaben der Notifier

Notifier

- verwalten UI-Zustände,
- koordinieren Use Cases,
- reagieren auf Benutzeraktionen.

Sie enthalten keine komplexen Geschäftsregeln.

---

## State

State-Klassen

- sind immutable,
- beschreiben ausschließlich den aktuellen Zustand,
- enthalten keine Geschäftslogik.

---

# Navigation

Navigation gehört ausschließlich in den Presentation Layer.

---

## Regeln

Navigation darf niemals

- im Repository,
- im Use Case,
- im Domain Layer

erfolgen.

---

## Navigation Flow

```text
Widget
      │
      ▼
Navigation Service
      │
      ▼
Neue Page
```

---

# Logging

Logging erfolgt zentral.

---

## Ziele

Logs dienen

- Fehlersuche,
- Diagnose,
- Nachvollziehbarkeit.

---

## Regeln

Logs enthalten niemals

- Gesundheitsdaten,
- Passwörter,
- PINs,
- Tokens,
- personenbezogene Informationen.

---

## Kategorien

```text
[Profile]

[Dashboard]

[Measurement]

[Backup]

[Analysis]
```

---

# Performance

Performance ist ein fester Bestandteil der Architektur.

---

## Ziele

- kurze Startzeit,
- geringe Speicherbelegung,
- geringe CPU-Auslastung,
- flüssige Darstellung.

---

## Regeln

Vermeiden

- unnötige Rebuilds,
- doppelte Datenbankzugriffe,
- unnötige Provider,
- blockierende Operationen.

---

## Asynchronität

Zeitintensive Operationen werden grundsätzlich asynchron ausgeführt.

Beispiele

```text
Backup

Import

Export

Cloud Sync

Analyse
```

---

# Sicherheit

Gesundheitsdaten besitzen höchste Priorität.

---

## Regeln

Alle sensiblen Daten

- werden verschlüsselt gespeichert,
- werden verschlüsselt übertragen,
- werden niemals im Log ausgegeben.

---

## Zugriff

Zugriffe erfolgen ausschließlich über definierte Repositorys und Services.

Direkte Datenbankzugriffe aus Widgets sind unzulässig.

---

# Konfiguration

Konfigurationswerte werden zentral verwaltet.

---

## Regeln

Keine Hardcodierung von

- URLs,
- Schlüsseln,
- Versionsnummern,
- Feature-Flags.

---

# Architekturregeln

Für das gesamte Projekt gelten folgende Regeln.

## A-001

Business-Logik gehört ausschließlich in Domain und Use Cases.

---

## A-002

Widgets enthalten keine Geschäftslogik.

---

## A-003

Repositorys enthalten keine UI.

---

## A-004

Domain kennt Flutter nicht.

---

## A-005

Domain kennt Riverpod nicht.

---

## A-006

Repositorys werden ausschließlich über Interfaces verwendet.

---

## A-007

Provider greifen niemals direkt auf Datasources zu.

---

## A-008

Navigation erfolgt ausschließlich im Presentation Layer.

---

## A-009

Alle externen Systeme werden über Adapter angebunden.

---

## A-010

Gesundheitsdaten werden ausschließlich über Domain-Objekte verarbeitet.

---

## A-011

Jede neue Funktion wird einem bestehenden Modul zugeordnet oder erhält ein neues Modul mit vollständiger Dokumentation.

---

## A-012

Architekturrelevante Änderungen werden über einen ADR dokumentiert.

---

# Architektur-Validierung

Vor jedem Merge wird geprüft:

- Schichten eingehalten
- Dependency Rule eingehalten
- Modulgrenzen eingehalten
- Repository Pattern eingehalten
- Riverpod korrekt verwendet
- Architekturregeln erfüllt

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Repository Pattern
- Use-Case Pattern
- Entity Design
- Value Objects
- Fehlerbehandlung
- State Management
- Navigation
- Logging
- Performance
- Sicherheit
- Konfiguration
- Architekturregeln
- Architekturvalidierung

---

## Teil 4

Der letzte Abschnitt behandelt:

- Architecture Decision Records (ADR)
- Architektur-Reviews
- Qualitätsmetriken
- Anti-Patterns
- Best Practices
- Review-Checkliste
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Architecture Decision Records (ADR)

Grundlegende Architekturentscheidungen werden als Architecture Decision Records (ADR) dokumentiert.

Ein ADR beschreibt:

- Problemstellung
- Kontext
- Entscheidungsalternativen
- getroffene Entscheidung
- Begründung
- Konsequenzen
- betroffene Module
- Referenzen zu Requirements
- Referenzen zu Tests

---

## Nummerierung

ADRs werden projektweit fortlaufend nummeriert.

Beispiele

```text
ADR-001
ADR-002
ADR-003
```

Die Nummern werden niemals wiederverwendet.

---

## Aufbau eines ADR

Jeder ADR enthält mindestens folgende Kapitel:

```text
Titel

Status

Kontext

Problem

Alternativen

Entscheidung

Begründung

Konsequenzen

Betroffene Module

Traceability

Referenzen
```

---

# Architektur-Reviews

Jede wesentliche Architekturänderung wird einem Architekturreview unterzogen.

## Ziele

Das Architekturreview prüft

- Einhaltung der Clean Architecture
- Schichtenmodell
- Modulgrenzen
- Dependency Rule
- Erweiterbarkeit
- Wartbarkeit
- Sicherheit
- Performance

---

## Review-Auslöser

Ein Architekturreview ist verpflichtend bei:

- Einführung eines neuen Moduls
- Änderung der Schichtenstruktur
- Einführung neuer Frameworks
- Änderung der Persistenztechnologie
- Einführung neuer externer Schnittstellen
- Änderungen an Sicherheitskonzepten
- Änderungen an der Navigationsarchitektur

---

# Qualitätsmetriken

Zur Bewertung der Architektur werden folgende Kennzahlen erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Architekturverletzungen | 0 |
| Zyklische Abhängigkeiten | 0 |
| Direkte Datenbankzugriffe aus Widgets | 0 |
| Flutter-Abhängigkeiten im Domain Layer | 0 |
| Riverpod-Abhängigkeiten im Domain Layer | 0 |
| Architekturreview bestanden | 100 % |
| ADR-Abdeckung architekturrelevanter Änderungen | 100 % |

---

# Architektur-Compliance

Vor jedem Merge wird geprüft:

- Dependency Rule eingehalten
- Schichtenmodell eingehalten
- Modulstruktur eingehalten
- Repository Pattern korrekt
- Use Cases korrekt
- Riverpod korrekt eingesetzt
- Sicherheitsregeln eingehalten
- Performance berücksichtigt

Eine Verletzung dieser Regeln verhindert die Freigabe.

---

# Anti-Patterns

Folgende Muster sind im gesamten Projekt unzulässig.

## AP-001 – Business-Logik im Widget

Nicht zulässig:

```dart
ElevatedButton(
  onPressed: () {
    if (profile.weight > 120) {
      // Fachliche Entscheidung
    }
  },
)
```

Fachliche Entscheidungen gehören in einen Use Case oder eine Domain-Regel.

---

## AP-002 – Direkter Datenbankzugriff aus der UI

Nicht zulässig:

```text
Widget
    │
    ▼
Isar
```

Korrekt:

```text
Widget
    │
    ▼
Notifier
    │
    ▼
Use Case
    │
    ▼
Repository
    │
    ▼
Datasource
```

---

## AP-003 – Technische Abhängigkeiten im Domain Layer

Unzulässig:

- Flutter
- Riverpod
- Isar
- HTTP
- SQLite
- Firebase
- Plattform-APIs

Der Domain Layer bleibt vollständig technologieunabhängig.

---

## AP-004 – God Classes

Klassen mit zu vielen Verantwortlichkeiten sind zu vermeiden.

Beispiele:

```text
ProfileManager

HealthManager

AppController
```

Verantwortlichkeiten werden auf Use Cases und Services verteilt.

---

## AP-005 – Zyklische Modulabhängigkeiten

Nicht zulässig:

```text
Profile
   │
   ▼
Dashboard
   │
   ▼
Profile
```

Module dürfen sich nicht gegenseitig direkt referenzieren.

---

## AP-006 – Verwaiste Architekturentscheidungen

Jede grundlegende Architekturentscheidung benötigt einen ADR.

Nicht dokumentierte Architekturentscheidungen gelten als Qualitätsmangel.

---

# Best Practices

Folgende Praktiken werden projektweit empfohlen.

## Kleine Module

Module besitzen eine klar abgegrenzte fachliche Verantwortung.

---

## Kleine Use Cases

Ein Use Case behandelt genau einen fachlichen Prozess.

---

## Immutable Domain

Entities und Value Objects werden soweit möglich unveränderlich modelliert.

---

## Explizite Abhängigkeiten

Alle Abhängigkeiten werden über Konstruktoren oder Provider injiziert.

Versteckte globale Zustände sind nicht zulässig.

---

## Testbare Architektur

Jede Komponente soll isoliert testbar sein.

Technische Abhängigkeiten werden über Schnittstellen abstrahiert.

---

## Erweiterbarkeit

Neue Funktionen sollen bestehende Module erweitern, nicht verändern.

Das Open-Closed-Prinzip wird bevorzugt.

---

# Review-Checkliste

Vor jeder Freigabe werden mindestens folgende Punkte geprüft.

## Architektur

- [ ] Clean Architecture eingehalten
- [ ] Dependency Rule eingehalten
- [ ] Modulstruktur korrekt
- [ ] Verantwortlichkeiten klar getrennt

---

## Domain

- [ ] Keine technischen Abhängigkeiten
- [ ] Entities korrekt modelliert
- [ ] Value Objects immutable
- [ ] Business Rules vollständig

---

## Application

- [ ] Use Cases eindeutig
- [ ] Fehlerbehandlung korrekt
- [ ] Keine UI-Abhängigkeiten

---

## Infrastructure

- [ ] Repository Pattern eingehalten
- [ ] Datasources gekapselt
- [ ] Adapter sauber implementiert

---

## Presentation

- [ ] Keine Business-Logik
- [ ] Riverpod korrekt verwendet
- [ ] Navigation getrennt
- [ ] Theme verwendet

---

## Sicherheit

- [ ] Verschlüsselung berücksichtigt
- [ ] Datenschutz eingehalten
- [ ] Keine sensiblen Daten im Logging

---

## Performance

- [ ] Keine unnötigen Rebuilds
- [ ] Asynchrone Verarbeitung
- [ ] Datenbankzugriffe optimiert

---

# Referenzen

Dieser Standard baut auf folgenden Projektdokumenten auf:

- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REVIEW_GUIDE.md
- TRACEABILITY_GUIDE.md
- REQUIREMENTS_GUIDE.md
- TESTING_GUIDE.md
- SECURITY_GUIDE.md

Zusätzlich werden Architecture Decision Records (ADR) als verbindlicher Bestandteil der Architektur verwendet.

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-ARCH-001 |
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

**Dokument:** `docs/standards/ARCHITECTURE_GUIDE.md`

**Version:** 1.0.0

**Status:** ✅ Ready for Repository