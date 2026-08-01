# DOCUMENTATION_STANDARD.md

> HealthTracker Documentation Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-001 |
| Dokumenttyp | Projektstandard |
| Version | 1.0.0 |
| Status | Approved |
| Owner | HealthTracker Team |
| Reviewer | Offen |
| Letzte Änderung | 2026-07-31 |
| Reviewintervall | Vor jedem Major Release |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|----------|------------|--------------------------|--------------------------------|----------------|
| 1.0.0 | 2026-07-31 | Erster Projektstandard | Initiale Projektdokumentation | HealthTracker Team |

---

# Dokumentqualität

| Kriterium | Status |
|------------|:------:|
| Vollständigkeit | ✅ |
| Konsistenz | ✅ |
| Verständlichkeit | ✅ |
| Traceability | ✅ |
| Beispiele | ✅ |
| Diagramme | ⏳ |
| Review | ✅ |
| Freigabe | ✅ |

**Qualitätsindex:** 95 %

---

# Zweck

Dieses Dokument definiert die verbindlichen Regeln für die Erstellung, Pflege und Versionierung sämtlicher Dokumentationen innerhalb des HealthTracker-Projekts.

Alle Dokumente des Projekts müssen diesem Standard entsprechen.

---

# Ziele

Der Dokumentationsstandard verfolgt folgende Ziele:

- Einheitlicher Aufbau aller Dokumente
- Verständliche und nachvollziehbare Dokumentation
- Eindeutige Anforderungen
- Rückverfolgbarkeit bis zum Code
- Hohe Wartbarkeit
- Unterstützung automatisierter Reviews
- Unterstützung KI-gestützter Entwicklung

---

# Geltungsbereich

Dieser Standard gilt für:

- Projektdokumentation
- Moduldokumentation
- Architektur
- Datenmodelle
- Medizinische Regeln
- Testdokumente
- ADRs
- Standards
- Vorlagen

---

# Grundprinzipien

## 1. Dokumentation vor Implementierung

Jede Funktion wird zuerst fachlich beschrieben.

Erst danach beginnt die Implementierung.

---

## 2. Eine Datei – ein Thema

Jedes Dokument besitzt genau einen Verantwortungsbereich.

---

## 3. Ein Modul – ein Dokumentationspaket

Jedes Fachmodul besitzt eine vollständige eigene Dokumentation.

---

## 4. Standards vor Individualität

Alle Dokumente verwenden dieselben Vorlagen.

---

## 5. Traceability

Alle Anforderungen müssen bis zur Implementierung nachvollziehbar sein.

---

## 6. Dokumentation ist Quellcode

Dokumentation besitzt denselben Stellenwert wie Quellcode.

Änderungen werden versioniert, reviewed und getestet.

---

# Dokumenttypen

| Typ | Zweck |
|------|------|
| Projekt | Projektweite Informationen |
| Modul | Fachliche Spezifikation |
| Architektur | Technische Architektur |
| Datenmodell | Fachliche Datenstrukturen |
| Medizin | Medizinische Regeln |
| Test | Testfälle |
| ADR | Architekturentscheidungen |
| Standard | Projektstandards |
| Vorlage | Wiederverwendbare Templates |

---

# Standardstruktur

Jedes Dokument besitzt mindestens folgende Kapitel:

1. Dokumentinformationen
2. Dokumenthistorie
3. Dokumentqualität
4. Zweck
5. Geltungsbereich
6. Inhalt
7. Referenzen
8. Änderungsverlauf

Weitere Kapitel hängen vom Dokumenttyp ab.

---

# Dokumentstatus

| Status | Bedeutung |
|---------|-----------|
| Draft | Erste Fassung |
| In Review | Prüfung läuft |
| Approved | Fachlich freigegeben |
| Ready | Bereit für Umsetzung |
| Implemented | Umgesetzt |
| Verified | Erfolgreich geprüft |
| Deprecated | Veraltet |
| Archived | Archiviert |

Der Status muss jederzeit den tatsächlichen Stand widerspiegeln.

---

# Versionierung

Die Dokumentation verwendet Semantic Versioning.

```
MAJOR.MINOR.PATCH
```

Beispiele:

- 1.0.0
- 1.1.0
- 2.0.0

---

# Dokument-IDs

Jedes Dokument besitzt eine eindeutige ID.

Beispiele

```
DOC-STD-001

DOC-PRO-REQ-001

DOC-MEA-API-002

DOC-ANA-BR-005
```

Dokument-IDs dürfen niemals geändert werden.

---

# Dokumentenaufbau

Jedes Dokument beginnt mit

- Dokumentinformationen
- Historie
- Qualitätsindex

Danach folgen die fachlichen Inhalte.

---

# Referenzen

Dokumente dürfen ausschließlich auf

- Dokument-IDs
- Modul-IDs
- Requirement-IDs

verweisen.

Freitextverweise sind zu vermeiden.

---

# Templates

Alle Dokumente werden ausschließlich aus den offiziellen Templates erstellt.

Eigene Dokumentstrukturen sind nicht zulässig.

---

# Reviewprozess

Jedes Dokument durchläuft mindestens drei Prüfungen.

## Fachliches Review

Sind die Inhalte fachlich korrekt?

---

## Technisches Review

Sind die Inhalte umsetzbar?

---

## Qualitätsreview

Entspricht das Dokument den Projektstandards?

---

# Traceability

Für Moduldokumente gilt folgende Mindestanforderung.

```
Requirement
      │
      ▼
Use Case
      │
      ▼
Business Rule
      │
      ▼
Validation Rule
      │
      ▼
API
      │
      ▼
Implementierung
      │
      ▼
Test Case
```

Unvollständige Traceability gilt als Fehler.

---

# Definition of Ready (DoR)

Ein Dokument erhält den Status **Ready**, wenn

- alle Pflichtkapitel vorhanden sind,
- alle IDs vergeben wurden,
- alle Referenzen korrekt sind,
- das Review erfolgreich abgeschlossen wurde,
- die Dokumentqualität mindestens **90 %** beträgt.

---

# Definition of Done (DoD)

Ein Dokument gilt als abgeschlossen, wenn

- der Status **Approved** erreicht wurde,
- alle Reviewpunkte erfüllt sind,
- die Traceability vollständig ist,
- die Dokumentqualität mindestens **95 %** beträgt,
- der Änderungsverlauf aktualisiert wurde.

---

# Pflege

Dokumente werden überprüft

- vor jedem Major Release,
- bei fachlichen Änderungen,
- bei Architekturänderungen.

Veraltete Dokumente erhalten den Status **Deprecated** oder **Archived**.

---

# Qualitätskriterien

Ein Dokument muss

- vollständig,
- eindeutig,
- konsistent,
- verständlich,
- testbar,
- wartbar

sein.

---

# Änderungsregeln

Jede Änderung muss dokumentieren:

- Was wurde geändert?
- Warum wurde geändert?
- Welche Dokumente sind betroffen?
- Welche Requirements sind betroffen?
- Muss die Traceability angepasst werden?

---

# Verbindlichkeit

Dieser Dokumentationsstandard ist für das gesamte Projekt verbindlich.

Abweichungen sind ausschließlich über einen **Architecture Decision Record (ADR)** zulässig.

---

# Referenzen

- DOC-STD-STYLE-001 (Style Guide)
- DOC-STD-NAMING-001 (Naming Conventions)
- DOC-STD-REVIEW-001 (Review Guide)
- DOC-STD-TRACE-001 (Traceability Guide)

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|------------|-------------------------|------------------------------|
| 1.0.0 | 2026-07-31 | Erster freigegebener Standard | Projektstart |