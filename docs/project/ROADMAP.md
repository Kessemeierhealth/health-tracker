# ROADMAP.md

**Dokument-ID:** DOC-PROJ-RM-001  
**Dokumenttyp:** Projektplanung  
**Version:** 1.0.0  
**Status:** Aktiv  
**Owner:** HealthTracker Team  
**Letzte Änderung:** 03.08.2026

---

# 1. Zweck

Diese Roadmap beschreibt die langfristige Entwicklung des Projekts **Health Tracker**.

Sie definiert

- Produktvision,
- Entwicklungsphasen,
- Versionen,
- Meilensteine,
- Prioritäten.

Die Roadmap beschreibt **was** geliefert werden soll.

Die konkrete Umsetzung erfolgt über den **SPRINT_PLAN.md**.

---

# 2. Produktvision

Der Health Tracker unterstützt Benutzer langfristig dabei,

- ihre Gesundheit zu dokumentieren,
- Entwicklungen verständlich auszuwerten,
- gesundheitliche Zusammenhänge zu erkennen,
- Empfehlungen abzuleiten,
- Daten sicher und datenschutzkonform zu verwalten.

Die Anwendung soll möglichst viele Informationen automatisch erfassen und den manuellen Aufwand minimieren.

---

# 3. Entwicklungsphasen

| Phase | Status |
|---------|--------|
| Architektur | ✅ Abgeschlossen |
| Domain Foundation | 🔄 In Arbeit |
| Application Layer | ⏳ Geplant |
| Infrastructure | ⏳ Geplant |
| Presentation | ⏳ Geplant |
| Geräteintegration | ⏳ Geplant |
| Beta | ⏳ Geplant |
| Release 1.0 | ⏳ Geplant |

---

# 4. Versionen

## Version 0.1 – Domain Foundation

### Ziel

Implementierung der fachlichen Grundlage.

### Inhalte

- Profile Domain
- Value Objects
- Aggregate
- Business Rules
- Unit Tests

Status

🔄 In Arbeit

---

## Version 0.2 – Application

### Ziel

Implementierung der Anwendungslogik.

### Inhalte

- Commands
- Queries
- DTOs
- Use Cases
- Application Services

Status

⏳ Geplant

---

## Version 0.3 – Infrastructure

### Ziel

Persistenz und technische Anbindung.

### Inhalte

- Repository
- SQLite
- Mapper
- Import
- Export

Status

⏳ Geplant

---

## Version 0.4 – Benutzeroberfläche

### Ziel

Erste vollständig nutzbare Flutter-Anwendung.

### Inhalte

- Navigation
- Home
- Meine Gesundheit
- Profile
- Einstellungen

Status

⏳ Geplant

---

## Version 0.5 – Geräte

### Ziel

Automatische Datenerfassung.

### Inhalte

- Health Connect
- Apple Health
- Smartwatch
- Waage
- Blutdruckmessgerät

Status

⏳ Geplant

---

## Version 0.6 – Ernährung

### Inhalte

- Ernährungstagebuch
- Mahlzeiten
- Rezepte
- Makronährstoffe
- Auswertungen

Status

⏳ Geplant

---

## Version 0.7 – Training

### Inhalte

- Training
- Aktivitäten
- Ziele
- Trainingshistorie

Status

⏳ Geplant

---

## Version 0.8 – Entwicklung

### Inhalte

- Diagramme
- Trends
- Korrelationen
- Empfehlungen

Status

⏳ Geplant

---

## Version 0.9 – Beta

### Ziel

Vollständige Testversion.

### Inhalte

- Feature Complete
- Fehlerkorrekturen
- Performance
- Optimierungen

Status

⏳ Geplant

---

## Version 1.0 – Erstes Release

### Ziel

Erste produktive Version.

### Inhalte

- vollständige Dokumentation
- stabile Architektur
- vollständige Tests
- App Store Vorbereitung
- Google Play Vorbereitung

Status

⏳ Geplant

---

# 5. Fachliche Module

Folgende Module werden schrittweise umgesetzt.

| Modul | Status |
|---------|--------|
| Profile | 🔄 |
| Gesundheit | ⏳ |
| Messwerte | ⏳ |
| Ernährung | ⏳ |
| Training | ⏳ |
| Geräte | ⏳ |
| Entwicklung | ⏳ |
| Dashboard | ⏳ |
| Einstellungen | ⏳ |

---

# 6. Meilensteine

## M1

Architektur abgeschlossen

Status

✅ Erreicht

---

## M2

UI-Spezifikation abgeschlossen

Status

✅ Erreicht

---

## M3

Profile Domain abgeschlossen

Status

🔄 In Arbeit

---

## M4

Profile vollständig implementiert

Status

⏳ Geplant

---

## M5

Erste lauffähige Anwendung

Status

⏳ Geplant

---

## M6

Beta-Test

Status

⏳ Geplant

---

## M7

Release 1.0

Status

⏳ Geplant

---

# 7. Qualitätsziele

Alle Versionen erfüllen folgende Grundsätze.

- Clean Architecture
- Testbarkeit
- Barrierefreiheit
- Datenschutz
- Responsive Design
- Wiederverwendbarkeit
- Dokumentationspflicht
- Traceability

---

# 8. Nichtziele der Version 1.0

Folgende Themen sind nicht Bestandteil der ersten Version.

- Cloud-Synchronisation
- Mehrbenutzerbetrieb
- KI-gestützte medizinische Diagnosen
- Soziale Netzwerke
- Öffentliche Profile
- Community-Funktionen

Diese Funktionen können nach Version 1.0 separat bewertet werden.

---

# 9. Änderungsmanagement

Neue Anforderungen werden

- dokumentiert,
- bewertet,
- priorisiert,
- einem zukünftigen Sprint und einer Zielversion zugeordnet.

Änderungen an bereits freigegebenen Versionen erfolgen ausschließlich kontrolliert und unter Berücksichtigung der Traceability.

---

# 10. Erfolgskriterien

Version 1.0 gilt als erreicht, wenn

- alle Kernmodule implementiert sind,
- sämtliche Architekturregeln eingehalten werden,
- alle definierten Tests erfolgreich sind,
- die Dokumentation vollständig ist,
- keine kritischen Fehler mehr offen sind,
- die Anwendung für den produktiven Einsatz freigegeben werden kann.