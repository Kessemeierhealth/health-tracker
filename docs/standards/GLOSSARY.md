# GLOSSARY.md

> HealthTracker Projektglossar

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-GLO-001 |
| Dokumenttyp | Projektstandard |
| Kategorie | Glossar |
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
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Projektweites Glossar eingeführt | HealthTracker Team |

---

# Zweck

Dieses Glossar definiert sämtliche im HealthTracker-Projekt verwendeten Begriffe.

Es dient als verbindliche Referenz für

- Dokumentation
- Architektur
- Entwicklung
- Tests
- Reviews
- Benutzerhandbuch

Alle Projektdokumente verwenden ausschließlich die hier definierten Begriffe.

---

# Ziele

Das Glossar verfolgt folgende Ziele:

- einheitliche Begriffswelt
- Vermeidung von Synonymen
- eindeutige Definitionen
- bessere Kommunikation
- einfachere Einarbeitung
- konsistente Dokumentation

---

# Regeln

## GLO-001

Jeder Begriff besitzt genau eine Definition.

---

## GLO-002

Synonyme sollen vermieden werden.

---

## GLO-003

Abkürzungen werden beim ersten Auftreten ausgeschrieben.

---

## GLO-004

Neue Begriffe werden ausschließlich über eine neue Dokumentversion ergänzt.

---

## GLO-005

Definitionen müssen fachlich korrekt und verständlich sein.

---

## Aufbau eines Glossareintrags

Jeder Eintrag besitzt – soweit sinnvoll – folgende Struktur:

```text
Begriff

Definition

Eigenschaften

Verwendung

Siehe auch
```

---

# Alphabetisches Glossar

---

# A

## Accessibility

**Definition**

Barrierefreiheit einer Anwendung.

Die Benutzeroberfläche soll von möglichst vielen Menschen unabhängig von körperlichen Einschränkungen genutzt werden können.

**Verwendung**

- UI
- UX
- WCAG
- Screenreader

**Siehe auch**

- Barrierefreiheit
- Screenreader
- UI

---

## Activity

**Definition**

Alle aufgezeichneten körperlichen Aktivitäten eines Profils.

**Verwendung**

- Dashboard
- Analyse
- Empfehlungen

---

## ADR

**Architecture Decision Record**

Dokumentiert eine dauerhafte Architekturentscheidung.

**Eigenschaften**

- versioniert
- nachvollziehbar
- dauerhaft gültig

**Verwendung**

```
docs/adr/
```

**Siehe auch**

- Architektur
- Traceability

---

## API

**Application Programming Interface**

Schnittstelle zwischen Softwarekomponenten.

**Eigenschaften**

- definiert Datenstrukturen
- definiert Kommunikation
- versionierbar

---

## Application Layer

Schicht der Clean Architecture.

Enthält ausschließlich Use Cases.

**Siehe auch**

- Domain Layer
- Infrastructure Layer
- Presentation Layer

---

## Architecture

Gesamte Softwarestruktur der Anwendung.

Beschreibt

- Module
- Abhängigkeiten
- Schichten
- Kommunikation

---

## Audit Trail

Nachvollziehbare Dokumentation sicherheitsrelevanter Ereignisse.

**Beispiele**

- Anmeldung
- Passwortänderung
- Backup
- Datenexport

---

## Authentication

Prüfung der Identität eines Benutzers.

**Beispiele**

- Passwort
- PIN
- Face ID
- Touch ID

**Siehe auch**

- Authorization

---

## Authorization

Festlegung, welche Aktionen ein authentifizierter Benutzer durchführen darf.

**Siehe auch**

- Authentication

---

# B

## Backup

Vollständige Sicherung aller gespeicherten Daten.

**Eigenschaften**

- verschlüsselt
- versioniert
- wiederherstellbar

---

## Barrierefreiheit

Deutsche Bezeichnung für Accessibility.

Die Anwendung orientiert sich an den WCAG-Richtlinien.

---

## Bauchumfang

Gesundheitsparameter zur Bewertung des Stoffwechselrisikos.

**Einheit**

cm

**Verwendung**

- Dashboard
- Analyse
- Empfehlungen

---

## BMI

**Body Mass Index**

Kennzahl zur Bewertung des Körpergewichts.

**Formel**

```
BMI = Gewicht / Größe²
```

**Einheit**

kg/m²

**Verwendung**

- Analyse
- Dashboard
- Empfehlungen

---

## Blood Pressure

Englische Bezeichnung für Blutdruck.

---

## Blutdruck

Messgröße des Herz-Kreislauf-Systems.

**Einheit**

mmHg

**Bestandteile**

- systolisch
- diastolisch

---

## Branch

Entwicklungslinie innerhalb eines Git-Repositories.

**Beispiele**

```
feature/profile

feature/dashboard

release/v1.0.0

hotfix/backup
```

---

## Breakpoint

Schwellenwert für Responsive Design.

Bestimmt den Wechsel zwischen unterschiedlichen Layouts.

---

## Business Rule

Fachliche Geschäftsregel.

**Beispiel**

```
Die Körpergröße muss mindestens 20 cm betragen.
```

---

## Build

Erzeugung einer ausführbaren Anwendung.

---

## BuildContext

Flutter-Klasse zur Navigation und zum Zugriff auf den Widget-Baum.

---

# C

## Card

Wiederverwendbare UI-Komponente.

Stellt zusammengehörige Informationen dar.

---

## Change Log

Dokumentiert Änderungen einer Version.

---

## CI

**Continuous Integration**

Automatisierte Qualitätsprüfung nach jeder Änderung.

---

## Clean Architecture

Architekturmuster mit klar getrennten Verantwortlichkeiten.

Besteht aus

- Domain
- Application
- Infrastructure
- Presentation

---

## Commit

Eine abgeschlossene Änderung innerhalb des Git-Verlaufs.

Jeder Commit beschreibt genau eine fachliche oder technische Änderung.

---

## Component

Wiederverwendbarer Bestandteil der Benutzeroberfläche.

---

## ConsumerWidget

Riverpod-Widget mit Zugriff auf Provider.

---

## Coverage

Messgröße für die Testabdeckung.

**Verwendung**

- Unit Tests
- Widget Tests
- Integration Tests

---

## CRUD

Abkürzung für:

- Create
- Read
- Update
- Delete

Grundoperationen der Datenverarbeitung.

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Regeln
- Aufbau des Glossars
- Begriffe A–C
- Querverweise
- Definitionen
- Verwendung
- Eigenschaften

---

## Teil 2

Der nächste Abschnitt behandelt die Begriffe:

**D–H**

unter anderem:

- Dashboard
- Data Model
- Design Token
- Dialog
- Domain
- DTO
- Entity
- Export
- Feature
- Flutter
- Form
- Golden Test
- Git
- GitHub
- Hash
- Hotfix
- Health Data

# D

## Dashboard

**Definition**

Zentrale Startseite des HealthTracker.

Das Dashboard bietet einen schnellen Überblick über die wichtigsten Gesundheitsdaten eines Profils.

**Eigenschaften**

- individuell konfigurierbar
- profilabhängig
- responsive
- widgetbasiert

**Siehe auch**

- Dashboard Widget
- Profile
- Measurement

---

## Dashboard Widget

**Definition**

Einzelne Informationskomponente innerhalb des Dashboards.

**Beispiele**

- Gewicht
- Bauchumfang
- Blutdruck
- Puls
- Ernährung
- Empfehlungen

---

## Data Model

**Definition**

Struktur sämtlicher gespeicherter Datenobjekte.

Das Datenmodell beschreibt Beziehungen zwischen den fachlichen Objekten.

---

## Data Transfer Object (DTO)

**Definition**

Objekt zur Übertragung von Daten zwischen Schichten.

DTOs enthalten keine Geschäftslogik.

**Siehe auch**

- Entity
- Mapper

---

## Database

**Definition**

Lokaler Datenspeicher der Anwendung.

Gesundheitsdaten werden verschlüsselt gespeichert.

---

## Design System

**Definition**

Sammlung aller Gestaltungsregeln der Benutzeroberfläche.

Enthält:

- Farben
- Typografie
- Komponenten
- Abstände
- Animationen

---

## Design Token

**Definition**

Zentrale Definition visueller Eigenschaften.

**Beispiele**

```text
color.primary

spacing.md

font.body

radius.large
```

---

## Dialog

**Definition**

Temporäres Fenster für Benutzereingaben oder Bestätigungen.

**Beispiele**

- Profil löschen
- Backup wiederherstellen
- Passwort ändern

---

## Domain Layer

**Definition**

Innerste Schicht der Clean Architecture.

Enthält ausschließlich fachliche Logik.

**Siehe auch**

- Entity
- Value Object
- Business Rule

---

## DTO Mapper

**Definition**

Konvertiert DTOs in Entities und umgekehrt.

---

# E

## Empty State

**Definition**

Darstellung einer Ansicht ohne vorhandene Daten.

**Beispiel**

```text
Noch keine Messwerte vorhanden.
```

---

## Encryption

**Definition**

Verschlüsselung sensibler Daten.

HealthTracker verwendet ausschließlich etablierte kryptographische Verfahren.

---

## Entity

**Definition**

Zentrales fachliches Objekt der Domäne.

**Beispiele**

- Profile
- Measurement
- Medication
- Nutrition Entry

---

## Error State

**Definition**

Darstellung eines Fehlers innerhalb der Benutzeroberfläche.

Fehler enthalten eine verständliche Beschreibung und einen Lösungshinweis.

---

## Export

**Definition**

Ausgabe gespeicherter Daten in ein externes Dateiformat.

**Unterstützte Formate**

- JSON
- CSV

---

# F

## Fake

**Definition**

Einfache Testimplementierung einer Komponente.

**Verwendung**

- Repository Tests
- Unit Tests

---

## Feature

**Definition**

Neue Funktion der Anwendung.

**Beispiele**

- Profilverwaltung
- Ernährung
- Analyse
- Geräteintegration

---

## Fixture

**Definition**

Wiederverwendbare Testdaten.

**Beispiele**

- profile_fixture.dart
- measurement_fixture.dart

---

## Flutter

**Definition**

Plattformübergreifendes UI-Framework.

HealthTracker verwendet Flutter für:

- Web
- Windows
- iPad
- zukünftige mobile Plattformen

---

## Form Validation

**Definition**

Prüfung von Benutzereingaben.

**Beispiele**

- Pflichtfelder
- Wertebereiche
- Datumsprüfungen

---

## Form Widget

**Definition**

Widget zur strukturierten Dateneingabe.

---

# G

## Git

**Definition**

Versionsverwaltungssystem des Projekts.

---

## GitHub

**Definition**

Zentrale Plattform für:

- Repository
- Pull Requests
- Reviews
- Releases
- CI/CD

---

## GitHub Actions

**Definition**

Automatisierte CI/CD-Workflows innerhalb von GitHub.

---

## Golden Test

**Definition**

Screenshotbasierter Test zur Erkennung unbeabsichtigter UI-Änderungen.

---

## Grid Layout

**Definition**

Rasterbasierte Anordnung der Benutzeroberfläche.

Grundlage des responsiven Layouts.

---

# H

## Hash

**Definition**

Einwegfunktion zur sicheren Speicherung sensibler Informationen.

**Verwendung**

- Passwörter
- PINs

---

## Health Data

**Definition**

Alle gesundheitsbezogenen Informationen eines Profils.

**Beispiele**

- Gewicht
- Blutdruck
- Medikamente
- Ernährung
- Laborwerte

---

## Health Recommendation

**Definition**

Automatisch erzeugte Empfehlung auf Basis gespeicherter Gesundheitsdaten.

---

## Height

**Definition**

Körpergröße eines Profils.

**Einheit**

cm

---

## Hotfix

**Definition**

Kritische Fehlerbehebung außerhalb des normalen Releaseprozesses.

Hotfixes erhalten eine PATCH-Version.

---

## Hydration

**Definition**

Erfasste tägliche Flüssigkeitsaufnahme.

Kann Bestandteil zukünftiger Auswertungen sein.

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Begriffe D–H
- Dashboard
- Design System
- Design Token
- Domain Layer
- Entity
- Export
- Flutter
- Git
- GitHub
- Golden Test
- Hash
- Health Data
- Hotfix
- weitere technische und fachliche Begriffe

---

## Teil 3

Der nächste Abschnitt behandelt die Begriffe:

**I–R**

unter anderem:

- Import
- Infrastructure Layer
- Integration Test
- Interface
- JSON
- Key Store
- Layout
- Logging
- Measurement
- Medication
- Migration
- Mock
- Navigation
- Notifier
- Offline First
- Profile
- Provider
- Pull Request
- Repository
- Requirement
- Riverpod
- Review

# I

## Import

**Definition**

Einlesen externer Daten in den HealthTracker.

**Unterstützte Formate**

- JSON
- CSV
- zukünftige Erweiterungen

**Eigenschaften**

- validiert
- versioniert
- nachvollziehbar

**Siehe auch**

- Export
- Backup

---

## Infrastructure Layer

**Definition**

Schicht der Clean Architecture.

Sie enthält alle technischen Implementierungen.

**Beispiele**

- Datenbank
- Repository-Implementierung
- Dateisystem
- API-Zugriffe

---

## Integration Test

**Definition**

Automatisierter Test des Zusammenspiels mehrerer Komponenten.

**Verwendung**

- Modulkommunikation
- Navigation
- Repositorys
- Persistenz

---

## Interface

**Definition**

Abstrakte Beschreibung einer Komponente.

Ermöglicht lose Kopplung und Testbarkeit.

---

# J

## JSON

**JavaScript Object Notation**

Standardformat zum Austausch strukturierter Daten.

**Verwendung**

- Export
- Import
- Backups
- APIs

---

# K

## Key Store

**Definition**

Sicherer Speicher des Betriebssystems für kryptographische Schlüssel.

**Beispiele**

- Android Keystore
- Apple Keychain
- Windows Credential Locker

---

## KPI

**Key Performance Indicator**

Messgröße zur Bewertung von Qualität oder Projektfortschritt.

---

# L

## Layout

**Definition**

Anordnung der Benutzeroberfläche.

Das Layout folgt dem projektweiten Designsystem.

---

## Loading State

**Definition**

Darstellung während einer laufenden Verarbeitung.

**Beispiele**

- Daten laden
- Backup erstellen
- Import durchführen

---

## Logging

**Definition**

Protokollierung technischer Ereignisse.

**Regeln**

Keine Gesundheitsdaten oder Passwörter dürfen protokolliert werden.

---

# M

## Mapper

**Definition**

Komponente zur Umwandlung verschiedener Datenmodelle.

**Beispiele**

- DTO → Entity
- Entity → DTO

---

## Measurement

**Definition**

Gespeicherter Gesundheitsmesswert.

**Beispiele**

- Gewicht
- Blutdruck
- Puls
- Bauchumfang

---

## Measurement Category

**Definition**

Fachliche Gruppe von Messwerten.

**Beispiele**

- Körperdaten
- Herz-Kreislauf
- Laborwerte

---

## Medication

**Definition**

Regelmäßig oder einmalig eingenommenes Arzneimittel.

**Eigenschaften**

- Name
- Dosierung
- Einnahmezeit
- Hinweise

---

## Migration

**Definition**

Überführung bestehender Daten in eine neue Datenstruktur.

---

## Mock

**Definition**

Simulierte Implementierung einer Komponente für automatisierte Tests.

---

## Module

**Definition**

Fachlich abgeschlossener Bestandteil der Anwendung.

**Beispiele**

- Profile
- Measurements
- Nutrition
- Dashboard
- Settings

---

# N

## Navigation

**Definition**

Benutzerführung innerhalb der Anwendung.

---

## Navigation Rail

**Definition**

Seitliche Navigation für größere Bildschirme.

---

## Navigation Drawer

**Definition**

Ausklappbares Navigationsmenü.

---

## Notifier

**Definition**

Riverpod-Komponente zur Verwaltung von Zuständen.

Notifier enthalten keine Benutzeroberfläche.

---

## Nutrition

**Definition**

Modul zur Verwaltung von Ernährungsdaten.

---

## Nutrition Entry

**Definition**

Ein einzelner Ernährungseintrag.

---

# O

## Offline First

**Definition**

Architekturprinzip.

Die Anwendung funktioniert vollständig ohne Internetverbindung.

---

# P

## Page

**Definition**

Eigenständige Bildschirmseite der Anwendung.

---

## Password Hash

**Definition**

Sichere Speicherung eines Passworts als Hashwert.

---

## Presentation Layer

**Definition**

Äußerste Schicht der Clean Architecture.

Enthält ausschließlich Benutzeroberfläche.

---

## Profile

**Definition**

Benutzerprofil innerhalb des HealthTracker.

Ein Profil besitzt eigene Gesundheitsdaten.

---

## Profile Color

**Definition**

Individuelle Akzentfarbe eines Profils.

Sie dient ausschließlich der Orientierung.

---

## Provider

**Definition**

Riverpod-Komponente zur Bereitstellung von Abhängigkeiten.

---

## Pull Request

**Definition**

Antrag auf Zusammenführung eines Branches.

Pull Requests bilden die Grundlage des Reviewprozesses.

---

# Q

## Quality Gate

**Definition**

Verpflichtende Qualitätsprüfung vor einem Merge oder Release.

---

# R

## Regression Test

**Definition**

Automatisierter Test zur Sicherstellung, dass ein bereits behobener Fehler nicht erneut auftritt.

---

## Release

**Definition**

Freigegebene Version der Anwendung.

---

## Repository

**Definition**

Abstraktion der Datenhaltung.

Repositories kapseln sämtliche Datenzugriffe.

---

## Requirement

**Definition**

Beschreibt eine fachliche oder technische Anforderung.

Requirements bilden die Grundlage der Entwicklung.

---

## Requirement ID

**Definition**

Eindeutige Kennzeichnung einer Requirement.

**Beispiel**

```text
PRO-FR-001
```

---

## Responsive Design

**Definition**

Automatische Anpassung der Benutzeroberfläche an unterschiedliche Bildschirmgrößen.

---

## Restore

**Definition**

Wiederherstellung eines zuvor erstellten Backups.

---

## Review

**Definition**

Strukturierte Qualitätsprüfung eines Artefakts.

---

## Review Guide

**Definition**

Projektstandard für Reviews.

Dokument:

```text
docs/standards/REVIEW_GUIDE.md
```

---

## Riverpod

**Definition**

Im HealthTracker verwendetes State-Management-System.

---

## Role

**Definition**

Definiert Verantwortlichkeiten innerhalb des Projekts oder der Anwendung.

---

## Route

**Definition**

Navigationsziel innerhalb einer Flutter-Anwendung.

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Begriffe I–R
- Import
- Infrastructure Layer
- Integration Test
- JSON
- Key Store
- Layout
- Loading State
- Logging
- Measurement
- Medication
- Migration
- Mock
- Module
- Navigation
- Notifier
- Nutrition
- Offline First
- Presentation Layer
- Profile
- Provider
- Pull Request
- Quality Gate
- Regression Test
- Release
- Repository
- Requirement
- Responsive Design
- Restore
- Review
- Riverpod
- Route

---

## Teil 4

Der letzte Abschnitt behandelt die Begriffe:

**S–Z**

unter anderem:

- Scaffold
- Screenreader
- Security
- Service
- Shared Preferences
- Sprint
- State
- StatelessWidget
- StatefulWidget
- Stub
- Test
- Traceability
- Use Case
- Validation
- Value Object
- Version
- Widget
- Widget Test
- Workflow

Zusätzlich enthält Teil 4:

- Abkürzungsverzeichnis
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# S

## Scaffold

**Definition**

Grundgerüst einer Flutter-Seite.

Ein Scaffold stellt grundlegende UI-Bereiche bereit.

**Bestandteile**

- AppBar
- Body
- Navigation
- Floating Action Button
- Bottom Navigation

---

## Screenreader

**Definition**

Hilfstechnologie zur barrierefreien Bedienung einer Anwendung.

HealthTracker unterstützt Screenreader auf allen unterstützten Plattformen.

---

## Security

**Definition**

Gesamtheit aller Maßnahmen zum Schutz von Daten, Benutzern und Systemen.

---

## Security by Design

**Definition**

Sicherheitsanforderungen werden bereits während der Architektur berücksichtigt.

---

## Service

**Definition**

Klasse mit fachlichen oder technischen Diensten.

Services enthalten keine Benutzeroberfläche.

---

## Session

**Definition**

Zeitraum zwischen erfolgreicher Anmeldung und Abmeldung eines Benutzers.

---

## Shared Preferences

**Definition**

Lokaler Speicher für einfache Einstellungen.

Nicht geeignet für sensible Gesundheitsdaten.

---

## SnackBar

**Definition**

Kurz eingeblendete Statusmeldung am unteren Bildschirmrand.

Beispiele

- Profil gespeichert
- Backup erfolgreich erstellt
- Daten importiert

---

## Sprint

**Definition**

Zeitlich begrenzter Entwicklungsabschnitt.

Im HealthTracker orientieren sich Sprints an abgeschlossenen Dokumentations- und Implementierungszielen.

---

## State

**Definition**

Aktueller Zustand einer Benutzeroberfläche oder eines Notifiers.

---

## StatefulWidget

**Definition**

Flutter-Widget mit veränderlichem Zustand.

---

## StatelessWidget

**Definition**

Flutter-Widget ohne eigenen Zustand.

---

## Stub

**Definition**

Testobjekt mit vorbereiteten Rückgabewerten.

---

# T

## Test

**Definition**

Verfahren zur Überprüfung einer Anforderung oder Funktion.

---

## Test Fixture

**Definition**

Wiederverwendbare Testdaten.

---

## Theme

**Definition**

Zentrale Definition visueller Eigenschaften einer Flutter-Anwendung.

---

## Token

**Definition**

Zentral definierter Gestaltungswert.

Beispiele

- Farbe
- Abstand
- Schriftgröße
- Radius

---

## Traceability

**Definition**

Nachvollziehbarkeit aller Anforderungen von der Spezifikation bis zur Implementierung und den Tests.

---

## Trend

**Definition**

Zeitliche Entwicklung eines Gesundheitswertes.

---

# U

## UI

**User Interface**

Benutzeroberfläche der Anwendung.

---

## Unit Test

**Definition**

Automatisierter Test einer einzelnen fachlichen Einheit.

---

## Use Case

**Definition**

Fachlicher Anwendungsfall der Application Layer.

Ein Use Case bildet genau einen fachlichen Prozess ab.

---

## User Story

**Definition**

Kurzbeschreibung einer fachlichen Anforderung aus Sicht eines Benutzers.

Kann Grundlage für Requirements sein.

---

# V

## Validation

**Definition**

Prüfung einer Eingabe auf fachliche und technische Gültigkeit.

---

## Validation Rule

**Definition**

Regel zur Prüfung einer Eingabe.

**Beispiel**

```text
Körpergröße ≥ 20 cm
```

---

## Value Object

**Definition**

Unveränderliches fachliches Objekt ohne eigene Identität.

---

## Version

**Definition**

Freigegebener Entwicklungsstand eines Dokuments oder der Software.

---

# W

## WCAG

**Web Content Accessibility Guidelines**

Internationale Richtlinien zur Barrierefreiheit digitaler Anwendungen.

---

## Weight

**Definition**

Körpergewicht eines Profils.

**Einheit**

kg

---

## Widget

**Definition**

Grundbaustein einer Flutter-Benutzeroberfläche.

---

## Widget Test

**Definition**

Automatisierter Test eines einzelnen Flutter-Widgets.

---

## Workflow

**Definition**

Definierter Ablauf mehrerer Arbeitsschritte.

---

# X

Zurzeit keine projektrelevanten Begriffe.

---

# Y

Zurzeit keine projektrelevanten Begriffe.

---

# Z

## Zielbereich

**Definition**

Empfohlener Wertebereich eines Gesundheitsparameters.

---

## Zustandsverwaltung

**Definition**

Verwaltung des aktuellen Anwendungszustands.

HealthTracker verwendet hierfür Riverpod.

---

# Abkürzungsverzeichnis

| Abkürzung | Bedeutung |
|------------|-----------|
| ADR | Architecture Decision Record |
| API | Application Programming Interface |
| BMI | Body Mass Index |
| CI | Continuous Integration |
| CSV | Comma-Separated Values |
| DTO | Data Transfer Object |
| FR | Functional Requirement |
| JSON | JavaScript Object Notation |
| KPI | Key Performance Indicator |
| PIN | Personal Identification Number |
| PR | Pull Request |
| UI | User Interface |
| UX | User Experience |
| WCAG | Web Content Accessibility Guidelines |

---

# Referenzen

Dieses Glossar gilt für sämtliche Projektdokumente.

Insbesondere:

- README.md
- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REQUIREMENTS_GUIDE.md
- REVIEW_GUIDE.md
- TRACEABILITY_GUIDE.md
- ARCHITECTURE_GUIDE.md
- TESTING_GUIDE.md
- SECURITY_GUIDE.md
- GIT_GUIDE.md
- UI_GUIDE.md

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-GLO-001 |
| Version | 1.0.0 |
| Status | **Approved** |
| Freigegeben am | 2026-07-31 |
| Gültig ab | 2026-07-31 |
| Nächstes Review | Vor dem nächsten Major Release |

---

# Änderungsstopp

Mit der Freigabe der Version **1.0.0** gilt dieses Glossar als abgeschlossen.

Änderungen erfolgen ausschließlich durch:

1. Erstellung einer neuen Dokumentversion.
2. Aktualisierung der Dokumenthistorie.
3. Ergänzung neuer Begriffe.
4. Erneute Freigabe.

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.

---

# Status

**Dokument:** `docs/standards/GLOSSARY.md`

**Version:** 1.0.0

**Status:** ✅ Approved