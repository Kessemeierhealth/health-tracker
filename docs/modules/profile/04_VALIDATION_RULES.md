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

- Dashboard
- Ernährung
- Messwerte
- Medikamente
- Geräte
- Auswertungen
- Empfehlungen

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

Optionales Feld

### Beschreibung

Das Geschlecht dient ausschließlich der fachlichen Ergänzung des Profils.

### Fachliche Regeln

Ist ein Geschlecht angegeben,

- MUSS es einem unterstützten Wert entsprechen.

Nicht angegebene Werte werden fachlich als **unspecified** behandelt.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-GENDER-001 | `validation.profile.gender.invalid` | enum | `{"allowedValues":["male","female","diverse","unspecified"]}` |

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

Der Profilstatus beschreibt den fachlichen Lebenszyklus eines Profils.

### Zulässige Status

- active
- inactive
- archived
- locked

### Fachliche Regeln

Der Profilstatus

- MUSS vorhanden sein.
- MUSS einem definierten Status entsprechen.
- DARF niemals mehrere Status gleichzeitig besitzen.

### Konsistenzregeln

- Ein archiviertes Profil DARF nicht aktiv sein.
- Ein gesperrtes Profil DARF nicht aktiv sein.
- Ein archiviertes Profil DARF nicht entsperrt werden.
- Ein gesperrtes Profil MUSS vor einer Aktivierung entsperrt werden.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-STATUS-001 | `validation.profile.status.required` | required | – |
| PRO-VAL-STATUS-002 | `validation.profile.status.invalid` | enum | `{"allowedValues":["active","inactive","archived","locked"]}` |
| PRO-VAL-STATUS-003 | `validation.profile.status.transition` | transition | – |

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

---

# PRO-VR-013

## Titel

Standardprofil validieren

### Typ

Systemvalidierung

### Beschreibung

Das Standardprofil wird beim Start der Anwendung automatisch geöffnet.

### Fachliche Regeln

- Es DARF höchstens ein Standardprofil existieren.
- Das Standardprofil MUSS vorhanden sein.
- Ein archiviertes Profil DARF kein Standardprofil sein.
- Ein gesperrtes Profil DARF kein Standardprofil sein.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-DEFAULT-001 | `validation.profile.default.notFound` | required | – |
| PRO-VAL-DEFAULT-002 | `validation.profile.default.multiple` | unique | `{"maximum":1}` |
| PRO-VAL-DEFAULT-003 | `validation.profile.default.invalidStatus` | status | – |

### Traceability

**Requirements**

- PRO-FR-009

**Use Cases**

- PRO-UC-009

**Business Rules**

- PRO-BR-012

---

# PRO-VR-014

## Titel

Zeitstempel validieren

### Typ

Systemvalidierung

### Beschreibung

Zeitinformationen dienen der Nachvollziehbarkeit aller Profiländerungen.

### Fachliche Regeln

Jedes Profil besitzt

- createdAt
- updatedAt

Es gilt

- createdAt MUSS vorhanden sein.
- updatedAt MUSS vorhanden sein.
- updatedAt DARF niemals vor createdAt liegen.
- Jede fachliche Änderung MUSS updatedAt aktualisieren.
- Reine Lesezugriffe verändern updatedAt nicht.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-TIME-001 | `validation.profile.timestamp.createdMissing` | required | `{"field":"createdAt"}` |
| PRO-VAL-TIME-002 | `validation.profile.timestamp.updatedMissing` | required | `{"field":"updatedAt"}` |
| PRO-VAL-TIME-003 | `validation.profile.timestamp.invalidOrder` | chronological | – |

### Traceability

**Requirements**

- PRO-FR-003
- PRO-FR-027

**Use Cases**

- PRO-UC-003
- PRO-UC-027

**Business Rules**

- PRO-BR-007

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

Ein Export darf ausschließlich zulässige Profildaten enthalten.

### Fachliche Regeln

Der Export

- MUSS eine Versionskennung enthalten.
- MUSS den Exportzeitpunkt enthalten.
- MUSS die Profil-ID enthalten.
- DARF keine Passwörter enthalten.
- DARF keine Passwort-Hashes enthalten.
- DARF keine kryptographischen Schlüssel enthalten.
- DARF keine Daten anderer Profile enthalten.

### Fehlercodes

| Fehlercode | Message Key | Constraint | Parameter |
|------------|-------------|------------|-----------|
| PRO-VAL-EXPORT-001 | `validation.profile.export.versionMissing` | required | `{"field":"version"}` |
| PRO-VAL-EXPORT-002 | `validation.profile.export.foreignProfile` | ownership | – |
| PRO-VAL-EXPORT-003 | `validation.profile.export.securityData` | forbidden | – |
| PRO-VAL-EXPORT-004 | `validation.profile.export.incomplete` | completeness | – |

### Traceability

**Requirements**

- PRO-FR-024

**Use Cases**

- PRO-UC-024

**Business Rules**

- PRO-BR-021

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