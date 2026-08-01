# STYLE_GUIDE.md

> HealthTracker Documentation Style Guide

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-STYLE-001 |
| Dokumenttyp | Projektstandard |
| Version | 1.0.0 |
| Status | Approved |
| Owner | HealthTracker Team |
| Reviewer | - |
| Letzte Änderung | 2026-07-31 |
| Reviewintervall | Vor jedem Major Release |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|---------|------------|--------------------|--------------------|----------------|
| 1.0.0 | 2026-07-31 | Erster Projektstandard | Projektstart | HealthTracker Team |

---

# Dokumentqualität

| Kriterium | Status |
|------------|:------:|
| Vollständigkeit | ✅ |
| Konsistenz | ✅ |
| Verständlichkeit | ✅ |
| Beispiele | ✅ |
| Review | ✅ |
| Freigabe | ✅ |

**Qualitätsindex:** 100 %

---

# Zweck

Dieser Style Guide definiert die verbindlichen Regeln für die Erstellung sämtlicher Dokumentationen innerhalb des HealthTracker-Projekts.

Der Style Guide stellt sicher, dass alle Dokumente

- konsistent,
- verständlich,
- wartbar,
- professionell,
- automatisiert auswertbar

sind.

---

# Geltungsbereich

Dieser Style Guide gilt für

- Projektdokumentation
- Moduldokumentation
- Architektur
- Datenmodelle
- Medizinische Dokumentation
- Testdokumente
- ADRs
- Projektstandards
- Templates

---

# Grundprinzipien

## Verständlichkeit

Dokumente müssen auch nach mehreren Jahren ohne zusätzliche Erklärung verständlich sein.

---

## Konsistenz

Gleiche Sachverhalte werden immer gleich beschrieben.

---

## Präzision

Jede Aussage besitzt genau eine fachliche Bedeutung.

---

## Wartbarkeit

Dokumente sollen möglichst selten strukturell geändert werden.

Neue Inhalte werden ergänzt, nicht umformuliert.

---

## Technologieunabhängigkeit

Fachliche Dokumente enthalten keine Implementierungsdetails.

---

# Sprache

## Dokumentation

Deutsch

---

## Quellcode

Englisch

---

## Kommentare

Deutsch oder Englisch

Innerhalb einer Datei sollte jedoch nur eine Sprache verwendet werden.

---

## Benutzeroberfläche

Version 1.0 verwendet deutsche Texte.

Mehrsprachigkeit wird später ergänzt.

---

# RFC 2119

Normative Anforderungen verwenden ausschließlich:

| Begriff | Bedeutung |
|----------|-----------|
| muss | Verpflichtend |
| soll | Empfohlen |
| kann | Optional |

Nicht zulässig:

- eventuell
- möglichst
- ungefähr
- normalerweise
- bei Bedarf

---

# Schreibstil

Verwenden

- Präsens
- aktive Sprache
- vollständige Sätze
- kurze Absätze
- klare Aussagen

Nicht verwenden

- Umgangssprache
- Werbesprache
- Vermutungen
- unnötige Wiederholungen

---

# Terminologie

Projektweit gelten ausschließlich definierte Fachbegriffe.

Beispiele

| Begriff | Bedeutung |
|----------|-----------|
| Profil | Person innerhalb der Anwendung |
| Aktives Profil | Aktuell ausgewähltes Profil |
| Stammdaten | Grundlegende Profildaten |
| Modul | Fachlich abgeschlossene Funktion |
| Requirement | Funktionale Anforderung |
| Business Rule | Geschäftsregel |
| Validation Rule | Eingabevalidierung |

Neue Begriffe werden ausschließlich im `GLOSSARY.md` definiert.

---

# Inklusive Sprache

Die Dokumentation verwendet eine neutrale und inklusive Sprache.

Beispiele

- Benutzer
- Person
- Team
- Entwickelnde (optional)

Geschlechtsspezifische Formulierungen werden vermieden, sofern sie fachlich nicht erforderlich sind.

---

# Markdown-Konventionen

## Überschriften

Es werden maximal vier Ebenen verwendet.

```text
#
##
###
####
```

---

## Tabellen

Tabellen werden verwendet für

- Eigenschaften
- Parameter
- Vergleiche
- Versionen
- Status

Beispiel

| Feld | Beschreibung |
|------|--------------|

---

## Listen

Aufzählungen verwenden `-`

Abläufe verwenden nummerierte Listen.

Beispiel

```text
1.
2.
3.
```

---

## Hervorhebungen

Fettschrift dient ausschließlich zur Hervorhebung wichtiger Begriffe.

Kursivschrift wird sparsam verwendet.

Unterstreichungen werden vermieden.

---

## Codeblöcke

Codeblöcke besitzen immer eine Sprachangabe.

Beispiel

```dart
class Profile {}
```

Dateistrukturen verwenden

```text
docs/
lib/
```

---

# Hinweise

Hinweise beginnen immer mit

> Hinweis

Sie besitzen keinen normativen Charakter.

---

# Beispiele

Beispiele beginnen mit

> Beispiel

Beispiele erläutern Anforderungen.

Sie ersetzen keine Anforderungen.

---

# Warnungen

Warnungen beginnen mit

> Achtung

Sie beschreiben Risiken oder Fehlanwendungen.

---

# Diagramme

Zugelassene Diagrammtypen

- Mermaid
- draw.io
- ASCII

Jedes Diagramm enthält

- Titel
- Zweck
- Versionsstand

---

# Datumsformat

ISO-8601

```text
2026-07-31
```

---

# Versionsformat

Semantic Versioning

```text
MAJOR.MINOR.PATCH
```

Beispiele

- 1.0.0
- 1.1.0
- 2.0.0

---

# Querverweise

Dokumente verweisen auf

- Dokument-IDs
- Requirement-IDs
- ADR-IDs

Beispiele

```text
DOC-STD-001

PRO-FR-001

ADR-003
```

---

# Tabellenformat

Tabellen besitzen

- Kopfzeile
- linke Ausrichtung
- kurze Inhalte

Beispiel

| Feld | Beschreibung |
|------|--------------|

---

# Qualitätsanforderungen

Ein Dokument muss

- vollständig
- verständlich
- konsistent
- überprüfbar
- wartbar

sein.

---

# Review

Vor der Freigabe wird geprüft

- Rechtschreibung
- Grammatik
- Einhaltung des Style Guides
- Markdown
- Tabellen
- Diagramme
- Terminologie

---

# Definition of Ready

Ein Dokument ist bereit für das Review, wenn

- alle Pflichtkapitel vorhanden sind
- Formatierung vollständig ist
- Referenzen geprüft wurden
- Dokumentqualität mindestens 90 % beträgt

---

# Definition of Done

Ein Dokument gilt als abgeschlossen, wenn

- Review erfolgreich
- Freigabe erfolgt
- Dokumentqualität mindestens 95 %
- Änderungsverlauf aktualisiert

---

# Verbindlichkeit

Dieser Style Guide ist für sämtliche Projektdokumente verbindlich.

Abweichungen sind ausschließlich über einen Architecture Decision Record (ADR) zulässig.

---

# Referenzen

- DOC-STD-001 – Documentation Standard
- DOC-STD-NAMING-001 – Naming Conventions
- DOC-STD-REVIEW-001 – Review Guide
- DOC-STD-TRACE-001 – Traceability Guide

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|---------|------------|-------------------------|-------------------------|
| 1.0.0 | 2026-07-31 | Erster freigegebener Style Guide | Projektstart |