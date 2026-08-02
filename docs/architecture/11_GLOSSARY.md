# 11 Glossary

| Version | Status | Autor | Letzte Änderung |
|----------|--------|-------|-----------------|
| 1.0 | Draft | Projektteam | 2026-08-02 |

---

# 1 Zweck

Dieses Glossar definiert die projektweit verwendeten Architekturbegriffe.

Alle Architekturdokumente, Moduldokumente und Diagramme verwenden ausschließlich die in diesem Dokument definierten Begriffe.

Das Glossar ist die **Single Source of Truth** für die Terminologie des Projekts.

---

# 2 Architekturbegriffe

## Aggregate

Eine fachliche Einheit, die aus einer Aggregate Root und den zugehörigen Entities und Value Objects besteht.

---

## Aggregate Root

Die einzige öffentlich zugängliche Wurzel eines Aggregates.

Alle Änderungen eines Aggregates erfolgen ausschließlich über die Aggregate Root.

---

## Application Layer

Schicht der Clean Architecture.

Der Application Layer koordiniert Anwendungsfälle und bildet die Schnittstelle zwischen Presentation Layer und Domain Layer.

---

## Application Mapper

Transformiert Daten zwischen Presentation Layer, Application Layer und Domain Layer.

Application Mapper enthalten keine Geschäftslogik.

---

## Application Service

Koordiniert einen Anwendungsfall.

Application Services enthalten keine fachlichen Geschäftsregeln.

---

## Clean Architecture

Architekturstil, bei dem fachliche Geschäftsregeln unabhängig von Frameworks, Datenbanken und Benutzeroberflächen bleiben.

---

## Clean UI

Architekturstil der Benutzeroberfläche.

Die UI enthält ausschließlich Darstellungslogik und delegiert fachliche Abläufe an den Application Layer.

---

## Command

Objekt, das eine fachliche Aktion beschreibt.

Ein Command verändert den Systemzustand.

---

## Data Source

Technische Datenquelle.

Beispiele:

- Datenbank
- Datei
- REST API
- Plattformdienst

---

## Dependency Rule

Architekturregel der Clean Architecture.

Abhängigkeiten zeigen ausschließlich nach innen.

---

## Domain Event

Beschreibt ein fachliches Ereignis innerhalb der Domäne.

---

## Domain Layer

Zentrale fachliche Schicht der Anwendung.

Sie enthält ausschließlich fachliche Geschäftsregeln.

---

## Domain Service

Enthält fachliche Geschäftsregeln, die nicht eindeutig einer Entity oder Aggregate Root zugeordnet werden können.

---

## DTO (Data Transfer Object)

Objekt zum Datenaustausch zwischen Schichten.

DTOs enthalten keine Geschäftslogik.

---

## Entity

Objekt mit fachlicher Identität.

Entities besitzen einen Lebenszyklus.

---

## External Environment

Alle Systeme außerhalb der Anwendung.

Beispiele:

- Betriebssystem
- Cloud
- Plattformdienste
- externe APIs

---

## External Service

Technischer Dienst außerhalb der Anwendung.

---

## Infrastructure Adapter

Adapter zur Anbindung technischer Systeme.

---

## Infrastructure Layer

Schicht der Clean Architecture.

Sie enthält ausschließlich technische Implementierungen.

---

## Mapper

Komponente zur Transformation von Daten zwischen unterschiedlichen Modellen.

Mapper enthalten keine Geschäftslogik.

---

## Navigation

Steuert den Wechsel zwischen Benutzeroberflächen.

Navigation enthält keine Geschäftslogik.

---

## Platform Service

Dienst des Betriebssystems oder der Zielplattform.

Beispiele:

- Kamera
- Health Connect
- Apple Health
- Dateisystem

---

## Port

Abstrakte Schnittstelle des Domain Layers oder Application Layers.

Ports werden durch den Infrastructure Layer implementiert.

---

## Presentation Layer

Schicht der Benutzeroberfläche.

Sie enthält ausschließlich Darstellungslogik.

---

## Presentation Mapper

Transformiert Daten zwischen UI-Modellen und Application-Modellen.

---

## Query

Objekt zur Abfrage fachlicher Informationen.

Queries verändern niemals den Systemzustand.

---

## Repository

Abstrakte Schnittstelle zum Zugriff auf fachliche Daten.

Repositories werden im Infrastructure Layer implementiert.

---

## Single Source of Truth

Für jede Information existiert genau eine führende Quelle.

---

## UI Component

Wiederverwendbare Komponente der Benutzeroberfläche.

---

## UI State

Repräsentiert den aktuellen Zustand einer Benutzeroberfläche.

---

## Use Case

Beschreibt einen abgeschlossenen fachlichen Anwendungsfall.

Use Cases koordinieren den Ablauf zwischen Presentation Layer und Domain Layer.

---

## Validation Rule

Fachliche Regel zur Prüfung von Eingabedaten.

---

## Value Object

Objekt ohne eigene Identität.

Value Objects werden ausschließlich über ihre Werte definiert.

---

# 3 Abkürzungen

| Abkürzung | Bedeutung |
|------------|----------------------------|
| AP | Architecture Principle |
| AR | Architecture Rule |
| DTO | Data Transfer Object |
| UI | User Interface |
| API | Application Programming Interface |

---

# 4 Referenzen

- 00_ARCHITECTURE_CONVENTIONS.md
- 07_APPLICATION_ARCHITECTURE.md
- 08_API_GUIDE.md
- 10_DIAGRAM_REGISTER.md

---

# 5 Status

**Version:** 1.0

**Status:** Draft