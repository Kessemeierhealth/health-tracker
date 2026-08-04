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
- UI Guide
- Navigation Specification
- Seitenspezifikationen
- Komponentenrichtlinien
- Formularrichtlinien
- Diagrammrichtlinien
- Project Roadmap
- Sprint Plan
- Changelog
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

## UI-Dokumentation

Die projektweite UI-Dokumentation befindet sich unter

```text
docs/ui/
```

Sie definiert die Benutzeroberfläche unabhängig von der Implementierung.

Hierzu gehören insbesondere

- UI Guide
- Navigation Specification
- Seitenspezifikationen
- Komponentenbibliothek
- Formularrichtlinien
- Diagrammrichtlinien

Unterstruktur

```text
docs/ui/
├── navigation/
├── pages/
├── components/
└── assets/
```

Die UI-Dokumentation beschreibt ausschließlich Bedienung, Darstellung und Interaktion.

Sie enthält keine fachliche Geschäftslogik.

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
| DIAGRAM_REGISTER | 10 |
| Glossary | 11 |

## Projektdokumente

Projektmanagementdokumente werden nicht nummeriert.

Sie befinden sich unter

```text
docs/project/
```

und verwenden sprechende Dateinamen.

| Dokument |
|----------|
| ROADMAP.md |
| SPRINT_PLAN.md |
| CHANGELOG.md |

## Gültigkeit der Dokumentnummern

Dokumentnummern gelten ausschließlich innerhalb des jeweiligen
Dokumentationsverzeichnisses.

Die Nummerierung der projektweiten Architekturdokumente unter
`docs/architecture/` ist unabhängig von der Nummerierung der
Moduldokumente unter `docs/modules/<module>/`.

Identische Dokumentnummern in unterschiedlichen Verzeichnissen stellen
daher keinen Namens- oder Versionskonflikt dar.

## Moduldokumente

| Dokument | Nummer | Zweck |
|----------|---------|
| Requirements | 01 | Anforderungen |
| Use Cases | 02 | Anwendungsfälle |
| Business Rules | 03 | Geschäftsregeln |
| Validation Rules | 04 | Validierungsregeln |
| DOMAIN_MODEL | 05 | Fachliches Domänmodell |
| ERROR_HANDLING_GUIDE | 06 | Fehlebehandlung |
| TEST_SPECIFICATION | 07 | Testkonzept |
| APPLICATION_MODEL | 08 | Anwendungsmodell |
| INFRASTRUCTURE_MODEL | 09 | Infrastrucutre Layer |

Die Nummern 01–09 gelten innerhalb jedes Moduls.

## Gültigkeit der Dokumentnummern

Dokumentnummern gelten ausschließlich innerhalb des jeweiligen
Dokumentationsverzeichnisses.

Die Nummerierung der projektweiten Architekturdokumente unter
`docs/architecture/` ist unabhängig von der Nummerierung der
Moduldokumente unter `docs/modules/<module>/`.

Identische Dokumentnummern in unterschiedlichen Verzeichnissen stellen
daher keinen Namens- oder Versionskonflikt dar.

---

## Fehlercode-Konventionen

### Grundsatz

Jeder fachliche Fehler besitzt genau einen stabilen Error Code.

Der Error Code dient der fachlichen Identifikation eines Fehlers und darf sich nach seiner Einführung nicht mehr ändern.

Jeder Error Code ist eindeutig und genau einem fachlichen Fehler zugeordnet.

### Format

Error Codes verwenden das folgende Schema:

```text
<MODUL>-<KATEGORIE>-<OBJEKT>-<NUMMER>
```

Beispiel:

```text
PRO-VAL-NAME-001
PRO-VAL-BIRTHYEAR-003
PRO-VAL-HEIGHT-002
PRO-VAL-COLOR-001
PRO-VAL-ID-001
```

### Message Keys

Message Keys dienen ausschließlich der Lokalisierung von Fehlermeldungen.

Sie sind keine Error Codes.

Beispiele:

```text
validation.profile.name.required
validation.profile.birthYear.minimum
validation.profile.height.maximum
validation.profile.color.invalid
```

### Verantwortlichkeiten

Die fachlichen Error Codes werden in den Validation Rules definiert.

Der Error Handling Guide beschreibt deren technische Repräsentation, Severity, Category und Logging-Verhalten.

### Änderungsregel

Neue Fehler erhalten einen neuen Error Code.

Vorhandene Error Codes werden niemals umbenannt oder wiederverwendet.

### Bootstrap-Regel

Projektweite Basistypen dürfen während ihrer eigenen Initialimplementierung
kontrolliert ArgumentError verwenden, wenn eine Verwendung von DomainResult
zu einer zirkulären Abhängigkeit führen würde.

Nach Abschluss der Domain Foundation verwenden fachliche Typen ausschließlich
DomainResult und DomainMessage.

---

### Zuständigkeit nicht lokal prüfbarer Fehler

Ein Value Object implementiert ausschließlich Regeln, die anhand seines
eigenen Eingabewerts und ausdrücklich übergebener Abhängigkeiten geprüft
werden können.

Regeln, die

- andere Aggregate,
- mehrere Profile,
- Persistenzzustände,
- historische Zustände,
- externe Systeme

benötigen, werden dem zuständigen Aggregate, Domain Service,
Application Service oder Port zugeordnet.

Ein dokumentierter Error Code muss nicht zwangsläufig von dem Value Object
ausgelöst werden, dessen Wert betroffen ist.

---

### Primitive Eingaben von Value-Object-Factories

Factory-Methoden müssen eindeutig dokumentieren:

- akzeptierten primitiven Eingabetyp,
- Normalisierung,
- kanonische interne Repräsentation,
- Verhalten bei fehlenden Eingaben,
- Verhalten bei ungültigen Eingaben.

Alternative Eingabeformate werden nur unterstützt, wenn sie ausdrücklich
spezifiziert sind.

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
| UI Design | docs/ui/UI_GUIDE.md |
| Navigation | docs/ui/navigation/NAVIGATION_SPEC.md |
| Seitenspezifikation | docs/ui/pages/ |
| Komponenten | docs/ui/components/COMPONENT_LIBRARY.md |
| Formulare | docs/ui/components/FORM_GUIDELINES.md |
| Diagramme | docs/ui/components/CHART_GUIDELINES.md |
| Projektplanung | docs/project/SPRINT_PLAN.md |
| Produktplanung | docs/project/ROADMAP.md |
| Versionshistorie | docs/project/CHANGELOG.md |

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