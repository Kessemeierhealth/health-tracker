# Documentation Guide

Version: 1.0.0

---

# Zweck

Dieser Guide beschreibt die Struktur der Projektdokumentation.

Er definiert

- Zweck der einzelnen Dokumente,
- Verantwortlichkeiten,
- Beziehungen zwischen den Dokumenten,
- Reihenfolge ihrer Erstellung,
- Regeln für Änderungen,
- Regeln für Konsistenz.

Er beschreibt keine fachlichen Anforderungen.

---

# Ziele

Die Projektdokumentation soll

- vollständig,
- nachvollziehbar,
- widerspruchsfrei,
- wartbar,
- versionierbar

sein.

Jedes Dokument besitzt einen eindeutig definierten Verantwortungsbereich.

---

# Dokumentationsarchitektur

Die Dokumentation besteht aus zwei Ebenen.

## Projektweite Dokumentation

Projektweite Dokumente gelten für sämtliche Module.

Beispiele:

- REQUIREMENTS_GUIDE.md
- DOCUMENTATION_GUIDE.md
- ARCHITECTURE_GUIDE.md
- UI_GUIDE.md
- STYLE_GUIDE.md
- TESTING_GUIDE.md
- REVIEW_GUIDE.md
- SECURITY_GUIDE.md
- TRACEABILITY_GUIDE.md
- GIT_GUIDE.md
- NAMING_CONVENTIONS.md
- GLOSSARY.md

---

## Modulspezifische Dokumentation

Jedes Modul besitzt seine eigene fachliche Dokumentation.

Beispielsweise:

```text
docs/
└── modules/
    └── profile/
```

Weitere Module werden nach demselben Prinzip aufgebaut.

---

# Standardstruktur eines Moduls

Jedes Modul verwendet dieselbe Dokumentationsstruktur.

1. Requirements
2. Use Cases
3. Business Rules
4. Validation Rules
5. Domain Model
6. Error Handling Guide

Weitere Dokumente dürfen ergänzt werden, sofern sie keine vorhandene
Verantwortlichkeit überschneiden.

---

# Verantwortlichkeiten

## Requirements

Beschreiben ausschließlich fachliche Anforderungen.

Keine technische Umsetzung.

---

## Use Cases

Beschreiben fachliche Abläufe.

Keine Implementierungsdetails.

---

## Business Rules

Beschreiben fachliche Regeln.

Keine Validierungsdetails.

---

## Validation Rules

Beschreiben ausschließlich Validierungslogik.

Keine Geschäftsprozesse.

---

## Domain Model

Beschreibt

- Aggregate
- Entities
- Value Objects
- Enumerationen
- Operationen
- Invarianten

Keine UI.

Keine Persistenz.

---

## Error Handling Guide

Beschreibt

- Validation Errors
- Business Errors
- Information Codes

Keine zusätzlichen fachlichen Regeln.

---

# Führende Dokumente

Für jede fachliche Information existiert genau eine führende Quelle.

Beispiele:

| Thema | Führendes Dokument |
|--------|--------------------|
| Anforderungen | Requirements |
| Fachlicher Ablauf | Use Cases |
| Geschäftsregeln | Business Rules |
| Domänenmodell | Domain Model |
| Validierung | Validation Rules |
| Fehler | Error Handling Guide |

Andere Dokumente dürfen diese Informationen ausschließlich referenzieren.

---

# Änderungsreihenfolge

Bei einer neuen fachlichen Entscheidung erfolgt die Anpassung grundsätzlich
in folgender Reihenfolge.

1. Führendes Dokument bestimmen.
2. Führendes Dokument aktualisieren.
3. Betroffene Dokumente synchronisieren.
4. Implementierung anpassen.
5. Tests ergänzen.
6. Review durchführen.

Nicht jede Änderung betrifft sämtliche Dokumente.

---

# Blockerorientierte Dokumentationspflege

Dokumentation wird angepasst, wenn

- neue Anforderungen entstehen,
- fachliche Entscheidungen geändert werden,
- Implementierungsblocker auftreten,
- dokumentierte Widersprüche erkannt werden.

Es erfolgt keine vorsorgliche Dokumentation hypothetischer zukünftiger
Funktionen.

---

# Konsistenzregeln

Zwischen den Dokumenten dürfen keine fachlichen Widersprüche bestehen.

Insbesondere müssen

- Domain Model,
- Validation Rules,
- Error Handling Guide

denselben fachlichen Zustand beschreiben.

---

# Traceability

Jede fachliche Entscheidung muss nachvollziehbar sein.

Zwischen den Dokumenten bestehen daher Referenzen.

Beispiele:

Requirements
↓

Use Cases
↓

Business Rules
↓

Domain Model
↓

Validation Rules
↓

Error Handling

↓

Implementierung

↓

Tests

Traceability beschreibt Beziehungen.

Sie ersetzt keine fachliche Spezifikation.

---

# Dokumentationsprinzipien

Die Dokumentation ist

- technologieunabhängig,
- frameworkunabhängig,
- implementierungsneutral.

Technische Bibliotheken werden nur dokumentiert, wenn sie fachlich
relevant sind.

---

# Versionierung

Dokumentationsänderungen werden gemeinsam mit der Implementierung
versioniert.

Jede fachliche Änderung muss nachvollziehbar sein.

---

# Qualitätskriterien

Eine Dokumentation ist vollständig, wenn

- Verantwortlichkeiten eindeutig sind,
- keine fachlichen Widersprüche bestehen,
- alle Referenzen konsistent sind,
- Implementierung und Dokumentation übereinstimmen.

---

# Review

Vor jedem Merge wird geprüft,

- ob alle betroffenen Dokumente aktualisiert wurden,
- ob Dokumente widerspruchsfrei sind,
- ob Traceability vollständig ist,
- ob Implementierung und Dokumentation übereinstimmen.

---

# Ziel

Die Dokumentation bildet gemeinsam mit den automatisierten Tests die
dauerhafte Wissensbasis der Gesundheitsplattform.

Sie entwickelt sich gemeinsam mit der Fachdomäne weiter und bleibt
jederzeit konsistent, nachvollziehbar und implementierbar.