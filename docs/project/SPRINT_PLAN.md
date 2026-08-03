# SPRINT_PLAN.md

**Dokument-ID:** DOC-PROJ-SPR-001  
**Dokumenttyp:** Projektplanung  
**Version:** 1.0.0  
**Status:** Aktiv  
**Owner:** HealthTracker Team  
**Letzte Änderung:** 03.08.2026

---

# 1. Zweck

Dieses Dokument beschreibt die aktuelle Sprintplanung des Projekts **Health Tracker**.

Es definiert

- Sprintziele,
- Sprintumfang,
- Abgrenzungen,
- Definition of Ready,
- Definition of Done,
- Abhängigkeiten,
- Fortschritt.

Es dient ausschließlich der Projektplanung und ergänzt die fachlichen sowie technischen Spezifikationen.

---

# 2. Projektstatus

| Sprint | Status |
|----------|--------|
| Sprint 1 – Architektur & Spezifikation | ✅ Abgeschlossen |
| Sprint 2 – Implementierung | 🔄 Aktiv |
| Sprint 3 – Integration | ⏳ Geplant |
| Sprint 4 – Beta | ⏳ Geplant |
| Sprint 5 – Release 1.0 | ⏳ Geplant |

---

# 3. Sprint 1

## Ziel

Erstellung einer vollständigen fachlichen und technischen Grundlage.

### Ergebnis

Abgeschlossen:

- Projektstruktur
- Clean Architecture
- Architekturdiagramme
- ADRs
- Architektur-Review
- Glossar
- UI Guide
- Navigation
- Seitenspezifikationen
- Komponentenrichtlinien
- Formularrichtlinien
- Diagrammrichtlinien

### Definition of Done

- Architektur freigegeben
- Dokumentation konsistent
- Diagramme geprüft
- Review abgeschlossen

Status:

**Abgeschlossen**

---

# 4. Sprint 2

## Titel

Profile Domain Foundation

Status:

**Aktiv**

---

## Ziel

Implementierung der fachlichen Grundlage des Profile-Moduls.

---

## Implementierungsumfang

Es werden ausschließlich folgende Value Objects implementiert:

- ProfileId
- ProfileName
- BirthYear
- Height
- Gender
- ProfileColor

---

## Nicht Bestandteil

Nicht Bestandteil dieses Sprints sind

- Profile Aggregate Root
- ProfileSettings
- ProfileSecurity
- Repository Ports
- Repository Implementierungen
- Application Layer
- UI
- Persistenz
- Domain Events

---

## Architekturregeln

- Alle Value Objects sind unveränderlich.
- Fachliche Validierung erfolgt ausschließlich in der Domain.
- ProfileId erzeugt keine IDs selbst.
- ProfileId validiert ausschließlich UUIDv7.
- Die spätere ID-Erzeugung erfolgt außerhalb der Domain.
- Eine fehlende Geschlechtsangabe wird durch `Gender.unspecified` dargestellt.
- Es werden ausschließlich dokumentierte Anforderungen umgesetzt.

---

## Qualitätsanforderungen

Alle implementierten Klassen

- besitzen Unit Tests,
- unterstützen Wertgleichheit,
- sind unveränderlich,
- verwenden dokumentierte Fehlercodes,
- besitzen keine TODOs,
- besitzen keine Platzhalter.

---

## Definition of Ready

Die Implementierung beginnt erst, wenn

- Requirements vollständig sind,
- Business Rules vollständig sind,
- Validation Rules vollständig sind,
- Domain Model vollständig ist,
- Error Handling definiert ist,
- offene Architekturfragen geklärt sind.

---

## Definition of Done

Sprint 2 ist abgeschlossen, wenn

- alle sechs Value Objects implementiert sind,
- sämtliche dokumentierten Validierungsregeln umgesetzt wurden,
- alle Unit Tests erfolgreich sind,
- `dart format .` erfolgreich war,
- `flutter analyze` ohne Fehler abgeschlossen wurde,
- `flutter test` erfolgreich war,
- Code Review abgeschlossen wurde,
- keine offenen Dokumentationslücken bestehen.

---

# 5. Nächste Sprints

## Sprint 2.2

Profile Aggregate

Geplant:

- Profile
- ProfileSettings
- ProfileSecurity
- Domain Events

---

## Sprint 2.3

Application Layer

Geplant:

- Commands
- Queries
- DTOs
- Use Cases

---

## Sprint 2.4

Infrastructure

Geplant:

- Repository
- Datenpersistenz
- Mapper

---

## Sprint 2.5

Presentation

Geplant:

- Flutter Screens
- Navigation
- Riverpod Provider
- ViewModels

---

# 6. Risiken

Aktuell bekannte Risiken

- Änderungen an der UI-Spezifikation
- Änderungen der fachlichen Anforderungen
- Geräteintegration
- Plattformunterschiede

---

# 7. Offene Entscheidungen

Zurzeit keine offenen Architekturentscheidungen für Sprint 2.1.

Neue Entscheidungen werden über ADRs dokumentiert.

---

# 8. Sprintfortschritt

| Bereich | Status |
|----------|--------|
| Domain | ⏳ |
| Application | ⏳ |
| Infrastructure | ⏳ |
| Presentation | ⏳ |
| Tests | ⏳ |

---

# 9. Review

Nach Abschluss jedes Sprintabschnitts erfolgt

- Dokumentationsreview
- Architekturreview
- Code Review
- Testreview

Erst danach beginnt der nächste Sprintabschnitt.