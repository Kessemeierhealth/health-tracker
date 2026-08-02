# Health Tracker – Projektarchitektur

Version: 1.0

Status: Frozen

---

# Zweck

Dieses Dokument dient als Einstiegspunkt für die projektweite Architektur des Health-Tracker-Projekts.

Es beschreibt

- die Architekturdokumente,
- deren Verantwortlichkeiten,
- die Architekturdiagramme,
- sowie die Beziehungen zwischen den einzelnen Dokumenten.

---

# Verzeichnisstruktur

```text
docs/
└── architecture/
    ├── README.md
    ├── 00_ARCHITECTURE_CONVENTIONS.md
    ├── 07_APPLICATION_ARCHITECTURE.md
    ├── 08_API_GUIDE.md
    ├── 09_TEST_GUIDE.md
    ├── adr/
    └── diagrams/
```

---

# Architekturdokumente

| Dokument | Zweck | Status | Version |
|----------|-------|--------|:-------:|
| 00_ARCHITECTURE_CONVENTIONS.md | Projektweite Architektur- und Dokumentationskonventionen | Frozen | 1.0 |
| 07_APPLICATION_ARCHITECTURE.md | Anwendungsschichten und Architektur | In Bearbeitung | 0.2 |
| 08_API_GUIDE.md | API- und Integrationsrichtlinien | Geplant | – |
| 09_TEST_GUIDE.md | Teststrategie und Testarchitektur | Geplant | – |

---

# Architecture Decision Records

Architecture Decision Records (ADR) dokumentieren wesentliche Architekturentscheidungen.

Ablage

```text
docs/architecture/adr/
```

Jeder ADR besitzt

- eine eindeutige Nummer,
- einen Titel,
- eine Begründung,
- dokumentierte Alternativen,
- die Entscheidung,
- die Auswirkungen.

---

# Architekturdiagramme

Alle projektweiten Architekturdiagramme befinden sich unter

```text
docs/architecture/diagrams/
```

Das Diagrammverzeichnis wird zentral verwaltet in

```text
docs/architecture/diagrams/README.md
```

Die projektweiten Architekturdiagramme werden zentral verwaltet in

docs/architecture/diagrams/README.md

---

# Dokumentationsfluss

Die projektweite Architektur entsteht in folgender Reihenfolge.

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

Die modulspezifische Dokumentation wird hiervon unabhängig entwickelt und übernimmt die projektweiten Architekturvorgaben.

---

# Beziehungen

```text
docs/README.md
        │
        ▼
architecture/README.md
        │
        ├───────────────┐
        ▼               ▼
00_ARCHITECTURE_    diagrams/
CONVENTIONS.md      README.md
        │
        ▼
07_APPLICATION_ARCHITECTURE.md
        │
        ▼
08_API_GUIDE.md
        │
        ▼
09_TEST_GUIDE.md
```

---

# Pflege

Dieses Dokument wird aktualisiert, wenn

- neue Architekturdokumente entstehen,
- sich Dokumentstatus ändern,
- neue Architekturdiagramme eingeführt werden,
- neue ADRs angelegt werden,
- sich die Architekturstruktur ändert.

Die Pflege erfolgt gemäß der Dokumentations-Checkliste aus

`00_ARCHITECTURE_CONVENTIONS.md`.

---

# Referenzen

Projektübersicht

```text
docs/README.md
```

Architekturkonventionen

```text
docs/architecture/00_ARCHITECTURE_CONVENTIONS.md
```

Architekturdiagramme

```text
docs/architecture/diagrams/README.md
```

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

Dieses Dokument bildet den zentralen Einstiegspunkt in die projektweite Architektur des Health-Tracker-Projekts.