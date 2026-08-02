# Architecture Diagrams

Version: 1.0

Status: Frozen

---

# Zweck

Dieses Dokument dient als zentrales Verzeichnis aller Architekturdiagramme des Health-Tracker-Projekts.

Es stellt sicher, dass

- jedes Architekturdiagramm eindeutig identifiziert wird,
- Diagrammnummern nur einmal vergeben werden,
- Diagramme eindeutig Architekturdokumenten zugeordnet sind,
- Bearbeitungsstand und Version nachvollziehbar bleiben,
- die Dokumentation projektweit konsistent bleibt.

---

# Geltungsbereich

Dieses Dokument gilt für sämtliche projektweiten Architekturdiagramme.

Modulspezifische Diagramme werden zusätzlich in den jeweiligen Modulverzeichnissen dokumentiert.

---

# Diagrammtypen

| Präfix | Typ | Verwendung |
|---------|-----|------------|
| AD-L | Layer Diagram | Beziehungen zwischen Architekturschichten |
| AD-C | Component Diagram | Komponenten innerhalb einer Architekturschicht |
| AD-M | Module Diagram | Aufbau eines fachlichen Moduls |
| AD-D | Dependency Diagram | Abhängigkeiten zwischen Schichten oder Komponenten |
| AD-F | Flow Diagram | Fachliche oder technische Abläufe |
| AD-S | Sequence Diagram | Nachrichten- und Methodenfolgen |
| AD-E | Event Diagram | Domain Events und Event-Flows |
| AD-R | Repository Diagram | Repository- und Persistenzarchitektur |
| AD-U | Deployment Diagram | Laufzeit- und Deploymentarchitektur |

---

# Diagrammverzeichnis

| ID | Typ | Titel | Referenz | Version | Status |
|----|-----|-------|-----------|:-------:|--------|
| AD-L-001 | Layer | Overall Layer Architecture | 07_APPLICATION_ARCHITECTURE.md | - | Planned |
| AD-C-001 | Component | Domain Layer Components | 07_APPLICATION_ARCHITECTURE.md | 0.1 | Draft |
| AD-C-002 | Component | Application Layer Components | 07_APPLICATION_ARCHITECTURE.md | – | Planned |
| AD-C-003 | Component | Presentation Layer Components | 07_APPLICATION_ARCHITECTURE.md | – | Planned |
| AD-C-004 | Component | Infrastructure Layer Components | 07_APPLICATION_ARCHITECTURE.md | – | Planned |
| AD-D-001 | Dependency | Layer Dependencies | 07_APPLICATION_ARCHITECTURE.md | – | Planned |
| AD-F-001 | Flow | Request Flow | 07_APPLICATION_ARCHITECTURE.md | – | Planned |

---

# Diagrammstatus

| Status | Bedeutung |
|---------|-----------|
| Planned | Diagramm vorgesehen, Erstellung noch nicht begonnen |
| Draft | Erste Version erstellt |
| Review | Diagramm befindet sich im Review |
| Frozen | Diagramm freigegeben |
| Deprecated | Diagramm wird nicht mehr verwendet |
| Archived | Diagramm archiviert |

---

# Dateikonvention

Jedes Architekturdiagramm besteht grundsätzlich aus zwei Dateien.

## Bearbeitbare Version

```text
AD-xxx-yyy_<Name>.drawio
```

## Dokumentationsversion

```text
AD-xxx-yyy_<Name>.svg
```

Weitere Exportformate (z. B. PDF oder PNG) können zusätzlich erzeugt werden, sind jedoch nicht führend.

---

# Ablagestruktur

Projektweite Architekturdiagramme

```text
docs/
└── architecture/
    └── diagrams/
```

Modulspezifische Diagramme

```text
docs/
└── modules/
    └── <module>/
        └── diagrams/
```

---

# Pflege

Dieses Dokument wird aktualisiert, wenn

- ein neues Architekturdiagramm angelegt wird,
- sich der Status eines Diagramms ändert,
- sich die Versionsnummer eines Diagramms ändert,
- ein Diagramm ersetzt oder archiviert wird,
- sich die Referenz auf ein Architekturdokument ändert.

Die Pflege erfolgt gemäß der Dokumentations-Checkliste aus

`00_ARCHITECTURE_CONVENTIONS.md`.

---

# Referenzen

Projektweite Architektur

```text
docs/architecture/
```

Projektkonventionen

```text
docs/architecture/00_ARCHITECTURE_CONVENTIONS.md
```

Anwendungsarchitektur

```text
docs/architecture/07_APPLICATION_ARCHITECTURE.md
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

Dieses Dokument ist das zentrale Register aller projektweiten Architekturdiagramme.