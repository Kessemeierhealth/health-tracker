# 10 Diagram Register

| Version | Status | Autor | Letzte Änderung |
|----------|--------|-------|-----------------|
| 1.0 | Draft | Projektteam | 2026-08-02 |

---

# 1 Zweck

Dieses Dokument dient als zentrales Register aller projektweiten Architekturdiagramme.

Für jedes Diagramm werden insbesondere folgende Informationen dokumentiert:

- eindeutige Diagramm-ID,
- Diagrammtyp,
- Bezeichnung,
- Quelldatei,
- Referenzdokument,
- Version,
- Status.

Das Diagrammregister ist die **Single Source of Truth** für alle projektweiten Architekturdiagramme.

---

# 2 Geltungsbereich

Dieses Register umfasst ausschließlich projektweite Architekturdiagramme unter

`docs/architecture/diagrams/`.

Modulspezifische Diagramme werden in den jeweiligen Moduldokumenten oder in einem modulspezifischen Diagrammregister dokumentiert.

---

# 3 Führendes Diagrammformat

Das führende Quellformat für Architekturdiagramme ist Mermaid.

```text
*.mmd
```

Mermaid-Dateien sind

- textbasiert,
- versionierbar,
- durch GitHub darstellbar,
- durch Codex und andere Entwicklungswerkzeuge lesbar,
- unabhängig von proprietären Diagrammformaten.

Optional dürfen aus den Mermaid-Quellen Darstellungsformate erzeugt werden.

```text
*.svg
*.png
```

Die Mermaid-Datei bleibt dabei stets die führende Quelle.

Bei Abweichungen zwischen Quelldatei und Export besitzt die Mermaid-Quelldatei Vorrang.

---

# 4 Diagrammtypen

| Präfix | Typ | Beschreibung |
|--------|-----|--------------|
| AD-L | Layer Diagram | Darstellung der Architekturschichten und ihrer zulässigen Abhängigkeiten |
| AD-C | Component Diagram | Darstellung der Architekturbestandteile einer Schicht |
| AD-P | Package Diagram | Darstellung der Paket- und Verzeichnisstruktur |
| AD-S | Sequence Diagram | Darstellung zeitlicher Abläufe und Interaktionen |
| AD-D | Deployment Diagram | Darstellung der technischen Deployment-Architektur |

Weitere Diagrammtypen dürfen nur eingeführt werden, wenn sie in den projektweiten Architekturkonventionen definiert und in diesem Register dokumentiert werden.

---

# 5 Diagrammregister

| ID | Typ | Bezeichnung | Quelldatei | Referenz | Version | Status |
|----|-----|-------------|------------|----------|---------|--------|
| AD-L-001 | Layer | Overall Layer Architecture | `docs/architecture/diagrams/AD-L-001_Overall_Layer_Architecture.mmd` | `07_APPLICATION_ARCHITECTURE.md` | 1.0 | Frozen |
| AD-C-001 | Component | Domain Layer Components | `docs/architecture/diagrams/AD-C-001_Domain_Layer_Components.mmd` | `07_APPLICATION_ARCHITECTURE.md` | 1.0 | Frozen |
| AD-C-002 | Component | Application Layer Components | `docs/architecture/diagrams/AD-C-002_Application_Layer_Components.mmd` | `07_APPLICATION_ARCHITECTURE.md` | 1.0 | Frozen |
| AD-C-003 | Component | Presentation Layer Components | `docs/architecture/diagrams/AD-C-003_Presentation_Layer_Components.mmd` | `07_APPLICATION_ARCHITECTURE.md` | 1.0 | Frozen |
| AD-C-004 | Component | Infrastructure Layer Components | `docs/architecture/diagrams/AD-C-004_Infrastructure_Layer_Components.mmd` | `07_APPLICATION_ARCHITECTURE.md` | 1.0 | Frozen |

---

# 6 Statusdefinitionen

| Status | Bedeutung |
|--------|-----------|
| Planned | Das Diagramm ist vorgesehen, aber noch nicht erstellt. |
| Draft | Das Diagramm wurde erstellt und befindet sich in Bearbeitung. |
| Review | Das Diagramm wird fachlich und architektonisch geprüft. |
| Frozen | Das Diagramm ist freigegeben und Bestandteil einer Architekturversion. |
| Deprecated | Das Diagramm wird nicht mehr für neue Änderungen verwendet. |
| Archived | Das Diagramm wurde archiviert und dient ausschließlich der Nachvollziehbarkeit. |

---

# 7 Diagrammlebenszyklus

Architekturdiagramme durchlaufen grundsätzlich folgenden Lebenszyklus:

```text
Planned
   ↓
Draft
   ↓
Review
   ↓
Frozen
```

Bei Ablösung eines Diagramms kann der Status anschließend geändert werden zu:

```text
Deprecated
   ↓
Archived
```

Ein Diagramm darf den Status **Frozen** nur erhalten, wenn

- die Quelldatei vollständig vorliegt,
- die dargestellten Inhalte mit den Referenzdokumenten übereinstimmen,
- die Terminologie dem `11_GLOSSARY.md` entspricht,
- die zulässigen und unzulässigen Abhängigkeiten korrekt dargestellt sind,
- ein Architekturreview durchgeführt wurde.

---

# 8 Versionierung

Für jedes Architekturdiagramm gelten folgende Regeln:

- Jedes Diagramm besitzt eine eigene Versionsnummer.
- Änderungen am Inhalt erfordern eine Prüfung der Versionsnummer.
- Redaktionelle Änderungen dürfen als Patch-Version geführt werden.
- Inhaltliche Architekturänderungen erfordern mindestens eine Minor-Version.
- Grundlegende Änderungen am Diagrammzweck oder Scope erfordern eine Major-Version.
- Der Status und die Version müssen im Diagrammregister aktualisiert werden.
- Veraltete Diagramme werden nicht ohne dokumentierte Entscheidung gelöscht.

Beispiele:

```text
1.0
1.0.1
1.1
2.0
```

---

# 9 Ablagestruktur

```text
docs/
└── architecture/
    ├── diagrams/
    │   ├── AD-L-001_Overall_Layer_Architecture.mmd
    │   ├── AD-C-001_Domain_Layer_Components.mmd
    │   ├── AD-C-002_Application_Layer_Components.mmd
    │   ├── AD-C-003_Presentation_Layer_Components.mmd
    │   └── AD-C-004_Infrastructure_Layer_Components.mmd
    │
    ├── 00_ARCHITECTURE_CONVENTIONS.md
    ├── 07_APPLICATION_ARCHITECTURE.md
    ├── 08_API_GUIDE.md
    ├── 09_TEST_GUIDE.md
    ├── 10_DIAGRAM_REGISTER.md
    └── 11_GLOSSARY.md
```

---

# 10 Namenskonventionen

Diagrammdateien verwenden folgendes Schema:

```text
<Diagramm-ID>_<Bezeichnung>.mmd
```

Beispiel:

```text
AD-C-003_Presentation_Layer_Components.mmd
```

Für Dateinamen gelten folgende Regeln:

- keine Leerzeichen,
- Wörter werden durch Unterstriche getrennt,
- die Diagramm-ID steht immer am Anfang,
- die Dateiendung ist bei der führenden Quelle `.mmd`,
- Bezeichnungen entsprechen dem Eintrag im Diagrammregister.

---

# 11 Verantwortlichkeiten

Bei jeder Änderung an einem Architekturdiagramm müssen geprüft werden:

- Diagrammquelle,
- Referenzdokument,
- Diagrammregister,
- Glossar,
- betroffene Architekturregeln,
- betroffene Architecture Principles.

Die Person, die ein Diagramm ändert, ist auch für die Aktualisierung des Diagrammregisters verantwortlich.

---

# 12 Pflegecheckliste

Vor der Freigabe eines Diagramms ist zu prüfen:

- [ ] Diagramm-ID ist eindeutig.
- [ ] Dateiname entspricht der Namenskonvention.
- [ ] Mermaid-Syntax ist gültig.
- [ ] Diagramm wird korrekt dargestellt.
- [ ] Zweck und Scope sind eindeutig.
- [ ] Begriffe entsprechen dem Glossar.
- [ ] Beziehungen entsprechen der textlichen Architektur.
- [ ] Es sind keine unzulässigen Abhängigkeiten dargestellt.
- [ ] Referenzdokument ist korrekt angegeben.
- [ ] Version und Status sind aktuell.
- [ ] Diagrammregister wurde aktualisiert.
- [ ] Architekturreview wurde durchgeführt.

---

# 13 Architecture Principles

Das Diagrammregister unterstützt insbesondere folgende projektweiten Architecture Principles:

- AP-001 – Domain First
- AP-002 – Single Source of Truth
- AP-004 – Clean Architecture
- AP-005 – Dependency Inversion

---

# 14 Architecture Rules

Das Diagrammregister konkretisiert insbesondere:

- AR-001 – Dependency Rule
- AR-002 – Domain Independence
- AR-005 – Layer Responsibility

---

# 15 Referenzen

Dieses Dokument verwendet folgende Referenzdokumente:

- `00_ARCHITECTURE_CONVENTIONS.md`
- `07_APPLICATION_ARCHITECTURE.md`
- `08_API_GUIDE.md`
- `09_TEST_GUIDE.md`
- `11_GLOSSARY.md`

---

# 16 Status

**Version:** 1.0

**Status:** Frozen

Dieses Dokument erhält den Status **Frozen**, sobald alle fünf aktuell registrierten Architekturdiagramme geprüft und freigegeben wurden.