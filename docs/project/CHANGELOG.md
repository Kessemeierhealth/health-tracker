# CHANGELOG.md

**Dokument-ID:** DOC-PROJ-CL-001  
**Dokumenttyp:** Projektprotokoll  
**Version:** 1.0.0  
**Status:** Aktiv  
**Owner:** HealthTracker Team  
**Letzte Änderung:** 03.08.2026

---

# 1. Zweck

Dieses Dokument protokolliert sämtliche fachlichen und technischen Änderungen des Projekts **Health Tracker**.

Es dient der

- Nachvollziehbarkeit,
- Versionsverwaltung,
- Release-Dokumentation,
- Kommunikation von Änderungen.

Der Changelog beschreibt ausschließlich tatsächlich umgesetzte Änderungen.

Geplante Funktionen werden ausschließlich in der `ROADMAP.md` dokumentiert.

---

# 2. Änderungsrichtlinien

Jeder Eintrag enthält mindestens

- Version
- Datum
- Status
- Art der Änderung
- Beschreibung

Änderungen werden nach folgenden Kategorien klassifiziert:

| Kategorie | Bedeutung |
|-----------|-----------|
| Added | Neue Funktion |
| Changed | Geändertes Verhalten |
| Fixed | Fehlerbehebung |
| Removed | Entfernte Funktion |
| Deprecated | Veraltet |
| Security | Sicherheitsänderung |
| Documentation | Dokumentationsänderung |
| Architecture | Architekturänderung |
| UI | Änderungen der Benutzeroberfläche |
| Testing | Testbezogene Änderungen |

---

# 3. Unreleased

## Status

In Arbeit

### Architecture

- Implementierung des Domain Layers vorbereitet.
- Projektstruktur gemäß Clean Architecture abgeschlossen.

### Documentation

- Sprintplanung erstellt.
- Roadmap erstellt.
- Changelog eingeführt.

---

# 4. Version 1.0.0 (geplant)

## Status

Nicht veröffentlicht

### Ziel

Erste produktive Version.

---

# 5. Historie

## 2026-08-03

### Documentation

#### Added

- Projektweite UI-Dokumentation abgeschlossen.
- `UI_GUIDE.md`
- `NAVIGATION_SPEC.md`
- `HOME_PAGE_SPEC.md`
- `MY_HEALTH_PAGE_SPEC.md`
- `COMPONENT_LIBRARY.md`
- `FORM_GUIDELINES.md`
- `CHART_GUIDELINES.md`

#### Changed

- UI-Dokumentation neu strukturiert.
- Seitenspezifikationen nach `docs/ui/pages/` verschoben.
- Navigation nach `docs/ui/navigation/` verschoben.
- Dokumentreferenzen vereinheitlicht.

---

### Architecture

#### Added

- Architekturdiagramme vollständig erstellt.
- Diagram Register eingeführt.
- Glossar erstellt.
- Architekturreview abgeschlossen.

---

### Project

#### Added

- `ROADMAP.md`
- `SPRINT_PLAN.md`
- `CHANGELOG.md`

---

## 2026-08-02

### Documentation

#### Added

- Architekturkonventionen erweitert.
- Navigation als eigenständige Spezifikation definiert.
- Seitenspezifikationen eingeführt.

#### Changed

- Bereich **Analyse** in **Meine Entwicklung** umbenannt.
- Bereich **Gesundheit** eingeführt.
- Navigation vollständig überarbeitet.
- Schnellzugriff für Messwerterfassung ergänzt.
- Regeln zum Schließen und Unterdrücken von Hinweisen systemweit vereinheitlicht.

---

### UI

#### Added

- Startseite neu konzipiert.
- Farbkonzept für Bereiche definiert.
- Responsive Navigation festgelegt.

---

## 2026-08-01

### Project

#### Added

- Projekt gestartet.
- Dokumentationsstruktur aufgebaut.
- Modul **Profile** spezifiziert.

### Architecture

#### Added

- Clean Architecture als Projektarchitektur festgelegt.
- Dokumentationsstandards eingeführt.
- Traceability-Konzept definiert.

---

# 6. Versionsschema

Das Projekt verwendet Semantic Versioning.

| Version | Bedeutung |
|----------|-----------|
| MAJOR | Nicht rückwärtskompatible Änderungen |
| MINOR | Neue Funktionen |
| PATCH | Fehlerkorrekturen |

Beispiel

```text
1.2.3

1 = Major
2 = Minor
3 = Patch
```

---

# 7. Eintragsregeln

Einträge erfolgen ausschließlich nach erfolgreichem Abschluss einer Änderung.

Jede Änderung wird genau einer Version zugeordnet.

Nicht zulässig sind

- geplante Änderungen,
- Ideen,
- Entwürfe,
- unbestätigte Fehler.

---

# 8. Zusammenhang mit anderen Dokumenten

Der Changelog ergänzt

- `ROADMAP.md`
- `SPRINT_PLAN.md`

Er ersetzt keine Architektur-, Modul- oder UI-Dokumentation.

---

# 9. Review

Vor einer Veröffentlichung ist zu prüfen

- Sind alle Änderungen vollständig dokumentiert?
- Stimmen Versionsnummern überein?
- Sind Kategorien korrekt verwendet?
- Enthält der Changelog ausschließlich tatsächlich umgesetzte Änderungen?
- Stimmen Datum und Status?

---

# 10. Dokumentstatus

| Feld | Wert |
|------|------|
| Status | Aktiv |
| Pflege | Laufend |
| Reviewintervall | Vor jedem Release |
| Versionierung | Semantic Versioning |

---

# Zusammenfassung

Der Changelog dokumentiert die Entwicklung des Health Trackers nachvollziehbar über alle Versionen hinweg.

Gemeinsam mit

- `ROADMAP.md`
- `SPRINT_PLAN.md`

bildet er die Grundlage für das Projektmanagement und die Release-Dokumentation.