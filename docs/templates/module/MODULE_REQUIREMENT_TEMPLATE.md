# MODULE_REQUIREMENT_TEMPLATE.md

> Standardvorlage für Functional Requirements (FR)

---

# Zweck

Diese Vorlage definiert den verbindlichen Aufbau einer **Functional Requirement (FR)** innerhalb von HealthTracker.

Alle Module verwenden ausschließlich diese Struktur.

Dadurch werden Anforderungen

- einheitlich,
- nachvollziehbar,
- testbar,
- implementierbar
- und wartbar.

---

# Allgemeine Regeln

Jede Functional Requirement

- besitzt eine eindeutige ID.
- beschreibt genau **eine** fachliche Anforderung.
- enthält keine Implementierungsdetails.
- ist eindeutig testbar.
- besitzt mindestens einen Use Case.
- besitzt mindestens eine Business Rule.
- besitzt mindestens einen Test Case.

---

# Kennung

```
<MODUL>-FR-XXX
```

Beispiele

```
PRO-FR-001
MEA-FR-014
MED-FR-008
ANA-FR-021
```

---

# Priorität (MoSCoW)

| Kürzel | Bedeutung |
|---------|-----------|
| M | Must |
| S | Should |
| C | Could |
| W | Won't (für diese Version) |

---

# Status

| Status | Bedeutung |
|---------|-----------|
| Draft | Entwurf |
| In Review | Fachliche Prüfung |
| Approved | Freigegeben |
| Implemented | Umgesetzt |
| Verified | Erfolgreich getestet |
| Deprecated | Veraltet |

---

# Vorlage

```markdown
## <MODUL>-FR-XXX

### Titel

<Name der Anforderung>

---

## Metadaten

| Feld | Wert |
|------|------|
| ID | PRO-FR-001 |
| Modul | PRO |
| Priorität | Must |
| Status | Draft |
| Version | 1.0 |
| Autor | |
| Reviewer | |
| Freigegeben | |
| Letzte Änderung | |

---

## Kurzbeschreibung

Eine kurze Zusammenfassung der Anforderung.

---

## Motivation

Warum wird diese Funktion benötigt?

Welchen Nutzen hat sie?

---

## Fachliche Beschreibung

Detaillierte Beschreibung der Anforderung.

Die Beschreibung muss vollständig und eindeutig sein.

---

## Vorbedingungen

Welche Bedingungen müssen erfüllt sein?

Beispiele

- Profil existiert.
- Benutzer ist angemeldet.
- Aktives Profil vorhanden.

---

## Nachbedingungen

Welche Zustände gelten nach erfolgreicher Ausführung?

Beispiele

- Profil wurde gespeichert.
- Dashboard wurde aktualisiert.
- Ereignis wurde ausgelöst.

---

## Fehlerfälle

Mögliche Fehler.

Beispiele

- ungültige Eingaben
- Profil nicht vorhanden
- Authentifizierung fehlgeschlagen

---

## Akzeptanzkriterien

Die Anforderung gilt als erfüllt, wenn

- ...
- ...
- ...

Alle Kriterien müssen objektiv überprüfbar sein.

---

## Qualitätsattribute

Welche Qualitätsziele werden beeinflusst?

Beispiele

- Performance
- Sicherheit
- Wartbarkeit
- Datenschutz
- Benutzbarkeit

---

## Risiken

Welche Risiken bestehen?

Beispiele

- Datenverlust
- falsche Eingaben
- Sicherheitsrisiken

---

## Annahmen

Welche Annahmen liegen dieser Anforderung zugrunde?

---

## Abhängigkeiten

Von welchen Modulen oder Anforderungen hängt diese Anforderung ab?

Beispiele

- Security
- Persistence
- Dashboard

---

## Verknüpfte Artefakte

### Use Cases

- PRO-UC-001

### Business Rules

- PRO-BR-001

### Validation Rules

- PRO-VR-001

### Events

- PRO-EV-001

### Interfaces

- PRO-IF-001

### Module API

- PRO-API-001

### Test Cases

- PRO-TC-001

### Qualitätsattribute

- PRO-QA-001

### Architekturentscheidungen

- ADR-001

---

## Hinweise

Weitere Informationen.

Links zu anderen Dokumenten.

Besondere Randbedingungen.
```

---

# Schreibregeln

Functional Requirements verwenden folgende Formulierungen.

## Muss

> Das System **muss** …

Verbindliche Anforderung.

---

## Soll

> Das System **soll** …

Empfohlene Anforderung.

---

## Kann

> Das System **kann** …

Optionale Erweiterung.

---

## Nicht zulässig

Unklare Formulierungen wie

- eventuell
- möglichst
- normalerweise
- bei Bedarf
- ungefähr

sind zu vermeiden.

---

# Qualitätskriterien

Eine Functional Requirement ist nur gültig, wenn sie

- eindeutig,
- vollständig,
- widerspruchsfrei,
- verständlich,
- überprüfbar,
- umsetzbar,
- nachvollziehbar

ist.

---

# Review-Checkliste

Vor der Freigabe sind folgende Fragen zu beantworten.

- Ist die Anforderung eindeutig?
- Ist sie fachlich korrekt?
- Ist sie testbar?
- Ist sie ohne Implementierungsdetails formuliert?
- Existieren Akzeptanzkriterien?
- Sind alle Verknüpfungen vorhanden?
- Ist die Traceability vollständig?
- Wurde die Anforderung reviewed?

Nur wenn alle Fragen mit **Ja** beantwortet werden können, erhält die Anforderung den Status **Approved**.