# 00_ARCHITECTURE_CONVENTIONS.md

# Architecture Conventions

Version: 1.0

Status: Frozen

---

# 1. Zweck

Dieses Dokument definiert die projektweiten Architektur- und Dokumentationskonventionen des Health-Tracker-Projekts.

Es bildet die verbindliche Grundlage für sämtliche Architektur-, Design- und Entwicklungsdokumente.

Alle nachfolgenden Dokumente übernehmen die in diesem Dokument definierten Konventionen.

Dieses Dokument beschreibt **nicht die Architektur selbst**, sondern ausschließlich die Regeln zu ihrer Dokumentation und Pflege.

---

# 2. Geltungsbereich

Diese Konventionen gelten projektweit.

Sie sind für sämtliche Architektur- und Designdokumente verbindlich.

Hierzu gehören insbesondere

- Business Rules
- Domain Model
- Error Handling Guide
- Application Architecture
- API Guide
- Test Guide
- zukünftige Module

---

# 3. Dokumentationsebenen

Die Projektdokumentation besteht aus zwei Ebenen.

## Projektweite Architektur

Projektweite Architekturdokumente befinden sich unter

```text
docs/architecture/
```

Sie definieren Regeln und Konventionen,
die für sämtliche Module gelten.

Hierzu gehören insbesondere

- Architecture Conventions
- Application Architecture
- API Guide
- Test Guide

---

## Moduldokumentation

Jedes fachliche Modul besitzt eine eigenständige Dokumentation.

Diese befindet sich unter

```text
docs/modules/<module>/
```

Jedes Modul verwendet grundsätzlich dieselbe Dokumentstruktur.

```text
01_REQUIREMENTS.md
02_USE_CASES.md
03_BUSINESS_RULES.md
04_VALIDATION_RULES.md
05_DOMAIN_MODEL.md
06_ERROR_HANDLING_GUIDE.md
```

Weitere Dokumente dürfen ergänzt werden,
wenn sie ausschließlich modulspezifische Inhalte beschreiben.

---

# 4. Architekturartefakte

Dieses Dokument definiert die Verwendung der projektweiten Architekturartefakte.

Die inhaltliche Beschreibung dieser Artefakte erfolgt ausschließlich in den jeweiligen Fachdokumenten.

---

## 4.1 Architecture Principles (AP)

Architecture Principles beschreiben langfristig gültige Leitlinien der Architektur.

Sie beantworten die Frage

> **Welche grundlegenden Prinzipien verfolgt die Architektur?**

Kennzeichnung

```text
AP-001
AP-002
...
```

Architecture Principles werden ausschließlich in der **Application Architecture** definiert.

---

## 4.2 Architecture Rules (AR)

Architecture Rules beschreiben verbindliche Regeln zur Umsetzung der Architektur.

Sie beantworten die Frage

> **Welche Regeln müssen eingehalten werden?**

Kennzeichnung

```text
AR-001
AR-002
...
```

Architecture Rules werden ausschließlich in der **Application Architecture** definiert.

---

## 4.3 Architecture Decision Records (ADR)

Architecture Decision Records dokumentieren wesentliche Architekturentscheidungen.

Sie beantworten die Frage

> **Warum wurde diese Entscheidung getroffen?**

Kennzeichnung

```text
ADR-001
ADR-002
...
```

Ein ADR beschreibt mindestens

- Entscheidung
- Begründung
- Alternativen
- Konsequenzen

---

# 5. Dokumentstruktur

Alle Architekturdokumente folgen einer einheitlichen Grundstruktur.

1. Zweck
2. Ziele
3. Grundlagen
4. Hauptinhalt
5. Erweiterbarkeit
6. Referenzen
7. Status

Nicht benötigte Kapitel dürfen entfallen.

---

# 6. Dokumentnummerierung

## Projektweite Dokumente

| Dokument | Nummer |
|----------|---------|
| Architecture Conventions | 00 |
| Application Architecture | 07 |
| API Guide | 08 |
| Test Guide | 09 |

## Moduldokumente

| Dokument | Nummer | Zweck |
|----------|---------|
| Requirements | 01 | Anforderungen |
| Use Cases | 02 | Anwendungsfälle |
| Business Rules | 03 | Geschäftsregeln |
| Validation Rules | 04 | Validierungsregeln |
| Domain Model | 05 | Fachliches Domänmodell |
| Error Handling Guide | 06 | Fehlebehandlung |
| TEST_SPECIFICATION | 07 | Testkonzept |
| APPLICATION_MODEL | 08 | Anwendungsmodell |
| INFRASTRUCTURE_MODEL | 09 | Infrastrucutre Layer |

Die Nummern 01–09 gelten innerhalb jedes Moduls.

---

# 7. Single Source of Truth

Jedes fachliche oder technische Artefakt besitzt genau eine führende Quelle.

Nachgelagerte Dokumente übernehmen ausschließlich Begriffe, Regeln und Strukturen ihrer führenden Quelle.

| Artefakt | Führendes Dokument |
|----------|--------------------|
| Anforderungen | `01_REQUIREMENTS.md` |
| Use Cases | `02_USE_CASES.md` |
| Business Rules | `03_BUSINESS_RULES.md` |
| Validation Rules | `04_VALIDATION_RULES.md` |
| Aggregate | `05_DOMAIN_MODEL.md` |
| Aggregate Roots | `05_DOMAIN_MODEL.md` |
| Entities | `05_DOMAIN_MODEL.md` |
| Value Objects | `05_DOMAIN_MODEL.md` |
| Domain Services | `05_DOMAIN_MODEL.md` |
| Domain Events | `05_DOMAIN_MODEL.md` |
| Error Codes | `06_ERROR_HANDLING_GUIDE.md` |
| Application Architecture | `07_APPLICATION_ARCHITECTURE.md` |
| API-Konventionen | `08_API_GUIDE.md` |
| Teststrategie | `09_TEST_GUIDE.md` |

Die führende Quelle ist ausschließlich für die Definition des jeweiligen Artefakts verantwortlich.

Andere Dokumente dürfen diese Inhalte erläutern oder referenzieren, jedoch nicht eigenständig definieren oder verändern.

---

# 8. Dokumentationsworkflow

Die Projektdokumentation folgt einem verbindlichen Dokumentationsworkflow.

Der Workflow stellt sicher, dass fachliche Inhalte zuerst definiert und anschließend schrittweise in technische Artefakte überführt werden.

---

## 8.1 Moduldokumentation

Jedes fachliche Modul wird in folgender Reihenfolge dokumentiert.

```text
01 Requirements
        │
        ▼
02 Use Cases
        │
        ▼
03 Business Rules
        │
        ▼
04 Validation Rules
        │
        ▼
05 Domain Model
        │
        ▼
06 Error Handling Guide
```

Jedes nachgelagerte Dokument wird ausschließlich aus den zuvor freigegebenen Dokumenten abgeleitet.

---

## 8.2 Projektweite Architekturdokumentation

Projektweite Architekturdokumente folgen einem eigenständigen Workflow.

```text
00 Architecture Conventions
        │
        ▼
07 Application Architecture
        │
        ▼
08 API Guide
        │
        ▼
09 Test Guide
```

Diese Dokumente definieren ausschließlich projektweite Architektur-, Integrations- und Testkonventionen.

Sie enthalten keine modulspezifische Fachlogik.

---

## 8.3 Änderungsmanagement

Änderungen erfolgen grundsätzlich entlang des Dokumentationsworkflows.

Eine Änderung an einem vorgelagerten Dokument erfordert eine Konsistenzprüfung aller davon abhängigen Dokumente.

Änderungen an projektweiten Architekturdokumenten sind nur erforderlich, wenn sich projektweite Regeln, Konventionen oder Architekturentscheidungen ändern.

---

## 8.4 Neue fachliche Anforderungen

Neue fachliche Anforderungen werden grundsätzlich zuerst
im Dokument

`01_REQUIREMENTS.md`

dokumentiert.

Die fachliche und technische Konkretisierung erfolgt anschließend
schrittweise entlang des Dokumentationsworkflows.

```text
01 Requirements
        │
        ▼
02 Use Cases
        │
        ▼
03 Business Rules
        │
        ▼
04 Validation Rules
        │
        ▼
05 Domain Model
        │
        ▼
06 Error Handling Guide
```

Erst nach Abschluss der Moduldokumentation werden projektweite Architekturdokumente überprüft.

Eine Anpassung von

- `00_ARCHITECTURE_CONVENTIONS.md`
- `07_APPLICATION_ARCHITECTURE.md`
- `08_API_GUIDE.md`
- `09_TEST_GUIDE.md`

erfolgt ausschließlich, wenn sich daraus projektweite Architekturregeln, Konventionen oder technische Standards ableiten.

Fachliche Änderungen eines einzelnen Moduls führen nicht automatisch zu Änderungen der projektweiten Architekturdokumentation.

---

## 8.5 Review und Freigabe

Jedes Dokument durchläuft denselben Qualitätsprozess.

```text
Erstellung
      │
      ▼
Architekturreview
      │
      ▼
Konsistenzprüfung
      │
      ▼
Überarbeitung
      │
      ▼
Abschlussreview
      │
      ▼
Version 1.0
      │
      ▼
Status "Frozen"
```

Erst nach erfolgreicher Freigabe dient ein Dokument als Grundlage für nachgelagerte Dokumente.

---

# 9. Namenskonventionen

Projektweit werden folgende Präfixe verwendet.

| Präfix | Bedeutung |
|---------|-----------|
| AP | Architecture Principle |
| AR | Architecture Rule |
| AD | Architecture Diagram |
| ADR | Architecture Decision Record |
| BR | Business Rule |
| AGG | Aggregate |
| ENT | Entity |
| VO | Value Object |
| EVT | Domain Event |
| ERR | Error Reference |
| UC | Use Case |

---

# Architecture Diagrams (AD)

Architecture Diagrams sind eigenständige Architekturartefakte.

Sie visualisieren die in den Architekturdokumenten beschriebenen
Zusammenhänge und besitzen ausschließlich erläuternden Charakter.

Diagramme definieren keine zusätzlichen Architekturregeln
und ersetzen keine textlichen Spezifikationen.

---

## Kennzeichnung

Architecture Diagrams verwenden die Kennzeichnung

```text
AD-001
AD-002
...
```

---

## Beispiele

- AD-001 Layer Architecture
- AD-002 Dependency Graph
- AD-003 Request Flow
- AD-004 Repository Pattern
- AD-005 Event Flow

---

## Referenzierung

Architecture Diagrams dürfen aus

- Architecture Principles (AP)
- Architecture Rules (AR)
- Architecture Decision Records (ADR)

referenziert werden.

Ebenso dürfen Architekturdokumente auf entsprechende Diagramme verweisen.

---

## Konsistenz

Jedes Diagramm muss mit den zugehörigen Architekturdokumenten konsistent sein.

Bei Widersprüchen gilt stets die textliche Spezifikation als führende Quelle.

---

# Architekturdiagramme

Architekturdiagramme sind eigenständige Architekturartefakte.

Sie visualisieren die in den Architekturdokumenten beschriebenen Zusammenhänge.

Die textliche Spezifikation besitzt bei Widersprüchen Vorrang.

---

## Diagrammtypen

| Präfix | Bedeutung | Verwendung |
|---------|-----------|------------|
| AD-L | Layer Diagram | Beziehungen zwischen Architekturschichten |
| AD-C | Component Diagram | Komponenten innerhalb einer Architekturschicht |
| AD-M | Module Diagram | Aufbau eines fachlichen Moduls |
| AD-D | Dependency Diagram | Abhängigkeiten zwischen Komponenten oder Schichten |
| AD-F | Flow Diagram | Fachliche oder technische Abläufe |
| AD-S | Sequence Diagram | Nachrichten- und Methodenfolgen |
| AD-E | Event Diagram | Domain Events und Event-Flows |
| AD-R | Repository Diagram | Persistenz- und Repositorystruktur |
| AD-U | Deployment Diagram | Laufzeit- und Deploymentarchitektur |

---

## Nummerierung

Jeder Diagrammtyp besitzt eine eigene fortlaufende Nummerierung.

Beispiele

- AD-L-001 Overall Layer Architecture
- AD-C-001 Domain Layer Components
- AD-M-001 Profile Module
- AD-D-001 Layer Dependencies
- AD-F-001 Request Flow

---

# 10. Dokumentationsregeln

Architekturdokumente

- beschreiben keine Implementierungsdetails,
- definieren keine UI,
- enthalten keine Frameworkabhängigkeiten,
- beschreiben ausschließlich Architektur und Verantwortlichkeiten.

---

# 11. Reviewprozess

Jedes Dokument durchläuft denselben Qualitätsprozess.

1. Erstellung
2. Architekturreview
3. Konsistenzprüfung
4. Überarbeitung
5. Abschlussreview
6. Version 1.0
7. Status "Frozen"

Nach der Freigabe erfolgen Änderungen ausschließlich versioniert.

# Dokumentations-Checkliste

Jedes Architektur- und Designdokument durchläuft vor der Freigabe dieselbe Abschlussprüfung.

## Abschluss-Checkliste

- Dokument erstellt
- Architekturreview durchgeführt
- Überarbeitung abgeschlossen
- Zugehörige Architekturdiagramme erstellt oder aktualisiert
- Querverweise geprüft
- Konsistenz mit den führenden Dokumenten geprüft
- `docs/README.md` aktualisiert
- Versionsnummer geprüft
- Dokumentstatus aktualisiert
- Git Commit erstellt
- Änderungen nach GitHub übertragen

Erst nach erfolgreichem Abschluss dieser Checkliste erhält ein Dokument den Status

`Frozen`.

---

# 12. Versionierung

Jedes Dokument besitzt mindestens

- Version
- Status
- Änderungsverlauf

Empfohlene Status

| Status | Bedeutung |
|---------|-----------|
| Draft | In Bearbeitung |
| Review | In Prüfung |
| Frozen | Freigegeben |
| Deprecated | Veraltet |

---

# 13. Dokumentlebenszyklus

Alle Projektdokumente besitzen denselben Lebenszyklus.

```text
Draft
   │
   ▼
Review
   │
   ▼
Frozen
   │
   ▼
Maintenance
   │
   ▼
Deprecated
   │
   ▼
Archived
```

Jeder Übergang wird versioniert dokumentiert.

---

# 14. Erweiterbarkeit

Neue Module übernehmen diese Konventionen unverändert.

Projektweite Konventionen werden ausschließlich in diesem Dokument geändert.

Alle anderen Dokumente verweisen auf dieses Dokument.

---

# 15. Governance

Dieses Dokument ist die verbindliche Grundlage
für sämtliche Architektur- und Dokumentationsentscheidungen.

Abweichungen sind ausschließlich über einen
Architecture Decision Record (ADR) zulässig.

---

# Status

Version

```text
1.0
```

Status

```text
Frozen
```

Dieses Dokument definiert die projektweiten Architektur- und Dokumentationskonventionen des Health-Tracker-Projekts.

Es bildet die Grundlage für sämtliche nachfolgenden Architektur- und Designdokumente.