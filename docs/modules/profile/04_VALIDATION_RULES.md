# 04_VALIDATION_RULES.md

> Modul: Profile

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-PRO-VR-001 |
| Dokumenttyp | Modulspezifikation |
| Modul | Profile |
| Version | 1.0.0 |
| Status | Draft |
| Owner | HealthTracker Team |
| Reviewer | HealthTracker Team |
| Letzte Änderung | 2026-08-01 |
| Reviewintervall | Bei jeder fachlichen Änderung |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|---------|-------|----------|-------|-------|
| 1.0.0 | 2026-08-01 | Erste Version | Zentrale Definition der Validierungsregeln des Profilmoduls | HealthTracker Team |

---

# Zweck

Dieses Dokument definiert sämtliche fachlichen Validierungsregeln des Moduls **Profile**.

Die Validierungsregeln stellen sicher, dass ausschließlich fachlich gültige, konsistente und vollständige Profildaten dauerhaft gespeichert werden.

Sie gelten unabhängig von

- Benutzeroberfläche
- Plattform
- Persistenz
- API
- Import
- Export
- zukünftigen Clients

Die Domainvalidierung besitzt stets Vorrang.

Validierungen in der Benutzeroberfläche dienen ausschließlich der frühzeitigen Benutzerunterstützung und ersetzen niemals die Domainvalidierung.

---

# Ziele

Dieses Dokument definiert

- Pflichtfelder
- Wertebereiche
- Formatprüfungen
- Plausibilitätsprüfungen
- Cross-Field-Validierungen
- Normalisierungsregeln
- Fehlercodes
- Message Keys
- Fehlerparameter
- Schweregrade
- Warnungen

Die Spezifikation bildet die Grundlage für

- Requirements
- Use Cases
- Business Rules
- Domainmodell
- Implementierung
- API-Verträge
- Testfälle
- Dokumentation

---

# Geltungsbereich

Dieses Dokument gilt ausschließlich für das Modul **Profile**.

Es beschreibt Validierungsregeln für

- Profilname
- Geburtsjahr
- Körpergröße
- Geschlecht
- Profilfarbe
- Passwort
- Profilbild
- Profilstatus
- Profil-ID
- Import
- Export
- Initialzustand

Nicht Bestandteil dieses Dokuments sind

- fachliche Dashboard-Inhalte und Dashboard-Auswertungen anderer Module
- Ernährung
- Messwerte
- Medikamente
- Geräte
- Auswertungen
- Empfehlungen

Profilbezogene Dashboard-Präferenzen wie Auswahl, Sichtbarkeit und Anordnung
sind Bestandteil des `Profile`-Aggregates und werden in diesem Dokument
validiert.

---

# Grundprinzipien

## PRO-VP-001 – Zentrale Validierung

Alle fachlichen Validierungsregeln werden ausschließlich innerhalb der Domain implementiert.

Benutzeroberflächen dürfen dieselben Regeln verwenden, um dem Benutzer bereits während der Eingabe Rückmeldungen zu geben.

Die endgültige Entscheidung über die Gültigkeit einer Eingabe trifft immer die Domain.

Dadurch wird sichergestellt, dass

- alle Clients identisches Verhalten zeigen,
- keine Plattform abweichende Regeln implementiert,
- sämtliche Persistenzvorgänge identisch validiert werden.

---

## PRO-VP-002 – Sprachunabhängige Validierung

Die Domain erzeugt niemals lokalisierte Fehlermeldungen.

Sie liefert ausschließlich

- Fehlercode
- Message Key
- Schweregrad
- Feldreferenz
- Constraint
- Parameter

Die eigentliche Übersetzung erfolgt ausschließlich über das zentrale Internationalisierungssystem (i18n/l10n).

Dadurch bleiben

- Domain
- REST-API
- Flutter-App
- Web-App
- automatisierte Tests
- Logging
- Monitoring

vollständig sprachunabhängig.

---

## PRO-VP-003 – Keine Speicherung ungültiger Daten

Ungültige Daten dürfen niemals dauerhaft gespeichert werden.

Existiert mindestens ein Validierungsfehler,

- DARF keine Persistierung erfolgen.
- DARF keine Teilpersistierung erfolgen.
- DARF kein inkonsistenter Zustand entstehen.

Dieses Prinzip gilt unabhängig davon, über welchen Client die Daten eingegeben wurden.

---

## PRO-VP-004 – Feldbezogene Validierungsfehler

Jeder Validierungsfehler wird genau einem fachlichen Eingabefeld zugeordnet.

Ein Feld kann

- keinen Fehler,
- einen Fehler,
- mehrere Fehler

gleichzeitig besitzen.

Mehrere Felder dürfen gleichzeitig Fehler enthalten.

Die Reihenfolge der Fehler besitzt keine fachliche Bedeutung.

---

## PRO-VP-005 – Warnungen

Warnungen unterscheiden sich fachlich von Fehlern.

Warnungen

- verhindern das Speichern grundsätzlich nicht,
- weisen den Benutzer auf mögliche Auffälligkeiten hin,
- können bewusst bestätigt werden.

Beispiel

- doppelter Profilname

Warnungen besitzen dieselbe technische Struktur wie Fehler, unterscheiden sich jedoch ausschließlich durch ihren Schweregrad (`WARNING`).

---

# Fortsetzung

Teil **1B** enthält:

- PRO-VP-006 – Fehler
- PRO-VP-007 – Stabilität von Fehlercodes
- PRO-VP-008 – Atomare Fachoperationen
- PRO-VP-009 – Standardisierte Validierungsfehler
- Schweregrade
- Standardaufbau einer Validierungsregel
- Beginn der fachlichen Validierungsregeln

## PRO-VP-006 – Fehler

Fehler verhindern grundsätzlich die erfolgreiche Ausführung einer fachlichen Operation.

Solange mindestens ein Fehler mit dem Schweregrad **ERROR** vorliegt,

- DARF keine Persistierung erfolgen.
- DARF keine Teilpersistierung erfolgen.
- DARF keine Folgeoperation gestartet werden.

Eine Operation gilt erst dann als erfolgreich abgeschlossen, wenn keine Fehler mehr vorhanden sind.

---

## PRO-VP-007 – Stabilität von Fehlercodes

Fehlercodes sind Bestandteil der öffentlichen fachlichen Schnittstelle zwischen

- Domain
- Benutzeroberfläche
- REST-API
- Import/Export
- Logging
- Monitoring
- automatisierten Tests
- Audit

Deshalb gelten folgende Regeln:

- Ein veröffentlichter Fehlercode DARF niemals seine fachliche Bedeutung ändern.
- Ein veröffentlichter Fehlercode DARF niemals erneut vergeben werden.
- Ein veröffentlichter Fehlercode DARF nicht gelöscht werden.
- Wird eine Validierungsregel entfernt, bleibt ihr Fehlercode dauerhaft reserviert.
- Neue Validierungsregeln erhalten immer neue Fehlercodes.
- Message Keys dürfen angepasst werden.
- Übersetzungen dürfen jederzeit geändert werden.

Dadurch bleiben

- APIs stabil,
- Tests reproduzierbar,
- Logdateien auswertbar,
- ältere Daten kompatibel.

---

## PRO-VP-008 – Atomare Fachoperationen

Mehrstufige fachliche Operationen werden atomar ausgeführt.

Es gilt immer genau eine der beiden Möglichkeiten:

- Die gesamte Operation wird erfolgreich abgeschlossen.
- Die gesamte Operation wird vollständig zurückgerollt.

Teilweise ausgeführte Operationen sind unzulässig.

Dieses Prinzip gilt insbesondere für

- Profil anlegen
- Profil bearbeiten
- Profil löschen
- Profil importieren
- Profil wiederherstellen
- Herstellung des Initialzustands
- zukünftige Batch-Operationen

Die technische Umsetzung erfolgt transaktional entsprechend der verwendeten Persistenztechnologie.

---

## PRO-VP-009 – Standardisierte Validierungsfehler

Jeder Validierungsfehler besitzt dieselbe fachliche Struktur.

### Pflichtfelder

| Feld | Beschreibung |
|------|--------------|
| errorCode | Fachlicher Fehlercode |
| messageKey | Schlüssel für die Übersetzung |
| severity | Schweregrad |
| field | Betroffenes Eingabefeld |
| constraint | Verletzte Validierungsregel |
| parameters | Fachliche Parameter |

---

### Zulässige Schweregrade

- ERROR
- WARNING
- INFORMATION

---

### Constraint

Das Feld **constraint** beschreibt die verletzte Regel unabhängig vom Fehlercode.

Typische Werte sind

- required
- minimum
- maximum
- range
- duplicate
- format
- pattern
- invalid
- immutable
- forbidden

Dadurch können Benutzeroberflächen, APIs und Tests Fehler unabhängig vom eigentlichen Fehlercode auswerten.

---

### Parameter

Parameter enthalten ausschließlich fachliche Informationen.

Parameter dürfen enthalten

- Zahlen
- Datumswerte
- UUIDs
- Einheiten
- Listen
- erlaubte Werte
- Grenzwerte
- Laufzeitwerte

Parameter dürfen niemals enthalten

- lokalisierte Texte
- formatierte Ausgaben
- HTML
- Markdown

---

### Regeln für Parameter

Parameter werden grundsätzlich strukturiert übertragen.

Es gelten folgende Regeln:

- Zahlen werden numerisch übertragen.
- Listen werden als Arrays übertragen.
- Datumswerte verwenden ISO-8601.
- Uhrzeiten verwenden UTC.
- UUIDs werden als Strings übertragen.
- Einheiten werden getrennt vom Zahlenwert gespeichert.
- Wahrheitswerte werden als Boolean übertragen.

---

### Beispiele

#### Mindestgröße

```json
{
  "minimum": 20,
  "unit": "cm"
}
```

#### Maximale Dateigröße

```json
{
  "maxSizeBytes": 2097152
}
```

#### Unterstützte Bildformate

```json
{
  "supportedFormats": [
    "JPEG",
    "PNG",
    "WebP"
  ]
}
```

#### Erwartetes ID-Format

```json
{
  "expectedFormat": "UUIDv7"
}
```

---

### Standardstruktur einer Fehlerrückgabe

```json
{
  "errorCode": "PRO-VAL-HEIGHT-003",
  "messageKey": "validation.profile.height.minimum",
  "severity": "ERROR",
  "field": "height",
  "constraint": "minimum",
  "parameters": {
    "minimum": 20,
    "unit": "cm"
  }
}
```

Die Benutzeroberfläche erzeugt daraus die sprachabhängige Fehlermeldung.

Deutsch

> Die Körpergröße muss mindestens 20 cm betragen.

Englisch

> Height must be at least 20 cm.

Grenzwerte, Einheiten und Formate werden niemals Bestandteil der Übersetzung.

---

# Schweregrade

| Wert | Bedeutung |
|------|-----------|
| ERROR | Speicherung oder Operation nicht zulässig |
| WARNING | Operation nach ausdrücklicher Bestätigung zulässig |
| INFORMATION | Reiner Hinweis ohne Einschränkung |

---

# Standardaufbau einer Validierungsregel

Alle Validierungsregeln dieses Dokuments besitzen denselben Aufbau.

```text
PRO-VR-xxx

Titel

Typ

Beschreibung

Fachliche Regeln

Normalisierung (optional)

Fehlercodes

Traceability
```

---

# Beginn der fachlichen Validierungsregeln

Die folgenden Kapitel definieren die konkreten Validierungsregeln des Profilmoduls.

# PRO-VR-001

## Titel

Profilname validieren

### Typ

Pflichtfeld

### Beschreibung

Jedes Profil besitzt einen frei wählbaren sichtbaren Namen.

Der Profilname dient der Anzeige und der Unterscheidung durch den Benutzer. Die fachliche Identität eines Profils wird ausschließlich durch die Profil-ID bestimmt.

### Fachliche Regeln

Der Profilname

- MUSS vorhanden sein.
- DARF nach der Normalisierung nicht leer sein.
- DARF nach der Normalisierung nicht ausschließlich aus Leerzeichen bestehen.

Eine maximale Zeichenlänge ist derzeit fachlich nicht festgelegt.

### Normalisierung

Vor der Validierung werden

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Leerzeichen innerhalb des Namens und die Groß-/Kleinschreibung bleiben unverändert erhalten.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-NAME-001 | `validation.profile.name.required` | required | – |
| PRO-VAL-NAME-002 | `validation.profile.name.blank` | blank | – |

### Traceability

**Requirements**

- PRO-FR-011
- PRO-FR-021
- PRO-FR-022

**Use Cases**

- PRO-UC-011
- PRO-UC-021
- PRO-UC-022

**Business Rules**

- PRO-BR-010

**Testfälle**

- PRO-TC-011
- PRO-TC-021
- PRO-TC-022


# PRO-VR-002

## Titel

Geburtsjahr validieren

### Typ

Pflichtfeld

### Beschreibung

Für jedes Profil wird ausschließlich das Geburtsjahr als vierstellige Jahreszahl gespeichert.

### Fachliche Regeln

Das Geburtsjahr

- MUSS mindestens 1900 betragen.
- DARF nicht in der Zukunft liegen.

Die Obergrenze entspricht dynamisch dem aktuellen Kalenderjahr.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-BIRTHYEAR-001 | `validation.profile.birthYear.required` | required | – |
| PRO-VAL-BIRTHYEAR-002 | `validation.profile.birthYear.format` | format | `{"expectedFormat":"YYYY"}` |
| PRO-VAL-BIRTHYEAR-003 | `validation.profile.birthYear.minimum` | minimum | `{"minimum":1900}` |
| PRO-VAL-BIRTHYEAR-004 | `validation.profile.birthYear.future` | maximum | `{"maximum":"currentYear"}` |


### Traceability

**Requirements**

- PRO-FR-012
- PRO-FR-021
- PRO-FR-022

**Use Cases**

- PRO-UC-012
- PRO-UC-021
- PRO-UC-022

**Testfälle**

- PRO-TC-012
- PRO-TC-021
- PRO-TC-022


# PRO-VR-003

## Titel

Körpergröße validieren

### Typ

Pflichtfeld

### Beschreibung

Die Körpergröße wird in Zentimetern gespeichert.

### Fachliche Regeln

Die Körpergröße

- MUSS vorhanden sein.
- MUSS in Zentimetern angegeben werden.
- MUSS mindestens 20 cm betragen.
- DARF höchstens 300 cm betragen.


### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-HEIGHT-001 | `validation.profile.height.required` | required | – |
| PRO-VAL-HEIGHT-002 | `validation.profile.height.maximum` | maximum | `{"maximum":300,"unit":"cm"}` |
| PRO-VAL-HEIGHT-003 | `validation.profile.height.minimum` | minimum | `{"minimum":20,"unit":"cm"}` |

### Traceability

**Requirements**

- PRO-FR-013
- PRO-FR-021
- PRO-FR-022

**Use Cases**

- PRO-UC-013
- PRO-UC-021
- PRO-UC-022

**Testfälle**

- PRO-TC-013
- PRO-TC-021
- PRO-TC-022


# PRO-VR-004

## Titel

Geschlecht validieren

### Typ

Optionale Enumerationsvalidierung

### Beschreibung

`Gender` beschreibt die optionale fachliche Geschlechtsangabe eines Profils.

Nicht vorhandene oder leere Werte werden fachlich als `unspecified`
behandelt.

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<Gender> Gender.fromString(
  String? value
)
```

### Fachliche Regeln

Für `Gender.fromString(...)` gilt:

- Ist `value` nicht vorhanden, wird `Gender.unspecified` erzeugt.
- Ist `value` leer oder nach dem Trimmen leer, wird
  `Gender.unspecified` erzeugt.
- Ist ein nicht leerer Wert vorhanden, MUSS er exakt einem unterstützten
  Wert entsprechen.
- Unterstützte Werte sind ausschließlich:

```text
male
female
diverse
unspecified
```

- Groß- und Kleinschreibung werden nicht automatisch verändert.
- Ein unbekannter Wert DARF nicht automatisch durch `unspecified` ersetzt
  werden.

### Normalisierung

Vor der Auswertung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-GENDER-001 | `validation.profile.gender.invalid` | ERROR | VALIDATION | value | enum | `{"allowedValues":["male","female","diverse","unspecified"]}` |

### Fehlerverhalten

#### Fehlender oder leerer Wert

Ist `value`

- nicht vorhanden,
- leer,
- oder nach dem Trimmen leer,

wird erfolgreich

```text
Gender.unspecified
```

erzeugt.

Es wird kein Validation Error erzeugt.

#### Ungültiger Enumerationswert

Entspricht der normalisierte, vorhandene und nicht leere Wert keinem
unterstützten Wert, wird

```text
PRO-VAL-GENDER-001
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "allowedValues": [
    "male",
    "female",
    "diverse",
    "unspecified"
  ]
}
```

Der ungültige Eingabewert wird nicht als Fehlerparameter übertragen.

### Validierungsreihenfolge

1. Vorhandensein prüfen.
2. Trimmen.
3. Fehlenden oder leeren Wert als `unspecified` behandeln.
4. Unterstützten Enumerationswert prüfen.
5. Gültigen `Gender`-Wert erzeugen.

### Traceability

**Requirements**

- PRO-FR-014
- PRO-FR-021

**Use Cases**

- PRO-UC-014
- PRO-UC-021

**Testfälle**

- PRO-TC-014
- PRO-TC-021

**Domain Model**

- `Gender`
- `Gender.fromString(...)`
- `Profile.gender`

# PRO-VR-005

## Titel

Profilfarbe validieren

### Typ

Pflichtfeld

### Beschreibung

Jedes Profil besitzt eine individuelle Profilfarbe.

Die Profilfarbe dient ausschließlich der visuellen Zuordnung eines Profils. Sie darf nicht zur Darstellung fachlicher Bewertungen, Warnungen oder Statuswerte verwendet werden.

### Fachliche Regeln

### Fachliche Regeln

Die Profilfarbe

- MUSS vorhanden sein.
- MUSS einen gültigen Farbwert repräsentieren.
- MUSS dauerhaft gespeichert werden können.
- DARF jederzeit geändert werden.
- DARF die systemweiten Bereichs- und Statusfarben nicht verändern.

Die Domain definiert keine feste Liste zulässiger Profilfarben.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-COLOR-001 | `validation.profile.color.required` | required | – |
| PRO-VAL-COLOR-002 | `validation.profile.color.invalid` | format | – |

### Traceability

**Requirements**

- PRO-FR-016
- PRO-FR-021
- PRO-FR-022

**Use Cases**

- PRO-UC-016
- PRO-UC-021
- PRO-UC-022

**Testfälle**

- PRO-TC-016
- PRO-TC-021
- PRO-TC-022


- PRO-VR-006 – Passwort
- PRO-VR-007 – Passwortbestätigung
- PRO-VR-008 – Aktuelles Passwort
- PRO-VR-009 – Doppelte Profilnamen
- PRO-VR-010 – Profilbild
- PRO-VR-011 – Profil-ID
- PRO-VR-012 – Profilstatus
- PRO-VR-013 – Standardprofil
- PRO-VR-014 – Zeitstempel
- PRO-VR-015 – Profilimport
- PRO-VR-016 – Profilexport

---

# Status dieses Teils

Mit Teil 1A und Teil 1B sind vollständig definiert:

- Dokumentinformationen
- Zweck
- Ziele
- Geltungsbereich
- **PRO-VP-001 bis PRO-VP-009**
- Schweregrade
- Standardisierte Validierungsfehler
- Standardaufbau einer Validierungsregel

Ab **PRO-VR-001** beginnen die konkreten fachlichen Validierungsregeln.

# PRO-VR-006

## Titel

Passwort validieren

### Typ

Bedingtes Pflichtfeld

### Beschreibung

Ist der Passwortschutz eines Profils aktiviert, muss ein fachlich gültiges Passwort angegeben werden.

### Fachliche Regeln

Das Passwort

- MUSS vorhanden sein.
- MUSS mindestens 12 Zeichen enthalten.
- DARF nicht ausschließlich aus Leerzeichen bestehen.
- DARF nicht mit dem Profilnamen identisch sein.
- MUSS gemeinsam mit einer Passwortbestätigung eingegeben werden.

### Hinweise

Technische Sicherheitsanforderungen werden ausschließlich im **SECURITY_GUIDE.md** definiert.

Dazu gehören insbesondere

- Passwortkomplexität
- Hashverfahren
- Passwort-Historie
- Blacklists
- kompromittierte Passwörter
- Rate Limiting
- Lockout-Regeln

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-PWD-001 | `validation.profile.password.required` | required | – |
| PRO-VAL-PWD-002 | `validation.profile.password.minLength` | minimum | `{"minimum":12,"unit":"characters"}` |
| PRO-VAL-PWD-003 | `validation.profile.password.blank` | blank | – |
| PRO-VAL-PWD-004 | `validation.profile.password.equalsProfileName` | forbidden | – |

### Traceability

**Requirements**

- PRO-FR-017
- PRO-FR-019
- PRO-FR-021

**Use Cases**

- PRO-UC-017
- PRO-UC-019
- PRO-UC-021

**Business Rules**

- PRO-BR-018
- PRO-BR-019

**Testfälle**

- PRO-TC-017
- PRO-TC-019
- PRO-TC-021

---

# PRO-VR-007

## Titel

Passwortbestätigung validieren

### Typ

Bedingtes Pflichtfeld

### Beschreibung

Bei jeder Passwortvergabe oder Passwortänderung muss die Passwortbestätigung exakt mit dem Passwort übereinstimmen.

### Fachliche Regeln

Die Passwortbestätigung

- MUSS vorhanden sein.
- MUSS exakt mit dem Passwort übereinstimmen.
- Berücksichtigt Groß-/Kleinschreibung.
- DARF nicht dauerhaft gespeichert werden.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-PWDCONF-001 | `validation.profile.passwordConfirmation.required` | required | – |
| PRO-VAL-PWDCONF-002 | `validation.profile.passwordConfirmation.mismatch` | equal | – |

### Traceability

**Requirements**

- PRO-FR-017
- PRO-FR-019

**Use Cases**

- PRO-UC-017
- PRO-UC-019

**Business Rules**

- PRO-BR-018
- PRO-BR-019

**Testfälle**

- PRO-TC-017
- PRO-TC-019

---

# PRO-VR-008

## Titel

Aktuelles Passwort validieren

### Typ

Sicherheitsrelevante Validierung

### Beschreibung

Bestimmte Profilaktionen dürfen nur nach erfolgreicher Authentifizierung durchgeführt werden.

### Gilt für

- Passwort ändern
- Passwortschutz deaktivieren
- geschütztes Profil entsperren
- zukünftige sicherheitskritische Funktionen

### Fachliche Regeln

Das aktuelle Passwort

- MUSS vorhanden sein.
- MUSS erfolgreich verifiziert werden.
- DARF weder gespeichert noch protokolliert werden.
- DARF nicht Bestandteil von Audit-Daten sein.

### Hinweise

Die technische Authentifizierung erfolgt gemäß **SECURITY_GUIDE.md**.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-CURPWD-001 | `validation.profile.currentPassword.required` | required | – |
| PRO-VAL-CURPWD-002 | `validation.profile.currentPassword.invalid` | valid | – |

### Traceability

**Requirements**

- PRO-FR-018
- PRO-FR-019
- PRO-FR-020

**Use Cases**

- PRO-UC-018
- PRO-UC-019
- PRO-UC-020

**Business Rules**

- PRO-BR-019
- PRO-BR-020

**Testfälle**

- PRO-TC-018
- PRO-TC-019
- PRO-TC-020

---

# PRO-VR-009

## Titel

Doppelte Profilnamen validieren

### Typ

Warning

### Beschreibung

Mehrere Profile dürfen denselben sichtbaren Namen besitzen.

### Fachliche Regeln

Vor dem Speichern wird geprüft,

- identischer Profilname,
- Unterschiede ausschließlich in der Groß-/Kleinschreibung,
- Unterschiede ausschließlich durch Leerzeichen.

### Verhalten

Bei einem Treffer

- wird eine Warnung erzeugt,
- bleibt das Speichern zulässig,
- entscheidet ausschließlich der Benutzer über die Fortsetzung.

Die eindeutige Profil-ID bleibt maßgeblich.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-DUPNAME-001 | `validation.profile.name.duplicate` | duplicate | `{"existingProfileCount":2}` |

### Traceability

**Requirements**

- PRO-FR-023

**Use Cases**

- PRO-UC-023

**Business Rules**

- PRO-BR-014

**Testfälle**

- PRO-TC-023

---

# PRO-VR-010

## Titel

Profilbild validieren

### Typ

Optional

### Beschreibung

Profilbilder müssen datenschutzkonform verarbeitet werden.

### Fachliche Regeln

Das Profilbild

- MUSS ein unterstütztes Bildformat besitzen.
- MUSS lesbar sein.
- MUSS tatsächlich Bilddaten enthalten.
- SOLL automatisch skaliert werden.
- SOLL komprimiert werden.
- MUSS von EXIF-Metadaten bereinigt werden.
- DARF keine Standortinformationen enthalten.

### Unterstützte Formate

- JPEG
- PNG
- WebP

### Zielwerte

| Eigenschaft | Wert |
|------------|------|
| Maximale Auflösung | 512 × 512 Pixel |
| Maximale Dateigröße | 2 MB |

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-IMG-001 | `validation.profile.image.invalidFormat` | format | `{"supportedFormats":["JPEG","PNG","WebP"]}` |
| PRO-VAL-IMG-002 | `validation.profile.image.notReadable` | readable | – |
| PRO-VAL-IMG-003 | `validation.profile.image.tooLarge` | maximum | `{"maxSizeBytes":2097152}` |
| PRO-VAL-IMG-004 | `validation.profile.image.processingFailed` | processing | – |

### Traceability

**Requirements**

- PRO-FR-015

**Use Cases**

- PRO-UC-015

**Business Rules**

- PRO-BR-017

**Testfälle**

- PRO-TC-015

---

# PRO-VR-011

## Titel

Profil-ID validieren

### Typ

Systemvalidierung

### Beschreibung

Jedes Profil besitzt eine unveränderliche und systemweit eindeutige Identität.

### Fachliche Regeln

Die Profil-ID

- MUSS vorhanden sein.
- MUSS dem definierten Format entsprechen.
- DARF nach der Erstellung nicht verändert werden.
- DARF nur einmal vergeben werden.
- MUSS bei jedem Import auf Konflikte geprüft werden.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-ID-001 | `validation.profile.id.required` | required | – |
| PRO-VAL-ID-002 | `validation.profile.id.invalidFormat` | format | `{"expectedFormat":"UUIDv7"}` |
| PRO-VAL-ID-003 | `validation.profile.id.modified` | immutable | – |
| PRO-VAL-ID-004 | `validation.profile.id.duplicate` | duplicate | `{"duplicateId":"<uuid>"}` |

### Traceability

**Requirements**

- PRO-FR-001
- PRO-FR-003
- PRO-FR-025

**Use Cases**

- PRO-UC-001
- PRO-UC-003
- PRO-UC-025

**Business Rules**

- PRO-BR-006
- PRO-BR-023

**Testfälle**

- PRO-TC-001
- PRO-TC-003
- PRO-TC-025

---

# Status dieses Teils

Mit Teil 2 sind vollständig spezifiziert:

- PRO-VR-006 – Passwort validieren
- PRO-VR-007 – Passwortbestätigung validieren
- PRO-VR-008 – Aktuelles Passwort validieren
- PRO-VR-009 – Doppelte Profilnamen validieren
- PRO-VR-010 – Profilbild validieren
- PRO-VR-011 – Profil-ID validieren

Alle Validierungsfehler entsprechen den Architekturprinzipien **PRO-VP-001 bis PRO-VP-009** und verwenden eine einheitliche, strukturierte Fehlerrückgabe.

---

# Teil 3

Der nächste Abschnitt enthält:

- PRO-VR-012 – Profilstatus validieren
- PRO-VR-013 – Standardprofil validieren
- PRO-VR-014 – Zeitstempel validieren
- PRO-VR-015 – Profilimport validieren
- PRO-VR-016 – Profilexport validieren
- Validierungsreihenfolge
- Cross-Field-Validierungen

# PRO-VR-012

## Titel

Profilstatus validieren

### Typ

Systemvalidierung

### Beschreibung

Der Profilstatus beschreibt ausschließlich den fachlichen Lebenszyklus eines
Profils.

Der Lebenszyklusstatus wird durch die Enumeration

```text
ProfileStatus
```

repräsentiert.

Der Sperrzustand eines Profils wird getrennt davon durch

```text
LockState
```

beziehungsweise

```text
ProfileLockStatus
```

modelliert.

Lebenszyklusstatus und Sperrzustand dürfen nicht miteinander vermischt
werden.

### Kontrollierte Rekonstruktion

Die kontrollierte Rekonstruktion eines einzelnen Lebenszyklusstatus erfolgt
über:

```text
DomainResult<ProfileStatus> ProfileStatus.fromString(
  String? value
)
```

Vor der Validierung werden ausschließlich führende und nachfolgende
Leerzeichen entfernt.

Die Groß- und Kleinschreibung wird nicht verändert.

Ein fehlender, leerer oder nach dem Trimmen leerer Wert wird als fehlender
Status behandelt.

### Zulässige Status

```text
inactive
active
archived
```

### Fachliche Regeln

Der Profilstatus

- MUSS vorhanden sein.
- MUSS einem definierten Wert der Enumeration `ProfileStatus` entsprechen.
- DARF niemals mehrere Lebenszyklusstatus gleichzeitig besitzen.
- DARF keinen Sperrstatus repräsentieren.

Die Werte

```text
locked
unlocked
```

sind keine Werte von `ProfileStatus`.

Sie gehören ausschließlich zum fachlichen Sperrzustand.

### Statusübergänge

Für den Lebenszyklus gelten insbesondere folgende Übergänge:

| Ausgangszustand | Operation | Zielzustand |
|-----------------|-----------|-------------|
| inactive | activate | active |
| active | deactivate | inactive |
| inactive | archive | archived |
| active | archive | archived |
| archived | restore | inactive |

Ein Übergang ist ungültig, wenn er durch das Domain Model nicht zugelassen
ist.

Beispiele:

- Ein archiviertes Profil darf nicht direkt aktiviert werden.
- Ein nicht archiviertes Profil darf nicht wiederhergestellt werden.
- Ein nicht zulässiger Zielstatus darf nicht übernommen werden.

### No-Change-Abgrenzung

Die folgenden Situationen sind keine Validierungsfehler:

- `activate()` bei bereits aktivem Profil,
- `deactivate()` bei bereits inaktivem Profil,
- `archive()` bei bereits archiviertem Profil.

Diese Fälle können entsprechend dem Domain Model als erfolgreicher
No-Change behandelt werden.

No-Change-Ergebnisse werden getrennt von Validation Errors dokumentiert.

### Cross-Field- und Aggregate-Regeln

Das Zusammenspiel zwischen Lebenszyklusstatus und Sperrzustand wird nicht
durch die Enumeration `ProfileStatus` allein validiert.

Insbesondere gelten auf Aggregate-Ebene:

- Ein gesperrtes Profil darf nicht aktiv sein.
- Ein gesperrtes Profil muss vor einer Aktivierung entsperrt werden.
- Ein archiviertes Profil darf nicht aktiviert werden.
- Ein archiviertes Profil darf nicht durch eine reguläre
  Aktivierungsoperation reaktiviert werden.

Diese Regeln werden durch

- das `Profile`-Aggregate,
- `ProfileSecurity`,
- `LockState`,
- zuständige Business Rules,
- Specifications und Domain Services

geschützt.

Sie erzeugen nicht automatisch einen zusätzlichen
`ProfileStatus`-Enum-Fehler.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-STATUS-001 | `validation.profile.status.required` | ERROR | VALIDATION | status | required | – |
| PRO-VAL-STATUS-002 | `validation.profile.status.invalid` | ERROR | VALIDATION | status | enum | `{"allowedValues":["inactive","active","archived"]}` |
| PRO-VAL-STATUS-003 | `validation.profile.status.transition` | ERROR | VALIDATION | status | transition | – |

### Fehlerverhalten

#### Fehlender oder leerer Profilstatus

Ist der an `ProfileStatus.fromString(...)` übergebene Wert

- nicht vorhanden,
- leer,
- oder nach dem Trimmen leer,

wird ausschließlich

```text
PRO-VAL-STATUS-001
```

erzeugt.

Weitere Enum-Prüfungen erfolgen in diesem Fall nicht.

#### Ungültiger Profilstatus

Entspricht der vorhandene Wert keinem zulässigen `ProfileStatus`, wird

```text
PRO-VAL-STATUS-002
```

erzeugt.

Als Parameter werden die zulässigen Werte übertragen:

```json
{
  "allowedValues": [
    "inactive",
    "active",
    "archived"
  ]
}
```

#### Ungültiger Statusübergang

Ist der aktuelle Status gültig, der angeforderte Lebenszyklusübergang jedoch
fachlich nicht zulässig, wird

```text
PRO-VAL-STATUS-003
```

erzeugt.

Der Fehler beschreibt ausschließlich einen ungültigen
Lebenszyklusübergang.

Sperr- und Authentifizierungsfehler werden nicht unter diesem Code
zusammengefasst.

`PRO-VAL-STATUS-003` wird ausschließlich durch die fachlichen
Lebenszyklusoperationen des `Profile`-Aggregats erzeugt.

Der Code wird nicht durch

```text
ProfileStatus.fromString(...)
```

erzeugt.

Die Enumeration prüft ausschließlich, ob ein einzelner gespeicherter Wert
einem zulässigen Enumerationswert entspricht.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein des Status prüfen.
2. Zulässigen Enum-Wert prüfen.
3. Angeforderten Lebenszyklusübergang prüfen.
4. Aggregate- und Cross-Field-Invarianten prüfen.

Ein fehlender Status erzeugt keinen zusätzlichen Enum- oder
Transition-Fehler.

Ein ungültiger Enum-Wert erzeugt keinen zusätzlichen Transition-Fehler.

Dadurch werden Folgefehler vermieden.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Passwortschutz,
- Authentifizierung,
- Credential-Prüfung,
- `AuthenticationProof`,
- technische Sperrmechanismen,
- Lockout- oder Rate-Limiting-Regeln,
- profilübergreifende Auswahl des aktiven Profils.

Die profilübergreifende Regel, dass höchstens ein Profil aktiv sein darf,
wird durch den zuständigen Domain Service beziehungsweise Coordinator
geschützt.

### Traceability

**Requirements**

- PRO-FR-005
- PRO-FR-006
- PRO-FR-007

**Use Cases**

- PRO-UC-005
- PRO-UC-006
- PRO-UC-007

**Business Rules**

- PRO-BR-008
- PRO-BR-010

**Domain Model**

- `Profile.status`
- `ProfileStatus`
- `Profile.activate()`
- `Profile.deactivate()`
- `Profile.archive()`
- `Profile.restore()`
- `LockState`
- `ProfileLockStatus`
- AG-INV-003
- AG-INV-010
- AG-INV-011

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

# PRO-VR-013

## Titel

Standardprofil validieren

### Typ

Profilübergreifende Systemvalidierung

### Beschreibung

Das Standardprofil bezeichnet das Profil, das bei der Ermittlung eines
bevorzugten Startprofils berücksichtigt wird.

Der Standardprofilstatus eines einzelnen Profils wird durch

```text
DefaultProfileFlag
```

beschrieben.

Die profilübergreifende Invariante wird durch den

```text
DefaultProfileCoordinator
```

geschützt.

Es darf höchstens ein Standardprofil existieren.

Ein Zustand ohne Standardprofil ist fachlich zulässig.

### Fachliche Regeln

Für den Standardprofilstatus gilt:

- Es DARF höchstens ein Standardprofil existieren.
- Es DARF auch kein Standardprofil existieren.
- Ein als Standardprofil ausgewähltes Profil MUSS vorhanden sein.
- Ein archiviertes Profil DARF kein Standardprofil sein.
- Ein gelöschtes Profil DARF nicht als Standardprofil referenziert werden.
- Ein gesperrtes Profil DARF Standardprofil sein.
- Der Sperrzustand allein macht ein Profil nicht ungeeignet als
  Standardprofil.

Die Prüfung, ob mehrere Profile gleichzeitig als Standardprofil markiert
sind, kann nicht durch ein einzelnes `DefaultProfileFlag` durchgeführt
werden.

Diese profilübergreifende Prüfung erfolgt ausschließlich durch den
`DefaultProfileCoordinator` beziehungsweise die zuständige
Application-Layer-Koordination.

### Zulässige Profilzustände

Ein Standardprofil darf den Lebenszyklusstatus

```text
inactive
active
```

besitzen.

Ein gesperrtes Profil darf ebenfalls Standardprofil sein, da der
Sperrzustand getrennt vom Lebenszyklusstatus modelliert wird.

Nicht zulässig ist der Lebenszyklusstatus

```text
archived
```

### No-Change-Abgrenzung

Ist ein Profil bereits Standardprofil und wird erneut als Standardprofil
markiert, liegt kein Validation Error vor.

Die Operation kann ein erfolgreiches No-Change-Ergebnis liefern.

No-Change-Ergebnisse werden getrennt von Validation Errors dokumentiert.

### Fehlercodes

| Fehlercode | Message Key | Severity | Feld | Constraint | Parameter | Status |
|------------|-------------|----------|------|------------|-----------|--------|
| PRO-VAL-DEFAULT-001 | `validation.profile.default.notFound` | ERROR | defaultProfile | required | – | reserviert |
| PRO-VAL-DEFAULT-002 | `validation.profile.default.multiple` | ERROR | defaultProfile | unique | `{"maximum":1}` | aktiv |
| PRO-VAL-DEFAULT-003 | `validation.profile.default.invalidStatus` | ERROR | defaultProfile | status | `{"disallowedStatuses":["archived"]}` | aktiv |

### Reservierter Error Code

#### PRO-VAL-DEFAULT-001

Der Error Code

```text
PRO-VAL-DEFAULT-001
```

wurde ursprünglich für die allgemeine Aussage verwendet, dass ein
Standardprofil vorhanden sein müsse.

Diese Aussage gilt nicht mehr als allgemeine fachliche Invariante.

Ein Zustand ohne Standardprofil ist zulässig.

Der Error Code bleibt gemäß `PRO-VP-007` dauerhaft reserviert und darf

- nicht neu vergeben,
- nicht für einen anderen Sachverhalt verwendet,
- nicht als allgemeiner Pflichtfeldfehler erzeugt

werden.

Die Prüfung einer ungültigen Referenz auf ein nicht vorhandenes Profil muss
im konkreten Aufrufkontext durch den zuständigen Coordinator,
Application Service oder Repository-Port behandelt werden.

### Fehlerverhalten

#### Mehrere Standardprofile

Sind mehrere Profile gleichzeitig als Standardprofil markiert, wird

```text
PRO-VAL-DEFAULT-002
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "maximum": 1
}
```

Die Prüfung erfolgt profilübergreifend.

#### Ungültiger Lebenszyklusstatus

Ist ein als Standardprofil markiertes Profil archiviert, wird

```text
PRO-VAL-DEFAULT-003
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "disallowedStatuses": [
    "archived"
  ]
}
```

Ein gesperrtes Profil erzeugt diesen Fehler nicht.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein referenzierter Profile prüfen.
2. Lebenszyklusstatus des ausgewählten Profils prüfen.
3. Anzahl der als Standardprofil markierten Profile prüfen.
4. Profilübergreifende Invariante durch den
   `DefaultProfileCoordinator` bestätigen.

Ein Zustand ohne Standardprofil erzeugt keinen Validation Error.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Aktivierung des Standardprofils,
- automatische Entsperrung,
- Authentifizierung,
- Auswahl des zuletzt verwendeten Profils,
- technische Persistenz von Profilreferenzen,
- Startnavigation der Benutzeroberfläche.

Ein gesperrtes Standardprofil darf als bevorzugtes Startprofil identifiziert
werden.

Es darf jedoch nicht automatisch aktiviert werden, bevor die erforderliche
Authentifizierung erfolgreich abgeschlossen wurde.

### Traceability

**Requirements**

- PRO-FR-009

**Use Cases**

- PRO-UC-009

**Business Rules**

- PRO-BR-012

**Domain Model**

- `Profile.defaultFlag`
- `DefaultProfileFlag`
- `Profile.markAsDefault()`
- `Profile.removeDefault()`
- `DefaultProfileCoordinator`
- `DefaultProfileSelectionPolicy`
- PRO-CINV-001
- PRO-CINV-002

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-014

## Titel

Audit-Zeitstempel validieren

### Typ

Systemvalidierung

### Beschreibung

Zeitinformationen dienen der fachlichen Nachvollziehbarkeit der Erstellung
und Änderung eines Profilaggregats.

Die Audit-Zeitstempel werden durch

```text
AuditInformation
```

verwaltet.

Jedes Profil besitzt:

- `createdAt`,
- `updatedAt`.

Beide Werte verwenden gültige `Timestamp`-Instanzen und repräsentieren
UTC-Zeitpunkte.

Diese Validation Rule beschreibt die chronologische Konsistenz der
Auditinformationen.

Sie ist nicht die allgemeine Factory-Validierung jedes beliebigen
`Timestamp`-Value-Objects.

### Fachliche Regeln

Für die Audit-Zeitstempel gilt:

- `createdAt` MUSS vorhanden sein.
- `updatedAt` MUSS vorhanden sein.
- `updatedAt` DARF niemals vor `createdAt` liegen.
- Bei der initialen Erzeugung MUSS `updatedAt` gleich `createdAt` sein.
- Bei einer erfolgreichen fachlichen Änderung MUSS der neue
  Änderungszeitpunkt `now` verwendet werden.
- `now` DARF nicht vor `createdAt` liegen.
- `now` DARF nicht vor dem bisherigen `updatedAt` liegen.
- Eine erfolgreiche fachliche Änderung MUSS `updatedAt` aktualisieren.
- `createdAt` DARF nach der Erzeugung nicht verändert werden.
- Reine Lesezugriffe verändern keine Audit-Zeitstempel.
- Fehlgeschlagene Operationen verändern keine Audit-Zeitstempel.
- Erfolgreiche No-Change-Operationen verändern keine Audit-Zeitstempel.

### Initialzustand

Bei

```text
AuditInformation.createInitial(now)
```

gilt:

```text
createdAt = now
updatedAt = now
```

Der übergebene Zeitpunkt muss ein gültiger `Timestamp` sein.

### Änderung

Bei

```text
AuditInformation.touchAndIncrement(now)
```

gilt:

```text
now >= createdAt
```

und:

```text
now >= bisheriges updatedAt
```

Ist eine dieser Bedingungen verletzt, darf keine neue
`AuditInformation`-Instanz erzeugt werden.

### Fehlercodes

| Fehlercode | Message Key | Severity | Feld | Constraint | Parameter |
|------------|-------------|----------|------|------------|-----------|
| PRO-VAL-TIME-001 | `validation.profile.timestamp.createdMissing` | ERROR | createdAt | required | `{"field":"createdAt"}` |
| PRO-VAL-TIME-002 | `validation.profile.timestamp.updatedMissing` | ERROR | updatedAt | required | `{"field":"updatedAt"}` |
| PRO-VAL-TIME-003 | `validation.profile.timestamp.invalidOrder` | ERROR | auditInformation | chronological | `{"comparison":"<comparison>","createdAt":"<createdAt>","previousUpdatedAt":"<previousUpdatedAt>","requestedUpdatedAt":"<requestedUpdatedAt>"}` |

### Parameter

#### PRO-VAL-TIME-001

```json
{
  "field": "createdAt"
}
```

#### PRO-VAL-TIME-002

```json
{
  "field": "updatedAt"
}
```

#### PRO-VAL-TIME-003

Der Parameter `comparison` beschreibt die verletzte chronologische Regel.

Zulässige Werte sind:

```text
updatedAtBeforeCreatedAt
requestedUpdatedAtBeforeCreatedAt
requestedUpdatedAtBeforePreviousUpdatedAt
```

Beispiel:

```json
{
  "comparison": "requestedUpdatedAtBeforePreviousUpdatedAt",
  "createdAt": "2026-08-01T08:00:00Z",
  "previousUpdatedAt": "2026-08-05T10:00:00Z",
  "requestedUpdatedAt": "2026-08-04T10:00:00Z"
}
```

Nicht benötigte Zeitwerte dürfen im konkreten Fehlerparameter entfallen.

Zeitwerte werden ausschließlich im ISO-8601-Format und in UTC übertragen.

### Fehlerverhalten

#### Fehlender Erstellungszeitpunkt

Ist `createdAt` nicht vorhanden, wird

```text
PRO-VAL-TIME-001
```

erzeugt.

Chronologische Prüfungen, die `createdAt` benötigen, werden in diesem Fall
nicht durchgeführt.

#### Fehlender Änderungszeitpunkt

Ist `updatedAt` nicht vorhanden, wird

```text
PRO-VAL-TIME-002
```

erzeugt.

Chronologische Prüfungen, die `updatedAt` benötigen, werden in diesem Fall
nicht durchgeführt.

#### Änderungszeitpunkt vor Erstellungszeitpunkt

Liegt `updatedAt` vor `createdAt`, wird

```text
PRO-VAL-TIME-003
```

mit folgendem Vergleich erzeugt:

```text
updatedAtBeforeCreatedAt
```

#### Neuer Änderungszeitpunkt vor Erstellungszeitpunkt

Liegt der für eine Änderung übergebene Zeitpunkt `now` vor `createdAt`, wird

```text
PRO-VAL-TIME-003
```

mit folgendem Vergleich erzeugt:

```text
requestedUpdatedAtBeforeCreatedAt
```

#### Neuer Änderungszeitpunkt vor bisherigem Änderungszeitpunkt

Liegt der für eine Änderung übergebene Zeitpunkt `now` vor dem bisherigen
`updatedAt`, wird

```text
PRO-VAL-TIME-003
```

mit folgendem Vergleich erzeugt:

```text
requestedUpdatedAtBeforePreviousUpdatedAt
```

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `createdAt` prüfen.
2. Vorhandensein von `updatedAt` prüfen.
3. Gültigkeit der enthaltenen `Timestamp`-Instanzen sicherstellen.
4. `updatedAt` mit `createdAt` vergleichen.
5. Bei einer Änderung `now` mit `createdAt` vergleichen.
6. Bei einer Änderung `now` mit dem bisherigen `updatedAt` vergleichen.

Fehlt ein für einen Vergleich benötigter Pflichtwert, wird für denselben
Sachverhalt kein zusätzlicher Chronologiefehler erzeugt.

Dadurch werden Folgefehler vermieden.

### Verhalten nach Operationen

#### Erfolgreiche fachliche Änderung

Nach einer erfolgreichen fachlichen Änderung gilt:

- `createdAt` bleibt unverändert.
- `updatedAt` entspricht dem gültigen Änderungszeitpunkt.
- Die zugehörige `AggregateVersion` wird genau einmal erhöht.

#### Fehlgeschlagene Operation

Nach einer fehlgeschlagenen Operation gilt:

- `createdAt` bleibt unverändert.
- `updatedAt` bleibt unverändert.
- Die `AggregateVersion` bleibt unverändert.

#### Erfolgreicher No Change

Nach einer erfolgreichen Operation ohne Zustandsänderung gilt:

- `createdAt` bleibt unverändert.
- `updatedAt` bleibt unverändert.
- Die `AggregateVersion` bleibt unverändert.
- Es entsteht kein Änderungs-Domain-Event.

No-Change ist kein Validation Error.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- die technische Ermittlung der Systemzeit,
- lokale Zeitzonen,
- Darstellung und Formatierung von Zeitwerten,
- allgemeine Parsing-Fehler beliebiger Zeitstempel,
- Persistenzzeitstempel,
- Datenbankzeitstempel,
- technische Audit Trails,
- Event-Publishing.

Die aktuelle Zeit wird ausschließlich über den abstrahierten

```text
Clock
```

-Port bereitgestellt.

Die allgemeine Gültigkeit eines einzelnen `Timestamp` wird durch dessen
eigene kontrollierte Erzeugung geschützt.

### Traceability

**Requirements**

- PRO-FR-003
- PRO-FR-027

**Use Cases**

- PRO-UC-003
- PRO-UC-027

**Business Rules**

- PRO-BR-007

**Domain Model**

- `AuditInformation`
- `AuditInformation.createInitial(...)`
- `AuditInformation.touchAndIncrement(...)`
- `Timestamp`
- `AggregateVersion`
- `Clock`
- AG-INV-007
- AG-INV-008
- AG-INV-014

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-008
- PRO-VP-009

---

# PRO-VR-015

## Titel

Profilimport validieren

### Typ

Importvalidierung

### Beschreibung

Vor jedem Import müssen sämtliche Profildaten vollständig validiert werden.

### Fachliche Regeln

Der Import

- MUSS ein unterstütztes Dateiformat besitzen.
- MUSS eine unterstützte Datenversion enthalten.
- MUSS vollständig sein.
- MUSS sämtliche Pflichtfelder enthalten.
- MUSS sämtliche Validierungsregeln dieses Dokuments erfüllen.

Nach erfolgreicher Rekonstruktion MÜSSEN zusätzlich sämtliche

- Aggregate-Invarianten,
- Entity-Invarianten,
- Value-Object-Invarianten

erfüllt sein.

Kann eine dieser Invarianten nicht hergestellt werden,

- MUSS der Import vollständig abgebrochen werden.
- DARF kein teilweise rekonstruiertes Aggregate übernommen werden.

### Atomare Ausführung

Der Profilimport ist eine mehrstufige Fachoperation.

Für ihn gilt das Architekturprinzip

**PRO-VP-008 – Atomare Fachoperationen**

Tritt während des Imports ein Fehler auf,

- MUSS der gesamte Import zurückgerollt werden.
- DARF kein teilweise importierter Datenbestand verbleiben.
- MUSS der ursprüngliche Datenbestand vollständig erhalten bleiben.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-IMPORT-001 | `validation.profile.import.invalidFormat` | format | `{"supportedFormats":["json"]}` |
| PRO-VAL-IMPORT-002 | `validation.profile.import.invalidVersion` | version | `{"supportedVersions":["1.0"]}` |
| PRO-VAL-IMPORT-003 | `validation.profile.import.corrupted` | integrity | – |
| PRO-VAL-IMPORT-004 | `validation.profile.import.missingRequiredData` | required | – |
| PRO-VAL-IMPORT-005 | `validation.profile.import.duplicateId` | duplicate | – |
| PRO-VAL-IMPORT-006 | `validation.profile.import.rollback` | atomic | – |

### Erläuterungen zu den Fehlercodes

#### PRO-VAL-IMPORT-005

`DuplicateId` bezeichnet jede Verletzung der
Eindeutigkeit fachlicher Identitäten innerhalb
des zu importierenden Aggregates.

Hierzu gehören insbesondere

- ProfileId
- ProfileSettingsId
- ProfileSecurityId

Andere Identitäten werden durch ihre jeweils
zuständigen Aggregate oder Module validiert.

#### PRO-VAL-IMPORT-006

`PRO-VAL-IMPORT-006` beschreibt nicht die
eigentliche Ursache eines Importfehlers.

Der Code kennzeichnet ausschließlich,
dass der atomare Import infolge mindestens
eines vorher aufgetretenen Validation Errors
vollständig zurückgerollt wurde.

Der ursprüngliche Datenbestand bleibt dabei
vollständig unverändert erhalten.

### Traceability

**Requirements**

- PRO-FR-025

**Use Cases**

- PRO-UC-025

**Business Rules**

- PRO-BR-022
- PRO-BR-023

---

# PRO-VR-016

## Titel

Profilexport validieren

### Typ

Exportvalidierung

### Beschreibung

Diese Validation Rule validiert das fachliche Exportmodell eines Profils.

Das fachliche Exportmodell wird durch

```text
ProfileExportModel
```

repräsentiert.

Es wird vor der technischen Serialisierung und Dateierzeugung durch den

```text
ProfileExportDomainService
```

vorbereitet.

Diese Validation Rule validiert nicht

- eine konkrete Exportdatei,
- ein JSON-Dokument,
- einen Dateipfad,
- einen Download,
- ein technisches Archivformat.

Technische Dateierzeugung und Serialisierung erfolgen ausschließlich
außerhalb der Domäne.

### Fachliche Regeln

Ein fachlich vollständiges Exportmodell

- MUSS eine Exportversion enthalten.
- MUSS einen Exportzeitpunkt enthalten.
- MUSS die `ProfileId` des exportierten Profils enthalten.
- MUSS die freigegebenen Profildaten enthalten.
- MUSS ausschließlich ausdrücklich ausgewählte und freigegebene
  Datenbereiche enthalten.
- DARF keine Daten anderer Profile enthalten.
- DARF keine fremden Bildreferenzen enthalten.
- DARF keine vermischten Datenbestände mehrerer Profile enthalten.
- DARF keine Klartextpasswörter enthalten.
- DARF keine `PlainPassword`-Werte enthalten.
- DARF keine `PasswordCredential`-Werte enthalten.
- DARF keine `PasswordHash`-Werte enthalten.
- DARF keine `PasswordHashParameters` enthalten.
- DARF keine internen `AuthenticationProof`-Werte enthalten.
- DARF keine kryptographischen Schlüssel enthalten.
- DARF keine sicherheitsrelevanten technischen Parameter enthalten.

Nicht angeforderte Datenbereiche dürfen nicht in das Exportmodell
aufgenommen werden.

### Mindestbestandteile

Ein vollständiges `ProfileExportModel` enthält mindestens:

```text
version
exportedAt
profileId
profileData
```

Zusätzlich müssen alle ausdrücklich angeforderten und freigegebenen
Exportbereiche vollständig enthalten sein.

Ein Exportmodell ist unvollständig, wenn

- ein Mindestbestandteil fehlt,
- ein angeforderter freigegebener Datenbereich fehlt,
- ein enthaltenes fachliches Teilmodell unvollständig ist.

### Profilzuordnung

Alle im Exportmodell enthaltenen profilbezogenen Daten müssen eindeutig
derselben

```text
ProfileId
```

zugeordnet sein.

Als fremde Profildaten gelten insbesondere:

- Stammdaten eines anderen Profils,
- Einstellungen eines anderen Profils,
- Bildreferenzen eines anderen Profils,
- Datenbereiche eines anderen Profils,
- vermischte Daten mehrerer Profile,
- Daten ohne eindeutige Zuordnung zum exportierten Profil.

### Verbotene Sicherheitsdaten

Verbotene Sicherheitsdaten sind insbesondere:

```text
PlainPassword
PasswordCredential
PasswordHash
PasswordHashParameters
AuthenticationProof
kryptographische Schlüssel
sicherheitsrelevante technische Parameter
```

Es dürfen ausschließlich die Typbezeichnungen festgestellter verbotener
Daten als Fehlerparameter übertragen werden.

Konkrete Werte, Hashes, Credentials, Proofs oder Schlüssel dürfen niemals
Bestandteil eines Validation Errors sein.

### Fehlercodes

| Fehlercode | Message Key | Severity | Feld | Constraint | Parameter |
|------------|-------------|----------|------|------------|-----------|
| PRO-VAL-EXPORT-001 | `validation.profile.export.versionMissing` | ERROR | version | required | `{"field":"version"}` |
| PRO-VAL-EXPORT-002 | `validation.profile.export.foreignProfile` | ERROR | profileData | ownership | `{"expectedProfileId":"<profileId>","detectedProfileIds":["<profileId>"]}` |
| PRO-VAL-EXPORT-003 | `validation.profile.export.securityData` | ERROR | profileData | forbidden | `{"detectedDataTypes":["<dataType>"]}` |
| PRO-VAL-EXPORT-004 | `validation.profile.export.incomplete` | ERROR | exportModel | completeness | `{"missingFields":["<field>"]}` |

### Parameter

#### PRO-VAL-EXPORT-001

```json
{
  "field": "version"
}
```

Dieser Error Code wird ausschließlich verwendet, wenn die Exportversion
fehlt.

Er wird nicht für andere fehlende Pflichtbestandteile verwendet.

#### PRO-VAL-EXPORT-002

```json
{
  "expectedProfileId": "<profileId>",
  "detectedProfileIds": [
    "<foreignProfileId>"
  ]
}
```

`detectedProfileIds` enthält ausschließlich fachliche Identitäten.

Es werden keine weiteren Daten der betroffenen Profile übertragen.

#### PRO-VAL-EXPORT-003

```json
{
  "detectedDataTypes": [
    "PasswordCredential",
    "PasswordHash"
  ]
}
```

Zulässige Werte für `detectedDataTypes` sind ausschließlich sichere
Typbezeichnungen, insbesondere:

```text
PlainPassword
PasswordCredential
PasswordHash
PasswordHashParameters
AuthenticationProof
CryptographicKey
SecurityParameter
```

Die tatsächlichen sensiblen Werte dürfen niemals übertragen werden.

#### PRO-VAL-EXPORT-004

```json
{
  "missingFields": [
    "exportedAt",
    "profileId",
    "profileData"
  ]
}
```

Der Parameter enthält ausschließlich die Namen fehlender fachlicher
Bestandteile.

### Fehlerverhalten

#### Fehlende Exportversion

Fehlt die Exportversion, wird

```text
PRO-VAL-EXPORT-001
```

erzeugt.

Die Prüfung weiterer Bestandteile darf fortgesetzt werden, sofern dies ohne
technische oder fachliche Folgefehler möglich ist.

#### Fremde Profildaten

Enthält das Exportmodell Daten, die nicht eindeutig der exportierten
`ProfileId` zugeordnet sind, wird

```text
PRO-VAL-EXPORT-002
```

erzeugt.

Der Fehler gilt auch für

- fremde Bildreferenzen,
- fremde profilbezogene Datenbereiche,
- vermischte Daten mehrerer Profile.

#### Verbotene Sicherheitsdaten

Enthält das Exportmodell mindestens einen verbotenen Sicherheitsdatentyp,
wird

```text
PRO-VAL-EXPORT-003
```

erzeugt.

Der Parameter nennt ausschließlich die festgestellten Datentypen.

Es werden keine sensiblen Werte in den Fehler übernommen.

#### Unvollständiges Exportmodell

Fehlt mindestens einer der erforderlichen Bestandteile, wird

```text
PRO-VAL-EXPORT-004
```

erzeugt.

Dieser Code wird insbesondere verwendet für fehlende:

- `exportedAt`,
- `profileId`,
- `profileData`,
- angeforderte freigegebene Exportbereiche.

Eine fehlende Version wird weiterhin zusätzlich durch den spezielleren Code

```text
PRO-VAL-EXPORT-001
```

beschrieben.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Exportversion prüfen.
2. Exportzeitpunkt prüfen.
3. `ProfileId` prüfen.
4. Vollständigkeit der Profildaten prüfen.
5. Vollständigkeit angeforderter Exportbereiche prüfen.
6. eindeutige Profilzuordnung sämtlicher Daten prüfen.
7. verbotene Sicherheitsdaten erkennen.
8. fachliche Vollständigkeit des Gesamtmodells bestätigen.

Fehlende Pflichtbestandteile dürfen keine technischen Folgefehler auslösen.

Sicherheitsdaten werden unabhängig von anderen Fehlern erkannt und niemals
in Fehlerparametern offengelegt.

### Erfolgsverhalten

Bei erfolgreicher Validierung gilt:

- Das Exportmodell ist fachlich vollständig.
- Sämtliche enthaltenen Daten gehören zum angeforderten Profil.
- Nur angeforderte und freigegebene Datenbereiche sind enthalten.
- Es sind keine verbotenen Sicherheitsdaten enthalten.
- Das Profilaggregat wurde nicht verändert.
- Es wurden keine Auditinformationen verändert.
- Die Aggregate-Version wurde nicht erhöht.
- Es wurde keine Datei erzeugt.
- Es erfolgte keine technische Serialisierung.

### Atomarität

Die Vorbereitung des fachlichen Exportmodells ist eine lesende Operation.

Ein unvollständiges oder ungültiges Exportmodell darf nicht an die
technische Exporterzeugung übergeben werden.

Es darf kein fachlich nur teilweise freigegebenes Exportmodell als Erfolg
zurückgegeben werden.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- technische Serialisierung,
- JSON-Erzeugung,
- Dateierzeugung,
- Kompression,
- Verschlüsselung,
- Download,
- Dateisystemzugriffe,
- Netzwerkübertragung,
- technische Speicherfehler,
- Event-Publishing.

Diese Verantwortlichkeiten liegen außerhalb der Domäne.

Das Ereignis

```text
ProfileExported
```

darf erst nach erfolgreicher technischer Exporterzeugung und erfolgreichem
Abschluss des Use Cases veröffentlicht werden.

### Traceability

**Requirements**

- PRO-FR-024

**Use Cases**

- PRO-UC-024

**Business Rules**

- PRO-BR-021

**Domain Model**

- `ProfileExportDomainService`
- `ProfileExportDomainService.prepareExport(...)`
- `ProfileExportModel`
- `ProfileDataQueryPort`
- `ProfileExportSectionSelection`
- `ProfileId`
- `PasswordCredential`
- `PasswordHash`
- `PasswordHashParameters`
- `AuthenticationProof`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-008
- PRO-VP-009

---

# PRO-VR-017

## Titel

ProfileSettings validieren

### Typ

Entity-Validierung

### Beschreibung

`ProfileSettings` beschreibt den vollständigen profilbezogenen
Einstellungszustand eines Profils.

Die Entity besteht aus

- einer unveränderlichen `ProfileSettingsId`,
- gültigen `LocalizationSettings`,
- gültigen `DashboardSettings`,
- gültigen `AppearanceSettings`.

Eine `ProfileSettings`-Entity darf ausschließlich als vollständiger und
konsistenter Zustand erzeugt oder rekonstruiert werden.

### Fachliche Regeln

Für `ProfileSettings` gilt:

- `settingsId` MUSS vorhanden und gültig sein.
- `settingsId` DARF nach der Erzeugung nicht verändert werden.
- `localization` MUSS vorhanden und gültig sein.
- `dashboard` MUSS vorhanden und gültig sein.
- `appearance` MUSS vorhanden und gültig sein.
- Alle Einstellungsbereiche MÜSSEN gemeinsam einen vollständigen Zustand
  bilden.
- Eine teilweise erzeugte oder teilweise geänderte Entity ist unzulässig.
- Eine fehlgeschlagene Operation DARF den bestehenden Zustand nicht
  verändern.

Die Gültigkeit der enthaltenen Value Objects wird ausschließlich durch deren
jeweilige Validation Rules bestimmt.

### Fehlercodes

| Fehlercode | Message Key | Severity | Feld | Constraint | Parameter |
|------------|-------------|----------|------|------------|-----------|
| PRO-VAL-PSET-001 | `validation.profileSettings.settingsId.required` | ERROR | settingsId | required | – |
| PRO-VAL-PSET-002 | `validation.profileSettings.settingsId.invalid` | ERROR | settingsId | invalid | – |
| PRO-VAL-PSET-003 | `validation.profileSettings.localization.required` | ERROR | localization | required | – |
| PRO-VAL-PSET-004 | `validation.profileSettings.dashboard.required` | ERROR | dashboard | required | – |
| PRO-VAL-PSET-005 | `validation.profileSettings.appearance.required` | ERROR | appearance | required | – |
| PRO-VAL-PSET-006 | `validation.profileSettings.incomplete` | ERROR | profileSettings | completeness | `{"requiredFields":["settingsId","localization","dashboard","appearance"]}` |

### Abgrenzung

Die folgenden Fehler werden nicht erneut als `ProfileSettings`-Fehler
erzeugt:

- ungültige Sprache,
- ungültiges Maßeinheitensystem,
- ungültiges Dashboardlayout,
- ungültige Widgetauswahl,
- ungültige Dashboard-Konfigurationsversion,
- ungültige Darstellungspräferenz.

Diese Fehler gehören ausschließlich zu den jeweiligen Value Objects.

Dadurch werden doppelte Fehlermeldungen und Folgefehler vermieden.

### Verhalten bei fachlichen Operationen

Die Operationen

```text
changeLanguage(...)

changeMeasurementSystem(...)

changeDashboardSettings(...)

changeAppearanceSettings(...)

resetToDefaults(...)
```

dürfen ausschließlich vollständige und gültige Zielzustände erzeugen.

Erhält eine Operation bereits ein gültiges Value Object, wird dessen interne
Validierung nicht als generischer `ProfileSettings`-Fehler dupliziert.

Ein identischer neuer Wert ist kein Validierungsfehler.

Das No-Change-Verhalten wird getrennt von den Validation Errors
spezifiziert.

### Traceability

**Domain Model**

- `ProfileSettings`
- `ProfileSettings.create(...)`
- `ProfileSettings.changeLanguage(...)`
- `ProfileSettings.changeMeasurementSystem(...)`
- `ProfileSettings.changeDashboardSettings(...)`
- `ProfileSettings.changeAppearanceSettings(...)`
- `ProfileSettings.resetToDefaults(...)`

**Business Rules**

- PRO-BR-007
- PRO-BR-026
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-008
- PRO-VP-009

---

# PRO-VR-018

## Titel

LocalizationSettings validieren

### Typ

Value-Object-Validierung

### Beschreibung

`LocalizationSettings` beschreibt die profilbezogenen Präferenzen für

- Sprache,
- Maßeinheitensystem.

Das Value Object ist vollständig und unveränderlich.

Beide Attribute müssen bei der kontrollierten Erzeugung vorhanden und
fachlich unterstützt sein.

### Fachliche Regeln

Für `LocalizationSettings` gilt:

- `language` MUSS vorhanden sein.
- `language` MUSS einem unterstützten Sprachcode entsprechen.
- `measurementSystem` MUSS vorhanden sein.
- `measurementSystem` MUSS einem unterstützten Maßeinheitensystem entsprechen.
- Beide Werte MÜSSEN gemeinsam einen vollständigen Zustand bilden.
- Eine Änderung erzeugt eine neue gültige `LocalizationSettings`-Instanz.
- Der Wechsel des Maßeinheitensystems DARF keine kanonisch gespeicherten
  Gesundheitswerte verändern.

### Unterstützte Werte

#### Language

Unterstützte Sprachcodes werden durch die Enumeration `Language` bestimmt.

Aktuell dokumentierte Beispielwerte sind:

```text
de
en
```

Die Liste der dauerhaft unterstützten Sprachen wird durch das Domain Model
und die zugehörige Sprachkonfiguration bestimmt.

#### MeasurementSystem

Zulässige Werte sind:

```text
metric
imperial
```

### Fehlercodes

| Fehlercode | Message Key | Severity | Feld | Constraint | Parameter |
|------------|-------------|----------|------|------------|-----------|
| PRO-VAL-LOC-001 | `validation.localization.language.required` | ERROR | language | required | – |
| PRO-VAL-LOC-002 | `validation.localization.language.invalid` | ERROR | language | enum | `{"allowedValues":"supportedLanguageCodes"}` |
| PRO-VAL-LOC-003 | `validation.localization.measurementSystem.required` | ERROR | measurementSystem | required | – |
| PRO-VAL-LOC-004 | `validation.localization.measurementSystem.invalid` | ERROR | measurementSystem | enum | `{"allowedValues":["metric","imperial"]}` |

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `language`,
2. unterstützter Wert von `language`,
3. Vorhandensein von `measurementSystem`,
4. unterstützter Wert von `measurementSystem`.

Ist ein Pflichtwert nicht vorhanden, wird für dieses Feld kein zusätzlicher
Enum-Fehler erzeugt.

Dadurch werden Folgefehler vermieden.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Landeseinstellungen,
- Zeitzonen,
- Datumsformate,
- konkrete Übersetzungen,
- UI-Locale-Typen,
- Flutter-Typen,
- Konvertierung gespeicherter Gesundheitswerte.

`country` und `timezone` sind keine Attribute von `LocalizationSettings` und
erzeugen daher keine Fehlercodes dieses Value Objects.

### Verhalten bei Änderungen

Die Operationen

```text
ProfileSettings.changeLanguage(...)

ProfileSettings.changeMeasurementSystem(...)
```

erzeugen intern einen vollständigen neuen `LocalizationSettings`-Zustand.

Dabei gilt:

- Bei einer Sprachänderung bleibt `measurementSystem` unverändert.
- Bei einer Änderung des Maßeinheitensystems bleibt `language` unverändert.
- Ein identischer neuer Wert ist kein Validierungsfehler.
- Das No-Change-Verhalten wird getrennt von den Validation Errors
  spezifiziert.

### Traceability

**Domain Model**

- `LocalizationSettings`
- `LocalizationSettings.create(...)`
- `Language`
- `MeasurementSystem`
- `ProfileSettings.changeLanguage(...)`
- `ProfileSettings.changeMeasurementSystem(...)`

**Business Rules**

- PRO-BR-007
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

# PRO-VR-019

## Titel

DashboardWidgetSelection validieren

### Typ

Value-Object-Validierung

### Beschreibung

`DashboardWidgetSelection` beschreibt die sichtbaren profilbezogenen
Dashboard-Inhalte und deren fachliche Reihenfolge.

Das Value Object speichert eine geordnete und unveränderliche Liste stabiler,
technologieunabhängiger Widget-Schlüssel.

Die Reihenfolge der Schlüssel ist Bestandteil des fachlichen Wertes.

### Interner Wert

```text
Ordered immutable List<String>
```

### Fachliche Regeln

Für `DashboardWidgetSelection` gilt:

- `widgetKeys` MUSS vorhanden sein.
- Die Liste DARF leer sein.
- Jeder enthaltene Widget-Schlüssel MUSS nach der Normalisierung einen
  nicht leeren Wert besitzen.
- Führende und nachfolgende Leerzeichen eines Widget-Schlüssels werden
  entfernt.
- Doppelte normalisierte Widget-Schlüssel sind unzulässig.
- Die Reihenfolge der Widget-Schlüssel ist fachlich relevant.
- Die interne Liste MUSS unveränderlich sein.
- Änderungen der ursprünglichen Eingabeliste DÜRFEN den erzeugten
  Domänenwert nicht nachträglich verändern.
- Flutter-Klassennamen, Flutter-Objekte und technische Laufzeitobjekte
  DÜRFEN nicht als fachliche Widget-Referenzen verwendet werden.

Eine leere Liste bedeutet, dass aktuell keine Dashboard-Widgets ausgewählt
sind. Sie ist kein Validierungsfehler.

### Normalisierung

Jeder Widget-Schlüssel wird vor der Validierung normalisiert.

Dabei werden ausschließlich

- führende Leerzeichen,
- nachfolgende Leerzeichen

entfernt.

Beispiel:

```text
"  weight  "

↓

"weight"
```

Die Groß- und Kleinschreibung wird nicht verändert.

Die Prüfung auf Dubletten erfolgt nach der Normalisierung.

Beispiel:

```text
"weight"

" weight "
```

Diese beiden Eingaben ergeben denselben normalisierten Widget-Schlüssel und
sind deshalb gemeinsam unzulässig.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-DWSEL-001 | `validation.dashboardWidgetSelection.widgetKeys.required` | ERROR | VALIDATION | widgetKeys | required | – |
| PRO-VAL-DWSEL-002 | `validation.dashboardWidgetSelection.widgetKey.blank` | ERROR | VALIDATION | widgetKeys | blank | `{"index":"<zeroBasedIndex>"}` |
| PRO-VAL-DWSEL-003 | `validation.dashboardWidgetSelection.widgetKey.duplicate` | ERROR | VALIDATION | widgetKeys | duplicate | `{"widgetKey":"<normalizedWidgetKey>","firstIndex":"<zeroBasedIndex>","duplicateIndex":"<zeroBasedIndex>"}` |

### Fehlerverhalten

#### Fehlende Liste

Ist `widgetKeys` nicht vorhanden, wird ausschließlich folgender Fehler
erzeugt:

```text
PRO-VAL-DWSEL-001
```

Weitere Prüfungen der enthaltenen Schlüssel werden in diesem Fall nicht
ausgeführt.

#### Leerer Widget-Schlüssel

Ergibt ein Widget-Schlüssel nach der Normalisierung einen leeren Wert, wird
für seine Position folgender Fehler erzeugt:

```text
PRO-VAL-DWSEL-002
```

Der Parameter `index` enthält die nullbasierte Position des ungültigen
Eintrags.

Der ursprüngliche Schlüsselwert wird nicht als Fehlerparameter übertragen.

#### Doppelter Widget-Schlüssel

Kommt ein normalisierter Widget-Schlüssel mehrfach vor, wird für jedes
zusätzliche Vorkommen folgender Fehler erzeugt:

```text
PRO-VAL-DWSEL-003
```

Die Parameter enthalten:

- den normalisierten Widget-Schlüssel,
- die Position seines ersten Vorkommens,
- die Position des doppelten Vorkommens.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `widgetKeys`,
2. Normalisierung der enthaltenen Schlüssel,
3. Prüfung auf leere normalisierte Schlüssel,
4. Prüfung auf doppelte normalisierte Schlüssel,
5. Erzeugung einer unveränderlichen geordneten Liste.

Ein leerer Schlüssel nimmt nicht an der Dublettenprüfung teil.

Dadurch werden Folgefehler vermieden.

### Nicht als Fehler definiert

Die folgenden Situationen sind keine Validierungsfehler:

- `widgetKeys` ist eine vorhandene leere Liste,
- die Reihenfolge der Schlüssel wurde bewusst verändert,
- die Widgetauswahl enthält weniger Einträge als zuvor,
- die Widgetauswahl enthält mehr Einträge als zuvor.

Ob ein Widget-Schlüssel zu einem fachlich verfügbaren Dashboard-Inhalt
gehört, kann erst geprüft werden, wenn ein verbindlicher Katalog
unterstützter Widget-Schlüssel spezifiziert ist.

Bis dahin darf für einen unbekannten, aber nicht leeren und nicht doppelten
String kein zusätzlicher Error Code erfunden werden.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- konkrete Flutter-Widgets,
- Widget-Klassen,
- Bildschirmkomponenten,
- Layoutgrößen,
- Farben,
- Abstände,
- Dashboard-Auswertungen,
- fachliche Inhalte anderer Module,
- Persistenz- oder DTO-Strukturen.

Die Gültigkeit des vollständigen `DashboardSettings`-Zustands wird durch die
zugehörige eigene Validation Rule geprüft.

### Equality

Zwei `DashboardWidgetSelection`-Instanzen sind fachlich gleich, wenn ihre
normalisierten Widget-Schlüssel

- dieselben Werte besitzen,
- in derselben Reihenfolge vorliegen.

Eine unterschiedliche Reihenfolge bedeutet einen unterschiedlichen
fachlichen Wert.

### Traceability

**Domain Model**

- `DashboardWidgetSelection`
- `DashboardWidgetSelection.create(...)`
- `DashboardSettings`
- `ProfileSettings.changeDashboardSettings(...)`

**Business Rules**

- PRO-BR-005
- PRO-BR-026
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

# PRO-VR-020

## Titel

DashboardConfigurationVersion validieren

### Typ

Value-Object-Validierung

### Beschreibung

`DashboardConfigurationVersion` beschreibt die Version einer
gespeicherten Dashboardkonfiguration.

Sie dient ausschließlich der fachlichen Kompatibilitäts- und
Migrationsprüfung von Dashboard-Einstellungen.

Sie ist nicht identisch mit der `AggregateVersion`.

Das Value Object ist unveränderlich.

### Interner Wert

```text
PositiveInteger
```

### Fachliche Regeln

Für `DashboardConfigurationVersion` gilt:

- `value` MUSS vorhanden sein.
- `value` MUSS größer oder gleich `1` sein.
- `1` ist der initiale Versionswert.
- Die Versionsnummer DARF niemals `0` oder negativ sein.
- Die Versionsnummer DARF keine Aggregate-Version repräsentieren.
- Die Versionsnummer DARF ausschließlich die Dashboardkonfiguration
  beschreiben.
- Das Value Object ist unveränderlich.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-DCV-001 | `validation.dashboardConfigurationVersion.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-DCV-002 | `validation.dashboardConfigurationVersion.minimum` | ERROR | VALIDATION | value | minimum | `{"minimum":1,"actual":"<value>"}` |

### Fehlerverhalten

#### Fehlender Wert

Ist keine Versionsnummer vorhanden, wird ausschließlich

```text
PRO-VAL-DCV-001
```

erzeugt.

Weitere Prüfungen erfolgen nicht.

#### Ungültige Versionsnummer

Ist der Wert kleiner als `1`, wird

```text
PRO-VAL-DCV-002
```

erzeugt.

Der tatsächliche Wert wird als Parameter übertragen.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `value`,
2. Mindestwert prüfen,
3. Value Object erzeugen.

Ein fehlender Wert erzeugt keinen zusätzlichen Mindestwertfehler.

Dadurch werden Folgefehler vermieden.

### Nicht als Fehler definiert

Die folgenden Situationen sind keine Validierungsfehler:

- Versionsnummer `1`,
- eine höhere Versionsnummer,
- unterschiedliche Versionsnummern verschiedener Dashboardkonfigurationen.

Ob eine bestimmte Versionsnummer fachlich migriert werden muss, ist keine
Aufgabe der Validierung.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- AggregateVersion,
- Datenmigration,
- Persistenzversionen,
- Datenbankschemata,
- technische Revisionsnummern,
- Optimistic Locking.

### Equality

Zwei `DashboardConfigurationVersion`-Instanzen sind fachlich gleich,
wenn ihr Versionswert identisch ist.

### Traceability

**Domain Model**

- `DashboardConfigurationVersion`
- `DashboardConfigurationVersion.create(...)`
- `DashboardSettings`

**Business Rules**

- PRO-BR-026
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

# PRO-VR-021

## Titel

DashboardSettings validieren

### Typ

Value-Object-Validierung

### Beschreibung

`DashboardSettings` beschreibt die profilbezogenen Dashboard-Einstellungen.

Das Value Object besteht vollständig aus

- `DashboardLayout`,
- `DashboardWidgetSelection`,
- `DashboardConfigurationVersion`.

Es darf ausschließlich als vollständiger und konsistenter Zustand erzeugt
werden.

### Fachliche Regeln

Für `DashboardSettings` gilt:

- `layout` MUSS vorhanden sein.
- `layout` MUSS ein unterstützter `DashboardLayout` sein.
- `visibleWidgets` MUSS vorhanden und gültig sein.
- `configurationVersion` MUSS vorhanden und gültig sein.
- Alle drei Bestandteile MÜSSEN gemeinsam einen vollständigen
  Dashboardzustand bilden.
- Das Value Object ist vollständig unveränderlich.
- Änderungen erzeugen ausschließlich einen neuen vollständigen Zustand.

Die enthaltenen Value Objects werden ausschließlich durch ihre eigenen
Validation Rules validiert.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-DSET-001 | `validation.dashboardSettings.layout.required` | ERROR | VALIDATION | layout | required | – |
| PRO-VAL-DSET-002 | `validation.dashboardSettings.layout.invalid` | ERROR | VALIDATION | layout | enum | `{"allowedValues":"DashboardLayout"}` |
| PRO-VAL-DSET-003 | `validation.dashboardSettings.visibleWidgets.required` | ERROR | VALIDATION | visibleWidgets | required | – |
| PRO-VAL-DSET-004 | `validation.dashboardSettings.configurationVersion.required` | ERROR | VALIDATION | configurationVersion | required | – |
| PRO-VAL-DSET-005 | `validation.dashboardSettings.incomplete` | ERROR | VALIDATION | dashboardSettings | completeness | `{"requiredFields":["layout","visibleWidgets","configurationVersion"]}` |

### Fehlerverhalten

#### Fehlendes Layout

Ist kein `layout` vorhanden, wird ausschließlich

```text
PRO-VAL-DSET-001
```

erzeugt.

#### Ungültiges Layout

Ist der Wert kein unterstützter `DashboardLayout`, wird

```text
PRO-VAL-DSET-002
```

erzeugt.

#### Fehlende Widgetauswahl

Ist `visibleWidgets` nicht vorhanden, wird

```text
PRO-VAL-DSET-003
```

erzeugt.

#### Fehlende Konfigurationsversion

Ist `configurationVersion` nicht vorhanden, wird

```text
PRO-VAL-DSET-004
```

erzeugt.

#### Unvollständiger Dashboardzustand

Fehlt mindestens einer der drei Pflichtbestandteile, kann zusätzlich

```text
PRO-VAL-DSET-005
```

erzeugt werden, sofern nicht bereits ein vollständiger Pflichtfeldfehler
den Zustand eindeutig beschreibt.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. `layout`
2. `visibleWidgets`
3. `configurationVersion`
4. Vollständigkeit des Gesamtzustands

Die interne Validierung der enthaltenen Value Objects erfolgt ausschließlich
durch deren jeweilige Validation Rule.

Es werden keine Fehler dieser Value Objects erneut als
`DashboardSettings`-Fehler erzeugt.

Dadurch werden doppelte Fehlermeldungen vermieden.

### Nicht als Fehler definiert

Die folgenden Situationen sind keine Validierungsfehler:

- eine leere Widgetauswahl,
- eine andere Reihenfolge der Widget-Schlüssel,
- eine höhere Konfigurationsversion,
- eine andere unterstützte Layoutvariante.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Dashboard-Inhalte,
- Dashboard-Auswertungen,
- Widgetdaten,
- Flutter-Widgets,
- Bildschirmgrößen,
- Farben,
- UI-Komponenten,
- Layoutberechnungen.

Diese Validation Rule prüft ausschließlich den vollständigen fachlichen
Dashboard-Einstellungszustand.

### Verhalten bei Änderungen

Die Operation

```text
ProfileSettings.changeDashboardSettings(...)
```

erzeugt ausschließlich einen neuen vollständigen und gültigen
`DashboardSettings`-Zustand.

Ein identischer neuer Wert ist kein Validierungsfehler.

Das No-Change-Verhalten wird getrennt von den Validation Errors
spezifiziert.

### Traceability

**Domain Model**

- `DashboardSettings`
- `DashboardSettings.create(...)`
- `DashboardLayout`
- `DashboardWidgetSelection`
- `DashboardConfigurationVersion`
- `ProfileSettings.changeDashboardSettings(...)`

**Business Rules**

- PRO-BR-026
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

# PRO-VR-022

## Titel

AppearanceSettings validieren

### Typ

Value-Object-Validierung

### Beschreibung

`AppearanceSettings` beschreibt die profilbezogenen
Darstellungspräferenzen.

Das Value Object besteht aus

- `ThemePreference`,
- optional `TextScalePreference`.

Es ist vollständig unveränderlich.

### Fachliche Regeln

Für `AppearanceSettings` gilt:

- `themePreference` MUSS vorhanden sein.
- `themePreference` MUSS ein unterstützter `ThemePreference` sein.
- `textScalePreference` DARF fehlen.
- Ist `textScalePreference` vorhanden, MUSS der Wert einem unterstützten
  `TextScalePreference` entsprechen.
- Eine fehlende `textScalePreference` bedeutet, dass die systemweite
  Textskalierung verwendet wird.
- Das Value Object ist vollständig unveränderlich.
- Änderungen erzeugen ausschließlich einen neuen vollständigen Zustand.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-APP-001 | `validation.appearanceSettings.themePreference.required` | ERROR | VALIDATION | themePreference | required | – |
| PRO-VAL-APP-002 | `validation.appearanceSettings.themePreference.invalid` | ERROR | VALIDATION | themePreference | enum | `{"allowedValues":"ThemePreference"}` |
| PRO-VAL-APP-003 | `validation.appearanceSettings.textScalePreference.invalid` | ERROR | VALIDATION | textScalePreference | enum | `{"allowedValues":"TextScalePreference"}` |

### Fehlerverhalten

#### Fehlende ThemePreference

Ist keine `themePreference` vorhanden, wird ausschließlich

```text
PRO-VAL-APP-001
```

erzeugt.

Weitere Prüfungen erfolgen nicht.

#### Ungültige ThemePreference

Ist der Wert kein unterstützter `ThemePreference`, wird

```text
PRO-VAL-APP-002
```

erzeugt.

#### Ungültige TextScalePreference

Ist `textScalePreference` vorhanden und kein unterstützter
`TextScalePreference`, wird

```text
PRO-VAL-APP-003
```

erzeugt.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `themePreference`,
2. unterstützter Wert von `themePreference`,
3. Prüfung von `textScalePreference`, sofern vorhanden.

Eine fehlende `textScalePreference` erzeugt keinen Fehler.

Dadurch werden Folgefehler vermieden.

### Nicht als Fehler definiert

Die folgenden Situationen sind keine Validierungsfehler:

- fehlende `textScalePreference`,
- Wechsel zwischen unterstützten Theme-Präferenzen,
- Wechsel zwischen unterstützten Textskalierungspräferenzen,
- Verwendung der Systemvorgabe.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Flutter-Themes,
- Material-Themes,
- Plattformdarstellung,
- konkrete Schriftgrößen,
- Farbdefinitionen,
- UI-Komponenten,
- Accessibility-Implementierungen.

Diese Validation Rule beschreibt ausschließlich die fachliche
Darstellungspräferenz.

### Verhalten bei Änderungen

Die Operation

```text
ProfileSettings.changeAppearanceSettings(...)
```

erzeugt ausschließlich einen neuen vollständigen und gültigen
`AppearanceSettings`-Zustand.

Ein identischer neuer Wert ist kein Validierungsfehler.

Das No-Change-Verhalten wird getrennt von den Validation Errors
spezifiziert.

### Traceability

**Domain Model**

- `AppearanceSettings`
- `AppearanceSettings.create(...)`
- `ThemePreference`
- `TextScalePreference`
- `ProfileSettings.changeAppearanceSettings(...)`

**Business Rules**

- PRO-BR-026
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

# PRO-VR-023

## Titel

ProfileSettingsDefaults validieren

### Typ

Value-Object-Validierung

### Beschreibung

`ProfileSettingsDefaults` beschreibt einen vollständigen fachlichen
Standardzustand der Profileinstellungen.

Das Value Object wird ausschließlich für

```text
ProfileSettings.resetToDefaults(...)
```

verwendet.

Es besitzt keine Identität und ist vollständig unveränderlich.

### Fachliche Regeln

Für `ProfileSettingsDefaults` gilt:

- `localization` MUSS vorhanden sein.
- `dashboard` MUSS vorhanden sein.
- `appearance` MUSS vorhanden sein.
- Alle drei enthaltenen Value Objects MÜSSEN gültig sein.
- Das Value Object MUSS immer einen vollständigen Standardzustand
  repräsentieren.
- Änderungen erzeugen ausschließlich einen neuen vollständigen Zustand.

Die Validierung der enthaltenen Value Objects erfolgt ausschließlich durch
deren jeweilige Validation Rules.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PDEF-001 | `validation.profileSettingsDefaults.localization.required` | ERROR | VALIDATION | localization | required | – |
| PRO-VAL-PDEF-002 | `validation.profileSettingsDefaults.dashboard.required` | ERROR | VALIDATION | dashboard | required | – |
| PRO-VAL-PDEF-003 | `validation.profileSettingsDefaults.appearance.required` | ERROR | VALIDATION | appearance | required | – |
| PRO-VAL-PDEF-004 | `validation.profileSettingsDefaults.incomplete` | ERROR | VALIDATION | profileSettingsDefaults | completeness | `{"requiredFields":["localization","dashboard","appearance"]}` |

### Fehlerverhalten

#### Fehlende LocalizationSettings

Ist `localization` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PDEF-001
```

erzeugt.

#### Fehlende DashboardSettings

Ist `dashboard` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PDEF-002
```

erzeugt.

#### Fehlende AppearanceSettings

Ist `appearance` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PDEF-003
```

erzeugt.

#### Unvollständiger Standardzustand

Fehlt mindestens einer der drei Pflichtbestandteile, kann zusätzlich

```text
PRO-VAL-PDEF-004
```

erzeugt werden, sofern nicht bereits ein eindeutiger Pflichtfeldfehler den
Zustand vollständig beschreibt.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. `localization`
2. `dashboard`
3. `appearance`
4. Vollständigkeit des Gesamtzustands

Die enthaltenen Value Objects werden ausschließlich durch ihre eigenen
Validation Rules geprüft.

Fehler dieser Value Objects werden nicht erneut als
`ProfileSettingsDefaults`-Fehler erzeugt.

Dadurch werden doppelte Fehlermeldungen vermieden.

### Nicht als Fehler definiert

Die folgenden Situationen sind keine Validierungsfehler:

- ein anderer vollständiger Standardzustand,
- geänderte Dashboard-Konfiguration,
- geänderte Sprache,
- geänderte Darstellungspräferenz.

Solange alle enthaltenen Value Objects gültig sind, ist jeder vollständige
Standardzustand zulässig.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- ProfileSettingsId,
- AuditInformation,
- AggregateVersion,
- Persistenz,
- Benutzerprofile,
- UI-Komponenten.

Diese Validation Rule beschreibt ausschließlich den vollständigen fachlichen
Standardzustand der Profileinstellungen.

### Verhalten bei fachlichen Operationen

Die Operation

```text
ProfileSettings.resetToDefaults(...)
```

darf ausschließlich einen vollständigen und gültigen
`ProfileSettingsDefaults`-Zustand übernehmen.

Ein bereits identischer Standardzustand ist kein Validierungsfehler.

Das No-Change-Verhalten wird getrennt von den Validation Errors
spezifiziert.

### Equality

Zwei `ProfileSettingsDefaults` sind fachlich gleich, wenn

- `localization`,
- `dashboard`,
- `appearance`

fachlich gleich sind.

### Traceability

**Domain Model**

- `ProfileSettingsDefaults`
- `ProfileSettingsDefaults.create(...)`
- `ProfileSettings.resetToDefaults(...)`

**Business Rules**

- PRO-BR-026
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

# PRO-VR-024

## Titel

ProfileSecurity validieren

### Typ

Entity-Validierung

### Beschreibung

`ProfileSecurity` beschreibt den sicherheitsrelevanten Zustand eines Profils.

Die Entity besteht aus

- einer unveränderlichen `ProfileSecurityId`,
- optional einem `PasswordCredential`,
- einem gültigen `LockState`.

Sie darf ausschließlich als vollständiger und konsistenter Zustand erzeugt
oder rekonstruiert werden.

Die kontrollierte Erzeugung erfolgt über

```text
DomainResult<ProfileSecurity> ProfileSecurity.create(
    ProfileSecurityId? securityId,
    PasswordCredential? passwordCredential,
    LockState? lockState
)
```

### Fachliche Regeln

Für `ProfileSecurity` gilt:

- `securityId` MUSS vorhanden und gültig sein.
- `securityId` DARF nach der Erzeugung nicht verändert werden.
- `lockState` MUSS vorhanden und gültig sein.
- Ein Profil ohne `PasswordCredential` DARF nicht gesperrt sein.
- Ein vorhandenes `PasswordCredential` MUSS gültig sein.
- Klartextpasswörter DÜRFEN nicht Bestandteil der Entity sein.
- Fehlgeschlagene Operationen DÜRFEN den bestehenden Zustand nicht verändern.
- Die Entity erzeugt keine Domain Events.

Die enthaltenen Value Objects werden ausschließlich durch ihre eigenen
Validation Rules validiert.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PSEC-001 | `validation.profileSecurity.securityId.required` | ERROR | VALIDATION | securityId | required | – |
| PRO-VAL-PSEC-002 | `validation.profileSecurity.securityId.invalid` | ERROR | VALIDATION | securityId | invalid | – |
| PRO-VAL-PSEC-003 | `validation.profileSecurity.lockState.required` | ERROR | VALIDATION | lockState | required | – |
| PRO-VAL-PSEC-004 | `validation.profileSecurity.passwordCredential.invalid` | ERROR | VALIDATION | passwordCredential | invalid | – |
| PRO-VAL-PSEC-005 | `validation.profileSecurity.lockState.requiresCredential` | ERROR | VALIDATION | lockState | consistency | `{"required":"passwordCredential"}` |
| PRO-VAL-PSEC-006 | `validation.profileSecurity.incomplete` | ERROR | VALIDATION | profileSecurity | completeness | `{"requiredFields":["securityId","lockState"]}` |

### Fehlerverhalten

#### Fehlende ProfileSecurityId

Ist `securityId` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PSEC-001
```

erzeugt.

#### Ungültige ProfileSecurityId

Ist `securityId` ungültig, wird

```text
PRO-VAL-PSEC-002
```

erzeugt.

#### Fehlender LockState

Ist `lockState` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PSEC-003
```

erzeugt.

#### Ungültiges PasswordCredential

Ist ein `PasswordCredential` vorhanden, aber ungültig, wird

```text
PRO-VAL-PSEC-004
```

erzeugt.

#### Gesperrter Zustand ohne Credential

Befindet sich `lockState` im gesperrten Zustand und ist gleichzeitig kein
`PasswordCredential` vorhanden, wird

```text
PRO-VAL-PSEC-005
```

erzeugt.

#### Unvollständiger Sicherheitszustand

Fehlt mindestens einer der Pflichtbestandteile, kann zusätzlich

```text
PRO-VAL-PSEC-006
```

erzeugt werden, sofern nicht bereits ein eindeutiger Pflichtfeldfehler den
Zustand vollständig beschreibt.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. `securityId`
2. `lockState`
3. optionales `PasswordCredential`
4. Konsistenz zwischen Credential und LockState
5. Vollständigkeit des Gesamtzustands

Die enthaltenen Value Objects werden ausschließlich durch ihre eigenen
Validation Rules geprüft.

Fehler dieser Value Objects werden nicht erneut als
`ProfileSecurity`-Fehler erzeugt.

Dadurch werden doppelte Fehlermeldungen vermieden.

### Nicht als Fehler definiert

Die folgenden Situationen sind keine Validierungsfehler:

- kein `PasswordCredential`,
- entsperrter Zustand ohne `PasswordCredential`,
- Austausch eines gültigen `PasswordCredential`,
- gültiger entsperrter Zustand.

Die fachliche Zulässigkeit von Operationen wie

- Passwortschutz aktivieren,
- Passwortschutz deaktivieren,
- Passwort ändern,
- sperren,
- entsperren

ist keine Aufgabe der Entity-Validierung.

Diese Fälle werden ausschließlich durch die Business Rules beschrieben.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Passwortprüfung,
- Passwortstärke,
- Authentifizierung,
- AuthenticationProof,
- Passwort-Ports,
- Kryptographie,
- technische Hashverfahren,
- Domain Events,
- Application Services.

Diese Validation Rule beschreibt ausschließlich den gültigen
Sicherheitszustand der Entity.

### Verhalten bei fachlichen Operationen

Die Operationen

```text
enablePasswordProtection(...)

disablePasswordProtection(...)

changePasswordCredential(...)

lock(...)

unlock(...)
```

dürfen ausschließlich vollständige und konsistente Zielzustände erzeugen.

Ein erfolgreicher No-Change ist kein Validierungsfehler.

Business Errors werden getrennt von Validation Errors spezifiziert.

### Traceability

**Domain Model**

- `ProfileSecurity`
- `ProfileSecurity.create(...)`
- `ProfileSecurity.enablePasswordProtection(...)`
- `ProfileSecurity.disablePasswordProtection(...)`
- `ProfileSecurity.changePasswordCredential(...)`
- `ProfileSecurity.lock(...)`
- `ProfileSecurity.unlock(...)`
- `PasswordCredential`
- `LockState`

**Business Rules**

- PRO-BR-026
- PRO-BR-027

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-009

---

---

# PRO-VR-025

## Titel

ProfileSettingsId validieren

### Typ

Value-Object-Validierung

### Beschreibung

`ProfileSettingsId` repräsentiert die unveränderliche lokale Identität der
untergeordneten Entity `ProfileSettings`.

Die ID besitzt ausschließlich innerhalb des `Profile`-Aggregats eine
fachliche Bedeutung.

Sie darf nicht als Ersatz für `ProfileId` verwendet und nicht aus
personenbezogenen Profildaten abgeleitet werden.

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<ProfileSettingsId> ProfileSettingsId.fromString(
  String? value
)
```

Die Erzeugung einer neuen Identität erfolgt über:

```text
DomainResult<ProfileSettingsId> ProfileSettingsId.generate()
```

### Interner Wert

```text
UUIDv7
```

### Fachliche Regeln

Für `ProfileSettingsId.fromString(...)` gilt:

- `value` MUSS vorhanden sein.
- `value` DARF nach dem Trimmen nicht leer sein.
- `value` MUSS eine syntaktisch gültige UUID Version 7 repräsentieren.
- Der normalisierte Wert MUSS in kanonischer UUIDv7-Darstellung gespeichert
  werden.
- Die erzeugte ID MUSS unveränderlich sein.
- Die ID DARF nicht aus `ProfileId`, Profilname oder anderen Profildaten
  abgeleitet werden.
- Die ID DARF nicht als `ProfileId` verwendet werden.

Die Prüfung, ob eine ID innerhalb eines konkreten Aggregats bereits
verwendet wird, gehört nicht zur lokalen Formatvalidierung dieses
Value Objects.

### Normalisierung

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Der anschließend validierte UUIDv7-Wert wird in seiner kanonischen
UUIDv7-Repräsentation gespeichert.

Weitere fachliche Transformationen sind nicht zulässig.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PSETID-001 | `validation.profileSettingsId.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PSETID-002 | `validation.profileSettingsId.blank` | ERROR | VALIDATION | value | blank | – |
| PRO-VAL-PSETID-003 | `validation.profileSettingsId.invalidFormat` | ERROR | VALIDATION | value | format | `{"expectedFormat":"UUIDv7"}` |

### Fehlerverhalten

#### Fehlender Wert

Ist `value` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PSETID-001
```

erzeugt.

Weitere Prüfungen werden in diesem Fall nicht durchgeführt.

#### Leerer Wert

Ist `value` vorhanden, ergibt aber nach dem Trimmen einen leeren Wert, wird
ausschließlich

```text
PRO-VAL-PSETID-002
```

erzeugt.

Eine zusätzliche Formatprüfung wird in diesem Fall nicht durchgeführt.

#### Ungültiges UUIDv7-Format

Ist der normalisierte Wert vorhanden und nicht leer, repräsentiert aber
keine syntaktisch gültige UUID Version 7, wird

```text
PRO-VAL-PSETID-003
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "expectedFormat": "UUIDv7"
}
```

Der ungültige Eingabewert wird nicht als Fehlerparameter übertragen.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `value` prüfen.
2. Normalisierung durch Trimmen durchführen.
3. Leeren normalisierten Wert prüfen.
4. UUIDv7-Format und UUID-Version prüfen.
5. Kanonische UUIDv7-Repräsentation herstellen.
6. Gültige unveränderliche `ProfileSettingsId` erzeugen.

Ein fehlender Wert erzeugt keinen zusätzlichen Blank- oder Formatfehler.

Ein leerer normalisierter Wert erzeugt keinen zusätzlichen Formatfehler.

Dadurch werden Folgefehler vermieden.

### Verhalten von generate()

Die Factory

```text
ProfileSettingsId.generate()
```

erzeugt ausschließlich eine neue gültige UUID Version 7.

Für die technische Erzeugung darf das Dart-Paket

```text
uuid
```

als reguläre Projektabhängigkeit verwendet werden.

Die Bibliothek ist ausschließlich ein internes technisches
Implementierungsdetail.

Typen der Bibliothek dürfen nicht Bestandteil sein von

- der öffentlichen Domain-Schnittstelle,
- `DomainResult`,
- Domain Messages,
- Fehlerparametern.

Die öffentliche Repräsentation von `ProfileSettingsId` bleibt ein
domäneneigener, unveränderlicher String-basierter Wert.

Jede erfolgreich erzeugte ID MUSS sämtliche Regeln dieser Validation Rule
erfüllen.

Für `generate()` werden keine Validation Errors definiert.

Ein unerwartetes technisches Versagen der UUID-Erzeugung ist kein
fachlicher Validierungsfehler und darf nicht mit einem
`PRO-VAL-PSETID-*`-Code abgebildet werden.

### Equality

Zwei `ProfileSettingsId`-Instanzen sind fachlich gleich, wenn ihre
kanonischen UUIDv7-Werte identisch sind.

Der Hashcode basiert ausschließlich auf dem kanonischen UUIDv7-Wert.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Eindeutigkeitsprüfungen über mehrere Aggregate,
- Persistenzkonflikte,
- Datenbank-Constraints,
- Verwendung als `ProfileId`,
- technische Generatorfehler,
- Serialisierung,
- JSON-Mapping,
- Repositoryzugriffe.

Die Entity `ProfileSettings` prüft ausschließlich, ob eine gültige
`ProfileSettingsId` vorhanden ist.

Sie erzeugt die internen Fehler dieses Value Objects nicht erneut als
`ProfileSettings`-Fehler.

### Traceability

**Domain Model**

- `ProfileSettingsId`
- `ProfileSettingsId.generate()`
- `ProfileSettingsId.fromString(...)`
- `ProfileSettings.settingsId`
- `ProfileSettings.create(...)`
- PRO-EINV-001

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-026

## Titel

ProfileSecurityId validieren

### Typ

Value-Object-Validierung

### Beschreibung

`ProfileSecurityId` repräsentiert die unveränderliche lokale Identität der
untergeordneten Entity `ProfileSecurity`.

Die ID besitzt ausschließlich innerhalb des `Profile`-Aggregats eine
fachliche Bedeutung.

Sie darf nicht als Ersatz für `ProfileId`, `ProfileSettingsId` oder eine
andere fachliche Identität verwendet werden.

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<ProfileSecurityId> ProfileSecurityId.fromString(
  String? value
)
```

Die Erzeugung einer neuen Identität erfolgt über:

```text
DomainResult<ProfileSecurityId> ProfileSecurityId.generate()
```

### Interner Wert

```text
UUIDv7
```

### Fachliche Regeln

Für `ProfileSecurityId.fromString(...)` gilt:

- `value` MUSS vorhanden sein.
- `value` DARF nach dem Trimmen nicht leer sein.
- `value` MUSS eine syntaktisch gültige UUID Version 7 repräsentieren.
- Der normalisierte Wert MUSS in kanonischer UUIDv7-Darstellung gespeichert
  werden.
- Die erzeugte ID MUSS unveränderlich sein.
- Die ID DARF nicht aus Passwörtern, Credentials, Hashes,
  `AuthenticationProof`, Profilnamen oder anderen Profildaten abgeleitet
  werden.
- Die ID DARF nicht als `ProfileId` oder `ProfileSettingsId` verwendet
  werden.

Die Prüfung, ob eine ID innerhalb eines konkreten Aggregats bereits
verwendet wird, gehört nicht zur lokalen Formatvalidierung dieses
Value Objects.

### Normalisierung

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Der anschließend validierte UUIDv7-Wert wird in seiner kanonischen
UUIDv7-Repräsentation und in Kleinschreibung gespeichert.

Weitere fachliche Transformationen sind nicht zulässig.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PSECID-001 | `validation.profileSecurityId.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PSECID-002 | `validation.profileSecurityId.blank` | ERROR | VALIDATION | value | blank | – |
| PRO-VAL-PSECID-003 | `validation.profileSecurityId.invalidFormat` | ERROR | VALIDATION | value | format | `{"expectedFormat":"UUIDv7"}` |

### Fehlerverhalten

#### Fehlender Wert

Ist `value` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PSECID-001
```

erzeugt.

Weitere Prüfungen werden in diesem Fall nicht durchgeführt.

#### Leerer Wert

Ist `value` vorhanden, ergibt aber nach dem Trimmen einen leeren Wert, wird
ausschließlich

```text
PRO-VAL-PSECID-002
```

erzeugt.

Eine zusätzliche Formatprüfung wird in diesem Fall nicht durchgeführt.

#### Ungültiges UUIDv7-Format

Ist der normalisierte Wert vorhanden und nicht leer, repräsentiert aber
keine syntaktisch gültige UUID Version 7, wird

```text
PRO-VAL-PSECID-003
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "expectedFormat": "UUIDv7"
}
```

Der ungültige Eingabewert wird nicht als Fehlerparameter übertragen.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `value` prüfen.
2. Normalisierung durch Trimmen durchführen.
3. Leeren normalisierten Wert prüfen.
4. UUIDv7-Format und UUID-Version prüfen.
5. Kanonische UUIDv7-Repräsentation herstellen.
6. Gültige unveränderliche `ProfileSecurityId` erzeugen.

Ein fehlender Wert erzeugt keinen zusätzlichen Blank- oder Formatfehler.

Ein leerer normalisierter Wert erzeugt keinen zusätzlichen Formatfehler.

Dadurch werden Folgefehler vermieden.

### Verhalten von generate()

Die Factory

```text
ProfileSecurityId.generate()
```

erzeugt ausschließlich eine neue gültige UUID Version 7.

Für die technische Erzeugung darf die bereits im Projekt verwendete
UUID-Bibliothek eingesetzt werden.

Die Bibliothek ist ausschließlich ein internes technisches
Implementierungsdetail.

Typen der UUID-Bibliothek dürfen nicht Bestandteil sein von

- der öffentlichen Domain-Schnittstelle,
- `DomainResult`,
- Domain Messages,
- Fehlerparametern.

Für `generate()` werden keine Validation Errors definiert.

Ein unerwartetes technisches Versagen der UUID-Erzeugung ist kein
fachlicher Validierungsfehler und darf nicht mit einem
`PRO-VAL-PSECID-*`-Code abgebildet werden.

### Equality

Zwei `ProfileSecurityId`-Instanzen sind fachlich gleich, wenn ihre
kanonischen UUIDv7-Werte identisch sind.

Der Hashcode basiert ausschließlich auf dem kanonischen UUIDv7-Wert.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Eindeutigkeitsprüfungen über mehrere Aggregate,
- Persistenzkonflikte,
- Datenbank-Constraints,
- Verwendung als `ProfileId`,
- Verwendung als `ProfileSettingsId`,
- technische Generatorfehler,
- Serialisierung,
- JSON-Mapping,
- Repositoryzugriffe,
- Passwortprüfung,
- Authentifizierung,
- Credential-Erzeugung.

Die Entity `ProfileSecurity` prüft ausschließlich, ob eine gültige
`ProfileSecurityId` vorhanden ist.

Sie erzeugt die internen Fehler dieses Value Objects nicht erneut als
`ProfileSecurity`-Fehler.

### Traceability

**Domain Model**

- `ProfileSecurityId`
- `ProfileSecurityId.generate()`
- `ProfileSecurityId.fromString(...)`
- `ProfileSecurity.securityId`
- `ProfileSecurity.create(...)`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-027

## Titel

PasswordAlgorithm validieren

### Typ

Value-Object-Validierung

### Beschreibung

`PasswordAlgorithm` bezeichnet den kryptographischen Algorithmus, mit dem
ein `PasswordHash` erzeugt wurde.

Für Version 1 des Profilmoduls ist ausschließlich folgender Wert zulässig:

```text
argon2id
```

Die Enumeration führt selbst keine kryptographischen Operationen aus.

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<PasswordAlgorithm> PasswordAlgorithm.fromString(
  String? value
)
```

### Fachliche Regeln

Für `PasswordAlgorithm.fromString(...)` gilt:

- `value` MUSS vorhanden sein.
- `value` DARF nach dem Trimmen nicht leer sein.
- Der normalisierte Wert MUSS exakt `argon2id` entsprechen.
- Groß- und Kleinschreibung werden nicht automatisch verändert.
- Ein unbekannter Wert DARF nicht durch einen Standardwert ersetzt werden.
- Weitere Algorithmen sind in Version 1 nicht zulässig.

### Normalisierung

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

Insbesondere wird die Groß- und Kleinschreibung nicht verändert.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PALG-001 | `validation.passwordAlgorithm.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PALG-002 | `validation.passwordAlgorithm.invalid` | ERROR | VALIDATION | value | enum | `{"allowedValues":["argon2id"]}` |

### Fehlerverhalten

#### Fehlender oder leerer Wert

Ist `value` nicht vorhanden oder nach dem Trimmen leer, wird ausschließlich

```text
PRO-VAL-PALG-001
```

erzeugt.

Ein zusätzlicher Enum-Fehler wird nicht erzeugt.

#### Nicht unterstützter Algorithmus

Entspricht der normalisierte Wert nicht exakt `argon2id`, wird

```text
PRO-VAL-PALG-002
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "allowedValues": [
    "argon2id"
  ]
}
```

Der ungültige Eingabewert wird nicht als Fehlerparameter übertragen.

### Validierungsreihenfolge

1. Vorhandensein prüfen.
2. Trimmen.
3. Leeren Wert prüfen.
4. Unterstützten Enumerationswert prüfen.
5. Gültigen `PasswordAlgorithm` erzeugen.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Passwort-Hashing,
- Passwortverifikation,
- Auswahl kryptographischer Bibliotheken,
- Argon2id-Parameter,
- Migration bestehender Credentials.

### Traceability

**Domain Model**

- `PasswordAlgorithm`
- `PasswordAlgorithm.fromString(...)`
- `PasswordCredential.algorithm`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-028

## Titel

PasswordHash validieren

### Typ

Value-Object-Validierung

### Beschreibung

`PasswordHash` repräsentiert einen bereits kryptographisch erzeugten
Passwort-Hash.

Die Domain behandelt den Wert ausschließlich als undurchsichtigen,
unveränderlichen Sicherheitswert.

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<PasswordHash> PasswordHash.fromPersistedValue(
  String? value
)
```

Die Factory erzeugt selbst keinen Passwort-Hash.

### Fachliche Regeln

Für `PasswordHash` gilt:

- `value` MUSS vorhanden sein.
- `value` DARF nach dem Trimmen nicht leer sein.
- Der Wert MUSS unveränderlich gespeichert werden.
- Der Wert DARF nicht fachlich interpretiert oder zerlegt werden.
- Der Wert DARF nicht aus einem Klartextpasswort innerhalb der Domain
  erzeugt werden.
- Der Wert DARF nicht in Domain Messages oder Fehlerparametern offengelegt
  werden.

### Normalisierung

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

Insbesondere dürfen nicht verändert werden:

- Groß- und Kleinschreibung,
- Sonderzeichen,
- Präfixe,
- Trennzeichen,
- algorithmusspezifische Bestandteile.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PHASH-001 | `validation.passwordHash.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PHASH-002 | `validation.passwordHash.blank` | ERROR | VALIDATION | value | blank | – |

### Fehlerverhalten

#### Fehlender Wert

Ist `value` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PHASH-001
```

erzeugt.

#### Leerer Wert

Ist `value` vorhanden, ergibt nach dem Trimmen aber einen leeren Wert, wird
ausschließlich

```text
PRO-VAL-PHASH-002
```

erzeugt.

Der tatsächliche Hashwert wird niemals als Fehlerparameter übertragen.

### Validierungsreihenfolge

1. Vorhandensein prüfen.
2. Trimmen.
3. Leeren Wert prüfen.
4. Unveränderlichen `PasswordHash` erzeugen.

### Sichere Darstellung

Der tatsächliche Hashwert darf nicht durch `toString()` ausgegeben werden.

Die sichere Darstellung lautet:

```text
PasswordHash(<redacted>)
```

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Passwort-Hashing,
- Hashformatinterpretation,
- Passwortverifikation,
- Algorithmusprüfung,
- Hashparameter,
- Salt-Erzeugung.

### Traceability

**Domain Model**

- `PasswordHash`
- `PasswordHash.fromPersistedValue(...)`
- `PasswordCredential.hash`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-029

## Titel

PasswordHashParameters validieren

### Typ

Value-Object-Validierung

### Beschreibung

`PasswordHashParameters` repräsentiert die Parameter, mit denen ein
`PasswordHash` erzeugt wurde.

Das Value Object besteht aus:

- `memoryCostKiB`,
- `iterations`,
- `parallelism`,
- `salt`.

Die kontrollierte Erzeugung erfolgt über:

```text
DomainResult<PasswordHashParameters> create(
  int? memoryCostKiB,
  int? iterations,
  int? parallelism,
  String? salt
)
```

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<PasswordHashParameters> fromPersistedValues(
  int? memoryCostKiB,
  int? iterations,
  int? parallelism,
  String? salt
)
```

Beide Factories prüfen dieselben fachlichen Invarianten.

### Fachliche Regeln

Für `PasswordHashParameters` gilt:

- `memoryCostKiB` MUSS vorhanden sein.
- `memoryCostKiB` MUSS größer als `0` sein.
- `iterations` MUSS vorhanden sein.
- `iterations` MUSS größer als `0` sein.
- `parallelism` MUSS vorhanden sein.
- `parallelism` MUSS größer als `0` sein.
- `salt` MUSS vorhanden sein.
- `salt` DARF nach dem Trimmen nicht leer sein.
- Alle vier Bestandteile MÜSSEN gemeinsam einen vollständigen Zustand
  bilden.
- Fehlende Werte DÜRFEN nicht durch Standardwerte ersetzt werden.
- Der Salt-Wert DARF nicht in Domain Messages oder Fehlerparametern
  offengelegt werden.

Es werden derzeit keine weiteren Mindest-, Höchst- oder Zielwerte
festgelegt.

### Normalisierung

Für `salt` werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen des Salt-Werts sind unzulässig.

Numerische Werte werden nicht normalisiert.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PHPAR-001 | `validation.passwordHashParameters.memoryCostKiB.required` | ERROR | VALIDATION | memoryCostKiB | required | – |
| PRO-VAL-PHPAR-002 | `validation.passwordHashParameters.memoryCostKiB.minimum` | ERROR | VALIDATION | memoryCostKiB | minimum | `{"minimum":1,"actual":"<value>"}` |
| PRO-VAL-PHPAR-003 | `validation.passwordHashParameters.iterations.required` | ERROR | VALIDATION | iterations | required | – |
| PRO-VAL-PHPAR-004 | `validation.passwordHashParameters.iterations.minimum` | ERROR | VALIDATION | iterations | minimum | `{"minimum":1,"actual":"<value>"}` |
| PRO-VAL-PHPAR-005 | `validation.passwordHashParameters.parallelism.required` | ERROR | VALIDATION | parallelism | required | – |
| PRO-VAL-PHPAR-006 | `validation.passwordHashParameters.parallelism.minimum` | ERROR | VALIDATION | parallelism | minimum | `{"minimum":1,"actual":"<value>"}` |
| PRO-VAL-PHPAR-007 | `validation.passwordHashParameters.salt.required` | ERROR | VALIDATION | salt | required | – |
| PRO-VAL-PHPAR-008 | `validation.passwordHashParameters.salt.blank` | ERROR | VALIDATION | salt | blank | – |

### Fehlerverhalten

#### Fehlender Speicherparameter

Ist `memoryCostKiB` nicht vorhanden, wird

```text
PRO-VAL-PHPAR-001
```

erzeugt.

Ein zusätzlicher Mindestwertfehler wird nicht erzeugt.

#### Ungültiger Speicherparameter

Ist `memoryCostKiB` kleiner als `1`, wird

```text
PRO-VAL-PHPAR-002
```

erzeugt.

#### Fehlende Iterationen

Ist `iterations` nicht vorhanden, wird

```text
PRO-VAL-PHPAR-003
```

erzeugt.

Ein zusätzlicher Mindestwertfehler wird nicht erzeugt.

#### Ungültige Iterationen

Ist `iterations` kleiner als `1`, wird

```text
PRO-VAL-PHPAR-004
```

erzeugt.

#### Fehlender Parallelitätsgrad

Ist `parallelism` nicht vorhanden, wird

```text
PRO-VAL-PHPAR-005
```

erzeugt.

Ein zusätzlicher Mindestwertfehler wird nicht erzeugt.

#### Ungültiger Parallelitätsgrad

Ist `parallelism` kleiner als `1`, wird

```text
PRO-VAL-PHPAR-006
```

erzeugt.

#### Fehlender Salt-Wert

Ist `salt` nicht vorhanden, wird

```text
PRO-VAL-PHPAR-007
```

erzeugt.

#### Leerer Salt-Wert

Ist `salt` vorhanden, ergibt nach dem Trimmen aber einen leeren Wert, wird

```text
PRO-VAL-PHPAR-008
```

erzeugt.

Der Salt-Wert wird niemals als Fehlerparameter übertragen.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. `memoryCostKiB` auf Vorhandensein prüfen.
2. `memoryCostKiB` auf Mindestwert prüfen.
3. `iterations` auf Vorhandensein prüfen.
4. `iterations` auf Mindestwert prüfen.
5. `parallelism` auf Vorhandensein prüfen.
6. `parallelism` auf Mindestwert prüfen.
7. `salt` auf Vorhandensein prüfen.
8. `salt` trimmen.
9. `salt` auf Leerwert prüfen.
10. Vollständiges Value Object erzeugen.

Fehlende numerische Werte erzeugen keinen zusätzlichen Mindestwertfehler.

Ein fehlender Salt-Wert erzeugt keinen zusätzlichen Blank-Fehler.

### Sichere Darstellung

Der Salt-Wert darf nicht durch `toString()` ausgegeben werden.

Eine sichere Darstellung lautet:

```text
PasswordHashParameters(
  memoryCostKiB: <value>,
  iterations: <value>,
  parallelism: <value>,
  salt: <redacted>
)
```

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Auswahl optimaler Argon2id-Parameter,
- aktuelle Sicherheitsempfehlungen,
- Salt-Erzeugung,
- Passwort-Hashing,
- Passwortverifikation,
- Migration bestehender Parameter.

### Traceability

**Domain Model**

- `PasswordHashParameters`
- `PasswordHashParameters.create(...)`
- `PasswordHashParameters.fromPersistedValues(...)`
- `PasswordCredential.parameters`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-030

## Titel

PasswordCredential validieren

### Typ

Value-Object-Validierung

### Beschreibung

`PasswordCredential` repräsentiert den vollständigen fachlichen Nachweis
eines bereits kryptographisch verarbeiteten Passworts.

Das Value Object besteht aus:

- `PasswordHash`,
- `PasswordAlgorithm`,
- `PasswordHashParameters`,
- `Timestamp`.

Die kontrollierte Erzeugung und Rekonstruktion erfolgen über:

```text
DomainResult<PasswordCredential> create(
  PasswordHash? hash,
  PasswordAlgorithm? algorithm,
  PasswordHashParameters? parameters,
  Timestamp? createdAt
)
```

Dieselbe Factory wird für die Übernahme eines neu erzeugten Credentials und
für die Rekonstruktion eines gespeicherten Credentials verwendet.

### Fachliche Regeln

Für `PasswordCredential` gilt:

- `hash` MUSS vorhanden und gültig sein.
- `algorithm` MUSS vorhanden und gültig sein.
- `parameters` MÜSSEN vorhanden und gültig sein.
- `createdAt` MUSS vorhanden und gültig sein.
- Alle vier Bestandteile MÜSSEN gemeinsam einen vollständigen Zustand
  bilden.
- Für Version 1 MUSS `algorithm` dem Wert `argon2id` entsprechen.
- Eine teilweise erzeugte Instanz ist unzulässig.
- Das Credential MUSS unveränderlich sein.
- Das Credential DARF kein `PlainPassword` enthalten.
- Hash- und Salt-Werte DÜRFEN nicht offengelegt werden.

Die interne Validierung der enthaltenen Value Objects erfolgt ausschließlich
durch deren eigene Validation Rules.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PCRED-001 | `validation.passwordCredential.hash.required` | ERROR | VALIDATION | hash | required | – |
| PRO-VAL-PCRED-002 | `validation.passwordCredential.algorithm.required` | ERROR | VALIDATION | algorithm | required | – |
| PRO-VAL-PCRED-003 | `validation.passwordCredential.parameters.required` | ERROR | VALIDATION | parameters | required | – |
| PRO-VAL-PCRED-004 | `validation.passwordCredential.createdAt.required` | ERROR | VALIDATION | createdAt | required | – |

### Fehlerverhalten

#### Fehlender PasswordHash

Ist `hash` nicht vorhanden, wird

```text
PRO-VAL-PCRED-001
```

erzeugt.

#### Fehlender PasswordAlgorithm

Ist `algorithm` nicht vorhanden, wird

```text
PRO-VAL-PCRED-002
```

erzeugt.

#### Fehlende PasswordHashParameters

Sind `parameters` nicht vorhanden, wird

```text
PRO-VAL-PCRED-003
```

erzeugt.

#### Fehlender Erzeugungszeitpunkt

Ist `createdAt` nicht vorhanden, wird

```text
PRO-VAL-PCRED-004
```

erzeugt.

### Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. `hash` prüfen.
2. `algorithm` prüfen.
3. `parameters` prüfen.
4. `createdAt` prüfen.
5. Vollständiges `PasswordCredential` erzeugen.

Mehrere fehlende Pflichtbestandteile dürfen gemeinsam als mehrere
strukturierte Validation Errors zurückgegeben werden.

### Keine Fehlerduplizierung

Die folgenden Fehler werden nicht erneut als
`PasswordCredential`-Fehler erzeugt:

- leerer oder ungültiger `PasswordHash`,
- ungültiger `PasswordAlgorithm`,
- ungültige `PasswordHashParameters`,
- ungültiger `Timestamp`.

Diese Fehler gehören ausschließlich zu den jeweiligen Value Objects.

Ein bereits typisiert übergebener `PasswordAlgorithm` ist bereits gültig
und entspricht für Version 1 dem Wert `argon2id`.

### Sichere Darstellung

`toString()` darf keine Hash- oder Salt-Werte ausgeben.

Eine sichere Darstellung lautet:

```text
PasswordCredential(
  algorithm: argon2id,
  createdAt: <timestamp>,
  hash: <redacted>,
  parameters: <redacted>
)
```

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Klartextpasswörter,
- Passwort-Hashing,
- Passwortverifikation,
- Security Ports,
- Hashbibliotheken,
- Salt-Erzeugung,
- AuthenticationProof,
- Passwortänderungsregeln,
- Lockout und Rate Limiting.

### Traceability

**Domain Model**

- `PasswordCredential`
- `PasswordCredential.create(...)`
- `PasswordHash`
- `PasswordAlgorithm`
- `PasswordHashParameters`
- `Timestamp`
- `ProfileSecurity.passwordCredential`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

---

# PRO-VR-031

## Titel

Timestamp validieren

### Typ

Value-Object-Validierung

### Beschreibung

`Timestamp` repräsentiert einen unveränderlichen fachlichen Zeitpunkt.

Innerhalb der Domain werden Zeitpunkte ausschließlich in UTC gespeichert.

Die kontrollierte Erzeugung erfolgt über:

```text
DomainResult<Timestamp> Timestamp.fromUtc(
  DateTime? value
)
```

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<Timestamp> Timestamp.parseIso8601(
  String? value
)
```

Diese Validation Rule beschreibt ausschließlich die allgemeine Gültigkeit
eines einzelnen `Timestamp`.

Chronologische Beziehungen zwischen mehreren Zeitpunkten werden durch die
jeweils zuständigen Domain-Typen validiert.

### Fachliche Regeln

Für `Timestamp.fromUtc(...)` gilt:

- `value` MUSS vorhanden sein.
- `value` MUSS bereits in UTC vorliegen.
- Eine automatische Umrechnung aus einer lokalen Zeitzone ist unzulässig.
- Der erzeugte Zeitpunkt MUSS unveränderlich sein.

Für `Timestamp.parseIso8601(...)` gilt:

- `value` MUSS vorhanden sein.
- `value` DARF nach dem Trimmen nicht leer sein.
- `value` MUSS einen syntaktisch gültigen ISO-8601-Zeitpunkt repräsentieren.
- Der Zeitwert MUSS ausdrücklich UTC repräsentieren.
- Die Eingabe MUSS mit dem UTC-Kennzeichen `Z` enden.
- Eine Eingabe mit lokalem Zeitpunkt oder numerischem Offset ist unzulässig.
- Der erzeugte Zeitpunkt MUSS unveränderlich sein.

### Normalisierung

Für `parseIso8601(...)` werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

Insbesondere erfolgt keine

- automatische Zeitzonenumrechnung,
- Ersetzung eines Offsets durch `Z`,
- Korrektur ungültiger Datums- oder Zeitbestandteile.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-TS-001 | `validation.timestamp.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-TS-002 | `validation.timestamp.notUtc` | ERROR | VALIDATION | value | utc | `{"expectedTimezone":"UTC"}` |
| PRO-VAL-TS-003 | `validation.timestamp.invalidFormat` | ERROR | VALIDATION | value | format | `{"expectedFormat":"ISO-8601 UTC"}` |
| PRO-VAL-TS-004 | `validation.timestamp.blank` | ERROR | VALIDATION | value | blank | – |

### Fehlerverhalten

#### Fehlender Wert

Ist bei `fromUtc(...)` oder `parseIso8601(...)` kein Wert vorhanden, wird
ausschließlich

```text
PRO-VAL-TS-001
```

erzeugt.

Weitere Prüfungen werden für diesen Wert nicht durchgeführt.

#### Leerer Stringwert

Ist der an `parseIso8601(...)` übergebene Wert vorhanden, ergibt nach dem
Trimmen aber einen leeren Wert, wird ausschließlich

```text
PRO-VAL-TS-004
```

erzeugt.

Ein zusätzlicher Format- oder UTC-Fehler wird nicht erzeugt.

#### Nicht-UTC-DateTime

Liegt der an `fromUtc(...)` übergebene `DateTime` nicht in UTC vor, wird

```text
PRO-VAL-TS-002
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "expectedTimezone": "UTC"
}
```

Der tatsächliche Zeitwert wird nicht als Fehlerparameter übertragen.

#### Ungültiges ISO-8601-Format

Ist der normalisierte String vorhanden und nicht leer, kann aber nicht als
gültiger ISO-8601-Zeitpunkt interpretiert werden, wird

```text
PRO-VAL-TS-003
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "expectedFormat": "ISO-8601 UTC"
}
```

Der ungültige Eingabewert wird nicht als Fehlerparameter übertragen.

#### ISO-8601-Wert ohne UTC-Kennzeichen

Repräsentiert der String zwar einen syntaktisch gültigen Zeitpunkt, aber
keinen ausdrücklich mit `Z` gekennzeichneten UTC-Zeitpunkt, wird

```text
PRO-VAL-TS-002
```

erzeugt.

Dies gilt insbesondere für

- lokale Zeitwerte ohne Zeitzonenkennzeichen,
- Zeitwerte mit positivem oder negativem numerischem Offset.

### Validierungsreihenfolge

#### Timestamp.fromUtc(...)

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `value` prüfen.
2. UTC-Eigenschaft prüfen.
3. Unveränderlichen `Timestamp` erzeugen.

#### Timestamp.parseIso8601(...)

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `value` prüfen.
2. Trimmen.
3. Leeren normalisierten Wert prüfen.
4. ISO-8601-Format prüfen.
5. Explizites UTC-Kennzeichen `Z` prüfen.
6. Unveränderlichen `Timestamp` erzeugen.

Ein fehlender Wert erzeugt keinen zusätzlichen Blank-, Format- oder
UTC-Fehler.

Ein leerer normalisierter Wert erzeugt keinen zusätzlichen Format- oder
UTC-Fehler.

Ein syntaktisch ungültiger Wert erzeugt keinen zusätzlichen UTC-Fehler.

Dadurch werden Folgefehler vermieden.

### Erfolgsverhalten

Bei erfolgreicher Erzeugung gilt:

- Der interne Zeitpunkt liegt in UTC vor.
- Der Wert ist unveränderlich.
- Die kanonische String-Darstellung verwendet ISO-8601 und endet mit `Z`.
- Es wurde keine automatische Zeitzonenumrechnung durchgeführt.

### Equality

Zwei `Timestamp`-Instanzen sind fachlich gleich, wenn sie denselben
UTC-Zeitpunkt repräsentieren.

Der Hashcode basiert ausschließlich auf dem UTC-Zeitpunkt.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- chronologische Vergleiche mehrerer Zeitpunkte,
- AuditInformation,
- Ablaufzeiten,
- Zeitdifferenzen,
- lokale Zeitzonen,
- Sommer- und Winterzeit,
- Benutzer-Locale,
- Kalenderdarstellung,
- Scheduling,
- Timer,
- technische Systemuhren.

Die chronologische Konsistenz von Auditinformationen wird weiterhin
ausschließlich durch `PRO-VR-014` beschrieben.

### Traceability

**Domain Model**

- `Timestamp`
- `Timestamp.fromUtc(...)`
- `Timestamp.parseIso8601(...)`
- `PasswordCredential.createdAt`
- `AuditInformation.createdAt`
- `AuditInformation.updatedAt`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

---

# PRO-VR-032

## Titel

AuthenticationProof validieren

### Typ

Value-Object-Validierung

### Beschreibung

`AuthenticationProof` bestätigt, dass eine technische Authentifizierung für
eine bestimmte `ProfileSecurity`-Entity erfolgreich abgeschlossen wurde.

Der Proof wird ausschließlich nach einer erfolgreichen technischen
Authentifizierung durch den zuständigen Security Port erzeugt.

Die kontrollierte Erzeugung erfolgt über:

```text
DomainResult<AuthenticationProof> AuthenticationProof.createVerified(
  ProfileSecurityId? securityId,
  Timestamp? verifiedAt,
  Timestamp? validUntil
)
```

Die Verwendbarkeit eines bereits erzeugten Proofs wird über folgende
Operation geprüft:

```text
DomainResult<AuthenticationProof> AuthenticationProof.validateFor(
  ProfileSecurityId? expectedSecurityId,
  Timestamp? now
)
```

Der Proof enthält keine Passwörter, Hashwerte, Credentials,
Authentifizierungstokens oder kryptographischen Schlüssel.

### Fachliche Regeln

Für `AuthenticationProof.createVerified(...)` gilt:

- `securityId` MUSS vorhanden und gültig sein.
- `verifiedAt` MUSS vorhanden und gültig sein.
- `validUntil` MUSS vorhanden und gültig sein.
- `validUntil` MUSS nach `verifiedAt` liegen.
- Ein identischer Wert für `verifiedAt` und `validUntil` ist unzulässig.
- Der Proof MUSS unveränderlich sein.
- Der Proof DARF keine Passwort-, Hash-, Credential-, Salt-, Token- oder
  Schlüsselinformationen enthalten.
- Der Proof DARF ausschließlich für die zugehörige `ProfileSecurityId`
  verwendet werden.
- Die Domain DARF fehlende Zeitwerte nicht selbst erzeugen.
- Die Domain DARF den Gültigkeitszeitraum nicht automatisch verlängern.

Für `AuthenticationProof.validateFor(...)` gilt:

- `expectedSecurityId` MUSS vorhanden und gültig sein.
- `now` MUSS vorhanden und gültig sein.
- `expectedSecurityId` MUSS der gespeicherten `securityId` entsprechen.
- `now` DARF nicht vor `verifiedAt` liegen.
- `now` DARF nicht nach `validUntil` liegen.
- Ein Proof ist einschließlich des Zeitpunkts `validUntil` gültig.
- Ein abgelaufener Proof DARF nicht erneut verwendet werden.

Es gilt:

```text
verifiedAt <= now <= validUntil
```

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-AUTHPRF-001 | `validation.authenticationProof.securityId.required` | ERROR | VALIDATION | securityId | required | – |
| PRO-VAL-AUTHPRF-002 | `validation.authenticationProof.verifiedAt.required` | ERROR | VALIDATION | verifiedAt | required | – |
| PRO-VAL-AUTHPRF-003 | `validation.authenticationProof.validUntil.required` | ERROR | VALIDATION | validUntil | required | – |
| PRO-VAL-AUTHPRF-004 | `validation.authenticationProof.validityPeriod.invalid` | ERROR | VALIDATION | validUntil | chronological | `{"comparison":"validUntilNotAfterVerifiedAt"}` |
| PRO-VAL-AUTHPRF-005 | `validation.authenticationProof.expectedSecurityId.required` | ERROR | VALIDATION | expectedSecurityId | required | – |
| PRO-VAL-AUTHPRF-006 | `validation.authenticationProof.now.required` | ERROR | VALIDATION | now | required | – |
| PRO-VAL-AUTHPRF-007 | `validation.authenticationProof.securityId.mismatch` | ERROR | VALIDATION | expectedSecurityId | ownership | – |
| PRO-VAL-AUTHPRF-008 | `validation.authenticationProof.notYetValid` | ERROR | VALIDATION | now | chronological | `{"comparison":"nowBeforeVerifiedAt"}` |
| PRO-VAL-AUTHPRF-009 | `validation.authenticationProof.expired` | ERROR | VALIDATION | now | expired | `{"comparison":"nowAfterValidUntil"}` |

### Fehlerverhalten

#### Fehlende ProfileSecurityId

Ist bei `createVerified(...)` keine `securityId` vorhanden, wird

```text
PRO-VAL-AUTHPRF-001
```

erzeugt.

#### Fehlender Verifizierungszeitpunkt

Ist `verifiedAt` nicht vorhanden, wird

```text
PRO-VAL-AUTHPRF-002
```

erzeugt.

#### Fehlender Ablaufzeitpunkt

Ist `validUntil` nicht vorhanden, wird

```text
PRO-VAL-AUTHPRF-003
```

erzeugt.

#### Ungültiger Gültigkeitszeitraum

Liegt `validUntil` nicht nach `verifiedAt`, wird

```text
PRO-VAL-AUTHPRF-004
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "comparison": "validUntilNotAfterVerifiedAt"
}
```

Die konkreten Zeitwerte werden nicht als Fehlerparameter übertragen.

#### Fehlende erwartete ProfileSecurityId

Ist bei `validateFor(...)` keine `expectedSecurityId` vorhanden, wird

```text
PRO-VAL-AUTHPRF-005
```

erzeugt.

#### Fehlender Prüfzeitpunkt

Ist bei `validateFor(...)` kein `now` vorhanden, wird

```text
PRO-VAL-AUTHPRF-006
```

erzeugt.

#### Falsche Zuordnung

Entspricht `expectedSecurityId` nicht der im Proof gespeicherten
`securityId`, wird

```text
PRO-VAL-AUTHPRF-007
```

erzeugt.

Die tatsächlichen IDs werden nicht als Fehlerparameter übertragen.

#### Proof noch nicht gültig

Liegt `now` vor `verifiedAt`, wird

```text
PRO-VAL-AUTHPRF-008
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "comparison": "nowBeforeVerifiedAt"
}
```

#### Proof abgelaufen

Liegt `now` nach `validUntil`, wird

```text
PRO-VAL-AUTHPRF-009
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "comparison": "nowAfterValidUntil"
}
```

Der Zeitpunkt `validUntil` selbst ist weiterhin gültig.

### Validierungsreihenfolge

#### AuthenticationProof.createVerified(...)

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `securityId` prüfen.
2. Vorhandensein von `verifiedAt` prüfen.
3. Vorhandensein von `validUntil` prüfen.
4. Chronologische Reihenfolge prüfen.
5. Vollständigen unveränderlichen Proof erzeugen.

Chronologische Prüfungen werden nur durchgeführt, wenn beide Zeitwerte
vorhanden sind.

#### AuthenticationProof.validateFor(...)

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein von `expectedSecurityId` prüfen.
2. Vorhandensein von `now` prüfen.
3. Zuordnung zu `securityId` prüfen.
4. `now` mit `verifiedAt` vergleichen.
5. `now` mit `validUntil` vergleichen.
6. Unveränderten Proof als erfolgreich verwendbar zurückgeben.

Fehlende Pflichtwerte erzeugen keine zusätzlichen Zuordnungs- oder
Chronologiefehler.

Eine falsche Zuordnung erzeugt keine zusätzlichen Zeitfehler.

Ein Zeitpunkt vor `verifiedAt` erzeugt keinen zusätzlichen Ablauf-Fehler.

Dadurch werden Folgefehler vermieden.

### Erfolgsverhalten

Bei erfolgreicher Erzeugung gilt:

- Der Proof ist vollständig.
- Der Proof ist einer `ProfileSecurityId` zugeordnet.
- `validUntil` liegt nach `verifiedAt`.
- Der Proof ist unveränderlich.
- Es wurden keine sensiblen Authentifizierungsdaten übernommen.

Bei erfolgreicher Prüfung durch `validateFor(...)` gilt:

- `expectedSecurityId` entspricht der gespeicherten `securityId`.
- `now` liegt innerhalb des gültigen Zeitraums.
- Der bestehende Proof bleibt unverändert.
- Es wird derselbe fachliche Proof zurückgegeben.
- Es entstehen keine Domain Events.
- Es werden keine Audit- oder Versionsinformationen verändert.

### Sichere Darstellung

Die String-Darstellung darf keine Passwort-, Hash-, Credential-, Token- oder
Schlüsselinformationen enthalten.

Zulässig ist beispielsweise:

```text
AuthenticationProof(
  securityId: <profileSecurityId>,
  verifiedAt: <timestamp>,
  validUntil: <timestamp>
)
```

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Passwortprüfung,
- Hashvergleich,
- technische Authentifizierung,
- Credential-Erzeugung,
- Authentifizierungstokens,
- Sessions,
- kryptographische Schlüssel,
- Festlegung der Gültigkeitsdauer,
- Lockout,
- Rate Limiting,
- Persistenz,
- Security-Port-Implementierungen.

Die technische Authentifizierung muss bereits erfolgreich abgeschlossen
sein, bevor `createVerified(...)` aufgerufen wird.

### Traceability

**Domain Model**

- `AuthenticationProof`
- `AuthenticationProof.createVerified(...)`
- `AuthenticationProof.validateFor(...)`
- `ProfileSecurity.disablePasswordProtection(...)`
- `ProfileSecurity.changePasswordCredential(...)`
- `ProfileSecurity.unlock(...)`
- `ProfileSecurityId`
- `Timestamp`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

---

# PRO-VR-033

## Titel

ProfileLockStatus validieren

### Typ

Enumerationsvalidierung

### Beschreibung

`ProfileLockStatus` beschreibt den fachlichen Sperrzustand einer
`ProfileSecurity`-Entity.

Zulässige Werte sind ausschließlich:

```text
unlocked
locked
```

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<ProfileLockStatus> ProfileLockStatus.fromString(
  String? value
)
```

### Fachliche Regeln

Für `ProfileLockStatus.fromString(...)` gilt:

- `value` MUSS vorhanden sein.
- `value` DARF nach dem Trimmen nicht leer sein.
- Der normalisierte Wert MUSS exakt `unlocked` oder `locked` entsprechen.
- Groß- und Kleinschreibung werden nicht automatisch verändert.
- Unbekannte Werte DÜRFEN nicht durch einen Standardwert ersetzt werden.
- Weitere Statuswerte sind nicht zulässig.

### Normalisierung

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

Insbesondere wird die Groß- und Kleinschreibung nicht verändert.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-PLSTAT-001 | `validation.profileLockStatus.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PLSTAT-002 | `validation.profileLockStatus.invalid` | ERROR | VALIDATION | value | enum | `{"allowedValues":["unlocked","locked"]}` |

### Fehlerverhalten

#### Fehlender oder leerer Wert

Ist `value` nicht vorhanden oder nach dem Trimmen leer, wird ausschließlich

```text
PRO-VAL-PLSTAT-001
```

erzeugt.

Ein zusätzlicher Enum-Fehler wird nicht erzeugt.

#### Ungültiger Statuswert

Entspricht der normalisierte Wert weder `unlocked` noch `locked`, wird

```text
PRO-VAL-PLSTAT-002
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "allowedValues": [
    "unlocked",
    "locked"
  ]
}
```

Der ungültige Eingabewert wird nicht als Fehlerparameter übertragen.

### Validierungsreihenfolge

1. Vorhandensein prüfen.
2. Trimmen.
3. Leeren Wert prüfen.
4. Zulässigen Enumerationswert prüfen.
5. Gültigen `ProfileLockStatus` erzeugen.

### Erfolgsverhalten

Bei erfolgreicher Rekonstruktion gilt:

- Der Wert entspricht exakt `unlocked` oder `locked`.
- Es wurde ein unveränderlicher `ProfileLockStatus` erzeugt.
- Es wurden keine Zeitstempel erzeugt oder verändert.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Zeitpunkte von Sperrungen oder Entsperrungen,
- Authentifizierung,
- allgemeiner Profilstatus,
- Lockout,
- Rate Limiting,
- Sperrhistorie.

### Traceability

**Domain Model**

- `ProfileLockStatus`
- `ProfileLockStatus.fromString(...)`
- `LockState.status`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-034

## Titel

LockState validieren

### Typ

Value-Object-Validierung

### Beschreibung

`LockState` repräsentiert den aktuellen fachlichen Sperrzustand einer
`ProfileSecurity`-Entity.

Das Value Object besteht aus:

- `ProfileLockStatus status`,
- `Timestamp? lockedAt`,
- `Timestamp? unlockedAt`.

Es speichert ausschließlich den aktuellen Zustand und keine Historie.

Die kontrollierte Erzeugung erfolgt über:

```text
DomainResult<LockState> LockState.createLocked(
  Timestamp? lockedAt
)
```

und

```text
DomainResult<LockState> LockState.createUnlocked(
  Timestamp? unlockedAt
)
```

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<LockState> LockState.reconstruct(
  ProfileLockStatus? status,
  Timestamp? lockedAt,
  Timestamp? unlockedAt
)
```

Die Zustandsübergänge erfolgen über:

```text
DomainResult<LockState> LockState.lock(
  Timestamp? lockedAt
)
```

und

```text
DomainResult<LockState> LockState.unlock(
  Timestamp? unlockedAt
)
```

### Gültige Zustände

Ein entsperrter Zustand ist ausschließlich gültig als:

```text
status = unlocked
lockedAt = null
unlockedAt != null
```

Ein gesperrter Zustand ist ausschließlich gültig als:

```text
status = locked
lockedAt != null
unlockedAt = null
```

### Fachliche Regeln

Für `LockState` gilt:

- `status` MUSS vorhanden und gültig sein.
- Bei `status = locked` MUSS `lockedAt` vorhanden sein.
- Bei `status = locked` MUSS `unlockedAt` fehlen.
- Bei `status = unlocked` MUSS `unlockedAt` vorhanden sein.
- Bei `status = unlocked` MUSS `lockedAt` fehlen.
- Genau einer der beiden Zeitstempel MUSS vorhanden sein.
- Fehlende Zeitstempel DÜRFEN nicht automatisch erzeugt werden.
- Das Value Object MUSS unveränderlich sein.
- Ein Zustandsübergang MUSS eine neue vollständige Instanz erzeugen.
- Der jeweils vorherige Zeitstempel wird nicht übernommen.
- `LockState` speichert keine Sperrhistorie.
- `LockState` greift nicht auf eine technische Systemuhr zu.

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-LSTATE-001 | `validation.lockState.status.required` | ERROR | VALIDATION | status | required | – |
| PRO-VAL-LSTATE-002 | `validation.lockState.lockedAt.required` | ERROR | VALIDATION | lockedAt | required | `{"requiredForStatus":"locked"}` |
| PRO-VAL-LSTATE-003 | `validation.lockState.unlockedAt.required` | ERROR | VALIDATION | unlockedAt | required | `{"requiredForStatus":"unlocked"}` |
| PRO-VAL-LSTATE-004 | `validation.lockState.lockedAt.forbidden` | ERROR | VALIDATION | lockedAt | forbidden | `{"forbiddenForStatus":"unlocked"}` |
| PRO-VAL-LSTATE-005 | `validation.lockState.unlockedAt.forbidden` | ERROR | VALIDATION | unlockedAt | forbidden | `{"forbiddenForStatus":"locked"}` |

### Fehlerverhalten

#### Fehlender Status

Ist bei `reconstruct(...)` kein `status` vorhanden, wird ausschließlich

```text
PRO-VAL-LSTATE-001
```

erzeugt.

Statusabhängige Zeitstempelprüfungen werden in diesem Fall nicht
durchgeführt.

#### Fehlender Sperrzeitpunkt

Ist der Zielzustand `locked` und `lockedAt` fehlt, wird

```text
PRO-VAL-LSTATE-002
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "requiredForStatus": "locked"
}
```

Dies gilt ebenfalls für:

```text
createLocked(null)
```

und

```text
lock(null)
```

#### Fehlender Entsperrzeitpunkt

Ist der Zielzustand `unlocked` und `unlockedAt` fehlt, wird

```text
PRO-VAL-LSTATE-003
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "requiredForStatus": "unlocked"
}
```

Dies gilt ebenfalls für:

```text
createUnlocked(null)
```

und

```text
unlock(null)
```

#### Unzulässiger Sperrzeitpunkt

Ist der Status `unlocked` und gleichzeitig `lockedAt` vorhanden, wird

```text
PRO-VAL-LSTATE-004
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "forbiddenForStatus": "unlocked"
}
```

Der tatsächliche Zeitwert wird nicht als Fehlerparameter übertragen.

#### Unzulässiger Entsperrzeitpunkt

Ist der Status `locked` und gleichzeitig `unlockedAt` vorhanden, wird

```text
PRO-VAL-LSTATE-005
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "forbiddenForStatus": "locked"
}
```

Der tatsächliche Zeitwert wird nicht als Fehlerparameter übertragen.

### Validierungsreihenfolge

#### LockState.createLocked(...)

1. `lockedAt` auf Vorhandensein prüfen.
2. Gesperrten Zustand erzeugen.

#### LockState.createUnlocked(...)

1. `unlockedAt` auf Vorhandensein prüfen.
2. Entsperrten Zustand erzeugen.

#### LockState.reconstruct(...)

1. `status` auf Vorhandensein prüfen.
2. Bei `locked` den erforderlichen `lockedAt` prüfen.
3. Bei `locked` das Fehlen von `unlockedAt` prüfen.
4. Bei `unlocked` den erforderlichen `unlockedAt` prüfen.
5. Bei `unlocked` das Fehlen von `lockedAt` prüfen.
6. Vollständigen `LockState` erzeugen.

Fehlt `status`, werden keine statusabhängigen Folgefehler erzeugt.

Mehrere voneinander unabhängige Zustandsfehler dürfen gemeinsam
zurückgegeben werden.

### Zustandsübergang `lock(...)`

Ist der aktuelle Zustand `unlocked`, gilt bei Erfolg:

```text
status = locked
lockedAt = übergebener Zeitpunkt
unlockedAt = null
```

Der bisherige `unlockedAt`-Wert wird verworfen.

Ist der Zustand bereits `locked`, entsteht auf Ebene von `LockState` kein
Validation Error.

Der No Change wird von `ProfileSecurity` über den dort vorgesehenen
Information Code behandelt.

### Zustandsübergang `unlock(...)`

Ist der aktuelle Zustand `locked`, gilt bei Erfolg:

```text
status = unlocked
lockedAt = null
unlockedAt = übergebener Zeitpunkt
```

Der bisherige `lockedAt`-Wert wird verworfen.

Ist der Zustand bereits `unlocked`, entsteht auf Ebene von `LockState` kein
Validation Error.

Der No Change wird von `ProfileSecurity` über den dort vorgesehenen
Information Code behandelt.

### Keine Fehlerduplizierung

Fehler eines bereits typisiert übergebenen

- `ProfileLockStatus`,
- `Timestamp`

werden nicht als generische `LockState`-Fehler dupliziert.

### Erfolgsverhalten

Bei erfolgreicher Erzeugung, Rekonstruktion oder Änderung gilt:

- Genau ein Zeitstempel ist vorhanden.
- Der vorhandene Zeitstempel entspricht dem aktuellen Status.
- Der jeweils andere Zeitstempel ist `null`.
- Der bestehende Zustand wurde nicht mutiert.
- Es wurden keine Domain Events erzeugt.
- Es wurden keine Audit- oder Versionsinformationen verändert.

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- allgemeiner Profilstatus,
- Regel „gesperrt und gleichzeitig aktiv“,
- Authentifizierung,
- `AuthenticationProof`,
- Lockout,
- Rate Limiting,
- Sperrhistorie,
- technische Systemuhren,
- Persistenz.

### Traceability

**Domain Model**

- `LockState`
- `LockState.createLocked(...)`
- `LockState.createUnlocked(...)`
- `LockState.reconstruct(...)`
- `LockState.lock(...)`
- `LockState.unlock(...)`
- `ProfileLockStatus`
- `Timestamp`
- `ProfileSecurity.lockState`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# PRO-VR-035

## Titel

AggregateVersion validieren

### Typ

Value-Object-Validierung

### Beschreibung

`AggregateVersion` repräsentiert die unveränderliche fachliche Version
eines Aggregatzustands.

Die Version dient insbesondere

- der Erkennung erfolgreicher Zustandsänderungen,
- der optimistischen Nebenläufigkeitskontrolle,
- der Synchronisation,
- der Konflikterkennung,
- der eindeutigen Reihenfolge von Domain Events.

Die kontrollierte initiale Erzeugung erfolgt über:

```text
DomainResult<AggregateVersion> AggregateVersion.createInitial()
```

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<AggregateVersion> AggregateVersion.fromValue(
  int? value
)
```

Die Erzeugung der nächsten Version erfolgt über:

```text
DomainResult<AggregateVersion> AggregateVersion.next()
```

---

### Fachliche Regeln

Für `AggregateVersion` gilt:

- Der Versionswert MUSS vorhanden sein.
- Der Versionswert MUSS mindestens `0` betragen.
- Der Versionswert DARF den Wert

```text
9223372036854775807
```

nicht überschreiten.

- Der Initialwert MUSS `0` sein.
- Eine erfolgreiche fachliche Änderung erhöht die Version genau um `1`.
- Eine fehlgeschlagene Operation verändert die Version nicht.
- Ein erfolgreicher No Change verändert die Version nicht.
- Die Version steigt ausschließlich monoton.
- Die Version DARF niemals verringert werden.
- Die Version DARF nicht direkt verändert werden.
- Das Value Object MUSS unveränderlich sein.

---

### Verhalten von createInitial()

Die Factory

```text
AggregateVersion.createInitial()
```

erzeugt immer

```text
AggregateVersion(0)
```

Für `createInitial()` werden keine Validation Errors definiert.

---

### Verhalten von fromValue(...)

Für `AggregateVersion.fromValue(...)` gilt:

- `value` MUSS vorhanden sein.
- `value` MUSS mindestens `0` betragen.
- `value` DARF den maximal zulässigen Versionswert nicht überschreiten.

---

### Verhalten von next()

Ist der aktuelle Versionswert kleiner als

```text
9223372036854775807
```

wird eine neue `AggregateVersion`
mit exakt um `1` erhöhtem Versionswert erzeugt.

Ist der aktuelle Versionswert bereits

```text
9223372036854775807
```

wird keine neue Version erzeugt.

Die bestehende Instanz bleibt unverändert.

---

### Fehlercodes

| Fehlercode | Message Key | Severity | Category | Feld | Constraint | Parameter |
|------------|-------------|----------|----------|------|------------|-----------|
| PRO-VAL-AGGVER-001 | `validation.aggregateVersion.required` | ERROR | VALIDATION | value | required | – |
| PRO-VAL-AGGVER-002 | `validation.aggregateVersion.minimum` | ERROR | VALIDATION | value | minimum | `{"minimum":0}` |
| PRO-VAL-AGGVER-003 | `validation.aggregateVersion.maximum` | ERROR | VALIDATION | value | maximum | `{"maximum":9223372036854775807}` |
| PRO-VAL-AGGVER-004 | `validation.aggregateVersion.overflow` | ERROR | VALIDATION | value | overflow | `{"maximum":9223372036854775807}` |

---

### Fehlerverhalten

#### Fehlender Versionswert

Ist `value` nicht vorhanden,

wird ausschließlich

```text
PRO-VAL-AGGVER-001
```

erzeugt.

Weitere Prüfungen erfolgen nicht.

---

#### Versionswert kleiner als Minimum

Ist

```text
value < 0
```

wird ausschließlich

```text
PRO-VAL-AGGVER-002
```

erzeugt.

Der Fehlerparameter lautet

```json
{
  "minimum": 0
}
```

---

#### Versionswert größer als Maximum

Ist

```text
value > 9223372036854775807
```

wird ausschließlich

```text
PRO-VAL-AGGVER-003
```

erzeugt.

Der Fehlerparameter lautet

```json
{
  "maximum": 9223372036854775807
}
```

---

#### Überlauf bei next()

Soll `next()` auf einer Version

```text
9223372036854775807
```

ausgeführt werden,

wird ausschließlich

```text
PRO-VAL-AGGVER-004
```

erzeugt.

Der Fehlerparameter lautet

```json
{
  "maximum": 9223372036854775807
}
```

Die bestehende Instanz bleibt unverändert.

---

### Validierungsreihenfolge

#### AggregateVersion.fromValue(...)

1. Vorhandensein prüfen.
2. Minimalwert prüfen.
3. Maximalwert prüfen.
4. AggregateVersion erzeugen.

Ein fehlender Wert erzeugt keine weiteren Folgefehler.

---

#### AggregateVersion.next()

1. Überlauf prüfen.
2. Version um exakt `1` erhöhen.
3. Neue AggregateVersion erzeugen.

---

### Erfolgsverhalten

Bei erfolgreicher Erzeugung gilt:

- Es wurde eine gültige `AggregateVersion` erzeugt.
- Der Versionswert liegt innerhalb des zulässigen Bereichs.
- Das Value Object ist unveränderlich.

Bei erfolgreicher Erhöhung gilt zusätzlich:

- Der Versionswert wurde exakt um `1` erhöht.
- Die bisherige Instanz blieb unverändert.

---

### Abgrenzung

Nicht Bestandteil dieser Validation Rule sind:

- Persistenzkonflikte,
- Optimistic Locking,
- Synchronisationsprotokolle,
- Datenbanktransaktionen,
- Domain-Event-Publishing,
- AuditInformation,
- Zeitstempel,
- technische Revisionen,
- Repositoryzugriffe.

---

### Traceability

**Domain Model**

- `AggregateVersion`
- `AggregateVersion.createInitial()`
- `AggregateVersion.fromValue(...)`
- `AggregateVersion.next()`
- `AuditInformation.version`

**Validation Principles**

- PRO-VP-001
- PRO-VP-002
- PRO-VP-003
- PRO-VP-004
- PRO-VP-007
- PRO-VP-009

---

# Validierungsreihenfolge

Jede Profilerstellung und Profiländerung wird in folgender Reihenfolge validiert:

1. Eingaben normalisieren
2. Pflichtfelder prüfen
3. Datentypen prüfen
4. Wertebereiche prüfen
5. Formatprüfungen durchführen
6. Cross-Field-Validierungen durchführen
7. Warnungen ermitteln
8. Sicherheitsprüfungen durchführen
9. Persistierung freigeben

---

# Cross-Field-Validierungen

## Passwortschutz

Ist der Passwortschutz aktiviert,

- MUSS ein Passwort vorhanden sein.
- MUSS eine Passwortbestätigung vorhanden sein.
- MÜSSEN beide Werte identisch sein.

---

## Archiviertes Profil

Ein archiviertes Profil

- DARF nicht aktiv sein.
- DARF kein Standardprofil sein.

---

## Erstes Profil

Existiert bislang kein Profil,

- MUSS das erste Profil automatisch
  - aktiv,
  - Standardprofil und
  - zuletzt verwendetes Profil

werden.

---

## Letztes Profil gelöscht

Wird das letzte Profil gelöscht,

- MÜSSEN sämtliche Profilreferenzen entfernt werden.
- MUSS das Standardprofil entfernt werden.
- MUSS das zuletzt verwendete Profil entfernt werden.
- MUSS das aktive Profil entfernt werden.
- MUSS die Anwendung vollständig in den Initialzustand wechseln.

Für diese Operation gilt

**PRO-VP-008 – Atomare Fachoperationen**

---

# Status dieses Teils

Mit Teil 3 sind vollständig definiert:

- PRO-VR-012 – Profilstatus
- PRO-VR-013 – Standardprofil
- PRO-VR-014 – Zeitstempel
- PRO-VR-015 – Profilimport
- PRO-VR-016 – Profilexport
- Validierungsreihenfolge
- Cross-Field-Validierungen

---

# Teil 4

Der letzte Abschnitt enthält

- UI-Verhalten bei Validierungsfehlern
- Domain-Validierung
- Qualitätskriterien
- Review-Checkliste
- Definition of Ready
- Definition of Done
- Referenzen
- Dokumentstatus

# UI-Verhalten bei Validierungsfehlern

Die Benutzeroberfläche dient der frühzeitigen Benutzerunterstützung.

Sie ersetzt niemals die fachliche Domainvalidierung.

---

## Anzeige von Fehlern

Validierungsfehler sollen

- unmittelbar am betroffenen Eingabefeld angezeigt werden,
- eindeutig erkennbar sein,
- nach Möglichkeit bereits während der Eingabe erscheinen,
- nach erfolgreicher Korrektur automatisch verschwinden.

Mehrere Fehler dürfen gleichzeitig angezeigt werden.

---

## Anzeige von Warnungen

Warnungen

- blockieren den Speichervorgang grundsätzlich nicht,
- weisen auf mögliche Auffälligkeiten hin,
- können vom Benutzer bewusst bestätigt werden.

Beispiele

- doppelter Profilname
- ungewöhnliche Eingabewerte
- bereits vorhandene ähnliche Profile

---

## Fokusverhalten

Nach einer fehlgeschlagenen Validierung

- SOLL das erste fehlerhafte Eingabefeld automatisch den Fokus erhalten.
- SOLL die erste sichtbare Fehlermeldung automatisch erreichbar sein.
- SOLLEN Screenreader über neue Fehlermeldungen informiert werden.

---

## Mehrere Fehler

Existieren mehrere Fehler gleichzeitig,

- werden sämtliche Fehler zurückgegeben,
- werden sämtliche Fehler dargestellt,
- erfolgt keine vorzeitige Beendigung der Validierung nach dem ersten Fehler.

---

## Barrierefreiheit

Validierungsfehler dürfen niemals ausschließlich über Farben dargestellt werden.

Zusätzlich müssen verwendet werden

- Symbole
- verständliche Texte
- Screenreader-kompatible Beschreibungen

Die Umsetzung erfolgt gemäß den jeweils gültigen Accessibility-Richtlinien.

---

# Domain-Validierung

Die Domainvalidierung besitzt stets Vorrang gegenüber allen anderen Validierungen.

Folgende Komponenten dürfen Vorvalidierungen durchführen:

- Flutter UI
- Web UI
- Importdialog
- zukünftige REST-Clients

Die endgültige Entscheidung über die Gültigkeit einer Eingabe trifft ausschließlich die Domain.

---

# Qualitätskriterien

Die Validierungsregeln erfüllen folgende Qualitätsmerkmale.

## Vollständigkeit

Alle fachlich relevanten Eingaben besitzen mindestens eine Validierungsregel.

---

## Eindeutigkeit

Jede Regel besitzt

- genau eine fachliche Bedeutung,
- genau einen Fehlercode,
- genau einen Message Key.

---

## Nachvollziehbarkeit

Jede Validierungsregel besitzt vollständige Traceability zu

- Requirements
- Use Cases
- Business Rules
- Testfällen

---

## Wiederverwendbarkeit

Validierungsregeln sind unabhängig von

- Benutzeroberfläche
- Datenbank
- Plattform
- API

---

## Testbarkeit

Jede Validierungsregel muss

- automatisiert getestet werden können,
- reproduzierbar sein,
- deterministisch sein.

---

# Review-Checkliste

Vor der Freigabe dieses Dokuments ist zu prüfen:

- Sind sämtliche Pflichtfelder validiert?
- Sind alle Wertebereiche definiert?
- Sind Cross-Field-Regeln vollständig?
- Besitzt jede Regel einen eindeutigen Fehlercode?
- Besitzt jede Regel einen Message Key?
- Besitzt jede Regel einen Constraint?
- Sind Parameter vollständig beschrieben?
- Ist die Traceability vollständig?
- Sind Warnungen und Fehler eindeutig getrennt?
- Sind alle Regeln unabhängig von der Benutzeroberfläche formuliert?
- Sind sämtliche Beispiele konsistent?
- Entsprechen alle Fehler den Architekturprinzipien PRO-VP-001 bis PRO-VP-009?

---

# Definition of Ready

Eine neue Validierungsregel ist implementierungsbereit, wenn

- Requirement vorhanden ist,
- Use Case vorhanden ist,
- Business Rule vorhanden ist,
- Validierungsregel vollständig beschrieben ist,
- Fehlercodes definiert sind,
- Message Keys definiert sind,
- Constraint definiert ist,
- Parameter definiert sind,
- Testfälle geplant sind.

---

# Definition of Done

Eine Validierungsregel gilt als abgeschlossen, wenn

- Implementierung abgeschlossen ist,
- Unit Tests erfolgreich sind,
- Integrationstests erfolgreich sind,
- UI-Tests erfolgreich sind,
- Code Review abgeschlossen ist,
- Dokumentation aktualisiert wurde,
- Traceability vollständig ist,
- keine bekannten Validierungsfehler mehr offen sind.

---

# Referenzen

Dieses Dokument verwendet und ergänzt folgende Spezifikationen:

- 01_REQUIREMENTS.md
- 02_USE_CASES.md
- 03_BUSINESS_RULES.md
- SECURITY_GUIDE.md
- TESTING_GUIDE.md
- ../../ui/UI_GUIDE.md

Später zusätzlich

- 05_DOMAIN_MODEL.md
- ERROR_HANDLING_GUIDE.md
- ARCHITECTURE_GUIDE.md

---

# Dokumentstatus

| Feld | Wert |
|------|------|
| Status | Draft |
| Fachliche Freigabe | ausstehend |
| Technische Freigabe | ausstehend |
| Implementierungsstatus | offen |

---

# Zusammenfassung

Dieses Dokument definiert sämtliche fachlichen Validierungsregeln des Profilmoduls.

Es beschreibt

- Architekturprinzipien
- Pflichtfelder
- Wertebereiche
- Cross-Field-Validierungen
- Fehlercodes
- Message Keys
- Constraints
- Parameter
- Qualitätskriterien
- Traceability

Alle Validierungsregeln sind

- sprachunabhängig,
- UI-unabhängig,
- plattformunabhängig,
- testbar,
- deterministisch,
- wiederverwendbar.

Sie bilden die verbindliche Grundlage für die Implementierung des Profilmoduls.