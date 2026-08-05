# 06_ERROR_HANDLING_GUIDE.md

> Projektweiter Leitfaden für Fehler-, Warnungs- und Informationsmeldungen

---

# Teil 1 – Grundlagen

# Dokumentinformationen

| Feld | Wert |
|---|---|
| Dokument-ID | DOC-ERR-001 |
| Dokumenttyp | Architekturleitfaden |
| Geltungsbereich | Gesamtes HealthTracker-Projekt |
| Version | 1.0.0 |
| Status | Draft |
| Owner | HealthTracker Team |
| Reviewer | HealthTracker Team |
| Letzte Änderung | 2026-08-01 |
| Reviewintervall | Bei grundlegenden Änderungen der Fehlerarchitektur |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|---|---|---|---|---|
| 1.0.0 | 2026-08-01 | Erste Version | Definition der projektweiten Fehlerarchitektur | HealthTracker Team |

---

# Zweck

Dieses Dokument definiert die einheitliche Fehler- und Nachrichtenarchitektur des HealthTracker-Projekts.

Es beschreibt insbesondere:

- `DomainResult<T>`,
- `DomainMessage`,
- Fehler, Warnungen und Informationen,
- stabile Fehler- und Nachrichtencodes,
- Message Keys,
- strukturierte Parameter,
- fachliche und technische Fehler,
- Exception-Grundsätze,
- Fehlerübersetzung an Schicht- und Port-Grenzen,
- Internationalisierung,
- Datenschutz und Sicherheit,
- Logging und Diagnose,
- Testbarkeit und Traceability.

Die Regeln gelten unabhängig von:

- Modul,
- Plattform,
- Benutzeroberfläche,
- Persistenztechnologie,
- API,
- Import und Export,
- zukünftigen Clients.

---

# Geltungsbereich

Dieser Leitfaden gilt für alle fachlichen und technischen Module, insbesondere:

- Profile,
- Measurements,
- Nutrition,
- Medication,
- Devices,
- Dashboard,
- Recommendations,
- Import,
- Export,
- Backup,
- Synchronisation,
- Event-Verarbeitung,
- Persistenz,
- Infrastrukturadapter.

Modulspezifische Fehlerkataloge dürfen diesen Leitfaden ergänzen, aber nicht widersprechen.

---

# Ziele

Die Fehlerarchitektur verfolgt folgende Ziele:

- einheitliche Rückgabestrukturen,
- klare Trennung von Fachlichkeit und Technik,
- stabile und maschinenlesbare Codes,
- sprachunabhängige Domäne,
- strukturierte und sichere Parameter,
- reproduzierbares Verhalten,
- vollständige Testbarkeit,
- verständliche UI-Rückmeldungen,
- datenschutzkonformes Logging,
- eindeutige Traceability,
- geringe Kopplung zwischen den Schichten.

---

# Begriffsdefinitionen

| Begriff | Bedeutung |
|---|---|
| DomainResult | Ergebnis einer fachlichen oder anwendungsbezogenen Operation |
| DomainMessage | Gemeinsame Struktur aller fachlich auswertbaren Meldungen |
| DomainError | Meldung, die den erfolgreichen Abschluss verhindert |
| DomainWarning | Meldung, die eine Bestätigung oder besondere Aufmerksamkeit erfordert |
| DomainInformation | Neutrale Information ohne Blockierungswirkung |
| ErrorCode | Stabiler projektweiter fachlicher oder technischer Code |
| Message Key | Schlüssel zur Lokalisierung von Benutzertexten |
| Constraint | Art der verletzten Regel |
| Parameters | Strukturierte Werte zur Erzeugung einer Meldung |
| Exception | Unerwarteter technischer oder programmatischer Ausnahmezustand |
| Correlation ID | Kennung zur Verbindung zusammengehöriger Abläufe |
| CauseCode | Abstrahierte technische Ursache eines Fehlers |

---

# Grundprinzipien

## ERR-001 – Erwartbare fachliche Fehler sind Ergebnisse

Erwartbare fachliche Fehler sind Bestandteil der normalen Verarbeitung.

Sie werden über:

```text
DomainResult<T>
```

zurückgegeben.

Beispiele:

- Profil wurde nicht gefunden,
- Profil ist archiviert,
- Statuswechsel ist unzulässig,
- Eingabewert ist ungültig,
- Authentifizierung ist erforderlich,
- Importdaten verletzen eine Business Rule.

Fachlich erwartbare Fehler werden nicht als Exceptions geworfen.

---

## ERR-002 – Exceptions sind keine Business-Ergebnisse

Exceptions sind ausschließlich für unerwartete technische oder programmatische Fehler vorgesehen.

Beispiele:

- beschädigte Datenbank,
- nicht erreichbares Dateisystem,
- unerwarteter Bibliotheksfehler,
- Speicherfehler,
- verletzte interne Programmierinvariante.

Nicht zulässig:

```text
throw ProfileAlreadyArchivedException
```

Zulässig:

```text
DomainResult.failure(
  DomainError(...)
)
```

---

## ERR-003 – Keine stillschweigende Fehlerbehandlung

Fehler dürfen nicht:

- ignoriert,
- verschluckt,
- als Erfolg ausgegeben,
- ungeprüft durch Standardwerte ersetzt,
- lediglich in einem Log vermerkt

werden.

Jeder relevante Fehler muss zu einem definierten Ergebnis führen.

---

## ERR-004 – Keine Teilresultate als Erfolg

Ein fachlich unvollständiges Ergebnis darf nicht als erfolgreicher Zustand zurückgegeben werden.

Es gilt:

```text
vollständiger Erfolg
```

oder:

```text
definierter Fehler
```

Bei atomaren Operationen ist ein teilweise übernommener Zustand unzulässig.

---

## ERR-005 – Sprachunabhängigkeit

Domäne, Application Layer und Ports erzeugen keine lokalisierten Benutzertexte.

Sie liefern ausschließlich:

- Code,
- Message Key,
- Schweregrad,
- Kategorie,
- Feldreferenz,
- Constraint,
- strukturierte Parameter,
- technische Metadaten.

Die eigentliche Übersetzung erfolgt außerhalb der Domäne.

---

## ERR-006 – Stabile Codes

Veröffentlichte Fehler- und Nachrichtencodes sind Bestandteil der fachlichen Schnittstelle.

Daher gilt:

- Ein Code ändert niemals seine Bedeutung.
- Ein Code wird niemals erneut vergeben.
- Entfernte Codes bleiben reserviert.
- Neue Sachverhalte erhalten neue Codes.
- Message Keys und Übersetzungen dürfen angepasst werden.
- Parameter dürfen nur kompatibel erweitert werden.

---

## Error Codes

### Grundsatz

Jeder fachliche Validierungsfehler besitzt genau einen stabilen Error Code.

Der Error Code wird ausschließlich in den Validation Rules des jeweiligen Moduls definiert.

Der Error Handling Guide übernimmt diesen Error Code unverändert und beschreibt ausschließlich seine technische Verarbeitung.

Error Codes werden nach ihrer Einführung niemals geändert oder wiederverwendet.

### Message Keys

Message Keys dienen ausschließlich der Lokalisierung.

Sie sind keine Error Codes.

Beispiel

| Error Code | Message Key |
|------------|-------------|
| PRO-VAL-NAME-001 | validation.profile.name.required |
| PRO-VAL-BIRTHYEAR-003 | validation.profile.birthYear.minimum |
| PRO-VAL-HEIGHT-002 | validation.profile.height.maximum |

---

## ERR-007 – Strukturierte Parameter

Dynamische Werte werden als strukturierte Parameter übertragen.

Zulässig:

```json
{
  "minimum": 20,
  "maximum": 300,
  "unit": "cm"
}
```

Nicht zulässig:

```text
"Der Wert muss zwischen 20 und 300 cm liegen."
```

Parameter:

- enthalten keine lokalisierten Texte,
- enthalten kein HTML oder Markdown,
- verwenden fachlich eindeutige Namen,
- übertragen Zahlen numerisch,
- übertragen Listen als Arrays,
- übertragen Wahrheitswerte als Boolean,
- verwenden ISO-8601 für Zeit- und Datumswerte.

---

## ERR-008 – Keine sensiblen Daten

Meldungen und Ergebnisse dürfen niemals enthalten:

- Klartextpasswörter,
- Passwort-Hashes,
- kryptographische Schlüssel,
- Tokens,
- vollständige Credentials,
- `AuthenticationProof`,
- biometrische Rohdaten,
- Bildbinärdaten,
- geheime technische Konfigurationen,
- Stacktraces für Benutzer,
- unnötige Gesundheitsdaten.

Sensible Inhalte dürfen auch nicht indirekt über Parameter oder verschachtelte Ursachen offengelegt werden.

---

## ERR-009 – Fehler bleiben schichtengerecht

Jede Schicht liefert Fehler in ihrer eigenen fachlichen Abstraktion.

Beispiele:

```text
Datenbankfehler
        │
        ▼
Repository-/Infrastructure-Fehler
        │
        ▼
Application-Ergebnis
        │
        ▼
UI-Rückmeldung
```

Technische Bibliotheksausnahmen dürfen nicht ungefiltert die Benutzeroberfläche erreichen.

---

## ERR-010 – Mehrere Meldungen sind zulässig

Eine Operation darf mehrere Meldungen zurückgeben.

Beispiel:

```text
1 Error
2 Warnings
1 Information
```

Alle relevanten Meldungen sollen gesammelt werden, sofern dadurch:

- keine Sicherheitsinformationen offengelegt werden,
- keine unnötigen Folgeoperationen ausgeführt werden,
- keine ungültigen Teilzustände entstehen.

---

## ERR-011 – Deterministisches Verhalten

Bei identischen Eingaben und identischem fachlichem Zustand muss eine Operation dieselben fachlichen Meldungen liefern.

Zeitabhängige Fehler verwenden eine abstrahierte `Clock`.

Zufällige technische Kennungen dürfen die fachliche Bedeutung des Ergebnisses nicht verändern.

---

## ERR-012 – Keine UI-Abhängigkeiten

Meldungen enthalten keine:

- Dialogdefinitionen,
- Widgets,
- Farben,
- Icons,
- Navigationsanweisungen,
- Flutter-Typen,
- Bildschirmtexte.

Die UI entscheidet anhand der strukturierten Meldung über die Darstellung.

---

# Fehler- und Nachrichtenarten

## Validierungsfehler

Ein Validierungsfehler zeigt an, dass ein Eingabewert oder eine Kombination von Eingaben ungültig ist.

Beispiele:

- Pflichtfeld fehlt,
- Wert liegt außerhalb des Bereichs,
- Format ist ungültig,
- zwei Felder widersprechen sich.

Kategorie:

```text
VALIDATION
```

Schweregrad:

```text
ERROR
```

oder in ausdrücklich definierten Fällen:

```text
WARNING
```

---

## Business Error

Ein Business Error zeigt an, dass eine fachliche Operation im aktuellen Zustand nicht zulässig ist.

Beispiele:

- archiviertes Profil kann nicht aktiviert werden,
- Profil ist bereits gelöscht,
- Standardprofilwechsel verletzt eine Invariante.

Kategorie:

```text
BUSINESS
```

---

## Security Error

Ein Security Error zeigt an, dass eine Sicherheitsbedingung nicht erfüllt wurde.

Beispiele:

- Authentifizierung fehlt,
- Authentication Proof ist abgelaufen,
- Zugriff ist nicht erlaubt,
- Passwortprüfung ist fehlgeschlagen.

Kategorie:

```text
SECURITY
```

Security Errors dürfen keine internen Sicherheitsdetails offenlegen.

---

## Technical Error

Ein Technical Error beschreibt das kontrollierte Ergebnis eines technischen Fehlers an einer Schicht- oder Port-Grenze.

Beispiele:

- Daten konnten nicht gespeichert werden,
- Bilddatei konnte nicht gelesen werden,
- Event konnte nicht zur Outbox hinzugefügt werden.

Kategorie:

```text
TECHNICAL
```

Die ursprüngliche Exception kann intern für Diagnosezwecke protokolliert werden, wird aber nicht Bestandteil der öffentlichen Domain Message.

---

## Warning

Eine Warning beschreibt einen auffälligen, aber grundsätzlich zulässigen Zustand.

Beispiele:

- doppelter Profilname,
- älteres Importformat,
- Credential sollte neu gehasht werden,
- Bild wurde automatisch verkleinert.

Eine Warning blockiert die Operation nur, wenn eine ausdrücklich spezifizierte Bestätigung erforderlich ist.

---

## Information

Eine Information beschreibt einen neutralen Sachverhalt.

Beispiele:

- Eingabe führt zu keiner Änderung,
- Standardwerte wurden verwendet,
- optionaler Datenbereich war leer.

Informationen beeinflussen die fachliche Gültigkeit nicht.

---

# MessageSeverity

## Zulässige Werte

```text
INFORMATION
WARNING
ERROR
CRITICAL
```

| Wert | Bedeutung |
|---|---|
| INFORMATION | Neutraler Hinweis |
| WARNING | Operation möglich, Aufmerksamkeit erforderlich |
| ERROR | Operation nicht erfolgreich |
| CRITICAL | Schwerwiegender Systemzustand oder Sicherheitsvorfall |

## Regeln

`CRITICAL` ist nicht für gewöhnliche Validierungs- oder Business-Fehler vorgesehen.

Der Schweregrad beeinflusst:

- Erfolgsstatus,
- Logging,
- Monitoring,
- UI-Darstellung,
- mögliche Eskalation.

---

# MessageCategory

## Zulässige Basiskategorien

```text
VALIDATION
BUSINESS
SECURITY
PERSISTENCE
IMPORT
EXPORT
EVENT
INFRASTRUCTURE
SYSTEM
```

Weitere Kategorien dürfen ergänzt werden, wenn sie:

- projektweit definiert,
- eindeutig abgegrenzt,
- dokumentiert

sind.

Kategorien ersetzen nicht den spezifischen Fehlercode.

---

# DomainMessage

## Zweck

`DomainMessage` ist die gemeinsame unveränderliche Struktur für alle fachlich auswertbaren Meldungen.

Spezialisierungen sind:

```text
DomainMessage
├── DomainError
├── DomainWarning
└── DomainInformation
```

---

## Pflichtfelder

| Feld | Typ | Beschreibung |
|---|---|---|
| code | ErrorCode | Stabiler fachlicher oder technischer Code |
| messageKey | MessageKey | Schlüssel für die Lokalisierung |
| severity | MessageSeverity | Schweregrad |
| category | MessageCategory | Meldungskategorie |
| parameters | Map<String, Object> | Strukturierte Parameter |

---

## Optionale Felder

| Feld | Typ | Beschreibung |
|---|---|---|
| field | FieldReference? | Betroffenes Eingabefeld |
| constraint | ConstraintType? | Verletzte Regel |
| correlationId | CorrelationId? | Zugehöriger Ablauf |
| causeCode | ErrorCode? | Abstrahierte Ursache |
| documentationReference | DocumentationReference? | Verweis auf Dokumentation |
| occurredAt | Timestamp? | Fachlich relevanter Zeitpunkt |

---

## Standardstruktur

```json
{
  "code": "PRO-VAL-HEIGHT-003",
  "messageKey": "validation.profile.height.minimum",
  "severity": "ERROR",
  "category": "VALIDATION",
  "field": "height",
  "constraint": "minimum",
  "parameters": {
    "minimum": 20,
    "unit": "cm"
  }
}
```

---

# DomainError

## Zweck

`DomainError` beschreibt eine Meldung, die den erfolgreichen Abschluss einer Operation verhindert.

## Regeln

Ein `DomainResult<T>` mit mindestens einem `DomainError`:

- ist nicht erfolgreich,
- darf keinen fachlich übernommenen Teilzustand repräsentieren,
- darf keine erfolgreichen Domain Events für die abgebrochene Operation enthalten.

---

# DomainWarning

## Zweck

`DomainWarning` beschreibt einen zulässigen, aber auffälligen Zustand.

## Regeln

Eine Warning:

- kann zusammen mit einem Erfolgswert auftreten,
- kann eine ausdrückliche Benutzerbestätigung erfordern,
- darf nicht als Error behandelt werden, sofern die Fachspezifikation nichts anderes verlangt.

---

# DomainInformation

## Zweck

`DomainInformation` beschreibt eine neutrale Rückmeldung.

## Beispiele

```text
noChange
defaultValueApplied
optionalSectionEmpty
```

Eine Information verändert den Erfolgsstatus nicht.

---

# ErrorCode

## Zweck

`ErrorCode` kapselt einen stabilen, sprachneutralen Meldungscode.

## Format

Alle fachlichen und technischen Error Codes verwenden das stabile
projektweite ID-Schema gemäß `00_ARCHITECTURE_CONVENTIONS.md`.

Beispiele:

```text
PRO-VAL-HEIGHT-003
PRO-VAL-NAME-001
PRO-BUS-PROFILE-001
PRO-SEC-AUTH-001
PRO-PER-SAVE-001
PRO-INF-FILE-001
```

Hinweis

Technische Ursachen (CauseCodes) verwenden bewusst ein separates Schema, z. B.

database.read.failed
network.timeout
serialization.failed

CauseCodes sind keine ErrorCodes und dienen ausschließlich der internen technischen Diagnose.

## Regeln

Ein Code:

- ist eindeutig,
- ist unveränderlich,
- enthält keine personenbezogenen Daten,
- enthält keinen lokalisierten Text,
- beschreibt genau einen Sachverhalt,
- wird in Tests direkt geprüft.

---

# MessageKey

## Zweck

`MessageKey` verweist auf einen lokalisierten Benutzer- oder Entwicklertext.

Beispiele:

```text
validation.profile.height.minimum
business.profile.archived
security.authentication.failed
technical.profile.saveFailed
```

## Regeln

- Der Message Key darf angepasst werden.
- Seine Änderung verändert nicht die Bedeutung des Error Codes.
- Fehlende Übersetzungen müssen kontrolliert behandelt werden.
- Der Error Code darf nicht als ungefilterter Standard-Benutzertext verwendet werden.

---

## Architekturregel

Ein Message Key besitzt keine fachliche Identität und darf nicht zur
Steuerung von Fachlogik verwendet werden.

Business Rules, Domainlogik, Verzweigungen und automatisierte Tests dürfen
nicht auf Message Keys basieren.

Für die stabile fachliche Identifikation einer Meldung ist ausschließlich
der Error Code maßgeblich.

Message Keys dienen ausschließlich der Lokalisierung und dürfen geändert
werden, ohne die fachliche Bedeutung des zugehörigen Error Codes zu verändern.

---

# ConstraintType

## Zweck

`ConstraintType` beschreibt die verletzte Regel unabhängig vom konkreten Fehlercode.

Beispiele:

```text
required
blank
minimum
maximum
range
format
pattern
duplicate
immutable
transition
ownership
authentication
atomic
```

Der verbindliche Constraint-Katalog wird im Fehlerkatalog dieses Dokuments festgelegt.

---

# DomainResult<T>

## Zweck

`DomainResult<T>` ist der einheitliche Rückgabetyp für fachlich auswertbare Operationen.

Es kann enthalten:

- einen Erfolgswert,
- Fehler,
- Warnungen,
- Informationen.

## Grundzustände

```text
Success
Failure
```

Ein erfolgreiches Ergebnis kann Warnungen und Informationen enthalten.

Ein fehlerhaftes Ergebnis enthält mindestens einen `DomainError`.

## Minimale Struktur

| Feld | Typ |
|---|---|
| value | T? |
| errors | List<DomainError> |
| warnings | List<DomainWarning> |
| information | List<DomainInformation> |
| isSuccess | Boolean |
| isFailure | Boolean |

Die vollständigen Invarianten und Factory-Methoden werden in Teil 2 definiert.

---

# Verantwortlichkeiten nach Schicht

| Komponente | Verantwortung |
|---|---|
| Value Object | Eingaben validieren und Validierungsfehler liefern |
| Entity | Lokale Business Rules prüfen |
| Aggregate | Invarianten schützen und fachliche Fehler liefern |
| Domain Service | Aggregate-übergreifende Fachregeln bewerten |
| Factory | Gültige Objekte erzeugen |
| Repository Interface | Fachliche Persistenzschnittstelle bereitstellen |
| Infrastrukturadapter | Technische Fehler sicher übersetzen |
| Application Service | Ergebnisse orchestrieren und an die UI weitergeben |
| UI | Meldungen lokalisieren und darstellen |
| Logging | Technische Diagnose ohne Offenlegung sensibler Daten |

---

# Standardfehlerfluss

```text
Benutzereingabe
        │
        ▼
UI-Vorvalidierung
        │
        ▼
Application Service
        │
        ▼
Value Objects / Aggregate / Domain Service
        │
        ▼
DomainResult<T>
        │
        ▼
Application Result / DTO
        │
        ▼
Lokalisierung
        │
        ▼
UI-Darstellung
```

Bei technischen Fehlern:

```text
Technische Exception
        │
        ▼
Infrastructure Adapter
        │
        ▼
sichere Fehlerübersetzung
        │
        ▼
DomainResult<T> oder Application Result
        │
        ▼
Logging und UI
```

---

# Beziehungen zu anderen Dokumenten

Dieser Leitfaden ergänzt insbesondere:

- `04_VALIDATION_RULES.md`,
- `05_DOMAIN_MODEL.md`,
- `SECURITY_GUIDE.md`,
- `TESTING_GUIDE.md`,
- `../../ui/UI_GUIDE.md`,
- zukünftige Application- und Persistence-Dokumente.

Modulspezifische Validierungsfehler behalten ihre dort definierten:

- Codes,
- Message Keys,
- Constraints,
- Parameter.

---

# Qualitätskriterien

Die Fehlerarchitektur muss:

- eindeutig,
- deterministisch,
- sprachunabhängig,
- datenschutzkonform,
- testbar,
- maschinenlesbar,
- erweiterbar,
- rückwärtskompatibel

sein.

---

# Status dieses Abschnitts

Mit Teil 1 sind definiert:

- Dokumentinformationen,
- Zweck und Geltungsbereich,
- Begriffe,
- zwölf Grundprinzipien,
- Fehler- und Nachrichtenarten,
- `MessageSeverity`,
- `MessageCategory`,
- `DomainMessage`,
- `DomainError`,
- `DomainWarning`,
- `DomainInformation`,
- `ErrorCode`,
- `MessageKey`,
- `ConstraintType`,
- die grundlegende Struktur von `DomainResult<T>`,
- Verantwortlichkeiten der Schichten,
- Standardfehlerflüsse,
- Qualitätskriterien.

---

# Teil 2

Der nächste Abschnitt definiert:

- vollständige Invarianten von `DomainResult<T>`,
- Success- und Failure-Zustände,
- Factory-Methoden,
- Kombination und Transformation von Ergebnissen,
- Aggregation von Meldungen,
- `map()`, `flatMap()` und verwandte Operationen,
- No-Change-Ergebnisse,
- Regeln für Warnungsbestätigungen,
- Beispiele und Tests.

# Teil 2 – DomainResult<T>

# DomainResult<T>

## Zweck

`DomainResult<T>` ist der einheitliche Rückgabetyp für fachlich und anwendungsbezogen auswertbare Operationen.

Er transportiert:

- einen optionalen Erfolgswert,
- Fehler,
- Warnungen,
- Informationen,
- den Erfolgsstatus der Operation.

`DomainResult<T>` ersetzt fachliche Exceptions.

Es ist unveränderlich und darf nach seiner Erzeugung nicht mehr verändert werden.

---

# Grundzustände

Ein `DomainResult<T>` befindet sich genau in einem der beiden Zustände:

```text
Success
```

oder:

```text
Failure
```

Ein dritter oder unbestimmter Zustand ist unzulässig.

---

# Ergebnisstruktur

## Pflichtfelder

| Feld | Typ | Beschreibung |
|---|---|---|
| value | T? | Erfolgswert |
| errors | List<DomainError> | Blockierende Fehler |
| warnings | List<DomainWarning> | Nicht blockierende Warnungen |
| information | List<DomainInformation> | Neutrale Informationen |
| isSuccess | Boolean | Operation erfolgreich |
| isFailure | Boolean | Operation fehlgeschlagen |

## Abgeleitete Eigenschaften

```text
hasValue

hasErrors

hasWarnings

hasInformation

messageCount
```

Diese Eigenschaften werden aus dem unveränderlichen Ergebniszustand abgeleitet.

Sie werden nicht separat gespeichert.

---

# Allgemeine Invarianten

## ERR-RES-001 – Eindeutiger Status

Es gilt immer genau eine der beiden Aussagen:

```text
isSuccess = true
```

oder:

```text
isFailure = true
```

Zulässig:

```text
isSuccess = true
isFailure = false
```

oder:

```text
isSuccess = false
isFailure = true
```

Unzulässig:

```text
isSuccess = true
isFailure = true
```

und:

```text
isSuccess = false
isFailure = false
```

---

## ERR-RES-002 – Erfolgszustand

Ein Ergebnis ist erfolgreich, wenn:

```text
errors.isEmpty
```

gilt.

Warnungen und Informationen verhindern den Erfolg nicht.

---

## ERR-RES-003 – Fehlerzustand

Ein Ergebnis ist fehlerhaft, wenn mindestens ein `DomainError` enthalten ist.

```text
errors.isNotEmpty
```

---

## ERR-RES-004 – Kein Erfolgswert bei Failure

Ein fehlerhaftes Ergebnis besitzt grundsätzlich keinen fachlich übernommenen Erfolgswert.

```text
isFailure = true
value = null
```

Abweichungen sind nur für ausdrücklich definierte Diagnose- oder Teilergebnisobjekte zulässig.

Solche Objekte dürfen nicht den Eindruck eines erfolgreich übernommenen Zustands vermitteln.

---

## ERR-RES-005 – Wert bei Success

Ein erfolgreiches Ergebnis darf einen Wert enthalten.

### Projektregel

Für Operationen ohne fachlichen Rückgabewert wird projektweit ausschließlich

```text
DomainResult<void> 
```
verwendet.

---

## ERR-RES-006 – Unveränderlichkeit

Alle enthaltenen Listen und Parameterstrukturen sind unveränderlich.

Externe Aufrufer dürfen:

- keine Meldung hinzufügen,
- keine Meldung entfernen,
- keine Reihenfolge verändern,
- keine Parameter nachträglich ändern.

---

## ERR-RES-007 – Meldungsreihenfolge

Meldungen bleiben innerhalb ihrer jeweiligen Kategorie in der Erzeugungsreihenfolge erhalten.

Die Reihenfolge muss deterministisch sein.

---

## ERR-RES-008 – Keine Null-Listen

Die Meldungslisten sind niemals `null`.

Ohne Meldungen werden leere Listen verwendet.

---

## ERR-RES-009 – Keine leeren Fehlerergebnisse

Ein Failure-Ergebnis muss mindestens einen `DomainError` enthalten.

Unzulässig:

```text
DomainResult.failure(
  errors: []
)
```

---

## ERR-RES-010 – Keine Errors in Success

Ein erfolgreiches Ergebnis darf keine `DomainError`-Instanz enthalten.

---

# Factory-Methoden

Alle Ergebnisse werden über kontrollierte Factory-Methoden erzeugt.

Öffentliche freie Konstruktoren sind nicht vorgesehen.

---

# success()

## Zweck

Erzeugt ein erfolgreiches Ergebnis mit Rückgabewert.

## Signatur

```text
DomainResult<T> success(
  T value,
  List<DomainWarning> warnings = [],
  List<DomainInformation> information = []
)
```

## Postconditions

- `isSuccess` ist `true`.
- `isFailure` ist `false`.
- `value` ist vorhanden.
- `errors` ist leer.
- Warnungen und Informationen dürfen enthalten sein.

---

# successWithoutValue()

## Zweck

Erzeugt ein erfolgreiches Ergebnis ohne fachlichen Rückgabewert.

## Signatur

```text
DomainResult<void> successWithoutValue(
  List<DomainWarning> warnings = [],
  List<DomainInformation> information = []
)
```

## Typische Verwendung

- Speicherung erfolgreich,
- Löschung erfolgreich,
- Event veröffentlicht,
- Cache bereinigt.

---

# failure()

## Zweck

Erzeugt ein fehlerhaftes Ergebnis.

## Signatur

```text
DomainResult<T> failure(
  List<DomainError> errors,
  List<DomainWarning> warnings = [],
  List<DomainInformation> information = []
)
```

## Preconditions

- `errors` enthält mindestens einen Eintrag.
- Kein Erfolgswert wird übergeben.
- Meldungen enthalten keine sensiblen Daten.

## Postconditions

- `isSuccess` ist `false`.
- `isFailure` ist `true`.
- `value` ist nicht vorhanden.
- mindestens ein Error ist enthalten.

---

# fromError()

## Zweck

Erzeugt ein Failure-Ergebnis aus genau einem Fehler.

## Signatur

```text
DomainResult<T> fromError(
  DomainError error
)
```

Konzeptionell entspricht dies:

```text
failure([error])
```

---

# fromWarning()

## Zweck

Erzeugt ein erfolgreiches Ergebnis mit Warnung und Wert.

## Signatur

```text
DomainResult<T> fromWarning(
  T value,
  DomainWarning warning
)
```

Eine Warning allein erzeugt keinen Failure-Zustand.

---

# informationOnly()

## Zweck

Erzeugt ein erfolgreiches Ergebnis ohne fachlichen Wert, aber mit einer Information.

## Signatur

```text
DomainResult<void> informationOnly(
  DomainInformation information
)
```

Typische Verwendung:

```text
noChange
optionalSectionEmpty
alreadyInRequestedState
```

---

# No-Change-Ergebnisse

## Zweck

Ein No-Change-Ergebnis zeigt an, dass eine gültige Operation keine fachliche Zustandsänderung bewirkt hat.

Beispiel:

```text
changeName(currentName)
```

## Struktur

```text
DomainResult<Profile>
├── value: aktuelles gültiges Profile
├── information:
│   └── noChange
├── warnings: optional
└── errors: leer
```

## Regeln

Bei einem No-Change-Ergebnis:

- bleibt der fachliche Zustand unverändert,
- wird die Aggregate-Version nicht erhöht,
- wird `updatedAt` nicht verändert,
- wird kein Änderungs-Domain-Event erzeugt.

---

# Warnungsbestätigung

## Zweck

Einige Warnungen erfordern vor der endgültigen Ausführung eine ausdrückliche Bestätigung.

Beispiel:

```text
doppelter Profilname
```

## Zweistufiges Modell

### Erste Ausführung

```text
DomainResult<PendingConfirmation<T>>
```

enthält:

- fachlich möglichen Zielzustand oder Plan,
- Warnung,
- Confirmation Requirement.

### Bestätigte Ausführung

Der Application Service übergibt eine gültige Bestätigung.

Danach darf die Operation abgeschlossen werden.

## Regel

Eine bestätigungspflichtige Warnung darf nicht stillschweigend als bestätigt behandelt werden.

---

# ConfirmationRequirement

## Struktur

| Feld | Typ |
|---|---|
| confirmationCode | ConfirmationCode |
| relatedWarningCode | ErrorCode |
| expiresAt | Timestamp? |
| context | Map<String, Object> |

## Regeln

- Die Bestätigung ist zweckgebunden.
- Eine abgelaufene Bestätigung ist ungültig.
- Sensible Daten sind unzulässig.
- Die UI erzeugt nicht selbst die fachliche Bestätigung, sondern übermittelt die Benutzerentscheidung.

---

# Meldungsaggregation

## Zweck

Mehrere Validierungs- oder Fachoperationen können Meldungen zu einem Gesamtergebnis beitragen.

Beispiel:

```text
ProfileName.create()
BirthYear.create()
Height.create()
```

Die Meldungen können für die Profilerstellung aggregiert werden.

---

## Aggregationsregeln

### Fehler

Alle relevanten Errors werden gesammelt, sofern:

- keine Sicherheitsinformationen offengelegt werden,
- keine unnötigen Folgeoperationen ausgeführt werden,
- die Verarbeitung weiterhin sicher ist.

### Warnungen

Warnungen bleiben auch bei einem Failure erhalten, wenn sie für die Korrektur oder Diagnose fachlich relevant sind.

### Informationen

Informationen dürfen bei einem Failure entfernt werden, wenn sie keinen Nutzen mehr besitzen.

---

# combine()

## Zweck

Kombiniert mehrere unabhängige Ergebnisse.

## Signatur

```text
DomainResult<List<T>> combine(
  List<DomainResult<T>> results
)
```

## Verhalten

Enthält mindestens ein Ergebnis Errors:

- das Gesamtergebnis ist Failure,
- alle relevanten Errors werden gesammelt,
- kein Erfolgswert wird zurückgegeben.

Sind alle Ergebnisse erfolgreich:

- alle Werte werden in Reihenfolge zurückgegeben,
- Warnungen und Informationen werden aggregiert.

---

# combineNamed()

## Zweck

Kombiniert Ergebnisse unterschiedlicher Typen über ein fachliches Ergebnisobjekt.

Beispiel:

```text
DomainResult<CreateProfileValues> combineNamed(
  nameResult,
  birthYearResult,
  heightResult
)
```

Die konkrete Implementierung kann über Builder, Records oder explizite Mapper erfolgen.

---

# map()

## Zweck

Transformiert den Erfolgswert, ohne den Fehlerzustand zu verändern.

## Signatur

```text
DomainResult<R> map<R>(
  R Function(T value) mapper
)
```

## Verhalten bei Success

- Der Mapper wird ausgeführt.
- Meldungen werden übernommen.
- Der neue Wert wird zurückgegeben.

## Verhalten bei Failure

- Der Mapper wird nicht ausgeführt.
- Errors, Warnungen und Informationen werden unverändert übernommen.
- Das Ergebnis bleibt Failure.

## Regeln

`map()` darf keine fachlichen Seiteneffekte ausführen.

---

# flatMap()

## Zweck

Verkettet fachliche Operationen, die selbst `DomainResult<R>` liefern.

## Signatur

```text
DomainResult<R> flatMap<R>(
  DomainResult<R> Function(T value) operation
)
```

## Verhalten bei Success

- Die Folgeoperation wird ausgeführt.
- Meldungen beider Ergebnisse werden konsistent kombiniert.

## Verhalten bei Failure

- Die Folgeoperation wird nicht ausgeführt.
- Das ursprüngliche Failure-Ergebnis wird typgerecht weitergegeben.

---

# bind()

`bind()` ist ein zulässiger alternativer Name für `flatMap()`.

Projektweit darf nur eine Benennung verwendet werden.

Empfehlung:

```text
flatMap()
```

---

# mapError()

## Zweck

Transformiert Fehler an einer klar definierten Schichtgrenze.

## Signatur

```text
DomainResult<T> mapError(
  DomainError Function(DomainError error) mapper
)
```

## Typische Verwendung

```text
Infrastructure Error
        │
        ▼
Application Error
```

## Regeln

- Die fachliche Bedeutung darf nicht verfälscht werden.
- Sensible technische Details müssen entfernt werden.
- Der ursprüngliche Code kann intern als `causeCode` erhalten bleiben.
- `mapError()` darf keinen Failure-Zustand in Success umwandeln.

---

# mapMessages()

## Zweck

Transformiert Meldungsmetadaten ohne Änderung des fachlichen Status.

Typische Verwendung:

- Correlation ID ergänzen,
- Dokumentationsreferenz ergänzen,
- sicheren Kontext ergänzen.

Nicht zulässig:

- Error zu Warning herabstufen,
- Bedeutung eines Codes ändern,
- sensible Daten ergänzen.

---

# withWarning()

## Zweck

Ergänzt eine Warning zu einem bestehenden Ergebnis.

## Signatur

```text
DomainResult<T> withWarning(
  DomainWarning warning
)
```

## Regeln

- Der Erfolgsstatus bleibt unverändert.
- Bei Success bleibt das Ergebnis erfolgreich.
- Bei Failure bleibt es fehlerhaft.
- Die Warning wird am Ende der Warnungsliste ergänzt.

---

# withInformation()

## Zweck

Ergänzt eine Information.

## Signatur

```text
DomainResult<T> withInformation(
  DomainInformation information
)
```

---

# withCorrelationId()

## Zweck

Ergänzt eine Correlation ID zu allen Meldungen, die noch keine besitzen.

## Signatur

```text
DomainResult<T> withCorrelationId(
  CorrelationId correlationId
)
```

Bereits vorhandene abweichende Correlation IDs dürfen nicht stillschweigend überschrieben werden.

---

# recover()

## Zweck

Ermöglicht eine ausdrücklich definierte fachliche Wiederherstellung aus bestimmten Fehlern.

## Signatur

```text
DomainResult<T> recover(
  bool Function(DomainError error) predicate,
  DomainResult<T> Function(List<DomainError> errors) recovery
)
```

## Regeln

`recover()` darf nur für dokumentierte, fachlich sichere Alternativen verwendet werden.

Beispiele:

- optionaler Cache nicht verfügbar → ohne Cache fortsetzen,
- optionale Exportrubrik leer → leerer Bereich mit Information.

Nicht zulässig:

- Datenbankfehler ignorieren,
- Security Error umgehen,
- atomare Operation teilweise fortsetzen.

---

# ensure()

## Zweck

Prüft eine zusätzliche Bedingung auf einem Erfolgswert.

## Signatur

```text
DomainResult<T> ensure(
  bool Function(T value) predicate,
  DomainError error
)
```

## Verhalten

- Bei Failure erfolgt keine weitere Prüfung.
- Bei erfüllter Bedingung bleibt das Ergebnis unverändert.
- Bei verletzter Bedingung wird ein Failure ohne Erfolgswert erzeugt.

---

# tap()

## Zweck

Führt eine nicht verändernde Beobachtung auf einem Success-Wert aus.

## Signatur

```text
DomainResult<T> tap(
  void Function(T value) observer
)
```

## Einschränkung

`tap()` darf keine fachlichen oder persistenten Seiteneffekte auslösen.

Zulässig:

- Testbeobachtung,
- sichere Metrikvorbereitung.

Nicht zulässig:

- Repository speichern,
- Event veröffentlichen,
- Aggregate verändern.

Aufgrund des Missbrauchsrisikos kann auf `tap()` vollständig verzichtet werden.

---

# Meldungsduplikate

## Grundregel

Identische Meldungen sollen innerhalb eines Ergebnisses nicht unnötig mehrfach enthalten sein.

## Identität einer Meldung

Für die Duplikaterkennung werden mindestens berücksichtigt:

- `code`,
- `field`,
- `constraint`,
- normalisierte Parameter.

## Ausnahme

Mehrere gleichartige Meldungen dürfen erhalten bleiben, wenn sie unterschiedliche fachliche Objekte betreffen.

Beispiel:

```text
zwei unterschiedliche importierte Profile mit demselben Fehlercode
```

---

# Priorisierung von Meldungen

## Grundregel

Die Reihenfolge der Meldungen besitzt keine fachliche Erfolgsbedeutung.

Für UI und Diagnose darf eine deterministische Priorisierung verwendet werden.

Empfohlene Reihenfolge:

1. `CRITICAL`
2. `ERROR`
3. `WARNING`
4. `INFORMATION`

Innerhalb desselben Schweregrads bleibt die Erzeugungsreihenfolge erhalten.

Die Domäne selbst muss Meldungen nicht für die UI sortieren.

---

# DomainResult und Exceptions

## Erwartbare Fehler

Werden als `DomainResult.failure()` zurückgegeben.

## Unerwartete technische Fehler

Entstehen zunächst als Exception innerhalb eines technischen Adapters.

An einer geeigneten Grenze werden sie:

- protokolliert,
- sicher abstrahiert,
- in einen kontrollierten technischen Fehler übersetzt,

sofern eine sichere Fortsetzung möglich ist.

## Programmierfehler

Programmierfehler wie:

- unmöglicher interner Zustand,
- verletzte nicht erreichbare Invariante,
- falsche Typannahme

dürfen nicht als gewöhnlicher `DomainResult` verschleiert werden.

Sie müssen sichtbar fehlschlagen und diagnostiziert werden.

---

# Rückgabe aus Repositories und Ports

Repositorys und Ports dürfen `DomainResult<T>` verwenden, wenn:

- technische Fehler sicher kategorisiert werden,
- fachliche und technische Meldungen eindeutig unterscheidbar sind,
- keine Bibliotheksdetails nach innen gelangen.

Beispiel:

```text
DomainResult<Profile>
├── error:
│   ├── category: PERSISTENCE
│   ├── code: PRO-PER-LOAD-001
│   └── causeCode: database.read.failed
```

Alternativ kann der Application Layer einen eigenen `ApplicationResult<T>` definieren.

Die projektweite Entscheidung muss im Application-Layer-Dokument verbindlich festgelegt werden.

---

# Beispiele

## Erfolgreiche Value-Object-Erzeugung

```json
{
  "isSuccess": true,
  "value": {
    "centimeters": 180
  },
  "errors": [],
  "warnings": [],
  "information": []
}
```

---

## Validierungsfehler

```json
{
  "isSuccess": false,
  "value": null,
  "errors": [
    {
      "code": "PRO-VAL-HEIGHT-003",
      "messageKey": "validation.profile.height.minimum",
      "severity": "ERROR",
      "category": "VALIDATION",
      "field": "height",
      "constraint": "minimum",
      "parameters": {
        "minimum": 20,
        "unit": "cm"
      }
    }
  ],
  "warnings": [],
  "information": []
}
```

---

## Erfolg mit Warnung

```json
{
  "isSuccess": true,
  "value": {
    "profileId": "018f4f42-9f5b-7ca4-bd20-3b31f09cd123"
  },
  "errors": [],
  "warnings": [
    {
      "code": "PRO-VAL-DUPNAME-001",
      "messageKey": "validation.profile.name.duplicate",
      "severity": "WARNING",
      "category": "VALIDATION",
      "field": "name",
      "constraint": "duplicate",
      "parameters": {
        "existingProfileCount": 1
      }
    }
  ],
  "information": []
}
```

---

## No Change

```json
{
  "isSuccess": true,
  "value": {
    "profileId": "018f4f42-9f5b-7ca4-bd20-3b31f09cd123"
  },
  "errors": [],
  "warnings": [],
  "information": [
    {
      "code": "PRO-BUS-NOCHANGE-001",
      "messageKey": "information.profile.noChange",
      "severity": "INFORMATION",
      "category": "BUSINESS",
      "parameters": {}
    }
  ]
}
```

---

# Testregeln

## ERR-TEST-001 – Factory-Tests

Für jede Factory-Methode sind mindestens zu testen:

- gültige Erzeugung,
- ungültige Erzeugung,
- leere Fehlerliste bei Success,
- mindestens ein Error bei Failure,
- unveränderliche Meldungslisten.

---

## ERR-TEST-002 – Statusinvarianten

Zu testen sind:

```text
isSuccess == !isFailure
```

und:

```text
isFailure == errors.isNotEmpty
```

---

## ERR-TEST-003 – map()

Zu testen:

- Mapper wird bei Success aufgerufen.
- Mapper wird bei Failure nicht aufgerufen.
- Meldungen bleiben erhalten.

---

## ERR-TEST-004 – flatMap()

Zu testen:

- erfolgreiche Verkettung,
- Abbruch nach erstem Failure,
- Meldungsaggregation,
- Reihenfolge der Meldungen.

---

## ERR-TEST-005 – combine()

Zu testen:

- alle Ergebnisse erfolgreich,
- ein Ergebnis fehlerhaft,
- mehrere Ergebnisse fehlerhaft,
- Warnungen und Informationen,
- deterministische Reihenfolge.

---

## ERR-TEST-006 – Datenschutz

Es muss getestet werden, dass:

- Passwörter,
- Hashwerte,
- Tokens,
- Proofs,
- Stacktraces

nicht in Meldungen oder JSON-Repräsentationen gelangen.

---

## ERR-TEST-007 – No Change

Zu testen:

- Success-Status,
- Information vorhanden,
- Version unverändert,
- Audit unverändert,
- keine Änderungs-Events.

---

## ERR-TEST-008 – Warning Confirmation

Zu testen:

- Warnung ohne Bestätigung,
- gültige Bestätigung,
- abgelaufene Bestätigung,
- falscher Confirmation Code,
- keine stillschweigende Bestätigung.

---

# Anti-Patterns

## Boolean-Rückgabe ohne Kontext

Nicht empfohlen:

```text
bool saveProfile()
```

Besser:

```text
DomainResult<void> saveProfile()
```

---

## Null als Fehler

Nicht zulässig:

```text
Profile? findProfile()
```

wenn `null` mehrere Fehlerursachen verschleiert.

Besser:

```text
DomainResult<Profile>
```

---

## Exception für Validierung

Nicht zulässig:

```text
throw InvalidHeightException
```

Besser:

```text
DomainResult<Height>.failure(...)
```

---

## Erfolgswert trotz Error

Nicht zulässig:

```text
value vorhanden
errors vorhanden
isSuccess = true
```

---

## String-basierte Fehler

Nicht zulässig:

```text
return "Profil konnte nicht gespeichert werden";
```

Besser:

```text
DomainError(
  code: PRO-PER-SAVE-001;
  ...
)
```

---

# Qualitätskriterien

Eine `DomainResult<T>`-Implementierung gilt als konform, wenn:

- alle Invarianten technisch erzwungen werden,
- freie inkonsistente Konstruktoren unmöglich sind,
- Meldungslisten unveränderlich sind,
- fachliche Exceptions vermieden werden,
- Meldungen sicher serialisierbar sind,
- `map()` und `flatMap()` statusstabil arbeiten,
- Datenschutzregeln eingehalten werden,
- alle Kernpfade getestet sind.

---

# Status dieses Abschnitts

Mit Teil 2 sind definiert:

- vollständige Struktur von `DomainResult<T>`,
- zehn Ergebnisinvarianten,
- Factory-Methoden,
- Success- und Failure-Zustände,
- No-Change-Ergebnisse,
- bestätigungspflichtige Warnungen,
- Meldungsaggregation,
- `combine()` und `combineNamed()`,
- `map()` und `flatMap()`,
- Meldungstransformationen,
- kontrollierte Recovery,
- Duplikat- und Priorisierungsregeln,
- Verhältnis zu Exceptions,
- Beispiele,
- Testregeln,
- Anti-Patterns,
- Qualitätskriterien.

---

# Teil 3

Der nächste Abschnitt definiert:

- Exception Policy,
- fachliche und technische Exceptions,
- Fehlerübersetzung an Schichtgrenzen,
- Repository- und Port-Fehler,
- Retry- und Recovery-Regeln,
- Transaktionsfehler,
- globale Exception-Behandlung,
- Crash- und Fallback-Verhalten.

# Teil 3A – Exception Policy

# Zweck

Dieses Kapitel definiert den projektweiten Umgang mit Exceptions.

Es legt verbindlich fest,

- wann Exceptions zulässig sind,
- wann `DomainResult<T>` verwendet wird,
- wie Exceptions an Schichtgrenzen behandelt werden,
- welche Komponente für die Übersetzung verantwortlich ist,
- welche Fehler sofort zum Abbruch führen.

Die Exception Policy gilt für das gesamte System.

---

# Grundprinzipien

## ERR-EX-001 – Exceptions sind außergewöhnlich

Exceptions beschreiben ausschließlich unerwartete Situationen.

Sie gehören nicht zum normalen Geschäftsablauf.

Beispiele

- beschädigte Datenbank
- Dateisystemfehler
- Bibliotheksfehler
- Speicherfehler
- interne Programmierfehler

---

## ERR-EX-002 – Fachliche Fehler sind keine Exceptions

Folgende Situationen erzeugen niemals Exceptions:

- ungültige Eingaben
- Business Rule verletzt
- Validation Rule verletzt
- Authentication fehlgeschlagen
- Profil existiert nicht
- Profil bereits archiviert

Diese Situationen werden ausschließlich über

```text
DomainResult<T>
```

signalisiert.

---

## ERR-EX-003 – Fail Fast

Programmierfehler dürfen nicht verschleiert werden.

Beispiele

- NullPointer
- unmöglicher Aggregatezustand
- verletzte interne Invariante
- falscher Cast
- nicht erreichbarer Code

führen zum sofortigen Abbruch.

---

## ERR-EX-004 – Keine Catch-All-Blöcke

Nicht zulässig

```text
catch (Exception) {
}
```

wenn dadurch

- Fehler verschluckt,
- Diagnosen verhindert,
- Business Rules verändert

werden.

Jeder Catch besitzt einen definierten Zweck.

---

# Exception-Klassifikation

Die Architektur unterscheidet vier Gruppen.

---

## Gruppe A

### Fachliche Fehler

Werden immer als

```text
DomainResult<T>
```

zurückgegeben.

Keine Exception.

---

## Gruppe B

### Technische Fehler

Entstehen in

- Datenbank
- Dateisystem
- Netzwerk
- Bibliotheken

Diese dürfen zunächst als Exception auftreten.

---

## Gruppe C

### Infrastrukturfehler

Beispiele

- SQLite defekt
- Datei nicht lesbar
- Outbox nicht erreichbar

Diese werden an der Port-Grenze übersetzt.

---

## Gruppe D

### Programmierfehler

Beispiele

- AssertionError
- StateError
- RangeError
- NullPointer

Diese werden nicht in

```text
DomainResult
```

übersetzt.

---

# Layer-Regeln

# Value Objects

## Regeln

Value Objects werfen keine fachlichen Exceptions.

Ungültige Werte führen zu

```text
DomainResult.failure()
```

---

## Zulässig

Programmierfehler

dürfen Exceptions erzeugen.

Beispiel

```text
interner Nullzustand
```

---

# Entities

Entities verwenden ausschließlich

```text
DomainResult
```

für fachliche Fehler.

Keine technische Behandlung.

---

# Aggregate

Aggregate erzeugen niemals technische Exceptions.

Business Rules

↓

DomainResult

---

# Domain Services

Domain Services

werfen keine fachlichen Exceptions.

Technische Fehler werden nicht behandelt,

sondern an Ports delegiert.

---

# Factory

Factories

übersetzen keine Exceptions.

Ungültige Aggregate

↓

DomainResult

---

# Repository

Repository-Implementierungen dürfen technische Exceptions erhalten.

Beispiele

```text
SQLiteException

IOException
```

Diese verlassen das Repository nicht ungefiltert.

---

# Repository-Regel

```text
SQLiteException

↓

Repository Error

↓

DomainResult
```

oder

```text
ApplicationResult
```

je nach Architekturentscheidung.

---

# Domain Ports

Ports definieren

keine

Exceptions.

Sie liefern ausschließlich

```text
DomainResult<T>
```

---

# Adapter

Adapter dürfen

Bibliotheks-Exceptions erhalten.

Beispiele

```text
IOException

SocketException

DatabaseException
```

---

# Adapter-Regel

Adapter

übersetzen

technische Exceptions

in

strukturierte Fehler.

---

## ERR-EX-009 – Behandlung asynchroner Exceptions

### Zweck

Asynchron auftretende Exceptions werden nach denselben Regeln behandelt wie synchron auftretende Exceptions.

Die Art der Ausführung darf die Fehlerbehandlung nicht verändern.

---

### Geltungsbereich

Diese Regel gilt insbesondere für

- `Future`
- `async / await`
- Streams
- Dateioperationen
- Datenbankzugriffe
- Netzwerkzugriffe
- Hintergrundaufgaben

---

### Standardablauf

```text
Future

↓

technische Exception

↓

Infrastructure Adapter

↓

Exception Mapping

↓

DomainResult<T>
```

---

### Regeln

Asynchrone Exceptions

dürfen niemals

ungefiltert

bis zur Benutzeroberfläche propagieren.

---

Alle Exceptions werden

an derselben Architekturschicht behandelt,

an der sie auch im synchronen Ablauf behandelt würden.

---

### Beispiel

```text
SQLite Exception

↓

ProfileRepositoryAdapter

↓

repository.profile.saveFailed

↓

DomainResult<void>
```

---

### Stream-Verarbeitung

Bei Stream-basierten Operationen gilt:

- jede Exception wird isoliert behandelt,
- bereits erfolgreich verarbeitete Elemente bleiben unverändert,
- atomare Operationen werden vollständig zurückgerollt,
- partielle Ergebnisse werden nur geliefert, wenn dies fachlich ausdrücklich vorgesehen ist.

---

### Cancellation

Abgebrochene asynchrone Operationen sind keine technischen Fehler.

Sie werden als definierter Kontrollfluss behandelt.

Beispiele

- Benutzer bricht Import ab,
- Backup wird bewusst beendet,
- Synchronisation wird gestoppt.

---

### Timeout

Ein Timeout stellt einen technischen Fehler dar.

Er wird in einen strukturierten Fehler übersetzt.

Beispiel

```text
network.timeout

↓

DomainError
```

---

### Retry

Eine automatische Wiederholung erfolgt ausschließlich,

wenn sie durch die Retry Policy ausdrücklich erlaubt ist.

Sie darf

- keine fachlichen Doppeloperationen erzeugen,
- keine Invarianten verletzen,
- keine Domain Events mehrfach veröffentlichen.

---

### Architekturregel

Synchroner und asynchroner Programmablauf besitzen dieselbe fachliche Fehlersemantik.

Die Domäne unterscheidet nicht,

ob eine Operation synchron oder asynchron ausgeführt wurde.

---

# Application Service

Application Services

fangen

technische Fehler,

wenn

sie

- übersetzt,
- protokolliert,
- oder koordiniert

werden müssen.

---

Sie erzeugen

keine

Business Exceptions.

---

# UI

Die UI

arbeitet niemals

mit

Bibliotheks-Exceptions.

Sie erhält ausschließlich

strukturierte Ergebnisse.

---

# Exception-Übersetzung

## Zweck

Technische Fehler

werden

an definierten Grenzen

übersetzt.

---

# Beispiel

```text
SQLiteException

↓

ProfileRepositoryAdapter

↓

PRO-PER-LOAD-001

↓

DomainResult
```

---

# Weitere Beispiele

```text
IOException

↓

ImageStorageAdapter

↓

PRO-INF-IMAGE-001
```

---

```text
SocketException

↓

ImportAdapter

↓

PRO-INF-IMPORT-001
```

---

# Übersetzungsregeln

## ERR-EX-005

Keine Bibliotheks-Exception

verlässt

den Adapter.

---

## ERR-EX-006

Stacktraces

werden

nicht

an

Domain

oder

UI

weitergegeben.

---

## ERR-EX-007

Interne Exceptiontexte

werden

nicht

Benutzermeldungen.

---
## ERR-EX-008 – Cause Chain Preservation

### Zweck

Beim Übersetzen technischer Exceptions muss die ursprüngliche Ursache für Diagnose- und Analysezwecke erhalten bleiben, ohne technische Implementierungsdetails an die Domain oder Benutzeroberfläche weiterzugeben.

---

### Grundsatz

Die ursprüngliche Exception darf ausschließlich innerhalb der Infrastruktur- bzw. Application-Schicht bekannt sein.

Die Domäne erhält ausschließlich eine abstrahierte Fehlerbeschreibung.

---

### Standardablauf

```text
Technische Exception
        │
        ▼
Infrastructure Adapter
        │
        ▼
Exception Mapping
        │
        ▼
DomainError
        │
        ├── code
        ├── causeCode
        └── category
```

---

### Beispiel

```text
IOException

↓

ImageStorageAdapter

↓

DomainError

code:
PRO-INF-IMAGE-001

causeCode:
io.file.read.failed
```

---

### Regeln

Die ursprüngliche Exception

- bleibt ausschließlich intern verfügbar,
- darf für Logging verwendet werden,
- darf für Diagnosezwecke gespeichert werden,
- darf niemals Bestandteil eines `DomainError` sein.

---

### Cause Code

Der `causeCode`

- beschreibt die technische Ursache,
- ist sprachneutral,
- enthält keine Bibliotheksklassen,
- enthält keine Stacktraces,
- enthält keine Dateipfade,
- enthält keine sensiblen Informationen.

Beispiele

```text
database.read.failed

database.write.failed

io.file.read.failed

io.file.write.failed

network.timeout

network.connection.failed

serialization.failed
```

---

### Nicht zulässig

Ein `DomainError` darf niemals enthalten:

- SQLiteException
- IOException
- SocketException
- FlutterError
- Stacktrace
- Bibliotheksmeldungen
- vollständige Exceptiontexte

---

### Logging

Für Diagnosezwecke dürfen intern protokolliert werden:

- ursprüngliche Exception,
- Stacktrace,
- CorrelationId,
- Timestamp,
- technische Metadaten.

Diese Informationen verlassen die Infrastruktur nicht.

---

### Architekturregel

Die Ursache einer technischen Exception bleibt nachvollziehbar,

die technische Implementierung bleibt jedoch vollständig von Domain und UI entkoppelt.

---

# Fail Fast

Folgende Situationen

führen

immer

zum sofortigen Abbruch.

---

## Ungültige interne Zustände

Beispiel

```text
AggregateVersion == null
```

---

## Verletzte Programmierannahmen

Beispiel

```text
Switch

ohne

Default

bei vollständigem Enum
```

---

## Nicht erreichbarer Code

```text
Unreachable
```

---

## Speicherkorruption

Nicht behandelbar.

---

## Inkonsistente interne Daten

Nicht behandelbar.

---

# Nicht übersetzbare Fehler

Folgende Fehler

dürfen

nicht

in

```text
DomainResult
```

übersetzt werden.

- OutOfMemory
- StackOverflow
- AssertionError
- interne Programmierfehler
- beschädigte Runtime

---

# Verantwortlichkeiten

| Komponente | Verantwortung |
|------------|---------------|
| Value Object | Validation |
| Aggregate | Business Rules |
| Factory | gültige Aggregate |
| Repository | technische Übersetzung |
| Adapter | Bibliotheksfehler übersetzen |
| Application Service | Fehler koordinieren |
| UI | Darstellung |

---

# Architekturregeln

## Keine Exception über Layer

Bibliotheks-Exceptions

dürfen

nicht

mehrere Schichten

ungefiltert

durchlaufen.

---

## Domain bleibt sauber

Die Domäne

kennt

keine

SQLiteException

IOException

SocketException

FlutterError

---

## Adapter kapseln Technik

Alle Bibliotheken

enden

am Adapter.

---

# Beispiele

## Richtig

```text
SQLiteException

↓

Repository

↓

DomainResult
```

---

## Falsch

```text
SQLiteException

↓

UI
```

---

## Richtig

```text
Business Rule

↓

DomainResult
```

---

## Falsch

```text
Business Rule

↓

Exception
```

---

# Testbarkeit

Zu testen sind

- technische Exception
- Repositoryübersetzung
- Adapterübersetzung
- DomainResult-Erzeugung
- Fail Fast
- keine Business Exception
- keine Stacktraces
- keine Bibliotheksklassen in Domain

---

# Traceability

## Requirements

- PRO-FR-024
- PRO-FR-025
- PRO-FR-026
- PRO-FR-027

---

## Domain Model

- DomainResult
- Domain Ports
- Repository
- Factory
- Application Layer

---

# Status dieses Abschnitts

Mit Teil **3A** sind definiert:

- Exception-Philosophie
- Exception-Klassifikation
- Layer-Regeln
- Value Objects
- Aggregate
- Factory
- Repository
- Adapter
- Application Service
- Exception-Übersetzung
- Fail-Fast-Regeln
- Verantwortlichkeiten
- Architekturregeln
- Testbarkeit
- Traceability

Teil **3B** beschreibt anschließend:

- Retry Policy
- Recovery
- Transaktionsfehler
- Global Exception Handler
- Crash Policy
- Logging Integration
- Anti-Patterns
- Qualitätsregeln
- Abschluss der Exception Policy

# Teil 3B – Recovery, Retry und globale Exception-Behandlung

# Zweck

Dieses Kapitel definiert den projektweiten Umgang mit technischen Fehlern nach deren Erkennung.

Es beschreibt

- Recovery-Strategien,
- Retry-Regeln,
- Transaktionsfehler,
- globale Exception-Behandlung,
- Crash-Policy,
- Logging,
- Monitoring,
- Qualitätsregeln.

Diese Regeln gelten für alle Module.

---

# Recovery Policy

## Zweck

Recovery beschreibt den kontrollierten Umgang mit einem Fehler,

wenn eine fachlich sichere Fortsetzung möglich ist.

Recovery ist ausschließlich für ausdrücklich definierte Situationen zulässig.

---

## ERR-REC-001 – Keine automatische Recovery fachlicher Fehler

Business Rules

werden niemals automatisch korrigiert.

Beispiele

Nicht zulässig

- Profilname ändern
- Passwort ersetzen
- Geburtsjahr korrigieren
- Standardprofil wechseln

Diese Entscheidungen trifft ausschließlich der Benutzer.

---

## ERR-REC-002 – Recovery nur für technische Fehler

Recovery ist ausschließlich zulässig bei

- Cachefehlern
- optionalen Dateien
- temporären Netzwerkfehlern
- optionalen Bildern
- optionalen Metadaten

---

## ERR-REC-003 – Keine Recovery bei Sicherheitsfehlern

Folgende Fehler dürfen niemals automatisch behoben werden

- Authentication fehlgeschlagen
- Passwort ungültig
- Zugriff verweigert
- AuthenticationProof abgelaufen

---

## ERR-REC-004 – Keine Recovery bei Datenverlust

Recovery darf niemals

- Daten löschen,
- Daten überschreiben,
- Business Rules verletzen,
- Invarianten ändern.

---

## ERR-REC-005 – Circuit Breaker

### Zweck

Bei wiederholt auftretenden technischen Fehlern darf eine Ressource
vorübergehend als nicht verfügbar markiert werden.

Dadurch werden

- unnötige Wiederholungen,
- Ressourcenbelastung,
- Kaskadeneffekte,
- Log-Fluten

vermieden.

---

### Einsatzgebiete

Beispiele

- Cloud-Synchronisation
- Web-API
- Netzwerklaufwerk
- externer Authentifizierungsdienst
- Dateispeicher

---

### Regeln

Ein Circuit Breaker

- wird ausschließlich bei technischen Fehlern verwendet,
- besitzt einen definierten Schwellenwert,
- besitzt eine definierte Sperrzeit,
- verhindert weitere automatische Zugriffe während der Sperrzeit.

---

### Wiederaufnahme

Nach Ablauf der Sperrzeit

erfolgt

ein

kontrollierter Testzugriff.

Nur bei erfolgreichem Test

wird

die Ressource

wieder freigegeben.

---

### Architekturregel

Circuit Breaker gehören ausschließlich

zur Infrastruktur

oder

zum Application Layer.

Die Domäne kennt keine Circuit Breaker.

---

# Retry Policy

## Zweck

Retry beschreibt das kontrollierte Wiederholen technischer Operationen.

---

## ERR-RET-001 – Retry nur bei temporären Fehlern

Retry ist zulässig bei

- Netzwerkfehler
- Timeout
- Dateisperre
- temporär gesperrte Datenbank
- Cloud Synchronisation

---

Nicht zulässig

- Validation Error
- Business Error
- Authentication Error
- Importfehler
- beschädigte Daten

---

## ERR-RET-002 – Idempotenz

Retry ist ausschließlich zulässig,

wenn die Operation idempotent ist.

---

Beispiele

Zulässig

```text
Bild lesen
```

```text
Profil laden
```

```text
Datei prüfen
```

---

Nicht zulässig

```text
Profil erzeugen
```

```text
Passwort ändern
```

```text
Domain Event veröffentlichen
```

ohne Idempotenzstrategie.

---

## ERR-RET-003 – Begrenzte Wiederholungen

Retry erfolgt niemals unbegrenzt.

Empfehlung

```text
maximal 3 Versuche
```

Danach

```text
Failure
```

---

## ERR-RET-004 – Backoff

Zwischen Wiederholungen

wird

ein Backoff verwendet.

Empfohlen

```text
Exponential Backoff
```

---

## ERR-RET-005 – Kein Retry innerhalb der Domain

Domain

kennt

keine

Retry-Logik.

Retry erfolgt ausschließlich

im Application Layer

oder

Infrastructure Layer.

---

## ERR-RET-006 – Retry Budget

### Zweck

Für einen fachlichen Vorgang existiert genau eine Retry-Verantwortung.

Mehrere Retry-Mechanismen dürfen sich nicht gegenseitig vervielfachen.

---

### Beispiel

Nicht zulässig

```text
HTTP Client
        │
        ▼
3 Retries
        │
        ▼
Repository
        │
        ▼
3 Retries
        │
        ▼
Application Layer
        │
        ▼
3 Retries
```

Ergebnis

```text
27 Wiederholungen
```

---

### Zulässig

Genau eine Schicht

übernimmt

die Retry-Verantwortung.

Beispiel

```text
Application Layer
        │
        ▼
Retry (max. 3)
        │
        ▼
Repository
        │
        ▼
Adapter
```

Repository und Adapter

führen

keine

zusätzlichen automatischen Wiederholungen aus.

---

### Architekturregel

Retry wird zentral koordiniert.

Die Retry-Strategie muss

- deterministisch,
- testbar,
- konfigurierbar

sein.

---

# Transaktionsfehler

## Zweck

Transaktionsfehler entstehen,

wenn atomare Operationen nicht erfolgreich abgeschlossen werden können.

---

## ERR-TX-001 – Atomarität

Eine Transaktion endet ausschließlich mit

```text
Commit
```

oder

```text
Rollback
```

Teilzustände sind unzulässig.

---

## ERR-TX-002 – Rollback

Bei Rollback gilt

- keine persistierten Änderungen
- keine veröffentlichten Domain Events
- keine Änderung der Aggregate-Version

---

## ERR-TX-003 – Outbox

Wird das Outbox Pattern verwendet,

muss gelten

```text
Aggregate gespeichert

UND

Outbox gespeichert

ODER

gar nichts gespeichert.
```

---

# Global Exception Handler

## Zweck

Der Global Exception Handler behandelt

unerwartete technische Fehler,

die nicht bereits lokal verarbeitet wurden.

---

## Verantwortlichkeiten

- Logging
- Monitoring
- Diagnose
- kontrollierte Fehlerantwort
- Crash-Entscheidung

---

## Nicht verantwortlich

- Business Rules
- Validation
- UI-Texte
- Persistenzlogik

---

# Crash Policy

## ERR-CRASH-001 – Nicht behandelbare Fehler

Folgende Fehler führen zum kontrollierten Abbruch

- OutOfMemory
- StackOverflow
- beschädigte Runtime
- interne Konsistenzverletzung
- AssertionError

---

## ERR-CRASH-002 – Keine Wiederaufnahme

Nach einem Crash

wird

keine

Fortsetzung

versucht.

---

# Logging Integration

## Zweck

Jede unerwartete technische Exception

wird

protokolliert.

---

## Mindestinformationen

- Timestamp
- CorrelationId
- Exceptiontyp
- CauseCode
- Stacktrace
- Layer
- Modul

---

## Datenschutz

Logs enthalten niemals

- Passwörter
- Tokens
- AuthenticationProof
- Gesundheitsdaten
- Bilddaten

---

# Monitoring

Folgende Kennzahlen dürfen überwacht werden

- Exception Rate
- Retry Rate
- Recovery Rate
- Rollback Rate
- Crash Rate
- Event Publish Errors

---

# Fehlerpriorität

Reihenfolge

```text
Critical

↓

Error

↓

Warning

↓

Information
```

---

# Architekturregeln

## Domain

kennt

keine

Recovery.

---

## Aggregate

führen

keine

Retry-Logik aus.

---

## Adapter

übersetzen

technische Fehler.

---

## Application Layer

koordiniert

Retry

Recovery

Logging.

---

## UI

entscheidet

nicht

über Recovery.

---

# Anti-Patterns

Nicht zulässig

```text
while(true)

retry()
```

---

Nicht zulässig

```text
catch(Exception){

retry();
}
```

---

Nicht zulässig

```text
Rollback

↓

Event Publish
```

---

Nicht zulässig

```text
Recovery

↓

Business Rule umgehen
```

---

# Testbarkeit

Zu testen

- Retry erfolgreich
- Retry fehlgeschlagen
- Rollback
- Recovery
- Outbox
- Crash
- Logging
- Monitoring
- Idempotenz

---

# Traceability

## Requirements

- PRO-FR-024
- PRO-FR-025
- PRO-FR-026
- PRO-FR-027

---

## Domain Model

- UnitOfWork
- Domain Events
- Outbox
- Repository
- DomainResult
- Domain Ports

---

# Qualitätskriterien

Die Exception Policy erfüllt

- Clean Architecture
- Domain-Driven Design
- Fail Fast
- Single Responsibility
- Determinismus
- vollständige Testbarkeit
- Datenschutz
- geringe Kopplung

---

# Status dieses Abschnitts

Mit Teil **3B** sind vollständig definiert:

- Recovery Policy
- Retry Policy
- Transaktionsfehler
- Rollback-Regeln
- Outbox-Regeln
- Global Exception Handler
- Crash Policy
- Logging Integration
- Monitoring
- Architekturregeln
- Anti-Patterns
- Testbarkeit
- Traceability

Damit ist **Kapitel 3 – Exception Policy** des `06_ERROR_HANDLING_GUIDE.md` vollständig abgeschlossen.

---

# Teil 4

Der nächste Abschnitt beschreibt:

- Logging Policy
- Audit Logging
- Log-Level
- CorrelationId
- TraceId
- strukturierte Logs
- Datenschutz im Logging
- Diagnoseinformationen
- Monitoring-Events
- Metriken
- Performance Logging
- Security Logging
- Log-Retention
- Export und Analyse
- Traceability

# 06_ERROR_HANDLING_GUIDE.md

# Teil 4A – Logging Policy

# Zweck

Die Logging Policy definiert die projektweit verbindlichen Regeln für das Erzeugen, Strukturieren, Speichern und Auswerten von Logeinträgen.

Ziele sind:

- nachvollziehbare Diagnose,
- reproduzierbare Fehleranalyse,
- Unterstützung der Entwicklung,
- Unterstützung des Betriebs,
- Datenschutz,
- Sicherheit,
- geringe Kopplung zur Fachlogik.

Logging ist ausschließlich eine technische Querschnittsfunktion.

---

# Geltungsbereich

Diese Logging Policy gilt für:

- Domain Layer
- Application Layer
- Infrastructure Layer
- UI
- Import
- Export
- Synchronisation
- Backup
- Event Processing
- Hintergrundprozesse

---

# Grundprinzipien

## LOG-001 – Logging ist keine Geschäftslogik

Logs dienen ausschließlich der Diagnose.

Sie beeinflussen niemals:

- Business Rules,
- Aggregate,
- DomainResult,
- Domain Events,
- Persistenzentscheidungen.

---

## LOG-002 – Logging verändert keine Ergebnisse

Fehlgeschlagenes Logging darf niemals:

- eine Operation abbrechen,
- einen Rollback auslösen,
- einen Success in Failure umwandeln.

Logging ist best effort.

---

## LOG-003 – Strukturierte Logs

Alle Logeinträge besitzen eine einheitliche Struktur.

Freitext allein ist nicht zulässig.

---

## LOG-004 – Datenschutz

Logs dürfen keine sensiblen Informationen enthalten.

Insbesondere niemals:

- Passwörter,
- Passwort-Hashes,
- AuthenticationProof,
- Tokens,
- Session Keys,
- Gesundheitsdaten,
- Bilddaten,
- vollständige Dateipfade,
- personenbezogene Diagnosedaten.

---

## LOG-005 – Determinismus

Bei identischen Abläufen entstehen gleich strukturierte Logs.

---

## LOG-006 – Strukturierte Metadaten

### Zweck

Zusätzliche Diagnoseinformationen werden ausschließlich als strukturierte Metadaten gespeichert.

Dadurch bleiben Logeinträge

- maschinenlesbar,
- filterbar,
- auswertbar,
- versionsstabil.

---

### Regeln

Metadaten bestehen ausschließlich aus

```text
Key

↓

Value
```

Paaren.

---

### Zulässige Werte

- Boolean
- Integer
- Decimal
- String
- Timestamp
- UUID
- Enum
- Listen einfacher Werte

---

### Nicht zulässig

- formatierte Freitexte
- eingebettete Stacktraces
- serialisierte Objekte
- HTML
- Markdown
- Binärdaten

---

### Beispiel

```text
metadata

operation:
ProfileImport

retryCount:
2

outboxSize:
14

batchSize:
25
```

---

### Architekturregel

Metadaten ergänzen Logeinträge,

ersetzen jedoch niemals

die definierten Pflichtfelder eines `LogEntry`.

---

# LogLevel

## Zulässige Stufen

```text
TRACE

DEBUG

INFO

WARNING

ERROR

CRITICAL
```

---

## TRACE

Verwendung

- Entwicklung
- tiefe Diagnose
- Performanceanalyse

Nicht für Produktivbetrieb vorgesehen.

---

## DEBUG

Verwendung

- Entwicklerdiagnose
- Ablaufanalyse
- Testbetrieb

---

## INFO

Normale Betriebsinformationen.

Beispiele

- Profil erstellt
- Backup gestartet
- Import beendet

---

## WARNING

Ungewöhnliche,

aber beherrschbare Situationen.

Beispiele

- Retry
- Circuit Breaker geöffnet
- veraltetes Importformat

---

## ERROR

Technische Fehler,

die behandelt werden konnten.

---

## CRITICAL

Nicht beherrschbare Fehler.

Beispiele

- beschädigte Datenbank
- OutOfMemory
- Crash

---

# LogEntry

## Zweck

Ein LogEntry beschreibt genau ein technisches Ereignis.

---

## Pflichtfelder

| Feld | Typ |
|------|-----|
| timestamp | Timestamp |
| level | LogLevel |
| category | LogCategory |
| message | LogMessage |
| module | ModuleName |

---

## Optionale Felder

| Feld | Typ |
|------|-----|
| correlationId | CorrelationId |
| traceId | TraceId |
| eventId | DomainEventId |
| aggregateId | AggregateId |
| profileId | ProfileId |
| exceptionType | String |
| causeCode | ErrorCode |
| duration | Duration |

---

# LogCategory

## Beispiele

```text
Application

Domain

Repository

Database

Import

Export

Backup

Security

Event

Infrastructure

UI
```

---

# LogMessage

## Regeln

Eine LogMessage

- beschreibt den technischen Vorgang,
- ist kurz,
- eindeutig,
- enthält keine sensiblen Daten.

---

# CorrelationId

## Zweck

Verbindet alle Logeinträge,

die zu einem fachlichen Vorgang gehören.

---

## Beispiel

```text
Profil löschen

↓

Repository

↓

Event

↓

Backup

↓

Logging
```

Alle Einträge

verwenden dieselbe

CorrelationId.

---

# TraceId

## Zweck

Kennzeichnet

einen

konkreten technischen Ablauf.

Mehrere TraceIds

dürfen

zu einer CorrelationId gehören.

---

# EventId

Falls ein Domain Event erzeugt wurde,

wird dessen

DomainEventId

im Log gespeichert.

---

## LOG-008 – Event Correlation Logging

### Zweck

Logeinträge,

die im Zusammenhang mit Domain Events entstehen,

übernehmen

deren Identifikationsmerkmale.

---

### Regeln

Besitzt ein Domain Event

eine

```text
CorrelationId
```

oder

```text
DomainEventId
```

werden diese

in alle daraus entstehenden Logeinträge übernommen.

---

### Beispiel

```text
ProfileDeleted

↓

DomainEvent

↓

Event Handler

↓

Repository

↓

Logging
```

Alle Logeinträge

verwenden dieselbe

```text
CorrelationId
```

und,

falls vorhanden,

dieselbe

```text
DomainEventId
```

---

### Nutzen

Dadurch können

- Eventfluss,
- Logging,
- Monitoring,
- Outbox,
- Retry,
- Recovery

vollständig miteinander korreliert werden.

---

### Architekturregel

Die Event-Korrelation

ändert niemals

den fachlichen Inhalt

eines Logeintrags.

Sie ergänzt ausschließlich

dessen Diagnoseinformationen.

---

# UserContext

## Zweck

Beschreibt den aktuellen Benutzerkontext.

---

## Zulässig

- ProfileId
- Rolleninformation
- SessionId (gekürzt)
- Gerätekennung (pseudonymisiert)

---

## Nicht zulässig

- Passwort
- Token
- AuthenticationProof
- Gesundheitsdaten

---

# Security Logging

## Zweck

Sicherheitsrelevante Vorgänge

werden

gesondert protokolliert.

---

## Beispiele

- Login
- Logout
- Passwort geändert
- Passwortprüfung fehlgeschlagen
- Profil entsperrt
- Authentifizierung verweigert

---

## Regeln

Keine Speicherung

von

- Passwort,
- Hash,
- Proof,
- Token.

---

# Audit Logging

## Zweck

Audit Logs dokumentieren

fachlich relevante Änderungen.

---

## Beispiele

- Profil erstellt
- Profil gelöscht
- Standardprofil geändert
- Passwortschutz aktiviert
- Profil exportiert

---

## Eigenschaften

Audit Logs

sind

unveränderlich.

---

# Performance Logging

## Zweck

Messung

technischer Laufzeiten.

---

## Beispiele

- Repository
- Datenbank
- Import
- Export
- Bildverarbeitung

---

## Felder

```text
Operation

Duration

Module

Timestamp
```

---

## LOG-007 – Log Sampling

### Zweck

Sehr häufig auftretende Logeinträge dürfen reduziert werden,

ohne die Diagnosefähigkeit wesentlich einzuschränken.

---

### Einsatzgebiete

Beispiele

- TRACE
- DEBUG
- Performance Logging
- Polling
- Health Checks

---

### Regeln

Sampling

darf

ausschließlich

bei

nicht sicherheitskritischen

Logeinträgen verwendet werden.

---

Nicht zulässig

- Audit Logs
- Security Logs
- ERROR
- CRITICAL

---

### Anforderungen

Sampling

muss

- deterministisch,
- konfigurierbar,
- nachvollziehbar

sein.

---

### Architekturregel

Sampling verändert niemals

den fachlichen Zustand

und

führt niemals

zum Verlust

sicherheitsrelevanter

Logeinträge.

---

# Exception Logging

## Regeln

Eine Exception

wird

genau einmal

vollständig geloggt.

Weitere Schichten

verwenden

CorrelationId

statt

erneutem Stacktrace.

---

# Stacktrace

Stacktraces

werden ausschließlich

bei

ERROR

oder

CRITICAL

gespeichert.

---

# Architekturregeln

## Domain Layer

Die Domäne

kennt

keine

Loggingbibliothek.

---

## Application Layer

Koordiniert

Logging

fachlicher Abläufe.

---

## Infrastructure Layer

Erzeugt

technische Logs.

---

## UI

Erzeugt

keine

Diagnoselogs

der Fachlogik.

---

# Verantwortlichkeiten

| Komponente | Verantwortung |
|------------|---------------|
| Domain | keine Loggingbibliothek |
| Application | Ablaufprotokoll |
| Repository | technische Diagnose |
| Adapter | technische Fehler |
| UI | optionale Benutzerdiagnose |
| Monitoring | Auswertung |

---

# Beispiele

## INFO

```text
Backup gestartet
```

---

## WARNING

```text
Retry gestartet
```

---

## ERROR

```text
Import fehlgeschlagen
```

---

## CRITICAL

```text
SQLite beschädigt
```

---

# Datenschutz

Logs

dürfen

niemals

Rückschlüsse

auf

Gesundheitsdaten zulassen,

wenn dies

nicht

zwingend erforderlich ist.

---

# Testbarkeit

Zu testen

- LogLevel
- CorrelationId
- TraceId
- Datenschutz
- Exception Logging
- Audit Logging
- Performance Logging

---

# Traceability

## Requirements

- PRO-FR-024
- PRO-FR-025
- PRO-FR-026
- PRO-FR-027

---

## Architektur

- DomainResult
- DomainEvent
- Repository
- Outbox
- Application Layer

---

# Qualitätskriterien

Die Logging Policy erfüllt

- Datenschutz
- Nachvollziehbarkeit
- geringe Kopplung
- deterministische Logs
- strukturierte Diagnose
- vollständige Testbarkeit

---

# Status dieses Abschnitts

Mit Teil **4A** sind definiert:

- Logging-Grundprinzipien
- LogLevel
- LogEntry
- LogCategory
- LogMessage
- CorrelationId
- TraceId
- EventId
- UserContext
- Security Logging
- Audit Logging
- Performance Logging
- Exception Logging
- Datenschutz
- Architekturregeln
- Verantwortlichkeiten
- Testbarkeit
- Traceability

---

# Teil 4B

Der nächste Abschnitt beschreibt:

- Monitoring
- Health Checks
- Metriken
- Alerting
- Event Monitoring
- Performance Monitoring
- Log-Retention
- Log-Rotation
- Log-Export
- Diagnosewerkzeuge
- Anti-Patterns
- Qualitätsregeln
- Abschluss des Logging-Kapitels

# 06_ERROR_HANDLING_GUIDE.md

# Teil 4B – Diagnostics, Monitoring und Log-Betrieb

# Zweck

Dieser Abschnitt definiert die projektweiten Regeln für:

- technische Diagnose,
- Monitoring,
- Health Checks,
- Metriken,
- Alerting,
- Log-Aufbewahrung,
- Log-Rotation,
- Log-Export,
- Diagnosewerkzeuge,
- Betriebsüberwachung.

Logging beschreibt einzelne technische Ereignisse.

Monitoring bewertet dagegen den Zustand, das Verhalten und die Entwicklung des Systems über einen Zeitraum.

---

# Geltungsbereich

Die Regeln gelten insbesondere für:

- Flutter-Anwendung,
- lokale Persistenz,
- Import und Export,
- Backup und Wiederherstellung,
- Event-Verarbeitung,
- Transactional Outbox,
- Bildverarbeitung,
- Synchronisation,
- zukünftige Cloud- und Serverkomponenten,
- Hintergrundprozesse,
- Infrastrukturadapter.

---

# Grundprinzipien

## MON-001 – Monitoring ist keine Fachlogik

Monitoring darf niemals:

- Business Rules verändern,
- Aggregate beeinflussen,
- Validierungen umgehen,
- fachliche Entscheidungen treffen,
- Benutzeraktionen ersetzen.

Monitoring beobachtet ausschließlich technische und betriebliche Zustände.

---

## MON-002 – Keine Zustandsänderung durch Diagnose

Das Lesen von:

- Logs,
- Metriken,
- Health-Status,
- Diagnoseinformationen

darf den fachlichen Zustand nicht verändern.

Ausnahmen sind ausschließlich technische Diagnosezähler oder ausdrücklich definierte Prüfmarkierungen.

---

## MON-003 – Datenschutz durch Datenminimierung

Es werden nur diejenigen Informationen erhoben, die für:

- Betrieb,
- Fehleranalyse,
- Sicherheit,
- Stabilität,
- Performance

erforderlich sind.

Nicht erforderliche personenbezogene oder gesundheitsbezogene Daten dürfen nicht erhoben werden.

---

## MON-004 – Strukturierte Diagnose

Diagnoseinformationen müssen:

- maschinenlesbar,
- eindeutig,
- filterbar,
- korrelierbar,
- zeitlich einordenbar

sein.

Freitext allein ist für automatisierte Diagnose nicht ausreichend.

---

## MON-005 – Monitoring-Ausfälle beeinflussen keine Fachoperation

Ein Ausfall des Monitorings darf grundsätzlich nicht:

- eine Profiländerung verhindern,
- einen Commit zurückrollen,
- ein Domain Event verwerfen,
- eine fachlich erfolgreiche Operation in einen Fehler umwandeln.

Ausnahmen müssen ausdrücklich sicherheits- oder compliancebezogen begründet sein.

---

## MON-005A – Offline- und lokale Betriebsart

Die Kernfunktionen der Anwendung müssen vollständig ohne externe Monitoring- oder Telemetrieplattform nutzbar sein.

Dies gilt insbesondere für:

- Profilverwaltung,
- Messwerterfassung,
- lokale Auswertung,
- Import und Export,
- Backup und Wiederherstellung,
- lokale Event-Verarbeitung.

Monitoring und Telemetrie sind technische Zusatzfunktionen.

Sie dürfen keine Voraussetzung für die fachliche Nutzung der Anwendung sein.

### Regeln

- Die Anwendung bleibt bei fehlender Internetverbindung funktionsfähig.
- Lokales Logging und lokale Diagnose dürfen unabhängig von Cloud-Diensten arbeiten.
- Nicht übertragene Monitoringdaten dürfen keine fachlichen Operationen blockieren.
- Externe Telemetrie muss deaktivierbar sein.
- Ein Ausfall externer Monitoringdienste darf keinen Retry-Sturm verursachen.
- Temporär gespeicherte Telemetriedaten müssen begrenzt und gemäß Retention-Regeln gelöscht werden.

### Architekturregel

```text
Fachfunktion
    │
    ├── funktioniert lokal
    │
    └── Monitoring optional

```

---

## MON-006 – Keine stillen kritischen Zustände

Kritische technische Zustände müssen:

- erkennbar,
- protokolliert,
- messbar,
- gegebenenfalls alarmierbar

sein.

Ein ausschließlich lokal verschluckter kritischer Fehler ist unzulässig.

---

# Diagnostics

## Zweck

Diagnostics stellt technische Informationen bereit, mit denen Fehlerursachen eingegrenzt werden können.

Diagnoseinformationen richten sich primär an:

- Entwicklung,
- Test,
- Support,
- Betrieb.

Sie sind nicht automatisch für Endbenutzer bestimmt.

---

# DiagnosticContext

## Zweck

`DiagnosticContext` bündelt die technischen Kontextinformationen eines Ablaufs.

## Mögliche Felder

| Feld | Typ | Beschreibung |
|---|---|---|
| correlationId | CorrelationId | Fachlich zusammengehöriger Ablauf |
| traceId | TraceId | Konkreter technischer Ablauf |
| operationId | OperationId? | Einzelne Operation |
| module | ModuleName | Zuständiges Modul |
| layer | ArchitectureLayer | Architekturschicht |
| startedAt | Timestamp | Startzeitpunkt |
| applicationVersion | ApplicationVersion | Anwendungsversion |
| platform | PlatformType | Zielplattform |
| environment | EnvironmentType | Laufzeitumgebung |

## Regeln

Der Diagnosekontext darf keine:

- Passwörter,
- Tokens,
- Credentials,
- Gesundheitsdaten,
- Bilddaten,
- vollständigen Benutzertexte

enthalten.

---

# DiagnosticSnapshot

## Zweck

Ein `DiagnosticSnapshot` beschreibt einen begrenzten technischen Zustand zu einem bestimmten Zeitpunkt.

## Mögliche Inhalte

- Anwendungsversion,
- Datenbankschemaversion,
- Outbox-Größe,
- Anzahl ausstehender Migrationen,
- verfügbarer Speicher,
- letzte erfolgreiche Sicherung,
- Status technischer Adapter,
- aktive Circuit Breaker,
- Anzahl ausstehender Hintergrundaufgaben.

## Regeln

Ein Snapshot:

- ist zeitlich begrenzt gültig,
- ist unveränderlich,
- enthält keine vollständigen Fachdatensätze,
- darf nicht automatisch unbegrenzt gespeichert werden.

---

# Monitoring

## Zweck

Monitoring bewertet den technischen Zustand und das Laufzeitverhalten des Systems.

Es basiert insbesondere auf:

- Logs,
- Metriken,
- Health Checks,
- Events,
- technischen Statusinformationen.

---

# Monitoring-Bereiche

Mindestens folgende Bereiche können überwacht werden:

```text
Application

Persistence

Import

Export

Backup

Synchronization

Security

Events

Outbox

Images

Performance

Resources
```

---

# Metriken

## Zweck

Metriken sind numerische Messwerte zur Bewertung des technischen Systemverhaltens.

---

# Metriktypen

## Counter

Ein monoton steigender Zähler.

Beispiele:

```text
profile.create.success.count

profile.create.failure.count

event.publish.count

retry.count
```

---

## Gauge

Ein aktueller Zustandswert.

Beispiele:

```text
outbox.pending.count

database.size.bytes

backup.age.hours

circuitBreaker.open.count
```

---

## Histogram

Verteilung gemessener Werte.

Beispiele:

```text
repository.load.duration

image.transformation.duration

import.duration

event.publish.duration
```

---

## Rate

Ereignisse pro Zeiteinheit.

Beispiele:

```text
exception.rate

retry.rate

event.failure.rate
```

---

# Metrikstruktur

Jede Metrik besitzt mindestens:

| Feld | Typ |
|---|---|
| name | MetricName |
| type | MetricType |
| value | NumericValue |
| timestamp | Timestamp |
| module | ModuleName |

Optional:

| Feld | Typ |
|---|---|
| operation | OperationName? |
| result | MetricResult? |
| tags | Map<String, String> |
| correlationId | CorrelationId? |

---

# Metrikregeln

## MON-MET-001 – Stabile Namen

Veröffentlichte Metriknamen sind stabil.

Eine geänderte Bedeutung erfordert einen neuen Namen.

---

## MON-MET-002 – Begrenzte Kardinalität

Metrik-Tags dürfen keine unkontrolliert hohe Kardinalität erzeugen.

Nicht als Tags zulässig:

- frei erzeugte UUIDs,
- vollständige ProfileIds,
- Namen,
- Dateipfade,
- Fehlertexte,
- CorrelationIds in aggregierten Zeitreihen.

CorrelationIds dürfen in Logs verwendet werden, aber nicht als reguläre hochkardinale Metrikdimension.

---

## MON-MET-003 – Keine sensiblen Werte

Metriknamen, Werte und Tags enthalten keine:

- personenbezogenen Daten,
- Gesundheitsdaten,
- Passwörter,
- Tokens,
- Bildinformationen.

---

## MON-MET-004 – Erfolgs- und Fehlerpfade

Für relevante technische Operationen sollen mindestens messbar sein:

- Anzahl der Aufrufe,
- Anzahl erfolgreicher Aufrufe,
- Anzahl fehlgeschlagener Aufrufe,
- Dauer,
- Retry-Anzahl.

---

# Empfohlene Kernmetriken

## Persistenz

```text
repository.profile.load.success.count

repository.profile.load.failure.count

repository.profile.save.duration

transaction.rollback.count

database.migration.failure.count
```

---

## Events und Outbox

```text
outbox.pending.count

outbox.oldest.age.seconds

event.publish.success.count

event.publish.failure.count

event.retry.count
```

---

## Import und Export

```text
profile.import.success.count

profile.import.failure.count

profile.import.duration

profile.export.success.count

profile.export.failure.count
```

---

## Backup

```text
backup.success.count

backup.failure.count

backup.lastSuccess.age.hours

restore.failure.count
```

---

## Sicherheit

```text
authentication.failure.count

authentication.cancelled.count

authentication.proof.expired.count

security.circuitBreaker.open.count
```

Sicherheitsmetriken dürfen keine Identität des betroffenen Profils offenlegen.

---

# Health Checks

## Zweck

Health Checks prüfen, ob technische Komponenten ihre vorgesehene Aufgabe grundsätzlich erfüllen können.

---

# HealthStatus

## Werte

```text
HEALTHY

DEGRADED

UNHEALTHY

UNKNOWN
```

| Status | Bedeutung |
|---|---|
| HEALTHY | Komponente arbeitet erwartungsgemäß |
| DEGRADED | Funktion eingeschränkt, Kernbetrieb möglich |
| UNHEALTHY | Wesentliche Funktion nicht verfügbar |
| UNKNOWN | Zustand konnte nicht zuverlässig ermittelt werden |

---

# HealthCheckResult

## Struktur

| Feld | Typ |
|---|---|
| component | ComponentName |
| status | HealthStatus |
| checkedAt | Timestamp |
| duration | Duration |
| code | HealthCode |

Optional:

| Feld | Typ |
|---|---|
| details | Map<String, Object> |
| nextCheckRecommendedAt | Timestamp? |

---

# Health-Check-Regeln

## MON-HC-001 – Keine Fachoperationen

Ein Health Check darf keine reguläre fachliche Operation ausführen.

Nicht zulässig:

```text
Testprofil erzeugen
```

Zulässig:

```text
Datenbankverbindung prüfen
```

---

## MON-HC-002 – Keine destruktiven Prüfungen

Health Checks dürfen keine:

- Daten löschen,
- bestehende Datensätze verändern,
- Benutzerzustände zurücksetzen,
- Events veröffentlichen

sofern dies nicht in einer isolierten technischen Testumgebung geschieht.

---

## MON-HC-003 – Begrenzte Laufzeit

Jeder Health Check besitzt ein definiertes Timeout.

Ein dauerhaft blockierender Check ist unzulässig.

---

## MON-HC-004 – Degraded statt pauschal Unhealthy

Der Zustand `DEGRADED` wird verwendet, wenn:

- optionale Funktionen ausfallen,
- ein Fallback verfügbar ist,
- Kernfunktionen weiterhin arbeiten.

Beispiel:

```text
Cloud-Synchronisation nicht verfügbar,
lokale Profilverwaltung funktioniert.
```

---

# Mögliche Health Checks

## Persistenz

- Datenbank erreichbar,
- Schema kompatibel,
- erforderliche Tabellen oder Collections vorhanden,
- Schreibzugriff grundsätzlich möglich.

---

## Bildspeicher

- Speicherort verfügbar,
- Leserechte vorhanden,
- Schreibrechte vorhanden,
- ausreichender Speicherplatz.

---

## Outbox

- Outbox lesbar,
- neue Einträge speicherbar,
- Dispatcher funktionsfähig,
- keine überalterten blockierten Einträge.

---

## Backup

- Ziel verfügbar,
- Konfiguration gültig,
- letzte Sicherung nicht überaltert.

---

## Synchronisation

- Netzwerk erreichbar,
- Dienst verfügbar,
- Authentifizierung gültig.

---

# Performance Monitoring

## Zweck

Performance Monitoring erkennt:

- langsame Operationen,
- Ressourcenengpässe,
- Verschlechterungen,
- Blockierungen,
- ungewöhnliche Laufzeiten.

---

# Performance-Messpunkte

Mindestens sinnvoll sind:

- Application-Service-Laufzeit,
- Repository-Lesezeit,
- Repository-Schreibzeit,
- Commit-Dauer,
- Importdauer,
- Exportdauer,
- Bildvalidierung,
- Bildtransformation,
- Event-Publishing,
- Startprofilermittlung.

---

# Performance Budget

Für relevante Operationen dürfen Zielwerte definiert werden.

Beispiel:

| Operation | Ziel |
|---|---|
| Profil lokal laden | unter 200 ms |
| Profil wechseln | unter 300 ms |
| Standardvalidierung | unter 50 ms |
| UI-Rückmeldung nach Eingabe | ohne wahrnehmbare Verzögerung |

Konkrete Grenzwerte müssen später durch Tests und reale Messungen bestätigt werden.

---

# Slow Operation

Eine Operation gilt als langsam, wenn sie einen definierten Schwellenwert überschreitet.

Ein Slow-Operation-Log enthält:

- Operation,
- Dauer,
- Modul,
- CorrelationId,
- Schwellenwert,
- keine sensiblen Nutzdaten.

---

# Event Monitoring

## Zweck

Event Monitoring überwacht den vollständigen technischen Lebenszyklus eines Domain Events.

---

# Zu überwachende Zustände

```text
created

storedInOutbox

committed

dispatched

handled

failed

scheduledForRetry

deadLettered
```

---

# Event-Monitoring-Regeln

## MON-EVT-001 – Nachverfolgbarkeit

Ein Event muss über mindestens folgende Werte korrelierbar sein:

- DomainEventId,
- AggregateId,
- AggregateVersion,
- CorrelationId.

---

## MON-EVT-002 – Keine Event-Payloads in Metriken

Event-Payloads dürfen nicht als Metrik-Tags oder Log-Metadaten dupliziert werden.

---

## MON-EVT-003 – Überalterte Outbox-Einträge

Ein Outbox-Eintrag, der einen definierten Altersgrenzwert überschreitet, muss als auffällig gelten.

---

## MON-EVT-004 – Dead Letter

Nach Ausschöpfung der Retry-Policy kann ein Event in einen kontrollierten Fehlerzustand überführt werden.

Beispiel:

```text
deadLettered
```

Dieser Zustand erfordert:

- Logging,
- Monitoring,
- Diagnosemöglichkeit,
- manuelle oder definierte automatische Behandlung.

---

# Exception Monitoring

## Zweck

Exception Monitoring erkennt Muster unerwarteter technischer Fehler.

---

# Zu erfassende Merkmale

- abstrahierter Exceptiontyp,
- Cause Code,
- Modul,
- Schicht,
- Anwendungsversion,
- Plattform,
- Häufigkeit,
- erstmaliges und letztes Auftreten,
- CorrelationId im Einzelereignis.

---

# Gruppierung

Exceptions sollen nach stabilen technischen Merkmalen gruppiert werden.

Nicht geeignet:

- vollständige Exceptiontexte,
- Dateipfade,
- wechselnde UUIDs,
- Benutzereingaben.

Geeignet:

```text
exceptionType

causeCode

module

operation
```

---

# Alerting

## Zweck

Alerting informiert über technische Zustände, die zeitnahe Aufmerksamkeit erfordern.

---

# AlertSeverity

```text
INFO

WARNING

HIGH

CRITICAL
```

---

# Mögliche Alerts

## WARNING

- Outbox wächst ungewöhnlich,
- Backup überfällig,
- erhöhte Retry-Rate,
- Circuit Breaker geöffnet.

## HIGH

- wiederholte Datenbankfehler,
- mehrere fehlgeschlagene Sicherungen,
- Event-Verarbeitung dauerhaft blockiert,
- Speicherkapazität kritisch.

## CRITICAL

- Datenbank beschädigt,
- nicht behebbarer Konsistenzfehler,
- sicherheitskritischer Vorfall,
- grundlegende Anwendungskomponente nicht funktionsfähig.

---

# Alert-Regeln

## MON-ALT-001 – Kein Alert für Einzelereignisse ohne Relevanz

Ein einzelner vorübergehender Fehler sollte nicht automatisch einen kritischen Alarm auslösen.

---

## MON-ALT-002 – Schwellenwerte

Alerts basieren auf:

- Häufigkeit,
- Dauer,
- Rate,
- Zustand,
- Kombination mehrerer Signale.

---

## MON-ALT-003 – Deduplizierung

Gleichartige aktive Alerts sollen zusammengefasst werden.

---

## MON-ALT-004 – Eskalation

Dauerhafte oder zunehmende Probleme dürfen eine höhere Alarmstufe erhalten.

---

## MON-ALT-005 – Keine sensiblen Inhalte

Alerts enthalten keine:

- Gesundheitsdaten,
- Passwörter,
- Tokens,
- Profilnamen,
- vollständigen Datensätze.

---

# Security Monitoring

## Zweck

Security Monitoring erkennt auffällige sicherheitsrelevante technische Muster.

---

# Beispiele

- ungewöhnlich viele fehlgeschlagene Authentifizierungen,
- wiederholt abgelaufene Proofs,
- nicht unterstützte Credential-Algorithmen,
- Manipulationshinweise,
- unerwartete Zugriffsversuche,
- Integritätsfehler.

---

# Regeln

Security Monitoring:

- trifft keine abschließende fachliche Schuldzuweisung,
- speichert keine geheimen Authentifizierungsdaten,
- verwendet möglichst aggregierte oder pseudonymisierte Informationen,
- beachtet Fehlalarme und Datenschutz.

---

# Log-Retention

## Zweck

Log-Retention definiert, wie lange Logdaten gespeichert werden.

---

# Grundregeln

## RET-001 – Zweckgebundene Aufbewahrung

Logs werden nur so lange gespeichert, wie sie für:

- Diagnose,
- Betrieb,
- Sicherheit,
- rechtliche Anforderungen

erforderlich sind.

---

## RET-002 – Unterschiedliche Klassen

Für verschiedene Logarten dürfen unterschiedliche Fristen gelten:

| Logart | Typische Behandlung |
|---|---|
| TRACE | sehr kurz oder deaktiviert |
| DEBUG | kurz |
| INFO | begrenzt |
| ERROR | länger |
| Security Log | gemäß Sicherheitskonzept |
| Audit Log | gemäß Audit- und Datenschutzkonzept |

Konkrete Fristen werden im Datenschutz- und Betriebskonzept festgelegt.

---

## RET-003 – Automatische Löschung

Abgelaufene Logs werden automatisiert gelöscht oder anonymisiert.

---

## RET-004 – Keine unbegrenzte Speicherung

Eine unbegrenzte Aufbewahrung ohne dokumentierten Zweck ist unzulässig.

---

# Log-Rotation

## Zweck

Log-Rotation verhindert:

- unbegrenztes Dateiwachstum,
- Speichermangel,
- Performanceprobleme.

---

# Rotationskriterien

Mögliche Kriterien:

- Dateigröße,
- Zeitraum,
- Anzahl Einträge,
- Anwendungssitzung.

---

# Regeln

- Rotation muss atomar oder sicher wiederholbar sein.
- Aktive Logdateien dürfen nicht beschädigt werden.
- Alte Dateien müssen gemäß Retention entfernt werden.
- Speichergrenzen müssen konfigurierbar sein.

---

# Log-Export

## Zweck

Ein Log-Export kann Support und Diagnose unterstützen.

---

# Exportregeln

Ein Diagnoseexport:

- erfolgt nur bewusst,
- zeigt den Umfang vorab an,
- enthält keine geheimen Daten,
- berücksichtigt Retention,
- ist versioniert,
- besitzt ein dokumentiertes Format.

---

# Redaction

Vor einem Export werden sensible Inhalte entfernt oder maskiert.

Beispiele:

```text
ProfileId → pseudonymisierte Kennung

Dateipfad → gekürzte oder entfernte Darstellung

Token → vollständig entfernt
```

---

# Externe Telemetrie und Einwilligung

## Zweck

Dieser Abschnitt regelt die Übertragung von Diagnose-, Monitoring- oder Telemetriedaten an externe Systeme.

Eine externe Übertragung ist von lokaler Protokollierung und lokaler Diagnose zu unterscheiden.

---

## TEL-001 – Rechtsgrundlage oder Einwilligung

Telemetriedaten dürfen nur übertragen werden, wenn eine dokumentierte Rechtsgrundlage oder eine wirksame Einwilligung vorliegt.

Ohne eine solche Grundlage erfolgt keine externe Übertragung.

---

## TEL-002 – Lokale Voreinstellung

Diagnose- und Monitoringdaten werden standardmäßig lokal verarbeitet und gespeichert.

Externe Telemetrie ist standardmäßig deaktiviert, sofern keine andere rechtlich geprüfte Vorgabe besteht.

---

## TEL-003 – Transparenz

Vor Aktivierung externer Telemetrie muss verständlich dargestellt werden:

- welche Daten übertragen werden,
- zu welchem Zweck die Übertragung erfolgt,
- an welchen Empfänger übertragen wird,
- wie lange die Daten gespeichert werden,
- wie die Einwilligung widerrufen werden kann.

---

## TEL-004 – Datenminimierung

Es dürfen ausschließlich Daten übertragen werden, die für den dokumentierten Zweck erforderlich sind.

Nicht zulässig sind insbesondere:

- Gesundheitsdaten,
- Passwörter,
- Passwort-Hashes,
- Credentials,
- AuthenticationProofs,
- Bilddaten,
- vollständige Profile,
- Profilnamen,
- frei lesbare personenbezogene Inhalte.

---

## TEL-005 – Pseudonymisierung

Soweit eine technische Zuordnung erforderlich ist, müssen Kennungen pseudonymisiert oder kurzlebig sein.

Dauerhafte ProfileIds dürfen nicht ohne ausdrückliche Notwendigkeit übertragen werden.

---

## TEL-006 – Widerruf

Eine erteilte Einwilligung muss jederzeit widerrufbar sein.

Nach einem Widerruf gilt:

- Es werden keine neuen Telemetriedaten übertragen.
- Noch nicht übertragene lokale Telemetriedaten werden gelöscht oder gesperrt.
- Bereits übertragene Daten werden entsprechend der geltenden Datenschutzregelung behandelt.
- Die fachlichen Kernfunktionen bleiben vollständig verfügbar.

---

## TEL-007 – Umfangsanzeige

Bei einem manuellen Diagnoseexport oder Support Bundle muss der Benutzer vorab erkennen können:

- welche Daten enthalten sind,
- welche Zeiträume betroffen sind,
- ob pseudonymisierte Kennungen enthalten sind,
- ob eine externe Übertragung erfolgt.

---

## TEL-008 – Keine Zweckänderung

Telemetriedaten dürfen nicht ohne neue Bewertung und gegebenenfalls neue Einwilligung für einen anderen Zweck verwendet werden.

---

## TEL-009 – Sichere Übertragung

Eine zulässige externe Übertragung muss:

- verschlüsselt erfolgen,
- authentifizierte Empfänger verwenden,
- Integritätsschutz besitzen,
- Fehler und Abbrüche kontrolliert behandeln.

---

## TEL-010 – Keine Beeinträchtigung bei Ablehnung

Die Ablehnung oder Deaktivierung externer Telemetrie darf:

- keine Kernfunktion sperren,
- keine fachliche Benachteiligung erzeugen,
- keine wiederholten Aufforderungen ohne sachlichen Anlass verursachen.

---

## Testbarkeit

Zu testen sind:

- Telemetrie standardmäßig deaktiviert,
- Aktivierung nach Einwilligung,
- Widerruf,
- Offline-Betrieb,
- keine Gesundheitsdaten im Payload,
- keine Übertragung bei fehlender Rechtsgrundlage,
- transparente Umfangsanzeige,
- fachliche Kernfunktionen ohne Telemetrie.

---

# Support Bundle

## Zweck

Ein Support Bundle kann mehrere technische Diagnoseinformationen bündeln.

Mögliche Inhalte:

- ausgewählte Logs,
- Anwendungsversion,
- Plattform,
- Konfigurationsversion,
- Datenbankschemaversion,
- Health-Check-Ergebnisse,
- aktive Circuit-Breaker-Zustände,
- Outbox-Statistik.

Nicht enthalten:

- Gesundheitsdaten,
- Passwörter,
- Credentials,
- Bilddaten,
- vollständige Profile,
- ungeschützte personenbezogene Daten.

---

# Diagnosewerkzeuge

Zulässige Diagnosewerkzeuge können sein:

- Log Viewer,
- Health-Status-Ansicht,
- Support-Bundle-Erzeugung,
- Outbox-Diagnose,
- Datenbank-Integritätsprüfung,
- Metrikübersicht.

Diese Werkzeuge dürfen keine Fachregeln umgehen.

---

# Architekturregeln

## Domain Layer

Die Domäne kennt keine:

- Monitoringbibliothek,
- Metrikbibliothek,
- Health-Check-Implementierung,
- Alerting-Plattform.

---

## Application Layer

Der Application Layer darf:

- Operationen messen,
- Correlation- und Trace-Kontext weitergeben,
- technische Monitoring-Ergebnisse koordinieren.

Er darf keine Business Rules aus Monitoringdaten ableiten.

---

## Infrastructure Layer

Der Infrastructure Layer implementiert:

- Logger,
- Metriksammler,
- Health Checks,
- Diagnoseexport,
- Monitoringadapter.

---

## UI

Die UI darf technische Zustände benutzerfreundlich darstellen.

Sie darf:

- keine Stacktraces anzeigen,
- keine internen Exceptiontexte anzeigen,
- keine sensiblen Diagnoseinformationen offenlegen.

---

# Fehlerverhalten des Monitorings

## Monitoring nicht verfügbar

Kann ein Monitoringadapter keine Daten übertragen:

- wird die Fachoperation grundsätzlich fortgesetzt,
- der Fehler kann lokal protokolliert werden,
- es darf keine rekursive Logging-Schleife entstehen.

---

## Rekursive Fehler vermeiden

Nicht zulässig:

```text
Logging schlägt fehl
        │
        ▼
Logging des Loggingfehlers
        │
        ▼
erneuter Loggingfehler
```

Für interne Monitoringfehler muss ein begrenzter Fallback existieren.

---

# Anti-Patterns

## Fachliche Daten als Metrik-Tags

Nicht zulässig:

```text
profileName = "Götz"
```

als Metrik-Tag.

---

## Unbegrenzte Kardinalität

Nicht zulässig:

```text
correlationId
```

als reguläre aggregierte Zeitreihendimension.

---

## Health Check mit Schreiboperation

Nicht zulässig:

```text
Profil erzeugen und wieder löschen
```

im produktiven Health Check.

---

## Alert bei jedem Fehler

Nicht zulässig:

```text
ein Timeout
        │
        ▼
CRITICAL Alert
```

ohne fachlich-technische Bewertung.

---

## Unbegrenzte Log-Aufbewahrung

Nicht zulässig ohne dokumentierte rechtliche oder betriebliche Begründung.

---

## Diagnoseexport ohne Redaction

Nicht zulässig.

---

# Testbarkeit

## Monitoringtests

Zu testen sind:

- Counter-Erhöhung,
- Gauge-Aktualisierung,
- Histogramm-Erfassung,
- stabile Metriknamen,
- begrenzte Tag-Kardinalität.

---

## Health-Check-Tests

Zu testen sind:

- `HEALTHY`,
- `DEGRADED`,
- `UNHEALTHY`,
- Timeout,
- Exception im Check,
- keine Fachzustandsänderung.

---

## Alerting-Tests

Zu testen sind:

- Schwellenwerterreichung,
- Deduplizierung,
- Eskalation,
- Rückkehr in Normalzustand,
- keine sensiblen Inhalte.

---

## Retention-Tests

Zu testen sind:

- fristgerechte Löschung,
- Rotation,
- Speichergrenze,
- Erhalt erforderlicher Auditdaten,
- kein Zugriff auf gelöschte Logdaten.

---

## Exporttests

Zu testen sind:

- Redaction,
- Umfang,
- Versionierung,
- fehlende sensible Daten,
- beschädigungsfreier Export.

---

# Qualitätskriterien

Teil 4B gilt als konform, wenn:

- technische Zustände messbar sind,
- relevante Fehler erkannt werden,
- Alerts nicht unnötig ausgelöst werden,
- Metriken keine sensiblen Daten enthalten,
- Health Checks keine Fachzustände verändern,
- Log-Retention definiert ist,
- Diagnoseexporte redigiert werden,
- Monitoringausfälle keine Fachoperationen verändern,
- alle Komponenten isoliert testbar sind.

---

# Traceability

## Error Handling

- `ERR-EX-001` bis `ERR-EX-009`
- `ERR-REC-001` bis `ERR-REC-005`
- `ERR-RET-001` bis `ERR-RET-006`
- `ERR-TX-001` bis `ERR-TX-003`
- `LOG-001` bis `LOG-008`

## Domain Model

- `DomainEvent`
- `DomainEventId`
- `CorrelationId`
- `UnitOfWork`
- `DomainEventPublisher`
- Transactional Outbox
- Domain Ports

## Projektanforderungen

- PRO-FR-024
- PRO-FR-025
- PRO-FR-026
- PRO-FR-027

---

# Status dieses Abschnitts

Mit Teil **4B** sind definiert:

- Diagnostics,
- `DiagnosticContext`,
- `DiagnosticSnapshot`,
- Monitoringbereiche,
- Metriktypen und Metrikregeln,
- empfohlene Kernmetriken,
- Health Checks,
- Performance Monitoring,
- Event Monitoring,
- Exception Monitoring,
- Alerting,
- Security Monitoring,
- Log-Retention,
- Log-Rotation,
- Log-Export,
- Support Bundles,
- Diagnosewerkzeuge,
- Fehlerverhalten des Monitorings,
- Anti-Patterns,
- Testbarkeit,
- Qualitätskriterien,
- Traceability.

Damit ist **Kapitel 4 – Logging, Diagnostics und Monitoring** vollständig abgeschlossen.

---

# Teil 5

Der nächste Abschnitt beschreibt:

- projektweiten Fehlerkatalog,
- Code-Namenskonventionen,
- Validierungscodes,
- Business-Codes,
- Security-Codes,
- Persistence-Codes,
- Import- und Export-Codes,
- Event-Codes,
- Infrastruktur-Codes,
- Reservierung und Deprecation von Codes,
- Traceability.

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5A – Fehlerkatalog: Grundlagen und Code-System

# Zweck

Dieses Kapitel definiert den projektweiten Aufbau aller Fehler-, Warnungs- und Informationscodes.

Der Fehlerkatalog stellt sicher, dass:

- Fehler eindeutig identifizierbar sind,
- Codes über Projektversionen stabil bleiben,
- Meldungen maschinenlesbar sind,
- Traceability möglich ist,
- Internationalisierung unabhängig vom Code erfolgt,
- Tests stabile Referenzen besitzen.

Der Fehlerkatalog gilt für das gesamte HealthTracker-Projekt.

---

# Geltungsbereich

Der Fehlerkatalog umfasst insbesondere:

- Validation Errors
- Business Errors
- Security Errors
- Persistence Errors
- Infrastructure Errors
- Import Errors
- Export Errors
- Backup Errors
- Synchronisation Errors
- Event Errors
- Logging Errors
- Monitoring Errors

Warnungen und Informationen folgen denselben Regeln.

---

# Grundprinzipien

## CAT-001 – Jeder fachliche Sachverhalt besitzt genau einen Code

Ein Fehlercode beschreibt genau einen fachlichen oder technischen Sachverhalt.

Nicht zulässig:

Ein Code mit mehreren Bedeutungen.

---

## CAT-002 – Codes sind sprachneutral

Codes enthalten niemals:

- deutsche Texte,
- englische Sätze,
- lokalisierte Begriffe.

Beispiel

Zulässig

```text
profile.notFound
```

Nicht zulässig

```text
Profil nicht gefunden
```

---

## CAT-003 – Codes sind unveränderlich

Nach Veröffentlichung darf die Bedeutung eines Codes nicht geändert werden.

Neue Bedeutung

↓

neuer Code.

---

## CAT-004 – Codes werden niemals wiederverwendet

Ein entfernter Code bleibt dauerhaft reserviert.

---

## CAT-005 – Message Keys sind unabhängig

Ein ErrorCode

und

ein MessageKey

sind unterschiedliche Konzepte.

Der MessageKey darf geändert werden,

der ErrorCode nicht.

---

## CAT-006 – UI verwendet keine Fehlertexte aus der Domain

Die Domain liefert ausschließlich:

- ErrorCode
- MessageKey
- Parameter
- Kategorie
- Severity

Die Übersetzung erfolgt außerhalb der Domain.

---

# Projektweite Fehlerklassifikation

Der Error Handling Guide unterscheidet sechs Fehlerklassen.

| Fehlerklasse | Präfix | Zweck |
|--------------|---------|-------|
| Validation | `validation.` | Validierung einzelner Domänenobjekte und Aggregate |
| Business | `business.` | Verletzung fachlicher Geschäftsregeln |
| Security | `security.` | Sicherheits- und Authentifizierungsfehler |
| Infrastructure | `infrastructure.` | Technische Infrastrukturfehler |
| Persistence | `persistence.` | Speicherung und Transaktionen |
| Integration | `integration.` | Kommunikation mit externen Systemen |

Diese Präfixe gelten projektweit für sämtliche Module.

---

# Architekturhierarchie

Die Fehlerbehandlung orientiert sich an der Architektur des Systems.

```text
Value Object
        ↓
Entity
        ↓
Aggregate
        ↓
Business Rules
        ↓
Domain Events
        ↓
Application Layer
        ↓
Infrastructure
```


```markdown
# Single Source of Truth

Das Dokument

`05_DOMAIN_MODEL.md`

definiert sämtliche fachlichen Domänentypen.

Hierzu gehören insbesondere

- Aggregate
- Aggregate Roots
- Entities
- Value Objects
- Domain Services
- Domain Events

Der Error Handling Guide definiert keine eigenen Domänentypen.

Alle fachlichen Begriffe werden ausschließlich aus dem Domain Model übernommen.

---

# Begriffe

| Begriff | Bedeutung |
|---------|-----------|
| ErrorCode | Stabiler fachlicher oder technischer Code |
| MessageKey | Schlüssel für lokalisierte Texte |
| Category | Fehlerkategorie |
| Severity | Schweregrad |
| Registry | zentrale Codeverwaltung |
| Deprecation | geordnete Außerbetriebnahme |

---

# Architektur

```text
Domain

↓

ErrorCode

↓

DomainMessage

↓

Application

↓

Localization

↓

UI
```

---

# Fehlerverarbeitungsreihenfolge

Die Fehlerverarbeitung erfolgt projektweit in einer festen Reihenfolge.

```text
Validation
        ↓
Aggregate Validation
        ↓
Business Rules
        ↓
Domain Events
        ↓
Application Layer
        ↓
Technical Processing
```

---

# Aufbau eines ErrorCodes

Ein Code besteht aus

```text
Bereich

↓

Modul

↓

Sachverhalt
```

Beispiel

```text
profile.notFound
```

oder

```text
validation.height.minimum
```

---

# Namenskonventionen

## Regeln

Codes

- beginnen klein geschrieben,
- verwenden Camel Case nur innerhalb eines Segments,
- verwenden Punktnotation,
- enthalten keine Leerzeichen,
- enthalten keine Sonderzeichen außer Punkt.

---

## Zulässig

```text
profile.notFound

profile.archived

validation.height.minimum

security.authentication.failed

repository.profile.saveFailed

event.publish.failed
```

---

## Nicht zulässig

```text
ProfileNotFound

PROFILE_NOT_FOUND

ProfilNichtGefunden

profile-not-found
```

---

# Segmentregeln

Empfohlene Struktur

```text
category

↓

module

↓

reason
```

Optional

```text
category.module.reason.detail
```

---

# Kategorien

## Validation

```text
validation
```

---

## Business

```text
business
```

---

## Security

```text
security
```

---

## Repository

```text
repository
```

---

## Infrastructure

```text
infrastructure
```

---

## Import

```text
import
```

---

## Export

```text
export
```

---

## Backup

```text
backup
```

---

## Event

```text
event
```

---

## Monitoring

```text
monitoring
```

---

## Logging

```text
logging
```

---

# Beispiele

```text
validation.birthYear.range

validation.height.minimum

business.profile.archived

security.authentication.failed

PRO-PER-LOAD-001

event.dispatch.failed

backup.file.corrupted
```

---

# ErrorCode und MessageKey

## ErrorCode

Eigenschaften

- stabil
- eindeutig
- fachlich
- testbar

---

## MessageKey

Eigenschaften

- lokalisierbar
- UI-orientiert
- änderbar

---

## Beispiel

ErrorCode

```text
validation.height.minimum
```

MessageKey

```text
validation.profile.height.minimum
```

---

# ErrorCode Registry

## Zweck

Alle veröffentlichten Codes werden zentral verwaltet.

---

## Registry enthält

- Code
- Kategorie
- Beschreibung
- Status
- Version
- Nachfolger
- Dokumentreferenz

---

# CAT-011 – Code Ownership

## Zweck

Jeder veröffentlichte ErrorCode besitzt einen eindeutig definierten fachlichen Verantwortlichen.

Dadurch bleiben

- Bedeutung,
- Konsistenz,
- Versionierung,
- Weiterentwicklung

kontrollierbar.

---

## Verantwortlichkeiten

Für jeden veröffentlichten Code werden dokumentiert:

- fachlicher Owner,
- verantwortliches Modul,
- Erstversion,
- aktueller Status,
- letzter Reviewer,
- Dokumentreferenz.

---

## Rechte des Owners

Der fachliche Owner darf

- neue ErrorCodes beantragen,
- einen Code als *Deprecated* kennzeichnen,
- einen Nachfolger definieren,
- Dokumentation ergänzen,
- Traceability aktualisieren.

---

## Einschränkungen

Auch der Owner darf nicht

- die Bedeutung eines bestehenden Codes ändern,
- einen entfernten Code erneut verwenden,
- einen bestehenden Code einem anderen fachlichen Sachverhalt zuordnen.

Für jede fachliche Änderung ist ein neuer ErrorCode anzulegen.

---

## Registry

Die ErrorCode Registry dokumentiert mindestens:

| Feld | Beschreibung |
|------|--------------|
| ErrorCode | eindeutiger Code |
| Category | Fehlerkategorie |
| Severity | Schweregrad |
| Status | Draft / Active / Deprecated / Removed |
| Owner | fachlich Verantwortlicher |
| Seit Version | Erstveröffentlichung |
| Nachfolger | optional |
| Dokumentreferenz | Architektur- oder Fachdokument |

---

## Architekturregel

Ein veröffentlichter ErrorCode besitzt jederzeit genau einen fachlichen Owner.

Ownership beschreibt ausschließlich die fachliche Verantwortung und ersetzt keine Repository-Berechtigungen.

---

# Status

Ein Code besitzt genau einen Status.

---

## Draft

Noch nicht veröffentlicht.

---

## Active

Produktiv verwendbar.

---

## Deprecated

Soll nicht mehr neu verwendet werden.

Bleibt kompatibel.

---

## Removed

Nicht mehr aktiv.

Bleibt dauerhaft reserviert.

---

# Versionierung

## Regeln

Ein neuer Code

erfordert

keine

neue Hauptversion.

---

Änderung der Bedeutung

↓

nicht zulässig.

---

# Deprecation

## CAT-007

Deprecated Codes

dürfen

weiter gelesen,

aber

nicht mehr neu erzeugt werden.

---

## CAT-008

Ein Deprecated Code

muss

einen

Nachfolger besitzen,

wenn ein fachlicher Ersatz existiert.

---

# Reservierung

## CAT-009

Entfernte Codes

bleiben dauerhaft reserviert.

---

## CAT-010

Reservierte Codes

dürfen niemals

neu vergeben werden.

---

# Erweiterung

Neue Module

dürfen

eigene Codes definieren,

wenn

- Namenskonventionen eingehalten werden,
- Registry aktualisiert wird,
- Traceability ergänzt wird.

---

# Breaking Changes

Nicht zulässig

- Bedeutung ändern
- Kategorie ändern
- Severity ändern
- vorhandenen Code wiederverwenden

---

Zulässig

- neuer Code
- neuer MessageKey
- neue Übersetzung

---

# ErrorCode und Tests

Alle Tests

verwenden

ErrorCodes.

Nicht

lokalisierte Texte.

---

# Traceability

Jeder Code

verweist mindestens auf

- Requirement
- Business Rule
- Validation Rule
- Domain Model
- Testfall

---

# CAT-012 – Traceability-Pflicht

## Zweck

Jeder veröffentlichte ErrorCode muss vollständig auf seine fachliche Herkunft zurückgeführt werden können.

Dadurch werden

- Auswirkungen von Änderungen,
- Testabdeckung,
- Wartbarkeit,
- Architekturkonformität

nachvollziehbar.

---

## Pflichtreferenzen

Jeder ErrorCode verweist mindestens auf:

- fachliche Anforderung (Requirement),
- Business Rule oder Validation Rule,
- Domain Model,
- Testfall.

Optional können zusätzlich referenziert werden:

- ADR (Architecture Decision Record),
- User Story,
- Use Case,
- Risikobewertung.

---

## Regeln

Traceability muss bidirektional möglich sein.

Es muss nachvollziehbar sein,

- warum ein ErrorCode existiert,
- wo er verwendet wird,
- welche Anforderungen betroffen sind,
- welche Tests ihn absichern.

---

## Architekturregel

Ein veröffentlichter ErrorCode ohne dokumentierte Traceability gilt als unvollständig und darf nicht in den Status **Active** überführt werden.

---

# Dokumentation

Für jeden veröffentlichten Code

werden dokumentiert

- Bedeutung
- Ursache
- Kategorie
- Severity
- Parameter
- empfohlene Benutzerreaktion
- Traceability

---

# Governance

## Verantwortlichkeiten

| Rolle | Verantwortung |
|--------|----------------|
| Domain Architect | Code-Struktur |
| Entwickler | neue Codes |
| Reviewer | Konsistenz |
| Tester | Testabdeckung |

---

# Qualitätsregeln

Ein Fehlercode ist konform, wenn

- eindeutig,
- sprachneutral,
- stabil,
- dokumentiert,
- testbar,
- rückwärtskompatibel

ist.

---

# Anti-Patterns

Nicht zulässig

```text
error1
```

---

Nicht zulässig

```text
invalid
```

---

Nicht zulässig

```text
Profil konnte nicht gespeichert werden
```

---

Nicht zulässig

denselben Code

für

mehrere

Business Rules

zu verwenden.

---

# Traceability

## Requirements

- PRO-FR-024
- PRO-FR-025
- PRO-FR-026
- PRO-FR-027

---

## Domain Model

- DomainError
- DomainWarning
- DomainInformation
- ErrorCode
- DomainResult

---

## Error Handling

- Teil 1
- Teil 2
- Teil 3
- Teil 4

---


```markdown
## Kapitelübersicht

| Kapitel | Inhalt |
|----------|--------|
| 5B-1 | Validation Errors |
| 5B-1b-2 | Aggregate Validation |
| 5B-2 | Business Rule Errors |
| 5B-3 | Domain Information Codes |
| 5C | Security, Infrastructure, Persistence und Integration Errors |
| 5D | Governance und Lebenszyklus des Fehlerkatalogs |

---

# Führende Referenzdokumente

| Thema | Führendes Dokument |
|--------|--------------------|
| Domain Model | `05_DOMAIN_MODEL.md` |
| Business Rules | `03_BUSINESS_RULES.md` |
| Error Handling | `06_ERROR_HANDLING_GUIDE.md` |
| Application Architecture | `07_APPLICATION_ARCHITECTURE.md` |
| API | `08_API_GUIDE.md` |
| Tests | `09_TEST_GUIDE.md` |

Jedes Dokument besitzt einen klar definierten Verantwortungsbereich.

Querverweise erfolgen ausschließlich auf das jeweils führende Dokument.

---

# Status dieses Abschnitts

Mit Teil **5A** sind definiert:

- Zweck des Fehlerkatalogs
- Aufbau der ErrorCodes
- Namenskonventionen
- Kategorien
- Registry
- Versionierung
- Deprecation
- Reservierung
- Governance
- Qualitätsregeln
- Anti-Patterns
- Traceability

---

# Teil 5B

Der nächste Abschnitt definiert die vollständigen projektweiten:

- Validation Error Codes
- Business Error Codes
- Confirmation Codes
- Duplicate Codes
- Status Transition Codes
- Message Keys
- Parameter
- Beispiele
- Testregeln

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5B-1a-1 – Validation Framework

## Zweck

Dieses Kapitel definiert das projektweite Validation Framework.

Es beschreibt die gemeinsamen Regeln für sämtliche Validierungen innerhalb der Domäne und bildet die Grundlage für alle Validation Error Codes.

Die konkreten Error Codes werden ausschließlich in Kapitel **5B-1b – Validation Error Catalog** definiert.

---

# Geltungsbereich

Das Validation Framework gilt für sämtliche Domänenkomponenten:

- Value Objects
- Entities
- Aggregates
- Domain Services
- Factories
- Application Services
- Import
- Export
- Synchronisation
- Benutzeroberfläche (fachliche Validierung)

---

# Architekturprinzipien

# Validation Principles

## Zweck

Die folgenden Prinzipien bilden die Grundlage des gesamten Validation Frameworks.

Sie gelten für sämtliche Validation Rules, Validation Errors und Validation-Prozesse.

---

## Prinzipien

Das Validation Framework folgt den Grundprinzipien:

- Single Source of Truth
- Deterministische Validierung
- Side-Effect-Free Validation
- Immutable Validation Results
- Separation of Concerns
- Fail Safe by Default

---

## Bedeutung

| Prinzip | Beschreibung |
|----------|--------------|
| Single Source of Truth | Gemeinsame Regeln werden nur einmal definiert. |
| Deterministische Validierung | Gleiche Eingaben erzeugen immer dasselbe Ergebnis. |
| Side-Effect-Free Validation | Validierung verändert niemals den Systemzustand. |
| Immutable Validation Results | Validation Results werden nach ihrer Erzeugung nicht verändert. |
| Separation of Concerns | Validation, Business, Security und Infrastructure bleiben getrennt. |
| Fail Safe by Default | Ungültige Eingaben werden niemals stillschweigend akzeptiert. |

---

## Architekturregel

Alle nachfolgenden Kapitel des Validation Frameworks orientieren sich an diesen Prinzipien.

## VAL-001 – Deterministische Validierung

Identische Eingaben erzeugen immer dasselbe Validierungsergebnis.

---

## VAL-002 – Keine Seiteneffekte

Eine Validierung darf niemals

- Daten speichern,
- Aggregate verändern,
- Domain Events veröffentlichen,
- Transaktionen starten,
- externe Systeme aufrufen.

---

## VAL-003 – Strukturierte Fehler

Ungültige Eingaben werden ausschließlich als strukturierte `DomainError`-Objekte zurückgegeben.

Freitextmeldungen oder technische Exceptions sind nicht Bestandteil der Domäne.

---

## VAL-004 – Trennung der Verantwortlichkeiten

Validation Rules prüfen ausschließlich die Gültigkeit von Eingaben.

Business Rules prüfen die fachliche Zulässigkeit einer Operation.

Security Rules prüfen Authentifizierung und Autorisierung.

Infrastructure Rules behandeln technische Laufzeitfehler.

Diese Kategorien dürfen nicht vermischt werden.

---

## VAL-005 – Mehrere Fehler

Unabhängige Validierungsfehler dürfen gemeinsam zurückgegeben werden.

Folgefehler werden nicht erzeugt.

---

# Validation Pipeline

Die empfohlene Reihenfolge lautet:

```text
Input
 ↓
Normalization
 ↓
Syntax
 ↓
Format
 ↓
Range
 ↓
Consistency
 ↓
Business Validation
 ↓
DomainResult
```

---

# Validation Sources

Validation Errors können optional ihren Ursprung dokumentieren.

## ValidationSource

```text
USER_INPUT
IMPORT
RESTORE
MIGRATION
SYNCHRONIZATION
SYSTEM
```

Die Source dient ausschließlich Diagnose und Nachvollziehbarkeit.

Sie verändert niemals den ErrorCode.

---

# Validation Stages

Jeder Validation Error kann zusätzlich einer Validierungsphase zugeordnet werden.

## ValidationStage

```text
NORMALIZATION
SYNTAX
FORMAT
RANGE
CONSISTENCY
BUSINESS
```

Validation Stages dienen ausschließlich Analysezwecken.

---

# Validation Modes

## COMPLETE

Alle unabhängigen Fehler werden gesammelt.

Geeignet für:

- Formulare
- Profile
- Einstellungen
- Importe

---

## FAIL_FAST

Die Validierung endet beim ersten kritischen Fehler.

Geeignet für:

- Parser
- beschädigte Dateien
- ungültige Datenstrukturen
- technische Vorbedingungen

Der Validation Mode beeinflusst ausschließlich den Ablauf der Validierung.

---

# Validation Categories

Jeder Validation Error gehört genau einer Kategorie an.

| Kategorie | Bedeutung |
|------------|-----------|
| REQUIRED | Pflichtfeld fehlt |
| FORMAT | Format ungültig |
| RANGE | Wertebereich verletzt |
| LENGTH | Länge ungültig |
| PRECISION | Genauigkeit verletzt |
| ENUM | Ungültiger Auswahlwert |
| REFERENCE | Referenz ungültig |
| DUPLICATE | Doppelter Wert |
| CONSISTENCY | Inkonsistente Eingaben |

---

# Severity

Standardmäßig verwenden Validation Errors

```text
ERROR
```

`WARNING` ist ausschließlich zulässig, wenn die Eingabe grundsätzlich akzeptiert werden kann, der Benutzer jedoch informiert werden soll.

`INFORMATION` ist für Validation Errors nicht zulässig.

---

# Standardstruktur eines Validation Errors

Jeder Validation Error besitzt mindestens:

| Feld | Beschreibung |
|------|--------------|
| ErrorCode | stabiler Fehlercode |
| MessageKey | Lokalisierungsschlüssel |
| Category | Validation Category |
| Severity | ERROR oder WARNING |
| Field | betroffenes Feld |
| Parameters | strukturierte Parameter |

Optional:

- Constraint
- ValidationSource
- ValidationStage
- CorrelationId
- DocumentationReference

---

# Standardparameter

Projektweit reservierte Parameternamen:

| Parameter | Bedeutung |
|-----------|-----------|
| field | betroffenes Feld |
| currentValue | aktueller Wert |
| expected | erwarteter Wert |
| minimum | Mindestwert |
| maximum | Höchstwert |
| allowedValues | zulässige Werte |
| pattern | erwartetes Format |
| unit | Maßeinheit |
| length | Länge |
| precision | Genauigkeit |

Diese Parameternamen sind projektweit verbindlich.

---

## Reservierte Parameternamen

### Zweck

Bestimmte Parameternamen sind projektweit reserviert.

Dadurch verwenden alle Module dieselben Begriffe für dieselbe fachliche Bedeutung.

---

### Reservierte Parameter

- field
- currentValue
- expected
- minimum
- maximum
- allowedValues
- pattern
- unit
- length
- precision

---

### Regeln

Reservierte Parameternamen dürfen nicht für andere Bedeutungen verwendet werden.

Neue Parameternamen dürfen nur eingeführt werden,

wenn ihre fachliche Bedeutung dokumentiert wurde.

---

### Architekturregel

Die Semantik reservierter Parameter bleibt projektweit unverändert.

---

# Parameterregeln

- Parameter besitzen stabile Namen.
- Parameter enthalten ausschließlich strukturierte Werte.
- Parameter enthalten keine lokalisierten Texte.
- Parameter enthalten keine sensiblen Informationen.
- Nicht benötigte Parameter werden nicht erzeugt.

---

# ErrorCode-Regeln

Validation Error Codes

- sind sprachneutral,
- eindeutig,
- versionsstabil,
- öffentlich dokumentiert.

Die Bedeutung eines veröffentlichten ErrorCodes darf nicht geändert werden.

---

## Naming Convention

### Zweck

Validation Error Codes folgen einer einheitlichen projektweiten Namenskonvention.

Dadurch bleiben sie eindeutig, lesbar und langfristig wartbar.

---

### Schema

Validation Error Codes folgen der projektweiten Error-Code-Konvention gemäß
`00_ARCHITECTURE_CONVENTIONS.md`.

Beispiel:

PRO-VAL-NAME-001
PRO-VAL-HEIGHT-003
PRO-VAL-ID-001

Message Keys verwenden die hierarchische Punktnotation:

validation.profile.name.required
validation.profile.height.minimum
validation.profile.id.invalidFormat

---

### Beispiele

**Error Codes**

```text
PRO-VAL-NAME-001
PRO-VAL-HEIGHT-003
PRO-VAL-ID-001
```

**Message Keys**

```text
validation.profile.name.required
validation.profile.height.minimum
validation.profile.id.invalidFormat
```

---

### Regeln

- Alle Bestandteile werden in Kleinbuchstaben geschrieben.
- Wörter werden durch Punkte getrennt.
- Abkürzungen sind nicht zulässig.
- Der Kontext beschreibt den fachlichen Bereich.
- Die Regel beschreibt ausschließlich die verletzte Validierungsregel.

---

### Architekturregel

Die Error-Code-Konvention gilt projektweit für sämtliche Validation Error Codes.

Die Message-Key-Konvention gilt projektweit für sämtliche Message Keys.

---

# MessageKey-Regeln

Die Benutzeroberfläche lokalisiert ausschließlich den MessageKey.

Der ErrorCode bleibt unabhängig von Sprache und Darstellung unverändert.

Mehrere Übersetzungen dürfen denselben MessageKey verwenden.

---

# Validation Context

Ein Validation Context darf zusätzliche technische Informationen enthalten.

Beispiele:

- Locale
- Maßeinheit
- Zeitzone
- Importmodus
- Quellsystem

Der Context dient ausschließlich Diagnosezwecken.

---

# Dokumentationspflicht

Jeder Validation Error wird dokumentiert durch:

- ErrorCode
- MessageKey
- Kategorie
- Beschreibung
- Parameter
- Beispiele
- Business Rule (optional)
- Testfälle
- Traceability

---

# Anti-Patterns

Nicht zulässig:

```text
throw InvalidHeightException
```

Nicht zulässig:

```text
return "Height invalid"
```

Nicht zulässig:

```text
validation.failed
```

als Sammelcode.

---

# Versionierung

## Zweck

Das Validation Framework wird versioniert weiterentwickelt.

Dabei besitzt die fachliche Stabilität veröffentlichter Regeln höchste Priorität.

---

## Regeln

Änderungen erfolgen ausschließlich über dokumentierte Architekturentscheidungen (ADR).

Neue Regeln dürfen bestehende Validation Error Codes nicht in ihrer fachlichen Bedeutung verändern.

Bestehende Error Codes bleiben abwärtskompatibel.

Neue fachliche Anforderungen führen zu neuen Error Codes oder neuen Validation Rules.

---

## Architekturregel

Die Versionierung betrifft das Framework.

Sie verändert niemals rückwirkend die Bedeutung veröffentlichter Validation Error Codes.

---

# Status dieses Abschnitts

Dieses Kapitel definiert ausschließlich die gemeinsamen Grundlagen des Validation Frameworks.

Konkrete Error Codes werden ausschließlich in Kapitel **5B-1b – Validation Error Catalog** beschrieben.

Der Validierungsablauf wird in **Teil 5B-1a-2 – Validation Processing** definiert.

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5B-1a-2 – Validation Processing

## Zweck

Dieses Kapitel definiert den projektweiten Ablauf der Validierung.

Während **Teil 5B-1a-1** die gemeinsamen Grundlagen beschreibt, legt dieses Kapitel fest,

- wie Validierungen ausgeführt werden,
- wie Validation Errors entstehen,
- wie sie aggregiert werden,
- welche Architekturregeln für den Ablauf gelten.

Konkrete Error Codes werden ausschließlich im **Validation Error Catalog (5B-1b)** definiert.

---

# Validation Processing Principles

## VAL-PROC-001 – Atomare Validierung

Ein Validation Run bewertet genau einen definierten Eingabekontext.

Das Ergebnis beschreibt ausschließlich diesen Zustand.

---

## VAL-PROC-002 – Deterministische Verarbeitung

Bei identischer Eingabe

und

identischem Validation Context

muss dasselbe Validation Result entstehen.

---

## VAL-PROC-003 – Keine Seiteneffekte

Validation Processing darf niemals

- Daten speichern,
- Aggregate verändern,
- Domain Events veröffentlichen,
- Transaktionen starten,
- Benutzeroberflächen beeinflussen.

---

# Validation Processing Pipeline

```text
Input
 ↓
Normalization
 ↓
Value Object Validation
 ↓
Entity Validation
 ↓
Aggregate Validation
 ↓
Domain Service Validation
 ↓
Error Aggregation
 ↓
DomainResult
```

---

# Validation Lifecycle

## Zweck

Der Validation Lifecycle beschreibt den vollständigen Ablauf eines Validation Runs.

Jeder Validation Run endet mit genau einem `DomainResult`.

---

## Phasen

```text
1. Vorbereitung

↓

2. Normalisierung

↓

3. Validierung

↓

4. Fehleraggregation

↓

5. Erstellung des DomainResult

↓

6. Rückgabe an den Aufrufer
```

---

## Regeln

Ein Validation Run

- besitzt genau einen Start,
- besitzt genau ein Ende,
- erzeugt genau ein DomainResult.

Ein Validation Run darf nicht mehrfach abgeschlossen werden.

---

## Architekturregel

Der Validation Lifecycle beschreibt ausschließlich den Ablauf der Validierung.

Er enthält keine fachlichen Business Rules.

---

# Verantwortlichkeiten

| Komponente | Verantwortung |
|------------|---------------|
| Value Object | Eigene Gültigkeit |
| Entity | Interne Konsistenz |
| Aggregate | Aggregate-Invarianten |
| Domain Service | Modulübergreifende Regeln |
| Application Layer | Koordination des Ablaufs |

---

# Cross-Field Validation

## Zweck

Einige Regeln betreffen mehrere Attribute gleichzeitig.

Beispiele

- Körpergröße + Gewicht
- Startdatum + Enddatum
- Medikament + Dosierung

---

## Regeln

Cross-Field Validation wird ausschließlich verwendet,

wenn

eine Regel mehrere Attribute gemeinsam bewertet.

---

## Architekturregel

Cross-Field Validation gehört

- in Aggregate
- oder Domain Services.

Sie gehört nicht in einzelne Value Objects.

---

# Validation Dependencies

## Zweck

Abhängige Prüfungen werden nur ausgeführt,

wenn ihre Vorbedingungen erfüllt sind.

Dadurch werden Folgefehler vermieden.

---

## Beispiel

```text
height fehlt
 ↓
BMI-Berechnung wird übersprungen
```

---

## Regeln

Eine abhängige Validierung wird nicht ausgeführt,

wenn eine erforderliche Vorbedingung bereits verletzt wurde.

---

# Context Propagation

## Zweck

Der Validation Context begleitet einen Validation Run über sämtliche Verarbeitungsschritte.

Dadurch stehen allen Validierungskomponenten dieselben Kontextinformationen zur Verfügung.

---

## Regeln

Der Validation Context wird unverändert weitergegeben.

- Value Objects dürfen ihn lesen.
- Entities dürfen ihn lesen.
- Aggregate dürfen ihn lesen.
- Domain Services dürfen ihn lesen.

Eine Änderung bestehender Contextinformationen ist nicht zulässig.

---

## Erweiterung

Zusätzliche Contextinformationen dürfen ausschließlich ergänzt werden.

Vorhandene Informationen dürfen weder entfernt noch überschrieben werden.

---

## Architekturregel

Der Validation Context dient ausschließlich der Verarbeitung.

Er verändert niemals die fachliche Bedeutung eines Validation Errors.

---

# Error Aggregation

## Zweck

Mehrere unabhängige Validation Errors werden in einem gemeinsamen DomainResult zusammengefasst.

---

## Regeln

Aggregation erfolgt nur,

wenn

- Fehler unabhängig sind,
- keine Folgefehler entstehen,
- die Diagnose verbessert wird.

---

## Nicht zulässig

```text
Geburtsjahr fehlt

↓

Alter ungültig
```

Nur der ursprüngliche Fehler wird zurückgegeben.

---

# Validation Cache

## Zweck

Bereits erfolgreich validierte,

unveränderte Value Objects

dürfen erneut verwendet werden.

---

## Voraussetzungen

Validation Cache ist ausschließlich zulässig,

wenn

- das Objekt unverändert ist,
- dieselben Validation Rules gelten,
- keine externen Abhängigkeiten bestehen.

---

## Architekturregel

Validation Cache ist ausschließlich eine technische Optimierung.

Er verändert niemals Validation Results.

---

# Performance

## Grundsätze

- Einfache Prüfungen möglichst früh.
- Teure Prüfungen möglichst spät.
- Unnötige Doppelvalidierungen vermeiden.
- Wiederverwendbare Validation Rules bevorzugen.

---

# Parallel Validation

## Zweck

Unabhängige Validation Rules dürfen parallel ausgeführt werden.

Dadurch kann die Performance verbessert werden,

ohne die fachliche Bedeutung der Ergebnisse zu verändern.

---

## Voraussetzungen

Parallelisierung ist ausschließlich zulässig,

wenn

- keine gemeinsamen Zustände verändert werden,
- keine Seiteneffekte auftreten,
- alle Ergebnisse deterministisch bleiben.

---

## Regeln

Die Reihenfolge der Ausführung darf variieren.

Die fachliche Bedeutung des Validation Results bleibt unverändert.

---

## Architekturregel

Parallel Validation ist eine technische Optimierung.

Sie verändert niemals ErrorCodes oder Validation Results.

---

# Reihenfolge der Validierung

Empfohlene Reihenfolge:

```text
Required
 ↓
Syntax
 ↓
Format
 ↓
Range
 ↓
Reference
 ↓
Consistency
 ↓
Business Validation
```

---

# Import Validation

Importe validieren mindestens:

- Dateistruktur
- Pflichtfelder
- Wertebereiche
- Referenzen
- Business Rules

Beschädigte Dateien verwenden typischerweise **FAIL_FAST**.

Fachlich fehlerhafte Datensätze verwenden typischerweise **COMPLETE**.

---

# Restore Validation

Vor jeder Wiederherstellung werden mindestens geprüft:

- Version
- Integrität
- Schema
- Referenzen
- Kompatibilität

---

# API Validation

API-Eingaben werden vollständig validiert,

bevor Domain Objects erzeugt werden.

Empfohlene Reihenfolge:

```text
Transport
 ↓
Schema
 ↓
Validation
 ↓
Domain
```

---

# UI Validation

Die Benutzeroberfläche darf Komfortvalidierungen durchführen,

beispielsweise

- Live-Feedback
- Zeichenbegrenzungen
- Eingabehilfen

Sie ersetzt jedoch niemals die Domain Validation.

---

# Architekturregeln

## Single Source of Truth

Jede fachliche Validierungsregel wird genau einmal implementiert.

---

## Wiederverwendbarkeit

Validation Rules sollen

- zustandslos,
- testbar,
- wiederverwendbar

sein.

---

## Separation of Concerns

Validation Processing

- validiert,
- entscheidet nicht über Business Rules,
- authentifiziert nicht,
- speichert keine Daten.

---

## Deterministische Ergebnisse

Ein Validation Run erzeugt ausschließlich reproduzierbare Ergebnisse.

---

# Qualitätskriterien

Validation Processing ist konform, wenn es

- deterministisch,
- seiteneffektfrei,
- testbar,
- wiederverwendbar,
- schichtenkonform,
- datenschutzkonform

ist.

---

# Validation Metrics

## Zweck

Während eines Validation Runs dürfen optionale Metriken erfasst werden.

Diese dienen ausschließlich

- Monitoring,
- Diagnose,
- Performanceanalyse.

---

## Beispiele

- Anzahl geprüfter Validation Rules
- Anzahl Validation Errors
- Anzahl Warnings
- Laufzeit
- verwendeter Validation Mode

---

## Regeln

Validation Metrics beeinflussen niemals

- ErrorCodes,
- MessageKeys,
- Parameter,
- DomainResult.

---

## Architekturregel

Metrics sind rein technische Informationen und gehören nicht zum fachlichen Ergebnis der Validierung.

---

# Processing Invariants

## Zweck

Während eines Validation Runs gelten unveränderliche Architekturregeln.

Diese Invarianten sichern die Konsistenz des Validation Frameworks.

---

## Invarianten

Während eines Validation Runs gilt:

- keine Seiteneffekte,
- keine Datenpersistenz,
- keine Domain Events,
- keine UI-Interaktion,
- keine Veränderung bereits vorhandener Contextinformationen,
- keine Änderung veröffentlichter ErrorCodes.

---

## Architekturregel

Processing Invariants dürfen durch keine Implementierung verletzt werden.

Sie besitzen Vorrang vor technischen Optimierungen.

---

# Status dieses Abschnitts

Mit **Teil 5B-1a-2** sind definiert:

- Validation Processing Pipeline
- Verantwortlichkeiten
- Cross-Field Validation
- Validation Dependencies
- Error Aggregation
- Validation Cache
- Performance-Regeln
- Import-, Restore-, API- und UI-Validierung
- Architekturregeln
- Qualitätskriterien

Die konkreten Validation Error Codes werden ausschließlich im **Validation Error Catalog (5B-1b)** beschrieben.

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5B-1b-1a – Core Validation Codes (Profile Aggregate)

## Zweck

Dieses Kapitel definiert die projektweiten Validation Error Codes des **Profile Aggregates**.

Die allgemeinen Regeln für

- Validation Framework
- Validation Processing
- ErrorCode-Konventionen
- Parameter
- Message Keys
- Architekturregeln

werden ausschließlich in **Kapitel 5B-1a** definiert.

Dieses Kapitel beschreibt ausschließlich die domänenspezifischen Validation Error Codes des Profile Aggregates.

---

# Profile Aggregate

## Aggregate Root

- Profile

---

## Enthaltene Entities

- Profile
- ProfileSettings
- ProfileSecurity

---

## Enthaltene Value Objects

- ProfileImage
- ProfileName
- BirthYear
- Height
- ProfileColor
- DefaultProfileFlag
- AuditInformation
- Timestamp
- AggregateVersion

---

## Architekturregel

Validation Errors werden grundsätzlich demjenigen Domänentyp zugeordnet,

der die jeweilige fachliche Invariante besitzt.

Dadurch wird verhindert,

dass identische Validierungsregeln mehrfach dokumentiert werden.

---

# Profile

### Zugeordneter Domänentyp

**Aggregate Root / Entity**

- Profile

---

## Zweck

Dieser Abschnitt definiert sämtliche Validation Error Codes,

die unmittelbar das Profile Aggregate oder die Entity **Profile**
betreffen.

Validation Errors der enthaltenen Entities und Value Objects
werden ausschließlich in deren jeweiligen Abschnitten dokumentiert.

---

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.profile.required | validation.profile.required |
| validation.profile.invalid | validation.profile.invalid |
| validation.profile.duplicate | validation.profile.duplicate |

> Hinweis:
> Aggregatbezogene Validierungsfehler werden zentral im Abschnitt
> **5B-1b-2 Aggregate Validation Errors** definiert.
> `validation.profile.aggregate.invalid` ist dort die führende Definition.

---

### Dokumentationsreihenfolge

Die Reihenfolge der Error Codes entspricht den Vorgaben aus Kapitel **5B-1a**.

Nicht benötigte Kategorien werden ausgelassen.

---

### Referenz zum Domain Model

Der Domänentyp **Profile** wird ausschließlich im Dokument

```text
05_DOMAIN_MODEL.md
```

definiert.

Änderungen erfolgen ausschließlich dort.

---

### Zugehörige Business Rules

Die fachlichen Regeln werden ausschließlich im Dokument

```text
03_BUSINESS_RULES.md
```

beschrieben.

Der Error Handling Guide enthält keine Definition fachlicher Regeln.

---

### Beziehung zu Domain Events

Validation Errors verhindern die erfolgreiche Ausführung
einer fachlichen Operation.

Solange Validation Errors vorliegen,

dürfen keine Domain Events erzeugt werden.

---

### Domänenspezifische Besonderheiten

Die Aggregate Root stellt die Konsistenz
des gesamten Profile Aggregates sicher.

Validation Errors dieses Abschnitts beziehen sich ausschließlich
auf Invarianten,

die das vollständige Aggregate betreffen.

---

# ProfileStatus

### Zugeordneter Domänentyp

**Enumeration**

- ProfileStatus

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für den fachlichen
Lebenszyklusstatus eines Profils.

`ProfileStatus` beschreibt ausschließlich den Lebenszyklus eines Profils.

Zulässige Werte sind:

```text
inactive
active
archived
```

Der Sperrzustand wird getrennt durch `LockState` und
`ProfileLockStatus` modelliert.

Die Werte

```text
locked
unlocked
```

sind keine Werte von `ProfileStatus`.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-STATUS-001 | validation.profile.status.required | ERROR | VALIDATION | status | required | – |
| PRO-VAL-STATUS-002 | validation.profile.status.invalid | ERROR | VALIDATION | status | enum | allowedValues |
| PRO-VAL-STATUS-003 | validation.profile.status.transition | ERROR | VALIDATION | status | transition | – |

### Parameter

#### PRO-VAL-STATUS-002

```json
{
  "allowedValues": [
    "inactive",
    "active",
    "archived"
  ]
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-012

Neue fachliche Validierungsregeln werden in diesem Dokument nicht definiert.

---

## Fehlerverhalten

### Fehlender Profilstatus

Ist kein Profilstatus vorhanden, wird ausschließlich

```text
PRO-VAL-STATUS-001
```

erzeugt.

Weitere Statusprüfungen werden in diesem Fall nicht durchgeführt.

### Ungültiger Profilstatus

Entspricht der vorhandene Wert keinem zulässigen `ProfileStatus`, wird

```text
PRO-VAL-STATUS-002
```

erzeugt.

Die zulässigen Statuswerte werden über den Parameter `allowedValues`
übertragen.

### Ungültiger Lebenszyklusübergang

Ist der aktuelle Status gültig, der angeforderte Lebenszyklusübergang aber
fachlich nicht zulässig, wird

```text
PRO-VAL-STATUS-003
```

erzeugt.

Dieser Code beschreibt ausschließlich ungültige Übergänge zwischen den
Lebenszyklusstatus:

```text
inactive
active
archived
```

Sperr-, Credential- und Authentifizierungsfehler werden nicht unter diesem
Code zusammengefasst.

---

## Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein des Status,
2. zulässiger Enum-Wert,
3. zulässiger Lebenszyklusübergang.

Ein fehlender Status erzeugt keinen zusätzlichen Enum- oder
Transition-Fehler.

Ein ungültiger Enum-Wert erzeugt keinen zusätzlichen Transition-Fehler.

---

## No-Change-Abgrenzung

Die folgenden Situationen sind keine Validation Errors:

- `activate()` bei bereits aktivem Profil,
- `deactivate()` bei bereits inaktivem Profil,
- `archive()` bei bereits archiviertem Profil.

Diese Situationen können als erfolgreiche No-Change-Ergebnisse behandelt
werden.

No-Change-Ergebnisse werden getrennt als `DomainInformation` dokumentiert.

---

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- `LockState`,
- `ProfileLockStatus`,
- Passwortschutz,
- Authentifizierung,
- Credential-Prüfung,
- profilübergreifende Auswahl des aktiven Profils,
- Business Errors.

Das Zusammenspiel zwischen Lebenszyklusstatus und Sperrzustand wird durch
das `Profile`-Aggregate sowie die zuständigen Business Rules,
Specifications und Domain Services geschützt.

---

# DefaultProfile

### Zugeordneter Domänentyp

**Value Object**

- DefaultProfileFlag

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für den
Standardprofilstatus.

Der Standardprofilstatus wird durch das Value Object
`DefaultProfileFlag` beschrieben.

Die profilübergreifende Invariante wird durch den
`DefaultProfileCoordinator` geschützt.

Es darf höchstens ein Standardprofil existieren.

Ein Zustand ohne Standardprofil ist fachlich zulässig.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters | Status |
|------------|------------|----------|----------|-------|------------|------------|--------|
| PRO-VAL-DEFAULT-001 | validation.profile.default.notFound | ERROR | VALIDATION | defaultProfile | required | – | reserviert |
| PRO-VAL-DEFAULT-002 | validation.profile.default.multiple | ERROR | VALIDATION | defaultProfile | unique | maximum | aktiv |
| PRO-VAL-DEFAULT-003 | validation.profile.default.invalidStatus | ERROR | VALIDATION | defaultProfile | status | disallowedStatuses | aktiv |

### Parameter

#### PRO-VAL-DEFAULT-002

```json
{
  "maximum": 1
}
```

#### PRO-VAL-DEFAULT-003

```json
{
  "disallowedStatuses": [
    "archived"
  ]
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-013

Neue fachliche Validierungsregeln werden in diesem Dokument nicht definiert.

---

## Reservierter Error Code

### PRO-VAL-DEFAULT-001

Der Error Code

```text
PRO-VAL-DEFAULT-001
```

bleibt ausschließlich aus Gründen der Stabilität des
Fehlerkatalogs reserviert.

Ein Zustand ohne Standardprofil stellt keinen Validation Error dar.

Der Code darf

- nicht erneut vergeben,
- nicht für einen anderen Sachverhalt verwendet,
- nicht als allgemeiner Pflichtfehler erzeugt

werden.

---

## Fehlerverhalten

### Mehrere Standardprofile

Sind mehrere Profile gleichzeitig als Standardprofil markiert,

wird

```text
PRO-VAL-DEFAULT-002
```

erzeugt.

Die Prüfung erfolgt profilübergreifend.

---

### Ungültiger Profilstatus

Ist ein als Standardprofil markiertes Profil archiviert,

wird

```text
PRO-VAL-DEFAULT-003
```

erzeugt.

Ein gesperrtes Profil erzeugt diesen Fehler ausdrücklich nicht.

---

## Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein referenzierter Profile.
2. Lebenszyklusstatus prüfen.
3. Anzahl der Standardprofile prüfen.
4. Profilübergreifende Invariante prüfen.

Ein Zustand ohne Standardprofil erzeugt keinen Validation Error.

---

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind

- Aktivierung eines Profils,
- Authentifizierung,
- Passwortschutz,
- Sperrlogik,
- Auswahl des zuletzt verwendeten Profils,
- technische Persistenz.

Die Auswahl eines bevorzugten Startprofils wird ausschließlich
durch den `DefaultProfileCoordinator`
und die zugehörigen Business Rules gesteuert.

---

# ProfileImport

### Zugeordneter fachlicher Prozess

**Importoperation**

- ProfileImport

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für den fachlichen
Import eines Profile-Aggregates.

Vor der Übernahme eines importierten Profils muss der vollständige
Importdatensatz erfolgreich validiert und rekonstruiert werden.

Ein Import darf niemals zu einem teilweise übernommenen Aggregate führen.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-IMPORT-001 | validation.profile.import.invalidFormat | ERROR | VALIDATION | import | format | supportedFormats |
| PRO-VAL-IMPORT-002 | validation.profile.import.invalidVersion | ERROR | VALIDATION | import | version | supportedVersions |
| PRO-VAL-IMPORT-003 | validation.profile.import.corrupted | ERROR | VALIDATION | import | integrity | – |
| PRO-VAL-IMPORT-004 | validation.profile.import.missingRequiredData | ERROR | VALIDATION | import | required | – |
| PRO-VAL-IMPORT-005 | validation.profile.import.duplicateId | ERROR | VALIDATION | import | duplicate | identityType |
| PRO-VAL-IMPORT-006 | validation.profile.import.rollback | ERROR | VALIDATION | import | atomic | – |

### Parameter

#### PRO-VAL-IMPORT-001

```json
{
  "supportedFormats": [
    "json"
  ]
}
```

#### PRO-VAL-IMPORT-002

```json
{
  "supportedVersions": [
    "1.0"
  ]
}
```

#### PRO-VAL-IMPORT-005

```json
{
  "identityType": "<identityType>"
}
```

Zulässige Werte sind:

```text
ProfileId
ProfileSettingsId
ProfileSecurityId
```

---

## Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-015

Neue fachliche Importregeln werden in diesem Dokument nicht definiert.

---

## Fehlerverhalten

### Ungültiges Dateiformat

Ist das Importformat nicht unterstützt,

wird

```text
PRO-VAL-IMPORT-001
```

erzeugt.

---

### Nicht unterstützte Datenversion

Ist die Datenversion unbekannt oder nicht unterstützt,

wird

```text
PRO-VAL-IMPORT-002
```

erzeugt.

---

### Beschädigte Importdaten

Kann der Importdatensatz nicht vollständig gelesen oder rekonstruiert
werden,

wird

```text
PRO-VAL-IMPORT-003
```

erzeugt.

---

### Fehlende Pflichtdaten

Fehlen für die Rekonstruktion erforderliche Daten,

wird

```text
PRO-VAL-IMPORT-004
```

erzeugt.

---

### Doppelte fachliche Identitäten

Verletzt der Import die Eindeutigkeit fachlicher Identitäten,

wird

```text
PRO-VAL-IMPORT-005
```

erzeugt.

Hierzu gehören insbesondere

- ProfileId
- ProfileSettingsId
- ProfileSecurityId

---

### Atomarer Rollback

Kann der Import aufgrund eines oder mehrerer Validation Errors
nicht erfolgreich abgeschlossen werden,

wird

```text
PRO-VAL-IMPORT-006
```

dokumentiert.

Dieser Code beschreibt ausschließlich den vollständigen Rollback
der Importoperation.

Er ersetzt nicht den ursprünglichen Validation Error.

---

## Rekonstruktionsvalidierung

Vor der Übernahme des importierten Aggregates müssen erfolgreich
validiert werden:

- Aggregate-Invarianten,
- Entity-Invarianten,
- Value-Object-Invarianten.

Erst danach darf das rekonstruierte Profile-Aggregate übernommen werden.

---

## Atomare Ausführung

Der Profilimport ist vollständig atomar.

Bei jedem Validation Error gilt:

- keine teilweise Übernahme,
- kein teilweise rekonstruiertes Aggregate,
- vollständiger Rollback,
- unveränderter ursprünglicher Datenbestand.

---

## Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Dateiformat
2. Datenversion
3. Datenintegrität
4. Pflichtdaten
5. Rekonstruktion
6. Aggregate-Invarianten
7. Entity-Invarianten
8. Value-Object-Invarianten
9. Atomare Übernahme

Ein früher Fehler verhindert nachgelagerte Validierungen.

---

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind

- technische Dateisystemfehler,
- Netzwerkfehler,
- Verschlüsselung,
- Kompression,
- Datenbanktransaktionen,
- Persistenzfehler.

Diese werden in den technischen Fehlerkatalogen dokumentiert.

---

# ProfileExport

### Zugeordneter fachlicher Prozess

**Exportoperation**

- ProfileExport

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für die fachliche
Validierung eines `ProfileExportModel`.

Die Validierung erfolgt vor der technischen Serialisierung und
Dateierzeugung.

Es wird ausschließlich das fachliche Exportmodell validiert.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-EXPORT-001 | validation.profile.export.versionMissing | ERROR | VALIDATION | version | required | field |
| PRO-VAL-EXPORT-002 | validation.profile.export.foreignProfile | ERROR | VALIDATION | profileData | ownership | expectedProfileId, detectedProfileIds |
| PRO-VAL-EXPORT-003 | validation.profile.export.securityData | ERROR | VALIDATION | profileData | forbidden | detectedDataTypes |
| PRO-VAL-EXPORT-004 | validation.profile.export.incomplete | ERROR | VALIDATION | exportModel | completeness | missingFields |

### Parameter

#### PRO-VAL-EXPORT-001

```json
{
  "field": "version"
}
```

---

#### PRO-VAL-EXPORT-002

```json
{
  "expectedProfileId": "<profileId>",
  "detectedProfileIds": [
    "<foreignProfileId>"
  ]
}
```

---

#### PRO-VAL-EXPORT-003

```json
{
  "detectedDataTypes": [
    "PasswordCredential",
    "PasswordHash"
  ]
}
```

Es werden ausschließlich Typbezeichnungen übertragen.

Geheime Inhalte dürfen niemals Bestandteil eines Validation Errors sein.

---

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

---

## Herkunft

Diese Error Codes werden ausschließlich aus

```text
PRO-VR-016
```

übernommen.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

---

## Fehlerverhalten

### Fehlende Exportversion

Fehlt die Exportversion,

wird

```text
PRO-VAL-EXPORT-001
```

erzeugt.

---

### Fremde Profildaten

Enthält das Exportmodell Daten,
die nicht eindeutig der exportierten

```text
ProfileId
```

zugeordnet sind,

wird

```text
PRO-VAL-EXPORT-002
```

erzeugt.

Hierzu gehören insbesondere

- fremde Stammdaten,
- fremde Einstellungen,
- fremde Bildreferenzen,
- vermischte Daten mehrerer Profile.

---

### Verbotene Sicherheitsdaten

Enthält das Exportmodell mindestens einen verbotenen
Sicherheitsdatentyp,

wird

```text
PRO-VAL-EXPORT-003
```

erzeugt.

Der Fehlerparameter enthält ausschließlich die Typbezeichnungen der
festgestellten Daten.

Passwortwerte, Hashes, Credentials,
AuthenticationProofs oder kryptographische Schlüssel dürfen niemals
Bestandteil eines Validation Errors sein.

---

### Unvollständiges Exportmodell

Fehlen erforderliche Bestandteile des Exportmodells,

wird

```text
PRO-VAL-EXPORT-004
```

erzeugt.

Hierzu gehören insbesondere

- exportedAt,
- profileId,
- profileData,
- angeforderte freigegebene Exportbereiche.

---

## Vollständigkeit

Ein vollständiges Exportmodell enthält mindestens

```text
version
exportedAt
profileId
profileData
```

Zusätzlich müssen sämtliche ausdrücklich freigegebenen
Exportbereiche vollständig enthalten sein.

---

## Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Exportversion.
2. Exportzeitpunkt.
3. ProfileId.
4. Vollständigkeit.
5. Profilzuordnung.
6. Sicherheitsdaten.
7. Vollständiges Exportmodell.

Ein früher Validation Error verhindert nachgelagerte
fachliche Prüfungen, soweit diese auf den fehlenden
Informationen aufbauen.

---

## Erfolgsverhalten

Nach erfolgreicher Validierung gilt:

- das Exportmodell ist fachlich vollständig,
- sämtliche Daten gehören zum exportierten Profil,
- keine verbotenen Sicherheitsdaten sind enthalten,
- keine technischen Exportartefakte wurden erzeugt,
- das Profile-Aggregate bleibt unverändert,
- Auditinformationen bleiben unverändert,
- die Aggregate-Version bleibt unverändert.

---

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind

- technische Serialisierung,
- JSON-Erzeugung,
- Dateierzeugung,
- Kompression,
- Verschlüsselung,
- Download,
- Dateisystemzugriffe,
- Netzwerkübertragung,
- technische Speicherfehler.

Diese Verantwortlichkeiten werden ausschließlich in den technischen
Fehlerkatalogen dokumentiert.

---

# ProfileSettingsId

### Zugeordneter Domänentyp

**Value Object**

- ProfileSettingsId

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für das Value Object
`ProfileSettingsId`.

`ProfileSettingsId` repräsentiert die lokale Identität der untergeordneten
Entity `ProfileSettings`.

Die ID besitzt ausschließlich innerhalb des `Profile`-Aggregats eine
fachliche Bedeutung.

Sie ersetzt keine `ProfileId`.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PSETID-001 | validation.profileSettingsId.required | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PSETID-002 | validation.profileSettingsId.blank | ERROR | VALIDATION | value | blank | – |
| PRO-VAL-PSETID-003 | validation.profileSettingsId.invalidFormat | ERROR | VALIDATION | value | format | expectedFormat |

### Parameter

#### PRO-VAL-PSETID-003

```json
{
  "expectedFormat": "UUID"
}
```

---

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-025

übernommen.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

---

## Fehlerverhalten

### Fehlender Wert

Ist kein Wert vorhanden,

wird

```text
PRO-VAL-PSETID-001
```

erzeugt.

Weitere Prüfungen werden nicht durchgeführt.

---

### Leerer Wert

Ist der Wert nach dem Trimmen leer,

wird

```text
PRO-VAL-PSETID-002
```

erzeugt.

Ein zusätzlicher Formatfehler wird nicht erzeugt.

---

### Ungültiges UUID-Format

Entspricht der normalisierte Wert keinem gültigen UUID-Format,

wird

```text
PRO-VAL-PSETID-003
```

erzeugt.

Der Fehlerparameter lautet:

```json
{
  "expectedFormat": "UUID"
}
```

Der ungültige Eingabewert wird nicht in den Fehlerparametern
übertragen.

---

## Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein prüfen.
2. Trimmen.
3. Leeren Wert prüfen.
4. UUID-Format prüfen.
5. `ProfileSettingsId` erzeugen.

Ein fehlender Wert erzeugt keinen zusätzlichen Blank- oder
Formatfehler.

Ein leerer Wert erzeugt keinen zusätzlichen Formatfehler.

---

## Verhalten von generate()

Die Factory

```text
ProfileSettingsId.generate()
```

erzeugt eine neue gültige UUID.

Für diese Factory werden keine Validation Errors definiert.

Fehler der technischen UUID-Erzeugung gehören nicht zu den
fachlichen Validation Errors.

---

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- technische UUID-Erzeugung,
- Persistenz,
- Datenbank-Constraints,
- Repository-Konflikte,
- Verwendung als `ProfileId`,
- JSON-Serialisierung,
- Infrastrukturfehler.

Die Entity `ProfileSettings` prüft ausschließlich,
ob eine gültige `ProfileSettingsId` vorhanden ist.

Validation Errors dieses Value Objects werden auf Entity-Ebene
nicht erneut erzeugt.

---

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5B-1b-1b – Core Validation Codes (ProfileSettings und ProfileSecurity)

## Zweck

Dieses Kapitel definiert die Validation Error Codes der Entities

- ProfileSettings
- ProfileSecurity

des **Profile Aggregates**.

Die allgemeinen Regeln des Validation Frameworks werden ausschließlich in **Kapitel 5B-1a** definiert.

---

# ProfileSettings

### Zugeordneter Domänentyp

**Entity**

- ProfileSettings

---

## Zweck

Dieser Abschnitt definiert sämtliche Validation Error Codes der Entity **ProfileSettings**.

Die Validierung betrifft ausschließlich die fachliche Konsistenz der Profileinstellungen.

---

## Zugehörige Value Objects

- ProfileSettingsId
- LocalizationSettings
- DashboardSettings
- AppearanceSettings

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PSET-001 | validation.profileSettings.settingsId.required | ERROR | VALIDATION | settingsId | required | – |
| PRO-VAL-PSET-002 | validation.profileSettings.settingsId.invalid | ERROR | VALIDATION | settingsId | invalid | – |
| PRO-VAL-PSET-003 | validation.profileSettings.localization.required | ERROR | VALIDATION | localization | required | – |
| PRO-VAL-PSET-004 | validation.profileSettings.dashboard.required | ERROR | VALIDATION | dashboard | required | – |
| PRO-VAL-PSET-005 | validation.profileSettings.appearance.required | ERROR | VALIDATION | appearance | required | – |
| PRO-VAL-PSET-006 | validation.profileSettings.incomplete | ERROR | VALIDATION | profileSettings | completeness | requiredFields |

### Herkunft

Diese Error Codes werden ausschließlich aus folgenden Validation Rules
abgeleitet:

- PRO-VR-017
- PRO-VR-018
- PRO-VR-021
- PRO-VR-022
- PRO-VR-023

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

### Hinweise

Validation Errors der enthaltenen Value Objects werden nicht als
`ProfileSettings`-Fehler dupliziert.

Die Detailvalidierung erfolgt ausschließlich in den jeweiligen
Domänentypen.

No-Change ist kein Validation Error und wird deshalb nicht in diesem
Abschnitt dokumentiert.

---

# ProfileSettingsId

### Zugeordneter Domänentyp

**Value Object**

- ProfileSettingsId

---

## Zweck

Dieser Abschnitt definiert sämtliche Validation Error Codes des
Value Objects **ProfileSettingsId**.

Die ID repräsentiert ausschließlich die lokale Identität der
Entity `ProfileSettings`.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PSETID-001 | validation.profileSettingsId.required | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PSETID-002 | validation.profileSettingsId.blank | ERROR | VALIDATION | value | blank | – |
| PRO-VAL-PSETID-003 | validation.profileSettingsId.invalidFormat | ERROR | VALIDATION | value | format | expectedFormat |

### Parameter

#### PRO-VAL-PSETID-003

```json
{
  "expectedFormat": "UUIDv7"
}
```

---

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-025

abgeleitet.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

---

## Hinweise

`fromString(...)` validiert ausschließlich

- Vorhandensein,
- Leerwert,
- UUIDv7-Format.

`generate()`

erzeugt ausschließlich eine gültige UUID Version 7.

Für `generate()` werden keine Validation Errors definiert.

Die technische UUID-Erzeugung ist kein Bestandteil der Domänenspezifikation.

Validation Errors dieses Value Objects werden von
`ProfileSettings` nicht erneut als Entity-Fehler erzeugt.

---

# LocalizationSettings

### Zugeordneter Domänentyp

**Value Object**

- LocalizationSettings

## Zweck

Dieser Abschnitt definiert die Validation Error Codes des Value Objects
`LocalizationSettings`.

Das Value Object beschreibt die profilbezogenen Einstellungen für

- Sprache,
- Maßeinheitensystem.

Land, Zeitzone und Datumsformat sind keine Attribute dieses Value Objects.

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-LOC-001 | validation.localization.language.required | ERROR | VALIDATION | language | required | – |
| PRO-VAL-LOC-002 | validation.localization.language.invalid | ERROR | VALIDATION | language | enum | allowedValues |
| PRO-VAL-LOC-003 | validation.localization.measurementSystem.required | ERROR | VALIDATION | measurementSystem | required | – |
| PRO-VAL-LOC-004 | validation.localization.measurementSystem.invalid | ERROR | VALIDATION | measurementSystem | enum | allowedValues |

### Parameter

#### PRO-VAL-LOC-002

```json
{
  "allowedValues": "supportedLanguageCodes"
}
```

Die tatsächlich unterstützten Sprachcodes werden durch die Enumeration
`Language` und die zugehörige Sprachkonfiguration bestimmt.

#### PRO-VAL-LOC-004

```json
{
  "allowedValues": [
    "metric",
    "imperial"
  ]
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-018

Neue fachliche Validierungsregeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

Ist `language` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-LOC-001
```

für dieses Feld erzeugt.

Ist `language` vorhanden, entspricht aber keinem unterstützten Sprachcode,
wird

```text
PRO-VAL-LOC-002
```

erzeugt.

Ist `measurementSystem` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-LOC-003
```

für dieses Feld erzeugt.

Ist `measurementSystem` vorhanden, entspricht aber keinem unterstützten
Wert, wird

```text
PRO-VAL-LOC-004
```

erzeugt.

Ein fehlender Pflichtwert erzeugt für dasselbe Feld keinen zusätzlichen
Enum-Fehler.

### Abgrenzung

Nicht zu `LocalizationSettings` gehören:

- `country`,
- `timezone`,
- Datumsformate,
- konkrete Übersetzungen,
- UI-Locale-Typen,
- Flutter-Typen.

Dafür werden in diesem Abschnitt keine Error Codes definiert.

Ein identischer neuer Wert ist kein Validation Error.

Das No-Change-Verhalten wird getrennt von den Validation Errors
dokumentiert.

---

# DashboardWidgetSelection

### Zugeordneter Domänentyp

**Value Object**

- DashboardWidgetSelection

## Zweck

Dieser Abschnitt definiert die Validation Error Codes des Value Objects
`DashboardWidgetSelection`.

Das Value Object beschreibt die sichtbaren Dashboard-Widgets eines Profils
sowie deren fachliche Reihenfolge.

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-DWSEL-001 | validation.dashboardWidgetSelection.widgetKeys.required | ERROR | VALIDATION | widgetKeys | required | – |
| PRO-VAL-DWSEL-002 | validation.dashboardWidgetSelection.widgetKey.blank | ERROR | VALIDATION | widgetKeys | blank | index |
| PRO-VAL-DWSEL-003 | validation.dashboardWidgetSelection.widgetKey.duplicate | ERROR | VALIDATION | widgetKeys | duplicate | widgetKey, firstIndex, duplicateIndex |

### Parameter

#### PRO-VAL-DWSEL-002

```json
{
  "index": "<zeroBasedIndex>"
}
```

#### PRO-VAL-DWSEL-003

```json
{
  "widgetKey": "<normalizedWidgetKey>",
  "firstIndex": "<zeroBasedIndex>",
  "duplicateIndex": "<zeroBasedIndex>"
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-019

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Fehlende Liste

Ist `widgetKeys` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-DWSEL-001
```

erzeugt.

#### Leerer Widget-Schlüssel

Ergibt ein Widget-Schlüssel nach der Normalisierung einen leeren Wert,

wird

```text
PRO-VAL-DWSEL-002
```

erzeugt.

#### Doppelter Widget-Schlüssel

Kommt ein normalisierter Widget-Schlüssel mehrfach vor,

wird

```text
PRO-VAL-DWSEL-003
```

erzeugt.

### Hinweise

Eine vorhandene leere Liste ist ausdrücklich zulässig.

Für einen unbekannten Widget-Schlüssel wird derzeit kein eigener
Error Code definiert, da das Domain Model keinen verbindlichen
Widget-Katalog enthält.

### Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- Flutter-Widgets,
- Widget-Klassen,
- UI-Komponenten,
- Dashboard-Inhalte,
- Dashboard-Auswertungen,
- Bildschirmgrößen,
- Persistenzstrukturen.

Die vollständige Validierung eines Dashboardzustands erfolgt
ausschließlich über `DashboardSettings`.

Validation Errors werden dort nicht erneut erzeugt.

---

# DashboardConfigurationVersion

### Zugeordneter Domänentyp

**Value Object**

- DashboardConfigurationVersion

## Zweck

Dieser Abschnitt definiert die Validation Error Codes des Value Objects
`DashboardConfigurationVersion`.

Das Value Object beschreibt die Version einer gespeicherten
Dashboardkonfiguration.

Es dient ausschließlich der fachlichen Kompatibilitäts- und
Migrationsprüfung von Dashboard-Einstellungen.

Es ist nicht identisch mit der `AggregateVersion`.

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-DCV-001 | validation.dashboardConfigurationVersion.required | ERROR | VALIDATION | value | required | – |
| PRO-VAL-DCV-002 | validation.dashboardConfigurationVersion.minimum | ERROR | VALIDATION | value | minimum | minimum, actual |

### Parameter

#### PRO-VAL-DCV-002

```json
{
  "minimum": 1,
  "actual": "<value>"
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-020

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Fehlende Versionsnummer

Ist keine Versionsnummer vorhanden, wird ausschließlich

```text
PRO-VAL-DCV-001
```

erzeugt.

Weitere Prüfungen erfolgen nicht.

#### Ungültige Versionsnummer

Ist die Versionsnummer kleiner als `1`,

wird

```text
PRO-VAL-DCV-002
```

erzeugt.

Der tatsächlich übergebene Wert wird als Parameter übertragen.

### Hinweise

Die Versionsnummer beschreibt ausschließlich die fachliche Version der
Dashboardkonfiguration.

Sie ist nicht identisch mit

- `AggregateVersion`,
- Optimistic Locking,
- Datenbankschemata,
- Persistenzversionen.

Eine Versionsnummer größer als `1` ist kein Validation Error.

Ob eine Dashboardkonfiguration migriert werden muss, wird nicht durch den
Error Handling Guide entschieden.

### Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- AggregateVersion,
- Datenmigration,
- Persistenz,
- Datenbankschemata,
- technische Revisionsnummern,
- Optimistic Locking.

Diese Verantwortlichkeiten werden an anderer Stelle beschrieben.

---

# DashboardSettings

### Zugeordneter Domänentyp

**Value Object**

- DashboardSettings

## Zweck

Dieser Abschnitt definiert die Validation Error Codes des Value Objects
`DashboardSettings`.

Das Value Object beschreibt die vollständigen profilbezogenen
Dashboard-Einstellungen.

Es besteht aus

- `DashboardLayout`,
- `DashboardWidgetSelection`,
- `DashboardConfigurationVersion`.

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-DSET-001 | validation.dashboardSettings.layout.required | ERROR | VALIDATION | layout | required | – |
| PRO-VAL-DSET-002 | validation.dashboardSettings.layout.invalid | ERROR | VALIDATION | layout | enum | allowedValues |
| PRO-VAL-DSET-003 | validation.dashboardSettings.visibleWidgets.required | ERROR | VALIDATION | visibleWidgets | required | – |
| PRO-VAL-DSET-004 | validation.dashboardSettings.configurationVersion.required | ERROR | VALIDATION | configurationVersion | required | – |
| PRO-VAL-DSET-005 | validation.dashboardSettings.incomplete | ERROR | VALIDATION | dashboardSettings | completeness | requiredFields |

### Parameter

#### PRO-VAL-DSET-002

```json
{
  "allowedValues": "DashboardLayout"
}
```

#### PRO-VAL-DSET-005

```json
{
  "requiredFields": [
    "layout",
    "visibleWidgets",
    "configurationVersion"
  ]
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-021

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Fehlendes Layout

Ist `layout` nicht vorhanden,

wird ausschließlich

```text
PRO-VAL-DSET-001
```

erzeugt.

#### Ungültiges Layout

Ist `layout` kein unterstützter `DashboardLayout`,

wird

```text
PRO-VAL-DSET-002
```

erzeugt.

#### Fehlende Widgetauswahl

Ist `visibleWidgets` nicht vorhanden,

wird

```text
PRO-VAL-DSET-003
```

erzeugt.

#### Fehlende Konfigurationsversion

Ist `configurationVersion` nicht vorhanden,

wird

```text
PRO-VAL-DSET-004
```

erzeugt.

#### Unvollständiger Dashboardzustand

Fehlt mindestens einer der Pflichtbestandteile,

kann zusätzlich

```text
PRO-VAL-DSET-005
```

erzeugt werden,

sofern nicht bereits ein eindeutiger Pflichtfeldfehler den Zustand
vollständig beschreibt.

### Hinweise

`DashboardSettings` validiert ausschließlich den vollständigen
Dashboardzustand.

Die Detailvalidierung erfolgt ausschließlich durch

- `DashboardWidgetSelection`
- `DashboardConfigurationVersion`

sowie die Enumeration

- `DashboardLayout`.

Fehler dieser Domänentypen werden nicht erneut als
`DashboardSettings`-Fehler erzeugt.

Dadurch werden doppelte Fehlermeldungen vermieden.

Eine vorhandene leere Widgetauswahl ist ausdrücklich zulässig.

### Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- Dashboard-Inhalte,
- Dashboard-Auswertungen,
- Widget-Daten,
- Flutter-Widgets,
- Bildschirmgrößen,
- Farben,
- UI-Komponenten,
- Layoutberechnungen.

Diese Verantwortlichkeiten gehören nicht zum fachlichen
Dashboard-Einstellungszustand.

Ein identischer neuer Wert ist kein Validation Error.

Das No-Change-Verhalten wird getrennt von den Validation Errors
dokumentiert.

---

# AppearanceSettings

### Zugeordneter Domänentyp

**Value Object**

- AppearanceSettings

## Zweck

Dieser Abschnitt definiert die Validation Error Codes des Value Objects
`AppearanceSettings`.

Das Value Object beschreibt die profilbezogenen Darstellungspräferenzen.

Es besteht aus

- `ThemePreference`,
- optional `TextScalePreference`.

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-APP-001 | validation.appearanceSettings.themePreference.required | ERROR | VALIDATION | themePreference | required | – |
| PRO-VAL-APP-002 | validation.appearanceSettings.themePreference.invalid | ERROR | VALIDATION | themePreference | enum | allowedValues |
| PRO-VAL-APP-003 | validation.appearanceSettings.textScalePreference.invalid | ERROR | VALIDATION | textScalePreference | enum | allowedValues |

### Parameter

#### PRO-VAL-APP-002

```json
{
  "allowedValues": "ThemePreference"
}
```

#### PRO-VAL-APP-003

```json
{
  "allowedValues": "TextScalePreference"
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-022

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Fehlende ThemePreference

Ist `themePreference` nicht vorhanden,

wird ausschließlich

```text
PRO-VAL-APP-001
```

erzeugt.

Weitere Prüfungen erfolgen nicht.

#### Ungültige ThemePreference

Ist `themePreference` kein unterstützter Wert,

wird

```text
PRO-VAL-APP-002
```

erzeugt.

#### Ungültige TextScalePreference

Ist `textScalePreference` vorhanden,

entspricht aber keinem unterstützten Wert,

wird

```text
PRO-VAL-APP-003
```

erzeugt.

Eine fehlende `textScalePreference` erzeugt keinen Validation Error.

### Hinweise

`AppearanceSettings` validiert ausschließlich den vollständigen fachlichen
Darstellungszustand.

Die Detailvalidierung der enthaltenen Enumerationen erfolgt ausschließlich
über

- `ThemePreference`
- `TextScalePreference`.

Fehler dieser Domänentypen werden nicht erneut als
`AppearanceSettings`-Fehler erzeugt.

Dadurch werden doppelte Fehlermeldungen vermieden.

### Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- Flutter-Themes,
- Material-Themes,
- Plattformdarstellung,
- konkrete Schriftgrößen,
- Farbdefinitionen,
- UI-Komponenten,
- Accessibility-Implementierungen.

Diese Verantwortlichkeiten gehören nicht zum fachlichen
Darstellungszustand.

Ein identischer neuer Wert ist kein Validation Error.

Das No-Change-Verhalten wird getrennt von den Validation Errors
dokumentiert.

---

# ProfileSecurityId

### Zugeordneter Domänentyp

**Value Object**

- ProfileSecurityId

---

## Zweck

Dieser Abschnitt definiert sämtliche Validation Error Codes des
Value Objects **ProfileSecurityId**.

Die ID repräsentiert ausschließlich die lokale Identität der
Entity `ProfileSecurity`.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PSECID-001 | validation.profileSecurityId.required | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PSECID-002 | validation.profileSecurityId.blank | ERROR | VALIDATION | value | blank | – |
| PRO-VAL-PSECID-003 | validation.profileSecurityId.invalidFormat | ERROR | VALIDATION | value | format | expectedFormat |

### Parameter

#### PRO-VAL-PSECID-003

```json
{
  "expectedFormat": "UUIDv7"
}
```

---

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-026

abgeleitet.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

---

## Fehlerverhalten

### Fehlender Wert

Ist kein Wert vorhanden,

wird

```text
PRO-VAL-PSECID-001
```

erzeugt.

Weitere Prüfungen werden nicht durchgeführt.

---

### Leerer Wert

Ist der Wert nach dem Trimmen leer,

wird

```text
PRO-VAL-PSECID-002
```

erzeugt.

Ein zusätzlicher Formatfehler wird nicht erzeugt.

---

### Ungültiges UUIDv7-Format

Entspricht der normalisierte Wert keiner gültigen UUID Version 7,

wird

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

Der ungültige Eingabewert wird nicht in den Fehlerparametern
übertragen.

---

## Validierungsreihenfolge

Die Validierung erfolgt in dieser Reihenfolge:

1. Vorhandensein prüfen.
2. Trimmen.
3. Leeren Wert prüfen.
4. UUIDv7-Format prüfen.
5. Gültige `ProfileSecurityId` erzeugen.

Ein fehlender Wert erzeugt keinen zusätzlichen Blank- oder
Formatfehler.

Ein leerer Wert erzeugt keinen zusätzlichen Formatfehler.

---

## Verhalten von generate()

Die Factory

```text
ProfileSecurityId.generate()
```

erzeugt ausschließlich eine neue gültige UUID Version 7.

Für die technische Erzeugung darf die bereits im Projekt verwendete
UUID-Bibliothek eingesetzt werden.

Die Bibliothek ist ausschließlich ein internes technisches
Implementierungsdetail.

Typen der Bibliothek dürfen nicht Bestandteil sein von

- der öffentlichen Domain-Schnittstelle,
- `DomainResult`,
- Domain Messages,
- Fehlerparametern.

Für diese Factory werden keine Validation Errors definiert.

Ein unerwarteter technischer Generatorfehler ist kein fachlicher
Validation Error.

---

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- technische UUID-Erzeugung,
- Persistenz,
- Datenbank-Constraints,
- Repository-Konflikte,
- Verwendung als `ProfileId`,
- Verwendung als `ProfileSettingsId`,
- JSON-Serialisierung,
- Infrastrukturfehler.

Die Entity `ProfileSecurity` prüft ausschließlich,
ob eine gültige `ProfileSecurityId` vorhanden ist.

Validation Errors dieses Value Objects werden von
`ProfileSecurity` nicht erneut als Entity-Fehler erzeugt.

---

# PasswordAlgorithm

### Zugeordneter Domänentyp

**Enumeration**

- PasswordAlgorithm

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für
`PasswordAlgorithm`.

Für Version 1 ist ausschließlich folgender Wert zulässig:

```text
argon2id
```

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PALG-001 | validation.passwordAlgorithm.required | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PALG-002 | validation.passwordAlgorithm.invalid | ERROR | VALIDATION | value | enum | allowedValues |

### Parameter

#### PRO-VAL-PALG-002

```json
{
  "allowedValues": [
    "argon2id"
  ]
}
```

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-027

abgeleitet.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

## Fehlerverhalten

### Fehlender oder leerer Wert

Ist `value` nicht vorhanden oder nach dem Trimmen leer, wird ausschließlich

```text
PRO-VAL-PALG-001
```

erzeugt.

Ein zusätzlicher Enum-Fehler wird nicht erzeugt.

### Nicht unterstützter Algorithmus

Entspricht der normalisierte Wert nicht exakt `argon2id`, wird

```text
PRO-VAL-PALG-002
```

erzeugt.

Der ungültige Eingabewert wird nicht als Fehlerparameter übertragen.

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- Passwort-Hashing,
- Passwortverifikation,
- Auswahl kryptographischer Bibliotheken,
- Argon2id-Parameter,
- Migration bestehender Credentials.

---

# PasswordHash

### Zugeordneter Domänentyp

**Value Object**

- PasswordHash

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für
`PasswordHash`.

Der tatsächliche Hashwert ist ein sensibler, undurchsichtiger Wert und darf
niemals in Domain Messages oder Fehlerparametern offengelegt werden.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PHASH-001 | validation.passwordHash.required | ERROR | VALIDATION | value | required | – |
| PRO-VAL-PHASH-002 | validation.passwordHash.blank | ERROR | VALIDATION | value | blank | – |

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-028

abgeleitet.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

## Fehlerverhalten

### Fehlender Wert

Ist `value` nicht vorhanden, wird ausschließlich

```text
PRO-VAL-PHASH-001
```

erzeugt.

### Leerer Wert

Ist `value` nach dem Trimmen leer, wird ausschließlich

```text
PRO-VAL-PHASH-002
```

erzeugt.

Der tatsächliche Hashwert wird niemals als Fehlerparameter übertragen.

## Sicherheitsregel

Der Hashwert darf niemals Bestandteil sein von:

- Validation Errors,
- Business Errors,
- Information Codes,
- Domain Messages,
- Logs,
- Exceptions,
- sichtbaren `toString()`-Ausgaben.

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- Erzeugung des Hashwerts,
- Interpretation des Hashformats,
- Passwortverifikation,
- Algorithmusprüfung,
- Salt-Erzeugung.

---

# PasswordHashParameters

### Zugeordneter Domänentyp

**Value Object**

- PasswordHashParameters

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für
`PasswordHashParameters`.

Das Value Object besteht aus:

- `memoryCostKiB`,
- `iterations`,
- `parallelism`,
- `salt`.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PHPAR-001 | validation.passwordHashParameters.memoryCostKiB.required | ERROR | VALIDATION | memoryCostKiB | required | – |
| PRO-VAL-PHPAR-002 | validation.passwordHashParameters.memoryCostKiB.minimum | ERROR | VALIDATION | memoryCostKiB | minimum | minimum, actual |
| PRO-VAL-PHPAR-003 | validation.passwordHashParameters.iterations.required | ERROR | VALIDATION | iterations | required | – |
| PRO-VAL-PHPAR-004 | validation.passwordHashParameters.iterations.minimum | ERROR | VALIDATION | iterations | minimum | minimum, actual |
| PRO-VAL-PHPAR-005 | validation.passwordHashParameters.parallelism.required | ERROR | VALIDATION | parallelism | required | – |
| PRO-VAL-PHPAR-006 | validation.passwordHashParameters.parallelism.minimum | ERROR | VALIDATION | parallelism | minimum | minimum, actual |
| PRO-VAL-PHPAR-007 | validation.passwordHashParameters.salt.required | ERROR | VALIDATION | salt | required | – |
| PRO-VAL-PHPAR-008 | validation.passwordHashParameters.salt.blank | ERROR | VALIDATION | salt | blank | – |

### Parameter

#### PRO-VAL-PHPAR-002

```json
{
  "minimum": 1,
  "actual": "<value>"
}
```

#### PRO-VAL-PHPAR-004

```json
{
  "minimum": 1,
  "actual": "<value>"
}
```

#### PRO-VAL-PHPAR-006

```json
{
  "minimum": 1,
  "actual": "<value>"
}
```

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-029

abgeleitet.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

## Fehlerverhalten

### Fehlende numerische Werte

Fehlt einer der numerischen Pflichtwerte, wird ausschließlich der zugehörige
Required-Code erzeugt:

```text
PRO-VAL-PHPAR-001
PRO-VAL-PHPAR-003
PRO-VAL-PHPAR-005
```

Für denselben fehlenden Wert wird kein zusätzlicher Mindestwertfehler erzeugt.

### Ungültige numerische Werte

Ist ein numerischer Wert kleiner als `1`, wird der zugehörige Mindestwertcode
erzeugt:

```text
PRO-VAL-PHPAR-002
PRO-VAL-PHPAR-004
PRO-VAL-PHPAR-006
```

### Fehlender Salt-Wert

Ist `salt` nicht vorhanden, wird

```text
PRO-VAL-PHPAR-007
```

erzeugt.

### Leerer Salt-Wert

Ist `salt` nach dem Trimmen leer, wird

```text
PRO-VAL-PHPAR-008
```

erzeugt.

Der Salt-Wert wird niemals als Fehlerparameter übertragen.

## Sicherheitsregel

Der Salt-Wert darf niemals Bestandteil sein von:

- Validation Errors,
- Business Errors,
- Information Codes,
- Domain Messages,
- Logs,
- Exceptions,
- sichtbaren `toString()`-Ausgaben.

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- Auswahl optimaler Argon2id-Parameter,
- Salt-Erzeugung,
- Passwort-Hashing,
- Passwortverifikation,
- Migration bestehender Parameter.

---

# PasswordCredential

### Zugeordneter Domänentyp

**Value Object**

- PasswordCredential

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für
`PasswordCredential`.

Das Value Object besteht aus:

- `PasswordHash`,
- `PasswordAlgorithm`,
- `PasswordHashParameters`,
- `Timestamp`.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PCRED-001 | validation.passwordCredential.hash.required | ERROR | VALIDATION | hash | required | – |
| PRO-VAL-PCRED-002 | validation.passwordCredential.algorithm.required | ERROR | VALIDATION | algorithm | required | – |
| PRO-VAL-PCRED-003 | validation.passwordCredential.parameters.required | ERROR | VALIDATION | parameters | required | – |
| PRO-VAL-PCRED-004 | validation.passwordCredential.createdAt.required | ERROR | VALIDATION | createdAt | required | – |

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-030

abgeleitet.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

## Fehlerverhalten

### Fehlender PasswordHash

Ist `hash` nicht vorhanden, wird

```text
PRO-VAL-PCRED-001
```

erzeugt.

### Fehlender PasswordAlgorithm

Ist `algorithm` nicht vorhanden, wird

```text
PRO-VAL-PCRED-002
```

erzeugt.

### Fehlende PasswordHashParameters

Sind `parameters` nicht vorhanden, wird

```text
PRO-VAL-PCRED-003
```

erzeugt.

### Fehlender Erzeugungszeitpunkt

Ist `createdAt` nicht vorhanden, wird

```text
PRO-VAL-PCRED-004
```

erzeugt.

Mehrere fehlende Pflichtwerte dürfen gemeinsam als mehrere strukturierte
Validation Errors zurückgegeben werden.

## Keine Fehlerduplizierung

Validation Errors der enthaltenen Value Objects werden nicht zusätzlich als
`PasswordCredential`-Fehler erzeugt.

Dies betrifft insbesondere:

- `PasswordHash`,
- `PasswordAlgorithm`,
- `PasswordHashParameters`,
- `Timestamp`.

## Sicherheitsregel

Folgende Inhalte dürfen niemals Bestandteil von Fehlern oder Domain Messages
sein:

- tatsächlicher Passwort-Hash,
- Salt-Wert,
- `PlainPassword`,
- `AuthenticationProof`,
- kryptographische Schlüssel.

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- Klartextpasswörter,
- Passwort-Hashing,
- Passwortverifikation,
- Security Ports,
- Hashbibliotheken,
- Salt-Erzeugung,
- AuthenticationProof,
- Passwortänderungsregeln,
- Lockout und Rate Limiting.

---

# Timestamp

### Zugeordneter Domänentyp

**Value Object**

- Timestamp

---

## Zweck

Dieser Abschnitt definiert sämtliche Validation Error Codes des
Value Objects `Timestamp`.

Der Typ repräsentiert einen einzelnen unveränderlichen UTC-Zeitpunkt.

Chronologische Beziehungen zwischen mehreren Zeitpunkten werden nicht durch
diesen Typ geprüft.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-TS-001 | validation.timestamp.required | ERROR | VALIDATION | value | required | – |
| PRO-VAL-TS-002 | validation.timestamp.notUtc | ERROR | VALIDATION | value | utc | expectedTimezone |
| PRO-VAL-TS-003 | validation.timestamp.invalidFormat | ERROR | VALIDATION | value | format | expectedFormat |
| PRO-VAL-TS-004 | validation.timestamp.blank | ERROR | VALIDATION | value | blank | – |

### Parameter

#### PRO-VAL-TS-002

```json
{
  "expectedTimezone": "UTC"
}
```

#### PRO-VAL-TS-003

```json
{
  "expectedFormat": "ISO-8601 UTC"
}
```

---

## Herkunft

Diese Error Codes werden ausschließlich aus

- PRO-VR-031

abgeleitet.

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

---

## Fehlerverhalten

### Fehlender Wert

Ist kein Wert vorhanden,

wird ausschließlich

```text
PRO-VAL-TS-001
```

erzeugt.

Weitere Prüfungen werden nicht durchgeführt.

---

### Leerer String

Ist der String nach dem Trimmen leer,

wird ausschließlich

```text
PRO-VAL-TS-004
```

erzeugt.

Ein zusätzlicher Format- oder UTC-Fehler wird nicht erzeugt.

---

### Kein UTC-Zeitpunkt

Liegt der Zeitpunkt nicht in UTC vor,

wird

```text
PRO-VAL-TS-002
```

erzeugt.

Der tatsächliche Zeitwert wird nicht in Fehlerparametern übertragen.

---

### Ungültiges ISO-8601-Format

Ist der normalisierte String kein gültiger ISO-8601-UTC-Zeitpunkt,

wird

```text
PRO-VAL-TS-003
```

erzeugt.

Der ursprüngliche Eingabewert wird nicht in Fehlerparametern übertragen.

---

## Validierungsreihenfolge

Für `fromUtc(...)`:

1. Vorhandensein prüfen.
2. UTC prüfen.
3. `Timestamp` erzeugen.

Für `parseIso8601(...)`:

1. Vorhandensein prüfen.
2. Trimmen.
3. Leerwert prüfen.
4. ISO-8601 prüfen.
5. UTC-Kennzeichen prüfen.
6. `Timestamp` erzeugen.

Folgefehler werden nicht erzeugt.

---

## Sichere Darstellung

Die kanonische Darstellung lautet ausschließlich:

```text
YYYY-MM-DDTHH:mm:ss.SSSZ
```

---

## Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- AuditInformation,
- chronologische Vergleiche,
- Ablaufberechnungen,
- Zeitdifferenzen,
- lokale Zeitzonen,
- Sommer-/Winterzeit,
- Scheduling,
- Timer,
- technische Systemuhren.

Diese Verantwortlichkeiten liegen außerhalb des Value Objects.

---

# ProfileSecurity

### Zugeordneter Domänentyp

**Entity**

- ProfileSecurity

---

## Zweck

Dieser Abschnitt definiert sämtliche Validation Error Codes der Entity **ProfileSecurity**.

Die Entity stellt sämtliche sicherheitsrelevanten fachlichen Invarianten des Profile Aggregates sicher.

---

## Zugehörige Value Objects

- ProfileSecurityId
- PlainPassword
- PasswordCredential
- AuthenticationProof
- LockState

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PSEC-001 | validation.profileSecurity.securityId.required | ERROR | VALIDATION | securityId | required | – |
| PRO-VAL-PSEC-002 | validation.profileSecurity.securityId.invalid | ERROR | VALIDATION | securityId | invalid | – |
| PRO-VAL-PSEC-003 | validation.profileSecurity.lockState.required | ERROR | VALIDATION | lockState | required | – |
| PRO-VAL-PSEC-004 | validation.profileSecurity.passwordCredential.invalid | ERROR | VALIDATION | passwordCredential | invalid | – |
| PRO-VAL-PSEC-005 | validation.profileSecurity.lockState.requiresCredential | ERROR | VALIDATION | lockState | consistency | required=passwordCredential |
| PRO-VAL-PSEC-006 | validation.profileSecurity.incomplete | ERROR | VALIDATION | profileSecurity | completeness | requiredFields |

### Parameter

#### PRO-VAL-PSEC-005

```json
{
  "required": "passwordCredential"
}
```

#### PRO-VAL-PSEC-006

```json
{
  "requiredFields": [
    "securityId",
    "lockState"
  ]
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-024

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Fehlende ProfileSecurityId

Ist `securityId` nicht vorhanden,

wird ausschließlich

```text
PRO-VAL-PSEC-001
```

erzeugt.

#### Ungültige ProfileSecurityId

Ist `securityId` ungültig,

wird

```text
PRO-VAL-PSEC-002
```

erzeugt.

#### Fehlender LockState

Ist `lockState` nicht vorhanden,

wird ausschließlich

```text
PRO-VAL-PSEC-003
```

erzeugt.

#### Ungültiges PasswordCredential

Ist ein `PasswordCredential` vorhanden, aber ungültig,

wird

```text
PRO-VAL-PSEC-004
```

erzeugt.

#### Gesperrter Zustand ohne Credential

Ist das Profil gesperrt und gleichzeitig kein
`PasswordCredential` vorhanden,

wird

```text
PRO-VAL-PSEC-005
```

erzeugt.

#### Unvollständiger Sicherheitszustand

Fehlt mindestens einer der Pflichtbestandteile,

kann zusätzlich

```text
PRO-VAL-PSEC-006
```

erzeugt werden,

sofern nicht bereits ein eindeutiger Pflichtfeldfehler den Zustand
vollständig beschreibt.

### Hinweise

Die kontrollierte initiale Erzeugung und die Rekonstruktion erfolgen
ausschließlich über:

```text
DomainResult<ProfileSecurity> ProfileSecurity.create(
  ProfileSecurityId? securityId,
  PasswordCredential? passwordCredential,
  LockState? lockState
)

`ProfileSecurity` validiert ausschließlich den vollständigen
fachlichen Sicherheitszustand.

Die Detailvalidierung erfolgt ausschließlich über

- `ProfileSecurityId`
- `PasswordCredential`
- `LockState`

sowie die zugehörigen Validation Rules.

Fehler dieser Value Objects werden nicht erneut als
`ProfileSecurity`-Fehler erzeugt.

Dadurch werden doppelte Fehlermeldungen vermieden.

### Abgrenzung

Nicht Bestandteil dieses Abschnitts sind:

- AuthenticationProof,
- Authentifizierung,
- Passwortprüfung,
- Passwortstärke,
- Kryptographie,
- Hashverfahren,
- technische Security Ports,
- Business Errors,
- No-Change-Ergebnisse.

Diese Verantwortlichkeiten werden in den Business Rules und den
zugehörigen technischen Komponenten beschrieben.

Ein erfolgreicher No-Change ist kein Validation Error.

---

# PlainPassword

### Zugeordneter Domänentyp

**Value Object**

- PlainPassword

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für ein vom Benutzer
eingegebenes Passwort vor dessen kryptographischer Verarbeitung.

`PlainPassword` ist ausschließlich ein kurzlebiger fachlicher Eingabewert.

Es darf weder dauerhaft gespeichert noch protokolliert oder Bestandteil
eines Audit-Eintrags werden.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PWD-001 | validation.profile.password.required | ERROR | VALIDATION | password | required | – |
| PRO-VAL-PWD-002 | validation.profile.password.minLength | ERROR | VALIDATION | password | minimum | minimum, unit |
| PRO-VAL-PWD-003 | validation.profile.password.blank | ERROR | VALIDATION | password | blank | – |
| PRO-VAL-PWD-004 | validation.profile.password.equalsProfileName | ERROR | VALIDATION | password | forbidden | – |

### Parameter

#### PRO-VAL-PWD-002

```json
{
  "minimum": 12,
  "unit": "characters"
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-006

Neue fachliche Validierungsregeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Fehlendes Passwort

Ist kein Passwort vorhanden, wird

```text
PRO-VAL-PWD-001
```

erzeugt.

Weitere inhaltliche Prüfungen werden in diesem Fall nicht ausgeführt.

#### Mindestlänge unterschritten

Enthält das Passwort weniger als zwölf Zeichen, wird

```text
PRO-VAL-PWD-002
```

erzeugt.

#### Passwort besteht ausschließlich aus Leerzeichen

Besteht das Passwort ausschließlich aus Leerzeichen, wird

```text
PRO-VAL-PWD-003
```

erzeugt.

#### Passwort entspricht dem Profilnamen

Entspricht das Passwort dem Profilnamen, wird

```text
PRO-VAL-PWD-004
```

erzeugt.

### Abgrenzung

Die folgenden bisherigen Katalogeinträge entfallen:

```text
validation.password.maximumLength
validation.password.tooWeak
```

Für diese Sachverhalte existieren in der aktuellen Validation Rule
`PRO-VR-006` keine Error Codes.

Technische Anforderungen wie

- Passwortkomplexität,
- Passwort-Historie,
- Blacklists,
- kompromittierte Passwörter,
- kryptographische Verarbeitung

werden nicht durch diesen Abschnitt definiert.

Sie gehören ausschließlich in den Security Guide beziehungsweise die
zuständigen technischen Sicherheitskomponenten.

### Datenschutz

Weder der Passwortwert noch Teile des Passworts dürfen in

- Parameters,
- Logs,
- Monitoring,
- Audit-Daten,
- Domain Events

übertragen werden.

---

# PasswordConfirmation

### Zugeordneter Domänentyp

**Eingabewert**

- PasswordConfirmation

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für die Bestätigung
eines neu eingegebenen Passworts.

`PasswordConfirmation` dient ausschließlich der Prüfung, ob die
Passwortbestätigung mit dem neu eingegebenen Passwort übereinstimmt.

Es handelt sich nicht um ein persistiertes Value Object.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-PWDCONF-001 | validation.profile.passwordConfirmation.required | ERROR | VALIDATION | passwordConfirmation | required | – |
| PRO-VAL-PWDCONF-002 | validation.profile.passwordConfirmation.mismatch | ERROR | VALIDATION | passwordConfirmation | equals | referenceField |

### Parameter

#### PRO-VAL-PWDCONF-002

```json
{
  "referenceField": "password"
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-007

Neue fachliche Validierungsregeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Fehlende Passwortbestätigung

Ist keine Passwortbestätigung vorhanden,

wird

```text
PRO-VAL-PWDCONF-001
```

erzeugt.

Weitere Vergleichsprüfungen erfolgen nicht.

#### Passwortbestätigung stimmt nicht überein

Entspricht die Passwortbestätigung nicht dem eingegebenen Passwort,

wird

```text
PRO-VAL-PWDCONF-002
```

erzeugt.

### Abgrenzung

Dieser Abschnitt prüft ausschließlich die Übereinstimmung zwischen

- Passwort
- Passwortbestätigung.

Die Qualität oder Gültigkeit des Passworts selbst wird ausschließlich durch

```text
PlainPassword
```

validiert.

### Datenschutz

Der Wert der Passwortbestätigung darf nicht in

- Logs,
- Audit-Daten,
- Domain Events,
- Parameters

übernommen werden.

---

# CurrentPassword

### Zugeordneter Domänentyp

**Eingabewert**

- CurrentPassword

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für das aktuelle
Passwort, das zur Bestätigung sicherheitsrelevanter Profiloperationen
angegeben wird.

`CurrentPassword` ist kein persistierter Domänenzustand.

Der Eingabewert dient ausschließlich der Authentifizierung für Operationen
wie

- Passwort ändern,
- Passwortschutz deaktivieren,
- geschütztes Profil entsperren.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-CURPWD-001 | validation.profile.currentPassword.required | ERROR | VALIDATION | currentPassword | required | – |
| PRO-VAL-CURPWD-002 | validation.profile.currentPassword.invalid | ERROR | VALIDATION | currentPassword | valid | – |

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-008

Neue fachliche Validierungs- oder Sicherheitsregeln werden in diesem
Dokument nicht definiert.

### Fehlerverhalten

#### Fehlendes aktuelles Passwort

Ist kein aktuelles Passwort vorhanden, wird

```text
PRO-VAL-CURPWD-001
```

erzeugt.

Eine Verifikation wird in diesem Fall nicht durchgeführt.

#### Ungültiges aktuelles Passwort

Kann das angegebene aktuelle Passwort nicht erfolgreich verifiziert werden,
wird

```text
PRO-VAL-CURPWD-002
```

erzeugt.

Der Fehler darf keine Informationen darüber offenlegen,

- welcher Teil der Eingabe falsch war,
- wie das gespeicherte Credential aufgebaut ist,
- welche kryptographischen Parameter verwendet werden.

### Abgrenzung

Dieser Abschnitt definiert ausschließlich die strukturierten
Validierungsergebnisse für das aktuelle Passwort.

Nicht Bestandteil dieses Abschnitts sind:

- technische Passwortverifikation,
- Hashverfahren,
- Credential-Erzeugung,
- `AuthenticationProof`,
- Autorisierung,
- Lockout- oder Rate-Limiting-Regeln.

Diese Verantwortlichkeiten werden durch den Security Guide und die
zuständigen Sicherheitsports geregelt.

### Datenschutz

Das aktuelle Passwort darf niemals Bestandteil sein von

- Parameters,
- Logs,
- Audit-Daten,
- Domain Events,
- Monitoringdaten,
- Fehlermeldungen.

---

# PasswordCredential

### Zugeordneter Domänentyp

**Value Object**

- PasswordCredential

## Zweck

Dieses Value Object repräsentiert die fachlichen Passwortinformationen eines Benutzerprofils.

---

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.passwordCredential.invalid | validation.passwordCredential.invalid |

---

# AuthenticationProof

### Zugeordneter Domänentyp

**Value Object**

- AuthenticationProof

## Zweck

Dieses Value Object beschreibt den Nachweis einer erfolgreichen Authentifizierung.

---

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.authenticationProof.invalid | validation.authenticationProof.invalid |

---

# LockState

### Zugeordneter Domänentyp

**Value Object**

- LockState

## Zweck

Dieses Value Object beschreibt den Sperrstatus eines Profils.

---

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.lockState.invalid | validation.lockState.invalid |

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5B-1b-1c – Core Validation Codes (Profile Value Objects)

## Zweck

Dieses Kapitel definiert sämtliche Validation Error Codes der verbleibenden
Value Objects des **Profile Aggregates**.

Die allgemeinen Regeln des Validation Frameworks werden ausschließlich
in Kapitel **5B-1a** definiert.

---

# ProfileImage

### Zugeordneter Domänentyp

**Value Object**

- ProfileImage

## Zugehörige Value Objects

- ImageReference
- ImageDimensions
- ImageChecksum

## Zweck

Dieser Abschnitt definiert die Validation Error Codes für die fachliche
Validierung eines Profilbilds.

Ein Profilbild ist optional.

Ist ein Profilbild vorhanden, muss es vollständig den Anforderungen aus
`PRO-VR-010` entsprechen.

---

## Error Codes

| ErrorCode | MessageKey | Severity | Category | Field | Constraint | Parameters |
|------------|------------|----------|----------|-------|------------|------------|
| PRO-VAL-IMG-001 | validation.profile.image.invalidFormat | ERROR | VALIDATION | image | format | supportedFormats |
| PRO-VAL-IMG-002 | validation.profile.image.notReadable | ERROR | VALIDATION | image | readable | – |
| PRO-VAL-IMG-003 | validation.profile.image.tooLarge | ERROR | VALIDATION | image | maximum | maxSizeBytes |
| PRO-VAL-IMG-004 | validation.profile.image.processingFailed | ERROR | VALIDATION | image | processing | – |

### Parameter

#### PRO-VAL-IMG-001

```json
{
  "supportedFormats": [
    "JPEG",
    "PNG",
    "WebP"
  ]
}
```

#### PRO-VAL-IMG-003

```json
{
  "maxSizeBytes": 2097152
}
```

### Herkunft

Diese Error Codes werden ausschließlich aus folgender Validation Rule
übernommen:

- PRO-VR-010

Neue fachliche Validierungsregeln werden in diesem Dokument nicht definiert.

### Fehlerverhalten

#### Ungültiges Bildformat

Besitzt das Profilbild kein unterstütztes Format, wird

```text
PRO-VAL-IMG-001
```

erzeugt.

Die unterstützten Formate werden über den Parameter `supportedFormats`
übertragen.

#### Profilbild nicht lesbar

Kann das Profilbild nicht als gültige Bilddatei gelesen werden, wird

```text
PRO-VAL-IMG-002
```

erzeugt.

#### Maximale Dateigröße überschritten

Überschreitet das Profilbild die maximale Dateigröße von zwei Megabyte, wird

```text
PRO-VAL-IMG-003
```

erzeugt.

Die maximale Dateigröße wird in Bytes über den Parameter `maxSizeBytes`
übertragen.

#### Bildverarbeitung fehlgeschlagen

Kann die vorgeschriebene Verarbeitung des Profilbilds nicht erfolgreich
abgeschlossen werden, wird

```text
PRO-VAL-IMG-004
```

erzeugt.

### Datenschutz

Ein Profilbild muss vor der dauerhaften Übernahme gemäß den fachlichen
Vorgaben verarbeitet werden.

Insbesondere dürfen keine

- EXIF-Metadaten,
- Standortinformationen,
- Bildbinärdaten

in Fehlerparametern, Logs oder Domain Messages enthalten sein.

### Abgrenzung

Das Fehlen eines Profilbilds ist kein Validation Error.

Daher existiert kein Error Code für ein erforderliches Profilbild.

Die bisherigen generischen Einträge

```text
validation.profileImage.required
validation.profileImage.invalid
```

entfallen vollständig.

Die Detailvalidierung der enthaltenen Value Objects

- `ImageReference`,
- `ImageDimensions`,
- `ImageChecksum`

wird nicht durch generische `ProfileImage`-Fehler dupliziert.

---

# ImageReference

### Zugeordneter Domänentyp

**Value Object**

- ImageReference

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.imageReference.required | validation.imageReference.required |
| validation.imageReference.invalid | validation.imageReference.invalid |

---

# ImageDimensions

### Zugeordneter Domänentyp

**Value Object**

- ImageDimensions

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.imageDimensions.invalid | validation.imageDimensions.invalid |

---

# ImageChecksum

### Zugeordneter Domänentyp

**Value Object**

- ImageChecksum

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.imageChecksum.invalid | validation.imageChecksum.invalid |

---

# ProfileName

### Zugeordneter Domänentyp

**Value Object**

- ProfileName

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| PRO-VAL-NAME-001 | validation.profile.name.required |
| PRO-VAL-NAME-002 | validation.profile.name.blank |

---

# BirthYear

### Zugeordneter Domänentyp

**Value Object**

- BirthYear

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| PRO-VAL-BIRTHYEAR-001 | validation.profile.birthYear.required |
| PRO-VAL-BIRTHYEAR-002 | validation.profile.birthYear.format |
| PRO-VAL-BIRTHYEAR-003 | validation.profile.birthYear.minimum |
| PRO-VAL-BIRTHYEAR-004 | validation.profile.birthYear.future |

---

# Height

### Zugeordneter Domänentyp

**Value Object**

- Height

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| PRO-VAL-HEIGHT-001 | validation.profile.height.required |
| PRO-VAL-HEIGHT-002 | validation.profile.height.maximum |
| PRO-VAL-HEIGHT-003 | validation.profile.height.minimum |

---

# Gender

### Zugeordneter Domänentyp

**Enumeration**

- Gender

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| PRO-VAL-GENDER-001 | validation.profile.gender.invalid |

---

# ProfileColor

### Zugeordneter Domänentyp

**Value Object**

- ProfileColor

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| PRO-VAL-COLOR-001 | validation.profile.color.required |
| PRO-VAL-COLOR-002 | validation.profile.color.invalid |

---

# ProfileId

### Zugeordneter Domänentyp

**Value Object**

- ProfileId

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| PRO-VAL-ID-001 | validation.profile.id.required |
| PRO-VAL-ID-002 | validation.profile.id.invalidFormat |
| PRO-VAL-ID-003 | validation.profile.id.modified |
| PRO-VAL-ID-004 | validation.profile.id.duplicate |

---

# DefaultProfileFlag

### Zugeordneter Domänentyp

**Value Object**

- DefaultProfileFlag

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.defaultProfileFlag.invalid | validation.defaultProfileFlag.invalid |

---

# AuditInformation

### Zugeordneter Domänentyp

**Value Object**

- AuditInformation

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.auditInformation.invalid | validation.auditInformation.invalid |

---

# Timestamp

### Zugeordneter Domänentyp

**Value Object**

- Timestamp

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.timestamp.required | validation.timestamp.required |
| validation.timestamp.invalid | validation.timestamp.invalid |
| validation.timestamp.future | validation.timestamp.future |

---

# AggregateVersion

### Zugeordneter Domänentyp

**Value Object**

- AggregateVersion

## Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| validation.aggregateVersion.invalid | validation.aggregateVersion.invalid |

---

# Status dieses Abschnitts

Dieses Kapitel definiert ausschließlich die Validation Error Codes
der verbleibenden Value Objects des Profile Aggregates.

Technische Fehler,
Persistenzfehler,
Security Errors,
Infrastructure Errors
und Business Rule Errors
werden in späteren Kapiteln beschrieben.

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5B-1b-2 – Aggregate Validation

## Zweck

Dieses Kapitel definiert Validation Errors,

die nicht einem einzelnen Domänenobjekt zugeordnet werden können,

sondern ausschließlich die Konsistenz des gesamten **Profile Aggregates**
betreffen.

Diese Validation Errors prüfen Beziehungen zwischen mehreren Entities,
Value Objects oder Aggregatebestandteilen.

Sie ergänzen die objektbezogenen Validation Errors aus Kapitel **5B-1b-1**.

---

# Architekturregel

Aggregate Validation überprüft ausschließlich Invarianten,

die mehrere Domänenobjekte gleichzeitig betreffen.

Validation Errors eines einzelnen Domänenobjekts
werden ausschließlich in Kapitel **5B-1b-1**
dokumentiert.

---

# Aggregate Root

## Profile

### Zweck

Die Aggregate Root stellt sicher,

dass sämtliche enthaltenen Entities und Value Objects
gemeinsam einen fachlich gültigen Zustand bilden.

---

## Aggregate Validation Errors

| ErrorCode | MessageKey |
|------------|------------|
| validation.profile.aggregate.invalid | validation.profile.aggregate.invalid |
| validation.profile.aggregate.inconsistent | validation.profile.aggregate.inconsistent |
| validation.profile.aggregate.incomplete | validation.profile.aggregate.incomplete |

---

# Cross Object Validation

## Zweck

Cross Object Validation überprüft fachliche Beziehungen
zwischen mehreren Domänenobjekten.

Die Validierung erfolgt immer auf Aggregate-Ebene.

---

## Profile ↔ ProfileSettings

### Beispiele

| ErrorCode | MessageKey |
|------------|------------|
| validation.profile.settings.required | validation.profile.settings.required |
| validation.profile.settings.inconsistent | validation.profile.settings.inconsistent |

---

## Profile ↔ ProfileSecurity

### Beispiele

| ErrorCode | MessageKey |
|------------|------------|
| validation.profile.security.required | validation.profile.security.required |
| validation.profile.security.inconsistent | validation.profile.security.inconsistent |

---

## Profile ↔ ProfileImage

### Beispiele

| ErrorCode | MessageKey |
|------------|------------|
| validation.profile.image.required | validation.profile.image.required |
| validation.profile.image.inconsistent | validation.profile.image.inconsistent |

---

## ProfileSettings ↔ LocalizationSettings

### Beispiele

| ErrorCode | MessageKey |
|------------|------------|
| validation.localization.configuration.invalid | validation.localization.configuration.invalid |

---

## ProfileSettings ↔ DashboardSettings

### Beispiele

| ErrorCode | MessageKey |
|------------|------------|
| validation.dashboard.configuration.invalid | validation.dashboard.configuration.invalid |

---

## ProfileSettings ↔ AppearanceSettings

### Beispiele

| ErrorCode | MessageKey |
|------------|------------|
| validation.appearance.configuration.invalid | validation.appearance.configuration.invalid |

---

# Validierungsreihenfolge

Aggregate Validation wird ausschließlich ausgeführt,

nachdem

- sämtliche Entities
- sämtliche Value Objects

erfolgreich validiert wurden.

Existieren bereits objektbezogene Validation Errors,

wird Aggregate Validation nicht mehr ausgeführt.

Dadurch werden Folgefehler vermieden.

---

# Beziehung zu Business Rules

Aggregate Validation prüft ausschließlich

fachliche Konsistenzregeln innerhalb eines Aggregates.

Komplexe Geschäftsregeln,

die Domänenvorgänge oder mehrere Aggregate betreffen,

werden ausschließlich als **Business Rule Errors**
in Kapitel **5B-2**
behandelt.

---

# Beziehung zu Domain Events

Nur ein erfolgreich validiertes Aggregate

darf Domain Events erzeugen.

Aggregate Validation Errors verhindern
die Erzeugung sämtlicher Domain Events
des betroffenen Aggregates.

---

# Status dieses Abschnitts

Dieses Kapitel definiert ausschließlich

Aggregate Validation.

Objektbezogene Validation Errors
werden in Kapitel **5B-1b-1**

Business Rule Errors
werden in Kapitel **5B-2**

Infrastructure Errors
werden in Kapitel **5C**

dokumentiert.

# Teil 5B-2 – Business Rule Errors

## Zweck

Dieses Kapitel definiert sämtliche Business Rule Errors der Domäne.

Business Rule Errors beschreiben Verletzungen fachlicher Geschäftsregeln,
die nach erfolgreicher Validierung einzelner Domänenobjekte und Aggregate
auftreten können.

Validation Errors werden ausschließlich in Kapitel **5B-1**
behandelt.

---

# Architekturregel

Business Rule Errors

- beschreiben ausschließlich fachliche Regelverletzungen,
- sind unabhängig von UI,
- sind unabhängig von Persistenz,
- sind unabhängig von Infrastruktur,
- sind unabhängig von Integrationen.

Sie werden ausschließlich innerhalb der Domäne definiert.

---

# Präfix

Alle Business Rule Errors verwenden ausschließlich das Präfix

```text
business.
```

Beispiele

```text
business.profile.default.alreadyExists

business.profile.security.locked

business.profile.delete.notAllowed
```

---

# Profile Aggregate

## DefaultProfile

### Fachliche Regel

Innerhalb des Systems darf genau ein Standardprofil existieren.

### Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| business.profile.default.alreadyExists | business.profile.default.alreadyExists |
| business.profile.default.required | business.profile.default.required |

---

## ProfileSecurity

### Zweck

Dieser Abschnitt definiert die Business Errors der fachlichen Operationen
von `ProfileSecurity`.

Die Codes werden ausschließlich aus folgenden Business Rules abgeleitet:

- PRO-BR-028
- PRO-BR-029
- PRO-BR-030
- PRO-BR-031

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

### Error Codes

| ErrorCode | MessageKey | Severity | Category | Operation | Field | Constraint | Parameters |
|------------|------------|----------|----------|-----------|-------|------------|------------|
| PRO-BUS-PSEC-001 | business.profileSecurity.passwordProtection.alreadyEnabled | ERROR | BUSINESS | enablePasswordProtection | passwordCredential | transition | – |
| PRO-BUS-PSEC-002 | business.profileSecurity.lock.requiresCredential | ERROR | BUSINESS | lock | passwordCredential | required | – |
| PRO-BUS-PSEC-003 | business.profileSecurity.changePassword.requiresCredential | ERROR | BUSINESS | changePasswordCredential | passwordCredential | required | – |

### PRO-BUS-PSEC-001

Der Passwortschutz ist bereits aktiviert.

Ein erneutes Aktivieren ist fachlich unzulässig.

Der bestehende Zustand bleibt vollständig unverändert.

### PRO-BUS-PSEC-002

Ein Profil ohne vorhandenes `PasswordCredential` darf nicht gesperrt werden.

Der bestehende Zustand bleibt vollständig unverändert.

### PRO-BUS-PSEC-003

Ein Passwort kann nur geändert werden, wenn bereits ein
`PasswordCredential` vorhanden ist.

Der bestehende Zustand bleibt vollständig unverändert.

### Abgrenzung

Die folgenden Situationen sind keine Business Errors:

- Passwortschutz ist bereits deaktiviert,
- Profil ist bereits gesperrt,
- Profil ist bereits entsperrt,
- Profil besitzt beim Entsperren kein Credential,
- neues Credential entspricht dem vorhandenen Credential.

Diese Situationen sind erfolgreiche No-Change-Ergebnisse und werden getrennt
als `DomainInformation` dokumentiert.

Validation Errors werden ausschließlich in Teil 5B-1 behandelt.

---

## ProfileImage

### Fachliche Regel

Ein Profilbild muss den fachlichen Vorgaben des Systems entsprechen.

### Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| business.profile.image.notAllowed | business.profile.image.notAllowed |

---

# Zustandsübergänge

Business Rule Errors können ebenfalls entstehen,
wenn ein fachlich unzulässiger Zustandswechsel angefordert wird.

## Beispiele

| ErrorCode | MessageKey |
|------------|------------|
| business.profile.state.invalidTransition | business.profile.state.invalidTransition |
| business.profile.delete.notAllowed | business.profile.delete.notAllowed |
| business.profile.activate.notAllowed | business.profile.activate.notAllowed |
| business.profile.deactivate.notAllowed | business.profile.deactivate.notAllowed |

---

# Beziehung zu Validation Errors

Business Rule Errors werden ausschließlich ausgeführt,

nachdem

- alle Value Objects,
- alle Entities,
- das Aggregate

erfolgreich validiert wurden.

Existieren Validation Errors,

werden Business Rules nicht mehr ausgeführt.

---

# Beziehung zu Domain Events

Business Rule Errors verhindern die Veröffentlichung sämtlicher
Domain Events des betroffenen Aggregates.

Erst nach erfolgreicher Ausführung aller Business Rules
dürfen Domain Events erzeugt werden.

---

# Erweiterbarkeit

Jedes Aggregate besitzt einen eigenen Abschnitt
für Business Rule Errors.

Neue Aggregate ergänzen ausschließlich neue Kapitel.

Bereits veröffentlichte Business Rule Errors
werden fachlich nicht umdefiniert.

---

# Status dieses Abschnitts

Dieses Kapitel definiert ausschließlich Business Rule Errors.

Die projektweite Fehlerklassifikation lautet:

| Fehlerklasse | Präfix |
|--------------|---------|
| Validation | `validation.` |
| Business Rules | `business.` |
| Security | `security.` |
| Infrastructure | `infrastructure.` |
| Integration | `integration.` |
| Persistence | `persistence.` |

Diese Präfixe gelten projektweit
für sämtliche Module der Health-Tracker-Anwendung.

---

# Teil 5B-3 – Domain Information Codes

## Zweck

Dieses Kapitel definiert stabile Codes für erfolgreiche fachliche
Operationen ohne Zustandsänderung.

Ein No-Change-Ergebnis

- ist erfolgreich,
- enthält keinen `DomainError`,
- enthält mindestens eine `DomainInformation`,
- verändert den fachlichen Zustand nicht,
- verändert keine Auditinformationen,
- erhöht keine Aggregate-Version,
- erzeugt kein Änderungs-Domain-Event.

Die allgemeinen Regeln für No-Change-Ergebnisse werden ausschließlich in
Teil 2 dieses Dokuments definiert.

---

# ProfileSettings

## Herkunft

Die No-Change-Informationen werden aus den im Domain Model definierten
Operationen von `ProfileSettings` abgeleitet.

Sie gelten für:

- `changeLanguage(...)`,
- `changeMeasurementSystem(...)`,
- `changeDashboardSettings(...)`,
- `changeAppearanceSettings(...)`,
- `resetToDefaults(...)`.

## Information Codes

| ErrorCode | MessageKey | Severity | Category | Operation | Field | Constraint | Parameters |
|------------|------------|----------|----------|-----------|-------|------------|------------|
| PRO-INF-PSET-001 | information.profileSettings.noChange | INFORMATION | BUSINESS | aktuelle Operation | – | – | operation |

### Parameter

```json
{
  "operation": "<operationName>"
}
```

Zulässige Werte für `operation` sind:

```text
changeLanguage
changeMeasurementSystem
changeDashboardSettings
changeAppearanceSettings
resetToDefaults
```

### Verhalten

`PRO-INF-PSET-001` wird verwendet, wenn der angeforderte vollständige
Zielzustand fachlich bereits dem aktuellen Zustand entspricht.

Das erfolgreiche `DomainResult<ProfileSettings>` enthält den unveränderten
gültigen Zustand.

---

# ProfileSecurity – Information Codes

## Herkunft

Die Information Codes werden ausschließlich aus folgenden Business Rules
abgeleitet:

- PRO-BR-028
- PRO-BR-029
- PRO-BR-030
- PRO-BR-031

Neue fachliche Regeln werden in diesem Dokument nicht definiert.

## Information Codes

| ErrorCode | MessageKey | Severity | Category | Operation | Field | Constraint | Parameters |
|------------|------------|----------|----------|-----------|-------|------------|------------|
| PRO-INF-PSEC-001 | information.profileSecurity.passwordProtection.alreadyDisabled | INFORMATION | BUSINESS | disablePasswordProtection | – | – | operation |
| PRO-INF-PSEC-002 | information.profileSecurity.credential.unchanged | INFORMATION | BUSINESS | changePasswordCredential | – | – | operation |
| PRO-INF-PSEC-003 | information.profileSecurity.alreadyLocked | INFORMATION | BUSINESS | lock | – | – | operation |
| PRO-INF-PSEC-004 | information.profileSecurity.alreadyUnlocked | INFORMATION | BUSINESS | unlock | – | – | operation |

### Parameter

Alle Information Codes dieses Abschnitts verwenden:

```json
{
  "operation": "<operationName>"
}
```

---

## PRO-INF-PSEC-001

Der Passwortschutz ist bereits deaktiviert.

`disablePasswordProtection(...)` liefert einen erfolgreichen No Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## PRO-INF-PSEC-002

Das neue `PasswordCredential` entspricht fachlich bereits dem vorhandenen
Credential.

`changePasswordCredential(...)` liefert einen erfolgreichen No Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## PRO-INF-PSEC-003

Das Profil ist bereits gesperrt.

`lock(...)` liefert einen erfolgreichen No Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## PRO-INF-PSEC-004

Das Profil ist fachlich bereits entsperrt.

Dieser Code wird verwendet, wenn

- das Profil bereits entsperrt ist,
- oder kein `PasswordCredential` vorhanden ist und das Profil deshalb
  fachlich nicht gesperrt sein kann.

`unlock(...)` liefert einen erfolgreichen No Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

# Gemeinsame Regeln

Für sämtliche Information Codes dieses Kapitels gilt:

- Severity ist `INFORMATION`.
- Category ist `BUSINESS`.
- Es ist kein Feld von einem Fehler betroffen.
- Es liegt keine Constraint-Verletzung vor.
- Das Ergebnis bleibt erfolgreich.
- Der aktuelle gültige Zustand wird unverändert zurückgegeben.
- Es werden keine Auditinformationen aktualisiert.
- Die Aggregate-Version wird nicht erhöht.
- Es wird kein Änderungs-Domain-Event erzeugt.
- Information Codes dürfen nicht als Business Errors behandelt werden.
- Message Keys dürfen nicht zur Steuerung der Fachlogik verwendet werden.

---

# Status dieses Abschnitts

Mit Teil **5B-3** sind die No-Change-Informationen für

- `ProfileSettings`,
- `ProfileSecurity`

vollständig definiert.

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5C – Security, Infrastructure, Persistence und Integration Errors

## Zweck

Dieses Kapitel definiert sämtliche technischen Fehlerklassen
außerhalb der Domäne.

Diese Fehler entstehen nicht durch fachliche Validierung
oder Business Rules,

sondern durch technische Komponenten
der Anwendung.

---

# Architekturregel

Technische Fehler

- besitzen keine fachliche Bedeutung,
- verändern keine Business Rules,
- verändern keine Aggregate,
- dürfen niemals Business Rule Errors ersetzen.

Technische Fehler werden ausschließlich
außerhalb der Domäne erzeugt.

---

# Fehlerklassifikation

| Fehlerklasse | Präfix |
|--------------|---------|
| Security | `security.` |
| Infrastructure | `infrastructure.` |
| Persistence | `persistence.` |
| Integration | `integration.` |

---

# Security Errors

## Zweck

Security Errors beschreiben technische Sicherheitsfehler.

Sie entstehen beispielsweise

- während der Authentifizierung,
- bei der Autorisierung,
- während kryptographischer Operationen,
- oder bei Sicherheitsrichtlinien.

### Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| security.authentication.failed | security.authentication.failed |
| security.authentication.expired | security.authentication.expired |
| security.authorization.denied | security.authorization.denied |
| security.password.hash.failed | security.password.hash.failed |
| security.password.verification.failed | security.password.verification.failed |
| security.encryption.failed | security.encryption.failed |
| security.decryption.failed | security.decryption.failed |
| security.token.invalid | security.token.invalid |
| security.token.expired | security.token.expired |

---

# Infrastructure Errors

## Zweck

Infrastructure Errors beschreiben Fehler
der technischen Infrastruktur.

### Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| infrastructure.configuration.invalid | infrastructure.configuration.invalid |
| infrastructure.configuration.missing | infrastructure.configuration.missing |
| infrastructure.file.notFound | infrastructure.file.notFound |
| infrastructure.file.accessDenied | infrastructure.file.accessDenied |
| infrastructure.io.failed | infrastructure.io.failed |
| infrastructure.network.unavailable | infrastructure.network.unavailable |
| infrastructure.timeout | infrastructure.timeout |

---

# Persistence Errors

## Zweck

Persistence Errors beschreiben Fehler
beim Speichern oder Laden
fachlicher Daten.

### Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| persistence.database.failed | persistence.database.failed |
| persistence.transaction.failed | persistence.transaction.failed |
| persistence.optimisticLock.failed | persistence.optimisticLock.failed |
| persistence.constraint.failed | persistence.constraint.failed |
| persistence.record.notFound | persistence.record.notFound |
| persistence.record.alreadyExists | persistence.record.alreadyExists |

---

# Integration Errors

## Zweck

Integration Errors entstehen
bei der Kommunikation
mit externen Systemen.

Hierzu gehören beispielsweise

- Health Connect
- Apple Health
- Google Fit
- Smartwatches
- Cloud Services
- Backup Services

### Error Codes

| ErrorCode | MessageKey |
|------------|------------|
| integration.healthConnect.unavailable | integration.healthConnect.unavailable |
| integration.healthConnect.permissionDenied | integration.healthConnect.permissionDenied |
| integration.appleHealth.unavailable | integration.appleHealth.unavailable |
| integration.googleFit.unavailable | integration.googleFit.unavailable |
| integration.device.notConnected | integration.device.notConnected |
| integration.device.timeout | integration.device.timeout |
| integration.backup.failed | integration.backup.failed |
| integration.import.failed | integration.import.failed |
| integration.export.failed | integration.export.failed |

---

# Recovery-Strategien

Die Recovery-Strategie wird pro Fehlerklasse definiert.

| Fehlerklasse | Retry | Fallback | Logging | Benutzerinformation |
|--------------|:----:|:--------:|:-------:|:-------------------:|
| Security | ❌ | ❌ | ✅ | ✅ |
| Infrastructure | ✅ | ✅ | ✅ | Optional |
| Persistence | Bedingt | ❌ | ✅ | ✅ |
| Integration | ✅ | ✅ | ✅ | Optional |

## Regeln

- Security Errors dürfen niemals automatisch wiederholt werden.
- Infrastructure Errors dürfen automatische Retry-Strategien verwenden.
- Persistence Errors dürfen ausschließlich bei transienten Fehlern wiederholt werden.
- Integration Errors dürfen Retry- und Fallback-Strategien verwenden, sofern dies fachlich zulässig ist.

---

# Exception-Zuordnung

Die technische Implementierung verwendet pro Fehlerklasse genau eine abstrakte Basisklasse.

| Fehlerklasse | Basisklasse |
|--------------|-------------|
| Security | `SecurityException` |
| Infrastructure | `InfrastructureException` |
| Persistence | `PersistenceException` |
| Integration | `IntegrationException` |

Konkrete Implementierungen dürfen von diesen Basisklassen ableiten.

Die Domäne besitzt keine Abhängigkeit zu diesen technischen Exceptions.

---

# Beziehung zur Domäne

Technische Fehler

- dürfen Aggregate nicht verändern,
- dürfen Business Rules nicht umgehen,
- dürfen Validation nicht überspringen.

Sie werden ausschließlich
an den Infrastrukturgrenzen behandelt.

---

# Beziehung zu Domain Events

Technische Fehler erzeugen keine Domain Events.

Sie können jedoch verhindern,
dass eine Anwendung erfolgreich abgeschlossen wird.

Domain Events entstehen ausschließlich
innerhalb der Domäne.

---

# Erweiterbarkeit

Neue technische Komponenten ergänzen ausschließlich neue Error Codes innerhalb ihrer Fehlerklasse.

Neue Fehlerklassen dürfen nur eingeführt werden,
wenn sie architektonisch eindeutig von den bestehenden Klassen abgegrenzt werden können.

---

# Status dieses Abschnitts

Dieses Kapitel definiert ausschließlich

- Security Errors
- Infrastructure Errors
- Persistence Errors
- Integration Errors

Validation Errors werden in Kapitel **5B-1**

Business Rule Errors in Kapitel **5B-2**

Governance-Regeln in Kapitel **5D**

beschrieben.

# 06_ERROR_HANDLING_GUIDE.md

# Teil 5D – Governance und Lebenszyklus des Fehlerkatalogs

## Zweck

Dieses Kapitel definiert die projektweiten Regeln
für Verwaltung, Erweiterung, Versionierung
und Qualitätssicherung des Error Handling Guides.

Ziel ist ein langfristig konsistenter,
stabiler und nachvollziehbarer Fehlerkatalog
für sämtliche Module der Anwendung.

---

# Architekturprinzipien

Der Error Handling Guide folgt den Prinzipien

- Domain-Driven Design
- Clean Architecture
- SOLID
- Single Source of Truth

Der Fehlerkatalog wird ausschließlich
aus dem Domain Model abgeleitet.

---

# Single Source of Truth

Das Dokument

```text
05_DOMAIN_MODEL.md
```

definiert sämtliche

- Aggregate
- Aggregate Roots
- Entities
- Value Objects
- Domain Services
- Domain Events

Der Error Handling Guide definiert
keine eigenen Domänentypen.

---

# Ownership

Für jede Fehlerklasse
existiert genau ein verantwortlicher Eigentümer.

| Bereich | Verantwortlich |
|----------|----------------|
| Validation | Domain Layer |
| Business Rules | Domain Layer |
| Security | Security Layer |
| Infrastructure | Infrastructure Layer |
| Persistence | Persistence Layer |
| Integration | Integration Layer |

---

# Lebenszyklus

Jeder Error Code besitzt genau einen Status.

| Status | Beschreibung |
|---------|--------------|
| Draft | In Bearbeitung |
| Active | Freigegeben |
| Deprecated | Veraltet |
| Removed | Entfernt |

---

# Versionierung

## Regeln

Error Codes besitzen eine stabile fachliche Bedeutung.

Bereits veröffentlichte Error Codes

- werden nicht umdefiniert,
- werden nicht wiederverwendet,
- bleiben fachlich stabil.

Neue Anforderungen führen ausschließlich

- zu neuen Error Codes
- oder zu einer Deprecation.

---

# Deprecation

Veraltete Error Codes

werden zunächst als

```text
Deprecated
```

markiert.

Zusätzlich werden dokumentiert

- Nachfolger
- Version
- Migrationshinweise

Erst nach Abschluss des definierten
Migrationszeitraums
dürfen Error Codes entfernt werden.

---

# Erweiterbarkeit

Neue Error Codes

werden ausschließlich ergänzt.

Neue Fehlerklassen

dürfen nur eingeführt werden,

wenn sie architektonisch
eindeutig begründet sind.

---

# Reviewprozess

Jede Änderung
am Error Handling Guide
durchläuft mindestens

1. Domain Model Review
2. Architekturreview
3. Konsistenzprüfung
4. Dokumentationsreview
5. Implementierungsreview
6. Testreview
7. Freigabe

---

# Konsistenzprüfung

Vor jeder Freigabe
werden mindestens folgende Punkte geprüft.

## Domain Model

- Aggregate vollständig
- Entities vollständig
- Value Objects vollständig

## Error Handling Guide

- ausschließlich Domänentypen des Domain Models verwendet
- keine Dubletten
- keine widersprüchlichen Error Codes

## Architektur

- DDD
- Clean Architecture
- SOLID
- Single Source of Truth

---

# Testbarkeit

Jeder Error Code

muss

- reproduzierbar,
- testbar,
- dokumentiert

sein.

Automatisierte Tests
decken mindestens ab

- Validation Errors
- Business Rule Errors
- Security Errors
- Infrastructure Errors
- Persistence Errors
- Integration Errors

---

# Dokumentationsregeln

Jeder Error Code dokumentiert mindestens

- ErrorCode
- MessageKey
- Fehlerklasse
- Beschreibung
- Ursache
- empfohlene Behandlung

Optional

- Recovery
- Retry
- Logging
- Telemetrie

---

# Traceability

Jeder Error Code darf einer oder mehreren
fachlichen Quellen zugeordnet werden.

Mögliche Referenzen sind

- Domain Model
- Business Rules
- Architecture Decision Records (ADR)
- Use Cases
- Anforderungen
- Testfälle

Die Referenzen dienen ausschließlich
der Nachvollziehbarkeit
und besitzen keine technische Bedeutung.

### Beispiel

| Artefakt | Referenz |
|----------|-----------|
| Domain Model | VO-ProfileName |
| Business Rule | BR-014 |
| ADR | ADR-007 |
| Testfall | TC-Validation-021 |

---

# Project Error Registry

Alle veröffentlichten Error Codes
werden in einer zentralen Registry geführt.

Die Registry stellt sicher,

- jeder Error Code ist eindeutig,
- jeder MessageKey ist eindeutig,
- Error Codes werden nicht mehrfach verwendet,
- Deprecation wird nachvollziehbar dokumentiert,
- Nachfolger werden eindeutig referenziert.

Die Registry dient als projektweite
Referenz für Implementierung,
Dokumentation
und Qualitätssicherung.

Automatisierte Prüfungen dürfen sicherstellen,

- dass keine doppelten Error Codes entstehen,
- dass keine doppelten MessageKeys entstehen,
- dass ausschließlich gültige Präfixe verwendet werden,
- dass Deprecation-Regeln eingehalten werden.

---

# Rückwärtskompatibilität

Neue Versionen

dürfen bestehende Clients
nicht beeinträchtigen.

Veröffentlichte Error Codes
bleiben fachlich stabil.

---

# Projektstandard

Diese Governance-Regeln gelten
für sämtliche Module
des Health Trackers.

Neue Module übernehmen unverändert

- Fehlerklassifikation
- Präfixe
- Dokumentationsstruktur
- Reviewprozess
- Governance
- Traceability
- Error Registry

---

# Abschluss

Kapitel 5 definiert vollständig

- Validation Errors
- Business Rule Errors
- Security Errors
- Infrastructure Errors
- Persistence Errors
- Integration Errors

sowie deren

- Governance
- Versionierung
- Lebenszyklus
- Pflege
- Erweiterbarkeit
- Traceability
- zentrale Error Registry.

Weitere Fehlerarten
werden ausschließlich
durch Erweiterung
dieses Dokuments eingeführt.