# GIT_GUIDE.md

> HealthTracker Git & GitHub Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-GIT-001 |
| Dokumenttyp | Projektstandard |
| Kategorie | Versionsverwaltung |
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
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Einführung eines projektweiten Git-Standards | HealthTracker Team |

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

Dieses Dokument definiert den verbindlichen Umgang mit Git und GitHub im HealthTracker-Projekt.

Es beschreibt:

- Repository-Struktur
- Branch-Strategie
- Entwicklungsworkflow
- Commit-Regeln
- Pull-Request-Prozess
- Versionsverwaltung
- Qualitätsanforderungen
- Sicherheitsregeln

Der Standard gewährleistet einen nachvollziehbaren, reproduzierbaren und wartbaren Entwicklungsprozess.

---

# Ziele

Die Git-Strategie verfolgt folgende Ziele:

- Nachvollziehbare Änderungen
- Einheitliche Commit-Historie
- Sichere Zusammenarbeit
- Hohe Codequalität
- Rückverfolgbarkeit aller Änderungen
- Unterstützung der Traceability
- Sichere Releases
- Langfristige Wartbarkeit

---

# Geltungsbereich

Dieser Standard gilt für:

- Quellcode
- Dokumentation
- Tests
- Skripte
- Konfigurationsdateien
- GitHub-Konfiguration
- Releases
- Tags
- Branches

---

# Git-Grundsätze

## Single Source of Truth

Das Git-Repository ist die einzige verbindliche Quelle für:

- Quellcode
- Dokumentation
- Tests
- Konfiguration
- Architekturentscheidungen

---

## Kleine Änderungen

Änderungen sollen möglichst klein und fachlich zusammenhängend sein.

Große Sammel-Commits sind zu vermeiden.

---

## Häufige Commits

Entwicklungsfortschritte werden regelmäßig committed.

Ein Commit beschreibt genau eine fachliche oder technische Änderung.

---

## Nachvollziehbarkeit

Jede Änderung muss nachvollziehbar sein.

Der Commit-Verlauf dokumentiert:

- was geändert wurde,
- warum die Änderung erfolgt ist,
- welche Requirement betroffen ist.

---

## Dokumentation und Code gemeinsam

Code und zugehörige Dokumentation werden gemeinsam geändert.

Eine Implementierung ohne aktualisierte Dokumentation ist nicht zulässig.

---

## Traceability

Jede fachliche Änderung verweist auf ihre Requirement-ID.

Beispiel

```text
feat(profile): create profile (PRO-FR-001)
```

---

# Repository-Struktur

Das Repository besitzt folgende Grundstruktur.

```text
/
├── .github/
├── assets/
├── docs/
├── integration_test/
├── lib/
├── scripts/
├── test/
├── .gitignore
├── pubspec.yaml
└── README.md
```

---

## Dokumentation

Alle Projektdokumente befinden sich unter

```text
docs/
```

Untergliederung

```text
docs/

architecture/

modules/

standards/

templates/

adr/

requirements/

reviews/
```

---

## Quellcode

Der Anwendungscode befindet sich ausschließlich unter

```text
lib/
```

---

## Tests

Testarten werden getrennt organisiert.

```text
test/

integration_test/
```

---

# Repository-Regeln

Das Repository enthält keine

- generierten Dateien,
- temporären Dateien,
- Build-Artefakte,
- lokalen Konfigurationen.

Diese werden über `.gitignore` ausgeschlossen.

---

# Branch-Strategie

HealthTracker verwendet eine modulorientierte Branch-Strategie.

---

## Hauptbranch

```text
main
```

Der Branch `main` enthält ausschließlich freigegebene Änderungen.

Direkte Commits auf `main` sind nicht zulässig.

---

## Entwicklungsbranches

Neue Funktionen werden in Feature-Branches entwickelt.

Beispiele

```text
feature/profile

feature/dashboard

feature/measurements

feature/nutrition

feature/analysis

feature/devices

feature/settings
```

---

## Dokumentationsbranches

Größere Dokumentationsarbeiten können in eigenen Branches erfolgen.

Beispiel

```text
docs/security-guide

docs/testing-guide
```

---

## Hotfix-Branches

Dringende Fehlerbehebungen erfolgen in separaten Branches.

Beispiel

```text
hotfix/profile-backup
```

---

# Rollen und Verantwortlichkeiten

## Entwickler

Verantwortlich für:

- saubere Commits
- Branch-Pflege
- Konfliktlösung
- Dokumentationspflege

---

## Reviewer

Prüft:

- Commitqualität
- Branch-Konformität
- Nachvollziehbarkeit
- Traceability

---

## Repository-Administrator

Verantwortlich für:

- Branch Protection
- Repository-Einstellungen
- Zugriffsrechte
- Release-Tags

---

# GitHub-Nutzung

GitHub ist die zentrale Plattform für:

- Versionsverwaltung
- Pull Requests
- Code Reviews
- Issues
- Releases
- Actions
- Projektdokumentation

Alle Änderungen werden über GitHub nachverfolgt.

---

# Projektregeln

Für das gesamte Projekt gelten folgende Grundregeln.

## G-001

Jede Änderung erfolgt in einem eigenen Branch.

---

## G-002

Direkte Commits auf `main` sind verboten.

---

## G-003

Code und Dokumentation werden gemeinsam versioniert.

---

## G-004

Jeder Commit muss nachvollziehbar sein.

---

## G-005

Jede fachliche Änderung verweist auf die zugehörige Requirement-ID.

---

## G-006

Architekturänderungen werden zusätzlich über einen ADR dokumentiert.

---

## G-007

Alle Änderungen müssen reviewbar sein.

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Dokumenthistorie
- Dokumentqualität
- Zweck
- Ziele
- Geltungsbereich
- Git-Grundsätze
- Repository-Struktur
- Branch-Strategie
- Rollen und Verantwortlichkeiten
- GitHub-Nutzung
- Projektregeln G-001 bis G-007

---

## Teil 2

Der nächste Abschnitt behandelt:

- Branch-Namenskonventionen
- Conventional Commits
- Commit-Nachrichten
- Pull Requests
- Merge-Regeln
- Code Reviews
- Konfliktlösung
- Tags
- Semantic Versioning

# Branch-Namenskonventionen

Alle Branches folgen einer einheitlichen Benennung.

Der Branchname beschreibt den Zweck der Änderung.

---

## Allgemeines Format

```text
<typ>/<beschreibung>
```

---

## Zulässige Branch-Typen

| Typ | Verwendung |
|------|------------|
| feature | Neue Funktionen |
| fix | Fehlerbehebung |
| hotfix | Kritische Fehler |
| docs | Dokumentation |
| refactor | Umstrukturierungen |
| release | Release-Vorbereitung |
| experiment | Prototypen |

---

## Beispiele

```text
feature/profile

feature/dashboard

feature/measurements

feature/nutrition

feature/analysis

feature/devices

feature/settings

docs/testing-guide

fix/profile-password

hotfix/backup-corruption

release/v1.0.0
```

---

# Branch-Regeln

## G-008

Ein Branch behandelt genau ein Thema.

---

## G-009

Branches werden nach erfolgreichem Merge gelöscht.

---

## G-010

Feature-Branches werden ausschließlich aus `main` erstellt.

---

## G-011

Feature-Branches werden niemals untereinander gemerged.

---

# Conventional Commits

HealthTracker verwendet verpflichtend das Format der **Conventional Commits**.

---

## Aufbau

```text
<type>(<scope>): <beschreibung>
```

---

## Commit-Typen

| Typ | Bedeutung |
|------|-----------|
| feat | Neue Funktion |
| fix | Fehlerbehebung |
| docs | Dokumentation |
| style | Formatierung |
| refactor | Umstrukturierung |
| perf | Performance |
| test | Tests |
| build | Buildsystem |
| ci | CI/CD |
| chore | Wartung |
| revert | Rücknahme eines Commits |

---

## Scope

Der Scope beschreibt das betroffene Modul.

Beispiele

```text
profile

dashboard

measurement

nutrition

analysis

backup

settings

security
```

---

## Beispiele

Neue Funktion

```text
feat(profile): create profile (PRO-FR-001)
```

---

Fehlerbehebung

```text
fix(profile): validate birth year (PRO-FR-008)
```

---

Dokumentation

```text
docs(architecture): update architecture guide
```

---

Tests

```text
test(profile): add repository tests
```

---

Refactoring

```text
refactor(measurement): simplify validation
```

---

# Requirement-Referenzen

Jede fachliche Änderung MUSS die betroffene Requirement-ID enthalten.

Beispiele

```text
feat(profile): add password protection (PRO-FR-015)

fix(profile): validate height (PRO-FR-008)

feat(measurement): add waist circumference (MEA-FR-003)
```

---

# Commit-Regeln

## G-012

Ein Commit enthält genau eine logisch zusammenhängende Änderung.

---

## G-013

Commit-Nachrichten werden in englischer Sprache verfasst.

---

## G-014

Commit-Nachrichten beginnen mit einem Conventional-Commit-Typ.

---

## G-015

Commit-Nachrichten beschreiben die Änderung, nicht den Arbeitsaufwand.

Nicht zulässig:

```text
fix stuff

changes

update

test
```

---

## G-016

Merge-Commits werden nicht manuell erstellt.

Sie entstehen ausschließlich über GitHub.

---

# Pull Requests

Alle Änderungen werden über Pull Requests integriert.

Direkte Commits auf `main` sind verboten.

---

## Inhalt eines Pull Requests

Ein Pull Request enthält mindestens:

- Beschreibung
- Zweck
- betroffene Module
- betroffene Requirements
- Tests
- Dokumentationsänderungen

---

## Pflichtangaben

| Feld | Pflicht |
|------|:-------:|
| Beschreibung | ✅ |
| Requirement-IDs | ✅ |
| Teststatus | ✅ |
| Dokumentation aktualisiert | ✅ |
| Review erforderlich | ✅ |

---

# Pull-Request-Template

Jeder Pull Request verwendet ein standardisiertes Template.

Mindestens enthalten:

```text
Beschreibung

Requirements

Tests

Dokumentation

Review

Checkliste
```

---

# Code Reviews

Jeder Pull Request wird mindestens einmal geprüft.

---

## Prüfkriterien

- Architektur
- Lesbarkeit
- Sicherheit
- Tests
- Dokumentation
- Traceability
- Performance

---

## Review-Regeln

## G-017

Kein Self-Review.

---

## G-018

Ein Pull Request benötigt mindestens eine Freigabe.

---

## G-019

Review-Kommentare werden vor dem Merge beantwortet.

---

# Merge-Regeln

Ein Merge ist nur zulässig wenn

- alle Reviews abgeschlossen sind,
- alle CI-Prüfungen erfolgreich sind,
- keine Konflikte bestehen,
- Dokumentation aktuell ist,
- Traceability vollständig ist.

---

## Merge-Methode

Verwendet wird ausschließlich

```text
Squash and Merge
```

Dadurch bleibt die Historie übersichtlich.

---

# Merge-Konflikte

Merge-Konflikte werden ausschließlich im Feature-Branch gelöst.

Der `main`-Branch bleibt konfliktfrei.

---

# Tags

Releases werden mit Git-Tags markiert.

Beispiele

```text
v1.0.0

v1.1.0

v2.0.0
```

---

# Semantic Versioning

HealthTracker verwendet Semantic Versioning.

```text
MAJOR.MINOR.PATCH
```

---

## Regeln

MAJOR

Nicht rückwärtskompatible Änderungen

---

MINOR

Neue Funktionen

---

PATCH

Fehlerbehebungen

---

## Beispiele

```text
1.0.0

1.1.0

1.1.1

2.0.0
```

---

# GitHub Releases

Jedes Release besitzt:

- Versionsnummer
- Changelog
- Release Notes
- Referenz auf den Git-Tag

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Branch-Namenskonventionen
- Branch-Regeln
- Conventional Commits
- Requirement-Referenzen
- Commit-Regeln
- Pull Requests
- Pull-Request-Templates
- Code Reviews
- Merge-Regeln
- Merge-Konflikte
- Git-Tags
- Semantic Versioning
- GitHub Releases

---

## Teil 3

Der nächste Abschnitt behandelt:

- CI/CD-Integration
- Branch Protection
- GitHub Actions
- Release-Workflow
- Hotfix-Prozess
- Revert-Strategie
- Git Hooks
- Umgang mit Binärdateien
- Repository-Hygiene
- Dokumentationsworkflow

# CI/CD-Integration

HealthTracker verwendet Continuous Integration (CI), um die Qualität jeder Änderung automatisch zu überprüfen.

Jeder Pull Request muss sämtliche automatisierten Prüfungen erfolgreich bestehen.

---

# Ziele

Die CI-Pipeline stellt sicher:

- einheitliche Codequalität,
- reproduzierbare Builds,
- automatische Testausführung,
- frühzeitige Fehlererkennung,
- konsistente Releases.

---

# CI-Pipeline

Vor jedem Merge wird mindestens folgende Pipeline ausgeführt.

```text
Git Push
      │
      ▼
GitHub Actions
      │
      ▼
dart format
      │
      ▼
flutter analyze
      │
      ▼
Unit Tests
      │
      ▼
Widget Tests
      │
      ▼
Integration Tests
      │
      ▼
Coverage
      │
      ▼
Build
```

Schlägt ein Schritt fehl, wird der Merge blockiert.

---

# GitHub Actions

Alle automatisierten Prüfungen werden über GitHub Actions ausgeführt.

---

## Standard-Workflows

Mindestens folgende Workflows werden eingerichtet.

| Workflow | Zweck |
|-----------|------|
| Format Check | Codeformatierung |
| Static Analysis | flutter analyze |
| Unit Tests | Fachliche Tests |
| Widget Tests | UI-Tests |
| Integration Tests | Gesamtabläufe |
| Documentation Check | Dokumentationsprüfung |
| Release Build | Erstellung eines Release-Builds |

---

# Branch Protection

Der Branch `main` wird geschützt.

---

## Regeln

Für `main` gelten:

- direkte Commits verboten
- Pull Request erforderlich
- erfolgreiche CI-Pipeline erforderlich
- mindestens ein Review erforderlich
- keine offenen Merge-Konflikte
- Branch muss aktuell sein

---

## Geschützte Branches

```text
main

release/*
```

---

# Status Checks

Vor einem Merge müssen mindestens folgende Status erfolgreich sein.

- Formatierung
- Analyse
- Tests
- Dokumentationsprüfung
- Sicherheitsprüfung
- Review

---

# Release-Workflow

Ein Release folgt einem standardisierten Ablauf.

```text
Feature fertig
      │
      ▼
Pull Request
      │
      ▼
Review
      │
      ▼
CI erfolgreich
      │
      ▼
Merge
      │
      ▼
Release Branch
      │
      ▼
Tag
      │
      ▼
GitHub Release
```

---

# Release-Branch

Für größere Releases wird ein eigener Branch verwendet.

Beispiel

```text
release/v1.2.0
```

---

# Release-Artefakte

Ein Release enthält mindestens:

- Git Tag
- Release Notes
- Changelog
- Versionsnummer
- Dokumentationsstand

---

# Hotfix-Prozess

Kritische Fehler werden unabhängig vom normalen Entwicklungsprozess behoben.

---

## Workflow

```text
main
      │
      ▼
hotfix/profile-backup
      │
      ▼
Review
      │
      ▼
Tests
      │
      ▼
Merge
      │
      ▼
Neuer Tag
```

---

## Regeln

Hotfixes

- besitzen höchste Priorität,
- werden vollständig getestet,
- werden dokumentiert,
- erhalten eine PATCH-Version.

---

# Revert-Strategie

Jede Änderung muss rückgängig gemacht werden können.

---

## Regeln

- Keine History-Rewrites auf `main`
- Reverts erfolgen über Git
- Revert-Commits werden dokumentiert
- Ursache wird im Changelog festgehalten

---

# Git Hooks

Lokale Git Hooks unterstützen die Qualitätssicherung.

---

## Pre-Commit Hook

Vor jedem Commit werden geprüft:

- Formatierung
- Analyse
- offensichtliche Syntaxfehler

---

## Pre-Push Hook

Vor jedem Push werden ausgeführt:

- Unit Tests
- Widget Tests (optional)
- statische Analyse

---

# Umgang mit Binärdateien

Binärdateien werden nur aufgenommen, wenn sie projektrelevant sind.

Beispiele

- Logos
- Icons
- Schriftarten
- Dokumentvorlagen

Nicht zulässig:

- Build-Artefakte
- temporäre Dateien
- große Testdateien ohne Begründung

---

# Repository-Hygiene

Das Repository bleibt dauerhaft übersichtlich.

---

## Regeln

- keine temporären Dateien
- keine lokalen Konfigurationen
- keine generierten Dateien
- keine Passwörter
- keine API-Schlüssel
- keine personenbezogenen Daten

---

# Dokumentationsworkflow

Dokumentation ist Bestandteil jeder Änderung.

---

## Regeln

Bei Änderungen an

- Requirements
- Architektur
- API
- Business Rules
- UI
- Tests

muss die zugehörige Dokumentation aktualisiert werden.

---

# Traceability im Git-Verlauf

Jede fachliche Änderung verweist auf:

- Requirement
- ADR (falls erforderlich)
- Modul
- Release

Beispiel

```text
feat(profile): add profile password protection

Requirement:
PRO-FR-015

ADR:
ADR-003
```

---

# Repository-Wartung

Regelmäßig werden durchgeführt:

- Branch-Bereinigung
- Tag-Kontrolle
- Abhängigkeitsprüfung
- Aktualisierung der Actions
- Überprüfung der Branch Protection

---

# Umgang mit .gitignore

Die `.gitignore` wird zentral gepflegt.

Sie enthält mindestens:

```text
build/

.dart_tool/

.idea/

.vscode/

*.log

*.tmp
```

Projektabhängige Erweiterungen werden dokumentiert.

---

# Backup des Repositorys

Das Git-Repository wird regelmäßig gesichert.

Gesichert werden:

- Repository
- Releases
- Tags
- Issues
- Dokumentation

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- CI/CD-Integration
- GitHub Actions
- Branch Protection
- Status Checks
- Release-Workflow
- Release Branches
- Release-Artefakte
- Hotfix-Prozess
- Revert-Strategie
- Git Hooks
- Umgang mit Binärdateien
- Repository-Hygiene
- Dokumentationsworkflow
- Traceability im Git-Verlauf
- Repository-Wartung
- `.gitignore`
- Repository-Backups

---

## Teil 4

Der letzte Abschnitt behandelt:

- Git-Sicherheitsregeln
- Anti-Patterns
- Best Practices
- Review-Checkliste
- Git-KPIs
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Git-Sicherheitsregeln

Die Versionsverwaltung ist Bestandteil des Sicherheitskonzeptes.

Alle Repositorys müssen gegen unbeabsichtigte oder unberechtigte Änderungen geschützt werden.

---

# Zugriffskontrolle

Der Zugriff auf das Repository erfolgt ausschließlich über authentifizierte Benutzer.

---

## Regeln

- Zugriff nur für berechtigte Projektmitglieder
- Persönliche Benutzerkonten verwenden
- Keine gemeinsamen Benutzerkonten
- Zwei-Faktor-Authentifizierung (2FA) aktivieren
- Zugriffsrechte regelmäßig überprüfen

---

# Geheimnisse (Secrets)

Geheimnisse dürfen niemals im Repository gespeichert werden.

---

## Verboten

Folgende Informationen dürfen niemals versioniert werden:

- Passwörter
- API-Schlüssel
- Tokens
- Zertifikate
- Private Schlüssel
- Zugangsdaten
- personenbezogene Daten
- Gesundheitsdaten

---

## Zulässig

Konfigurationswerte werden ausschließlich über:

- GitHub Secrets
- lokale Umgebungsvariablen
- sichere Secret-Management-Systeme

bereitgestellt.

---

# Branch-Sicherheit

Für geschützte Branches gelten folgende Regeln:

- Force Push verboten
- Branch-Löschung verboten
- Direkte Commits verboten
- Erfolgreiche Status Checks erforderlich
- Mindestens ein erfolgreiches Review erforderlich

---

# Repository-Sicherheit

Das Repository wird regelmäßig überprüft.

Geprüft werden:

- Zugriffsrechte
- Branch Protection
- GitHub Actions
- installierte Abhängigkeiten
- bekannte Sicherheitslücken

---

# Anti-Patterns

Folgende Vorgehensweisen sind projektweit unzulässig.

---

## GIT-AP-001 – Direkter Commit auf `main`

Alle Änderungen erfolgen ausschließlich über Pull Requests.

---

## GIT-AP-002 – Große Sammel-Commits

Ein Commit enthält genau eine logisch zusammenhängende Änderung.

---

## GIT-AP-003 – Fehlende Dokumentation

Codeänderungen ohne Aktualisierung der zugehörigen Dokumentation sind unzulässig.

---

## GIT-AP-004 – Fehlende Requirement-Referenz

Fachliche Änderungen ohne Requirement-ID verletzen die Traceability.

---

## GIT-AP-005 – Merge ohne Review

Ein Pull Request darf nicht ohne Review freigegeben werden.

---

## GIT-AP-006 – Ignorierte CI-Fehler

Fehlgeschlagene Prüfungen dürfen nicht umgangen werden.

---

## GIT-AP-007 – Versionssprünge ohne Dokumentation

Neue Versionen benötigen:

- Changelog
- Release Notes
- Git-Tag

---

## GIT-AP-008 – Verwaiste Branches

Nicht mehr benötigte Branches werden nach dem Merge gelöscht.

---

## GIT-AP-009 – Sensible Daten im Repository

Sicherheitsrelevante Informationen dürfen niemals in Git gespeichert werden.

---

# Best Practices

Folgende Vorgehensweisen werden empfohlen.

---

## Kleine Pull Requests

Pull Requests bleiben überschaubar und behandeln genau ein Thema.

---

## Häufige Synchronisation

Feature-Branches werden regelmäßig mit `main` synchronisiert.

---

## Aussagekräftige Commits

Commit-Nachrichten beschreiben:

- Zweck
- Umfang
- betroffene Module
- Requirement-ID

---

## Dokumentation zuerst

Requirements und Architektur werden vor der Implementierung aktualisiert.

---

## Automatisierte Qualität

CI/CD übernimmt möglichst viele Qualitätsprüfungen automatisch.

---

## Einheitliche Releases

Alle Releases folgen demselben Freigabeprozess.

---

# Review-Checkliste

Vor jedem Merge werden mindestens folgende Punkte geprüft.

## Repository

- [ ] Richtiger Branch
- [ ] Keine Konflikte
- [ ] Branch aktuell

---

## Commits

- [ ] Conventional Commit
- [ ] Requirement-ID vorhanden
- [ ] Kleine Commits
- [ ] Verständliche Beschreibung

---

## Qualität

- [ ] CI erfolgreich
- [ ] Tests erfolgreich
- [ ] Analyse erfolgreich
- [ ] Formatierung korrekt

---

## Dokumentation

- [ ] Dokumentation aktualisiert
- [ ] Traceability aktualisiert
- [ ] ADR ergänzt (falls erforderlich)

---

## Sicherheit

- [ ] Keine Secrets
- [ ] Keine sensiblen Daten
- [ ] Branch Protection eingehalten

---

# Git-KPIs

Zur Bewertung des Entwicklungsprozesses werden folgende Kennzahlen erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Erfolgreiche Builds | 100 % |
| Erfolgreiche Pull Requests | 100 % |
| Erfolgreiche Reviews | 100 % |
| Fehlgeschlagene CI-Läufe | 0 |
| Direkte Commits auf `main` | 0 |
| Offene Merge-Konflikte | 0 |
| Commits mit Requirement-ID | 100 % |
| Aktualisierte Dokumentation | 100 % |
| Traceability vollständig | 100 % |

---

# Kontinuierliche Verbesserung

Der Git-Workflow wird regelmäßig überprüft.

Verbesserungen stammen aus:

- Retrospektiven
- Code Reviews
- Architektur-Reviews
- Sicherheitsreviews
- CI-Auswertungen
- Release-Retrospektiven
- Entwicklerfeedback

Anpassungen erfolgen ausschließlich über eine neue Dokumentversion.

---

# Referenzen

Dieser Standard baut auf folgenden Projektdokumenten auf:

- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REVIEW_GUIDE.md
- TRACEABILITY_GUIDE.md
- ARCHITECTURE_GUIDE.md
- TESTING_GUIDE.md
- SECURITY_GUIDE.md
- REQUIREMENTS_GUIDE.md

Zusätzlich gelten:

- Architecture Decision Records (ADR)
- Moduldokumentationen
- GitHub Repository-Einstellungen

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-GIT-001 |
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
4. Erneutes Review.
5. Dokumentation wesentlicher Änderungen über Traceability und ADR.

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.

---

# Status

**Dokument:** `docs/standards/GIT_GUIDE.md`

**Version:** 1.0.0

**Status:** ✅ Approved