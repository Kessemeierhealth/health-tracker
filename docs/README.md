# Health Tracker – Dokumentationsübersicht

Version: 1.0

Status: Active

---

# Zweck

Diese Datei dient als Einstiegspunkt in die Projektdokumentation.

Sie beschreibt

- die Dokumentationsstruktur,
- den aktuellen Dokumentationsstand,
- die Projektarchitektur,
- sowie die Beziehungen zwischen den einzelnen Dokumenten.

Neue Entwickler sollten mit diesem Dokument beginnen.

---

# Dokumentationsstruktur

Die Projektdokumentation besteht aus zwei Ebenen.

```text
docs/
├── architecture/
└── modules/
```

---

# Projektweite Architektur

Projektweite Architekturdokumente befinden sich unter

```text
docs/architecture/
```

| Dokument | Status | Version |
|----------|--------|---------|
| 00_ARCHITECTURE_CONVENTIONS.md | Frozen | 1.0 |
| 07_APPLICATION_ARCHITECTURE.md | In Bearbeitung | 0.2 |
| 08_API_GUIDE.md | Geplant | – |
| 09_TEST_GUIDE.md | Geplant | – |

---

# Module

Jedes Modul besitzt eine eigenständige Dokumentation.

```text
docs/modules/
```

## Profile

```text
docs/modules/profile/
```

| Dokument | Status | Version |
|----------|--------|---------|
| 01_REQUIREMENTS.md | Vorhanden | 1.0 |
| 02_USE_CASES.md | Vorhanden | 1.0 |
| 03_BUSINESS_RULES.md | Vorhanden | 1.0 |
| 04_VALIDATION_RULES.md | Vorhanden | 1.0 |
| 05_DOMAIN_MODEL.md | Vorhanden | 1.0 |
| 06_ERROR_HANDLING_GUIDE.md | Frozen | 1.0 |

Weitere Module folgen derselben Dokumentationsstruktur.

---

# Dokumentationsworkflow

## Moduldokumentation

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

## Projektweite Architektur

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

---

# Architekturartefakte

Projektweit werden folgende Architekturartefakte verwendet.

| Präfix | Bedeutung |
|---------|-----------|
| AP | Architecture Principle |
| AR | Architecture Rule |
| ADR | Architecture Decision Record |
| AD | Architecture Diagram |
| BR | Business Rule |
| UC | Use Case |
| AGG | Aggregate |
| ENT | Entity |
| VO | Value Object |
| EVT | Domain Event |
| ERR | Error Reference |

---

# Architekturdiagramme

Projektweite Diagramme

```text
docs/architecture/diagrams/
```

Modulspezifische Diagramme

```text
docs/modules/<module>/diagrams/
```

| Präfix | Diagrammtyp |
|---------|-------------|
| AD-L | Layer Diagram |
| AD-D | Dependency Diagram |
| AD-F | Flow Diagram |
| AD-S | Sequence Diagram |
| AD-C | Component Diagram |
| AD-M | Module Diagram |
| AD-E | Event Diagram |
| AD-R | Repository Diagram |
| AD-U | Deployment Diagram |

---

# Dokumentstatus

| Status | Bedeutung |
|---------|-----------|
| Draft | In Bearbeitung |
| Review | In Prüfung |
| Frozen | Freigegeben |
| Deprecated | Veraltet |
| Archived | Archiviert |

---

# Projektfortschritt

## Projektweite Dokumentation

| Dokument | Status |
|----------|--------|
| Architecture Conventions | ✅ |
| Application Architecture | 🟡 |
| API Guide | ⏳ |
| Test Guide | ⏳ |

---

## Moduldokumentation

| Modul | Req | UC | BR | VR | DM | EH |
|--------|:---:|:--:|:--:|:--:|:--:|:--:|
| Profile | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Measurement | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |
| Medication | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |
| Nutrition | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |
| Devices | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |
| Reports | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |

Legende

- Req = Requirements
- UC = Use Cases
- BR = Business Rules
- VR = Validation Rules
- DM = Domain Model
- EH = Error Handling Guide

---

# Nächste Schritte

Aktueller Schwerpunkt

```text
07_APPLICATION_ARCHITECTURE.md
```

Nach Abschluss folgen

- 08_API_GUIDE.md
- 09_TEST_GUIDE.md

Danach werden weitere Module nach derselben Dokumentationsstrategie entwickelt.

---

# Referenzen

Projektweite Architektur

```text
docs/architecture/
```

Moduldokumentation

```text
docs/modules/
```

Projektweite Konventionen

```text
docs/architecture/00_ARCHITECTURE_CONVENTIONS.md
```