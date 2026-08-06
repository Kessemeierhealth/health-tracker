# 05_DOMAIN_MODEL.md

> Modul: Profile

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-PRO-DM-001 |
| Dokumenttyp | Domain Model |
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
| 1.0.0 | 2026-08-01 | Erste Version | Definition des Domänenmodells für das Profilmodul | HealthTracker Team |

---

# Zweck

Dieses Dokument beschreibt das fachliche Domänenmodell des Moduls **Profile**.

Es definiert

- fachliche Objekte,
- Verantwortlichkeiten,
- Beziehungen,
- Aggregate,
- Konsistenzgrenzen,
- Invarianten,
- Lebenszyklen,
- fachliche Operationen.

Das Dokument bildet die Grundlage für

- Domain-Implementierung,
- Persistenz,
- REST-API,
- Import/Export,
- automatisierte Tests,
- zukünftige Erweiterungen.

---

# Ziele

Das Domänenmodell verfolgt folgende Ziele:

- klare fachliche Verantwortlichkeiten,
- hohe Kohäsion,
- geringe Kopplung,
- vollständige Konsistenz,
- testbare Fachlogik,
- UI-Unabhängigkeit,
- Technologieunabhängigkeit,
- langfristige Wartbarkeit.

---

# Geltungsbereich

Dieses Dokument beschreibt ausschließlich das Modul **Profile**.

Es umfasst

- Aggregate
- Aggregate Root
- Entities
- Value Objects
- Enumerationen
- Domain Services
- Repository Interfaces
- Domain Events
- Commands
- Invarianten
- Konsistenzregeln

Nicht Bestandteil sind

- fachliche Dashboard-Inhalte und Dashboard-Auswertungen anderer Module
- Messwerte
- Ernährung
- Medikamente
- Geräte
- Empfehlungen


**Hinweis**

Profilbezogene Dashboard-Präferenzen wie Auswahl, Sichtbarkeit und Anordnung
gehören als `DashboardSettings` zum Profile-Aggregate.

---

# Architekturprinzipien

Das Profilmodul folgt den Prinzipien des **Domain-Driven Design (DDD)**.

Die Fachlichkeit bestimmt die Architektur.

Technische Komponenten passen sich der Domäne an – niemals umgekehrt.

---

## PRO-DM-001 – Domäne zuerst

Die Fachlichkeit bestimmt das Modell.

Nicht

- Flutter,
- SQLite,
- REST,
- JSON,
- Frameworks,
- Datenbanken

bestimmen die Struktur der Domäne.

---

## PRO-DM-002 – Persistenzignoranz

Domänenobjekte kennen

- keine Datenbank,
- keine Persistenztechnologie,
- keine Widgets,
- keine REST-Endpunkte,
- keine JSON-Strukturen.

Sie enthalten ausschließlich Fachlogik.

---

## PRO-DM-003 – Hohe Kohäsion

Jedes Domänenobjekt besitzt genau eine fachliche Verantwortung.

Es gilt:

> Eine Klasse – eine fachliche Aufgabe.

---

## PRO-DM-004 – Geringe Kopplung

Domänenobjekte besitzen ausschließlich notwendige Abhängigkeiten.

Zyklische Abhängigkeiten sind unzulässig.

---

## PRO-DM-005 – Konsistenz

Domänenobjekte dürfen niemals einen fachlich ungültigen Zustand besitzen.

Alle Invarianten werden innerhalb der Domäne durchgesetzt.

---

## PRO-DM-006 – Unveränderliche Value Objects

Value Objects

- sind unveränderlich,
- besitzen keine Identität,
- werden ausschließlich über ihren Wert verglichen,
- können jederzeit sicher ersetzt werden.

---

## PRO-DM-007 – Aggregate schützen Konsistenz

Alle Änderungen erfolgen ausschließlich über das Aggregate Root.

Interne Objekte dürfen niemals direkt verändert werden.

Das Aggregate schützt sämtliche fachlichen Invarianten.

---

## PRO-DM-008 – Atomare Änderungen

Mehrstufige fachliche Änderungen erfolgen atomar.

Es gilt immer genau eine der beiden Möglichkeiten:

- vollständiger Erfolg
- vollständiger Rollback

Teilweise ausgeführte Änderungen sind unzulässig.

Dieses Prinzip entspricht **PRO-VP-008** aus den Validierungsregeln.

---

## PRO-DM-009 – Fachliche Identität

Entities besitzen eine dauerhafte fachliche Identität.

Diese Identität

- ist eindeutig,
- unveränderlich,
- bleibt während des gesamten Lebenszyklus bestehen.

---

## PRO-DM-010 – Fachliche Operationen

Domänenobjekte werden ausschließlich über fachlich benannte Operationen verändert.

Beispiele

- create()
- changeName()
- changeHeight()
- changePassword()
- activate()
- archive()
- lock()
- unlock()
- changeProfileImage()
- changeSettings()
- setDefault()
- removeDefault()
- delete()
- restore()

Technische CRUD-Methoden wie

- setName()
- setStatus()
- setPassword()
- setHeight()

gehören nicht zur öffentlichen Domänenschnittstelle.

Jede fachliche Operation

- prüft ihre Preconditions,
- schützt die betroffenen Invarianten,
- liefert ein strukturiertes `DomainResult<T>`,
- wird innerhalb ihrer fachlichen Zuständigkeit atomar ausgeführt.

Jede erfolgreiche zustandsändernde Operation

- aktualisiert die Auditinformationen,
- erhöht die Aggregate-Version genau einmal,
- erzeugt die zugehörigen Domain Events.

Erfolgreiche Operationen ohne Zustandsänderung verändern weder
Auditinformationen noch Aggregate-Version und erzeugen keine
Änderungs-Domain-Events.

---

## PRO-DM-011 – Keine öffentlichen Setter

Entities besitzen keine öffentlichen Setter.

Der Zustand einer Entity darf ausschließlich über fachliche Operationen verändert werden.

Dadurch wird verhindert,

- dass Invarianten umgangen werden,
- dass ungültige Zustände entstehen,
- dass Domänenlogik außerhalb der Domäne implementiert wird.

---

# Domain-Driven Design

Das Profilmodul verwendet folgende DDD-Bausteine.

| Baustein | Verwendung |
|-----------|------------|
| Aggregate | Ja |
| Aggregate Root | Ja |
| Entity | Ja |
| Value Object | Ja |
| Repository | Ja |
| Domain Service | Ja |
| Factory | Ja |
| Domain Event | Ja |
| Command | Ja |
| Specification | Optional |

---

# Bounded Context

Das Modul **Profile** bildet einen eigenständigen Bounded Context.

Innerhalb dieses Kontexts werden ausschließlich Profilinformationen verarbeitet.

Andere Module greifen ausschließlich über definierte Schnittstellen auf Profile zu.

Direkte Änderungen an internen Domänenobjekten sind unzulässig.

---

# Ubiquitous Language

| Begriff | Bedeutung |
|----------|-----------|
| Profile | Benutzerprofil |
| ProfileId | Unveränderliche Identität |
| ProfileName | Sichtbarer Profilname |
| Default Profile | Standardprofil |
| Active Profile | Aktives Profil |
| Archived Profile | Archiviertes Profil |
| Locked Profile | Gesperrtes Profil |
| Password-Protected Profile | Passwortgeschütztes Profil |
| Profile Image | Profilbild |
| Profile Settings | Profileinstellungen |
| Profile Security | Sicherheitsinformationen |
| Aggregate | Fachliche Konsistenzgrenze |
| Aggregate Root | Einstiegspunkt eines Aggregats |
| Entity | Objekt mit Identität |
| Value Object | Objekt ohne Identität |
| Repository | Persistenzschnittstelle |
| Domain Service | Fachlicher Dienst |
| Domain Event | Fachliches Ereignis |
| Command | Fachlicher Änderungsauftrag |

---

# Architekturübersicht

```text
Profile Aggregate
│
├── Aggregate Root
│     └── Profile
│
├── Entities
│
├── Value Objects
│
├── Enumerationen
│
├── Domain Services
│
├── Repository
│
├── Domain Events
│
└── Commands
```

---

# Architekturziele

Die Architektur bleibt unabhängig von

- Flutter
- SQLite
- Hive
- Drift
- REST
- JSON
- zukünftigen Technologien

Dadurch kann die Infrastruktur ausgetauscht werden, ohne das Domänenmodell ändern zu müssen.

---

# Referenzen

Dieses Dokument baut auf folgenden Spezifikationen auf:

- 01_REQUIREMENTS.md
- 02_USE_CASES.md
- 03_BUSINESS_RULES.md
- 04_VALIDATION_RULES.md

Später zusätzlich

- ARCHITECTURE_GUIDE.md
- ERROR_HANDLING_GUIDE.md

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Dokumenthistorie
- Zweck
- Ziele
- Geltungsbereich
- **PRO-DM-001 bis PRO-DM-011**
- Domain-Driven-Design-Grundsätze
- Bounded Context
- Ubiquitous Language
- Architekturübersicht

---

# Teil 2

Der nächste Abschnitt enthält:

- Profile Aggregate
- Aggregate Root
- Aggregate Boundary
- Konsistenzgrenzen
- Invarianten
- Lebenszyklus
- Transaktionsgrenzen

# Profile Aggregate

## Zweck

Das `Profile`-Aggregate bildet die fachliche Konsistenzgrenze des Profilmoduls.

Es stellt sicher, dass sämtliche Änderungen an einem Profil kontrolliert, validiert und atomar erfolgen.

Das Aggregate folgt den Architekturprinzipien `PRO-DM-001` bis `PRO-DM-011`.

Alle fachlichen Operationen liefern ein einheitliches Ergebnis vom Typ:

```text
DomainResult<T>
```

`DomainResult<T>` enthält je nach Ergebnis:

- den erfolgreichen Rückgabewert,
- fachliche Fehler,
- Validierungsfehler,
- Warnungen,
- Informationen.

Fachlich erwartbare Fehler werden nicht über Exceptions signalisiert.

Die genaue Struktur von `DomainResult<T>` wird projektweit im späteren `ERROR_HANDLING_GUIDE.md` definiert.

---

# Aggregate Root

## Profile

Das Aggregate Root des Profilmoduls ist:

```text
Profile
```

`Profile` besitzt die alleinige Verantwortung für:

- fachliche Konsistenz,
- Schutz der Aggregate-Invarianten,
- Koordination interner Änderungen,
- Erzeugung von Domain Events,
- Bereitstellung fachlicher Operationsergebnisse.

Alle Änderungen innerhalb des Aggregats erfolgen ausschließlich über dieses Aggregate Root.

Untergeordnete Entities und Value Objects dürfen von außerhalb des Aggregats nicht direkt verändert werden.

---

# Aggregate Boundary

Zum Aggregate gehören folgende fachliche Objekte:

```text
Profile Aggregate
│
├── Profile (Aggregate Root)
│
├── ProfileSettings (Entity)
│   ├── LocalizationSettings (Value Object)
│   ├── DashboardSettings (Value Object)
│   └── AppearanceSettings (Value Object)
│
├── ProfileSecurity (Entity)
│   ├── PasswordCredential? (Value Object)
│   └── LockState (Value Object)
│
├── ProfileImage? (Value Object)
├── AuditInformation (Value Object)
│
├── grundlegende Value Objects
│   ├── ProfileId
│   ├── ProfileName
│   ├── BirthYear
│   ├── Height
│   ├── ProfileColor
│   ├── DefaultProfileFlag
│   └── AggregateVersion
│
└── Enumerationen
    ├── Gender
    ├── ProfileStatus
    ├── ProfileLockStatus
    ├── Language
    ├── MeasurementSystem
    └── ThemePreference
```

Alle Bestandteile innerhalb dieser Grenze werden ausschließlich durch `Profile` koordiniert.

---

# Verantwortlichkeiten des Aggregats

Das `Profile`-Aggregate ist verantwortlich für:

- Profilerstellung,
- Änderung der Profilstammdaten,
- Änderung der Profilfarbe,
- Änderung der Geschlechtsangabe,
- Verwaltung der Profileinstellungen,
- Verwaltung des Profilschutzes,
- Sperren und Entsperren,
- Verwaltung des Profilbilds,
- Aktivierung,
- Deaktivierung,
- Archivierung,
- Wiederherstellung,
- Standardprofilstatus,
- Auditinformationen,
- Erzeugung von Domain Events.

Nicht verantwortlich ist das Aggregate für:

- Datenbankzugriffe,
- Transaktionssteuerung,
- technische Passwort-Hash-Erzeugung,
- Dateispeicherung,
- Bildverarbeitung,
- Importdateiformate,
- Exportdateiformate,
- Event-Publishing,
- UI-Navigation.

Diese Verantwortlichkeiten liegen in Application Layer, Ports und Infrastruktur.

---

# Ergebnis fachlicher Operationen

## Grundregel

Jede öffentliche fachliche Operation liefert:

```text
DomainResult<T>
```

Beispiele:

```text
DomainResult<Profile>
DomainResult<ProfileImage>
DomainResult<void>
```

## Erfolg

Bei Erfolg enthält das Ergebnis:

- den fachlichen Rückgabewert,
- optionale Informationen oder Warnungen.

Erzeugte Domain Events werden ausschließlich im internen Event-Puffer des
Aggregats gesammelt. Sie sind nicht Bestandteil von `DomainResult<T>`.

## Fehler

Bei einem fachlichen Fehler enthält das Ergebnis:

- keinen erfolgreich geänderten Aggregatzustand,
- mindestens eine strukturierte Domain Message,
- keine Domain Events für nicht ausgeführte Änderungen.

## Warnungen

Warnungen können zusammen mit einem erfolgreichen Ergebnis zurückgegeben werden.

Beispiel:

```text
DomainResult<Profile>
├── value: aktualisiertes Profile
└── warnings:
    └── PRO-VAL-DUPNAME-001
```

## Exceptions

Exceptions sind ausschließlich für unerwartete technische oder programmatische Fehler vorgesehen.

Fachlich erwartbare Zustände wie:

- archiviertes Profil,
- ungültiger Statuswechsel,
- gesperrtes Profil,
- ungültige Eingabe,

werden über `DomainResult<T>` abgebildet.

---

# Aggregate-Invarianten

Während des gesamten Lebenszyklus gelten folgende Invarianten:

| ID | Invariante |
|---|---|
| AG-INV-001 | `ProfileId` ist unveränderlich. |
| AG-INV-002 | Ein Profil besitzt genau einen gültigen Namen. |
| AG-INV-003 | Ein Profil besitzt genau einen gültigen Lebenszyklusstatus. |
| AG-INV-004 | Ein Profil besitzt genau eine `ProfileSecurity`-Entity. |
| AG-INV-005 | Ein Profil besitzt höchstens ein `ProfileImage`. |
| AG-INV-006 | Ein Profil besitzt genau eine `ProfileSettings`-Entity. |
| AG-INV-007 | `createdAt` bleibt unverändert. |
| AG-INV-008 | `updatedAt` wird nach jeder erfolgreichen fachlichen Änderung aktualisiert. |
| AG-INV-009 | Passwörter sind niemals als Klartext Bestandteil des Aggregats. |
| AG-INV-010 | Ein archiviertes Profil kann nicht aktiv sein. |
| AG-INV-011 | Ein gesperrtes Profil kann nicht aktiv sein. |
| AG-INV-012 | Das Aggregate befindet sich nach jeder erfolgreichen Operation in einem gültigen Zustand. |
| AG-INV-013 | Eine fehlgeschlagene Operation verändert den Aggregatzustand nicht. |
| AG-INV-014 | Eine erfolgreiche fachliche Änderung erhöht die Aggregate-Version genau einmal. |
| AG-INV-015 | Domain Events entstehen ausschließlich für erfolgreich abgeschlossene Änderungen. |

Keine fachliche Operation darf eine dieser Invarianten verletzen.

---

# Konsistenzgrenze

Innerhalb des Aggregats gilt starke Konsistenz.

Jede Änderung:

- validiert Eingaben,
- prüft Preconditions,
- schützt Invarianten,
- erzeugt einen neuen gültigen Zustand,
- aktualisiert `AuditInformation`,
- erhöht die Aggregate-Version,
- erzeugt passende Domain Events,
- liefert ein `DomainResult<T>`.

Außerhalb der Aggregate-Grenze darf Eventual Consistency bestehen.

Beispiele:

- Dashboard reagiert auf `ProfileUpdated`,
- andere Module reagieren auf `ProfileDeleted`,
- Audit-Persistenz reagiert auf veröffentlichte Events.

---

# Fachliche Operationen

Das Aggregate Root stellt mindestens folgende Operationen bereit:

```text
changeName()

changeBirthYear()

changeHeight()

changeGender()

changeColor()

activate()

deactivate()

archive()

restore()

markAsDefault()

removeDefault()

changeLanguage()

changeMeasurementSystem()

changeDashboardSettings()

changeAppearanceSettings()

resetSettings()

enablePasswordProtection()

disablePasswordProtection()

changePassword()

lock()

unlock()

replaceProfileImage()

removeProfileImage()

requestDeletion()
```

Die Erzeugung eines neuen Aggregats erfolgt ausschließlich über
`ProfileFactory.createNew(...)` und ist keine öffentliche Änderungsoperation
einer bereits vorhandenen `Profile`-Instanz.

Technische Setter und generische CRUD-Operationen gehören nicht zur
öffentlichen Domänenschnittstelle.

Die öffentliche API des Aggregats besteht ausschließlich aus fachlichen
Operationen, die die Invarianten des Aggregats wahren.

---

# Rückgabetypen der Operationen

## Profilerstellung

```text
DomainResult<Profile> ProfileFactory.createNew(...)
```

Erfolg:

- neues gültiges Aggregate,
- `ProfileCreated` im Event-Puffer.

Fehler:

- kein Aggregate,
- strukturierte Fehler und Warnungen.

---

## Stammdaten ändern

```text
DomainResult<Profile> changeName(ProfileName name)

DomainResult<Profile> changeBirthYear(BirthYear birthYear)

DomainResult<Profile> changeHeight(Height height)

DomainResult<Profile> changeGender(Gender gender)

DomainResult<Profile> changeColor(ProfileColor color)
```

Erfolg:

- neues oder intern aktualisiertes gültiges Aggregate,
- aktualisierte Auditinformationen,
- passende Domain Events.

Fehler:

- unveränderter Zustand,
- strukturierte Domain Messages.

---

## Statusoperationen

```text
DomainResult<Profile> activate()

DomainResult<Profile> deactivate()

DomainResult<Profile> archive()

DomainResult<Profile> restore()

DomainResult<Profile> lock(
  Timestamp now
)

DomainResult<Profile> unlock(
  AuthenticationProof proof,
  Timestamp now
)
```

Statusoperationen prüfen:

- aktuellen Lebenszyklusstatus,
- Sperrzustand,
- erlaubte Transition,
- profilübergreifende Preconditions, soweit lokal prüfbar.

Profilübergreifende Invarianten werden zusätzlich durch Domain Services geschützt.

---

## Einstellungen ändern

```text
DomainResult<Profile> changeLanguage(Language language)

DomainResult<Profile> changeMeasurementSystem(
  MeasurementSystem measurementSystem
)

DomainResult<Profile> changeDashboardSettings(
  DashboardSettings dashboardSettings
)

DomainResult<Profile> changeAppearanceSettings(
  AppearanceSettings appearanceSettings
)
```

Die untergeordnete Entity wird nur intern verändert.

Das Ergebnis wird über das Aggregate Root zurückgegeben.

---

## Sicherheitsoperationen

```text
DomainResult<Profile> enablePasswordProtection(
  PasswordCredential credential
)

DomainResult<Profile> disablePasswordProtection(
  AuthenticationProof proof
)

DomainResult<Profile> changePassword(
  PasswordCredential newCredential,
  AuthenticationProof proof
)

DomainResult<Profile> lock(
  Timestamp now
)

DomainResult<Profile> unlock(
  AuthenticationProof proof,
  Timestamp now
)
```

Die technische Prüfung des Klartextpassworts erfolgt außerhalb des Aggregats.

Das Aggregate erhält nur:

- ein gültiges `PasswordCredential`,
- oder die Information, dass eine Authentifizierung erfolgreich war.

---

## Profilbildoperationen

```text
DomainResult<Profile> replaceProfileImage(
  ProfileImage image
)

DomainResult<Profile> removeProfileImage()
```

Das Aggregate kennt nur das fachliche Value Object.

Bilddateien und technische Speicheroperationen liegen außerhalb der Domäne.

---

## Standardprofilstatus

```text
DomainResult<Profile> markAsDefault()

DomainResult<Profile> removeDefault()
```

Diese Operationen ändern nur den Zustand des einzelnen Aggregats.

Die profilübergreifende Invariante:

```text
höchstens ein Standardprofil
```

wird durch `DefaultProfileCoordinator` geschützt.

---

## Löschung

```text
DomainResult<ProfileDeletionDecision> requestDeletion(
  DeletionAuthorization authorization
)
```

Die Operation kann konzeptionell eine Löschentscheidung liefern.

Sie löscht nicht selbst:

- Persistenzdaten,
- Bilddateien,
- Gesundheitsdaten anderer Module.

Das Aggregate prüft ausschließlich, ob die fachlichen Voraussetzungen für
eine Löschung erfüllt sind, und liefert eine `ProfileDeletionDecision`.

Die technische Löschung und die Erzeugung beziehungsweise zuverlässige
Speicherung des Ereignisses `ProfileDeleted` werden durch den zuständigen
Application Service atomar koordiniert.

```text
ProfileDeleted
```

Die vollständige Löschung wird durch Application Service, `ProfileLifecycleService`, Ports und `UnitOfWork` koordiniert.

---

# Preconditions

Vor jeder Operation gilt:

- Das Aggregate befindet sich in einem konsistenten Ausgangszustand.
- Die Eingabewerte sind gültige Value Objects.
- Die Operation ist für den aktuellen Lebenszyklusstatus zulässig.
- Sicherheitsrelevante Vorprüfungen wurden außerhalb des Aggregats durchgeführt.
- Lokal prüfbare Invarianten sind erfüllt.
- Profilübergreifende Preconditions werden durch den zuständigen Domain Service geprüft.

Werden Preconditions verletzt, liefert die Operation:

```text
DomainResult<T>
```

mit fachlichen Fehlern und ohne Zustandsänderung.

---

# Postconditions

Nach einer erfolgreichen fachlichen Operation mit Zustandsänderung gilt:

- Das Aggregate ist konsistent.
- Alle Aggregate-Invarianten sind erfüllt.
- Betroffene Werte wurden vollständig ersetzt.
- `updatedAt` wurde aktualisiert.
- `AggregateVersion` wurde genau einmal erhöht.
- Passende Domain Events wurden im Aggregate gesammelt.
- Das Ergebnis enthält keine Fehler mit Schweregrad `ERROR`.

Nach einer erfolgreichen fachlichen Operation ohne Zustandsänderung gilt:

- Das Aggregate bleibt unverändert konsistent.
- `updatedAt` bleibt unverändert.
- `AggregateVersion` bleibt unverändert.
- Es werden keine Änderungs-Domain-Events erzeugt.
- Das Ergebnis enthält keine Fehler mit Schweregrad `ERROR`.
- Das Ergebnis kann die Information `noChange` enthalten.

Nach einer fehlgeschlagenen Operation gilt:

- Der ursprüngliche Zustand bleibt unverändert.
- Die Version bleibt unverändert.
- Auditinformationen bleiben unverändert.
- Es wurden keine Erfolgs-Domain-Events erzeugt.
- Das `DomainResult<T>` enthält mindestens eine Domain Message.

---

# Fachliche Gleichheit und Zustandsänderung

Eine Operation gilt nur dann als fachliche Änderung, wenn sich der fachliche Zustand tatsächlich verändert.

Beispiel:

```text
changeName(aktuellerName)
```

kann ein erfolgreiches Ergebnis ohne Zustandsänderung liefern.

In diesem Fall:

- wird `updatedAt` nicht verändert,
- wird die Version nicht erhöht,
- wird kein `ProfileUpdated`-Event erzeugt.

Das `DomainResult<T>` kann eine Information enthalten:

```text
noChange
```

Die konkrete Code-Struktur wird im `ERROR_HANDLING_GUIDE.md` definiert.

---

# Transaktionsgrenzen

Eine einzelne Aggregate-Operation ist eine fachlich atomare Zustandsänderung.

Für Änderungen innerhalb eines Aggregats gilt:

- vollständiger neuer Zustand,
- oder unveränderter vorheriger Zustand.

Für Operationen über mehrere Aggregate oder Repositories gilt:

```text
Application Service
        │
        ▼
Domain Service / Aggregate
        │
        ▼
Repositories
        │
        ▼
UnitOfWork
        │
        ├── commit
        └── rollback
```

Das Aggregate selbst:

- öffnet keine Transaktion,
- ruft kein `commit()` auf,
- ruft kein `rollback()` auf,
- speichert sich nicht selbst.

---

# Lebenszyklusstatus

Der fachliche Lebenszyklus wird über `ProfileStatus` modelliert.

```text
inactive
active
archived
```

Der Sicherheitsstatus wird separat über `LockState` modelliert.

```text
locked
unlocked
```

Diese beiden Dimensionen dürfen nicht vermischt werden.

---

# Zustandsübergänge

```text
Nicht vorhanden
        │
        ▼
     create()
        │
        ▼
     inactive
        │
        ├──────────────► activate()
        │                       │
        │                       ▼
        │                    active
        │                       │
        │                       ├────────► deactivate()
        │                       │               │
        │                       │               ▼
        │                       │            inactive
        │                       │
        │                       └────────► archive()
        │                                       │
        ▼                                       ▼
    archive()                               archived
        │                                       │
        └────────────────── restore() ◄─────────┘
```

Zusätzliche Regeln:

- Ein gesperrtes Profil kann nicht aktiviert werden.
- Ein archiviertes Profil kann nicht aktiviert werden.
- Ein aktives Profil wird vor der Archivierung deaktiviert.
- Die Löschung ist aus jedem existierenden Zustand möglich, sofern alle Preconditions erfüllt sind.

---

# Übergangsmatrix

| Ausgangszustand | Operation | Zielzustand | Zulässig |
|---|---|---|---:|
| inactive | activate | active | Ja, wenn nicht gesperrt |
| active | deactivate | inactive | Ja |
| inactive | archive | archived | Ja |
| active | archive | archived | Ja, nach Deaktivierung |
| archived | restore | inactive | Ja |
| archived | activate | – | Nein |
| active | activate | active | Keine Änderung |
| inactive | deactivate | inactive | Keine Änderung |
| archived | archive | archived | Keine Änderung oder Information |
| jeder Zustand | requestDeletion | unverändert | Ja, bei erfüllten Preconditions |

`requestDeletion()` prüft ausschließlich die fachliche Zulässigkeit und
liefert eine `ProfileDeletionDecision`.

Die endgültige technische Löschung ist kein Zustandsübergang innerhalb des
`Profile`-Aggregats.

Ungültige Übergänge liefern ein fehlerhaftes `DomainResult<T>`.

---

# Domain Events

Das Aggregate sammelt Domain Events intern.

Mindestens folgende Events können entstehen:

```text
ProfileCreated

ProfileNameChanged

ProfileBirthYearChanged

ProfileHeightChanged

ProfileGenderChanged

ProfileColorChanged

ProfileActivated

ProfileDeactivated

ProfileArchived

ProfileRestored

ProfileMarkedAsDefault

ProfileDefaultRemoved

ProfileLanguageChanged

ProfileMeasurementSystemChanged

ProfileDashboardSettingsChanged

ProfileAppearanceSettingsChanged

ProfilePasswordProtectionEnabled

ProfilePasswordProtectionDisabled

ProfilePasswordChanged

ProfileLocked

ProfileUnlocked

ProfileImageReplaced

ProfileImageRemoved

ProfileDeleted
```

Generische Events wie `ProfileUpdated` können zusätzlich erzeugt werden, sollten aber die spezifischen Events nicht ersetzen.

---

# Event-Regeln

Domain Events:

- beschreiben eine bereits erfolgreich erfolgte Änderung,
- sind unveränderlich,
- enthalten keine Klartextpasswörter,
- enthalten keine Passwort-Hashes,
- enthalten keine Bilddaten,
- enthalten nur erforderliche personenbezogene Informationen,
- werden erst nach erfolgreichem Commit veröffentlicht.

Das Aggregate sammelt Events, veröffentlicht sie jedoch nicht selbst.

---

# Event-Puffer

Konzeptionell besitzt das Aggregate einen internen Event-Puffer:

```text
pendingDomainEvents
```

Operationen fügen bei Erfolg Events hinzu.

Die Application Layer:

1. speichert das Aggregate,
2. führt den Commit aus,
3. veröffentlicht danach die Events,
4. bestätigt oder leert den Event-Puffer gemäß Implementierungsstandard.

Die konkrete Implementierung wird im Architektur- und Event-Dokument festgelegt.

---

# Beziehungen zu anderen Aggregaten

Andere Module referenzieren das Profil ausschließlich über:

```text
ProfileId
```

Nicht zulässig sind direkte Objektverweise wie:

```text
Measurement.profile = Profile
```

Zulässig ist:

```text
Measurement.profileId = ProfileId
```

Das Profile Aggregate kennt keine internen Modelle von:

- Measurements,
- Nutrition,
- Medication,
- Devices,
- Dashboard,
- Analysis.

---

# Profilübergreifende Regeln

Folgende Regeln können nicht allein innerhalb eines einzelnen Aggregats geschützt werden:

- höchstens ein aktives Profil,
- höchstens ein Standardprofil,
- gültiger Verweis auf das zuletzt verwendete Profil,
- Erkennung doppelter Profilnamen,
- Startprofilermittlung,
- Löschung profilbezogener Daten anderer Module,
- Übergang in den Initialzustand.

Diese Regeln werden durch Domain Services und Application Services koordiniert.

---

# Architekturregeln

Für das `Profile`-Aggregate gelten zusätzlich:

- genau ein Aggregate Root,
- keine öffentlichen Setter,
- keine generischen Feld-Updates,
- keine direkte Mutation untergeordneter Entities von außen,
- Value Objects sind unveränderlich,
- fachliche Fehler werden über `DomainResult<T>` zurückgegeben,
- Domain Events entstehen nur bei Erfolg,
- fehlgeschlagene Operationen verändern keinen Zustand,
- Persistenz und Transaktionen liegen außerhalb des Aggregats,
- technische Exceptions werden nicht als fachliche Fehler missbraucht.

---

# Status dieses Teils

Mit Teil 2 sind aktualisiert und vollständig definiert:

- `Profile` als Aggregate Root,
- Aggregate Boundary,
- Verantwortlichkeiten,
- `DomainResult<T>` als einheitliche Rückgabe,
- Aggregate-Invarianten,
- fachliche Operationen,
- Preconditions,
- Postconditions,
- No-Change-Verhalten,
- Transaktionsgrenzen,
- Lebenszyklusstatus,
- Zustandsübergänge,
- Übergangsmatrix,
- Domain Events,
- Event-Puffer,
- Beziehungen zu anderen Aggregaten,
- profilübergreifende Regeln.

---

# Teil 3

Der nächste aktualisierte Abschnitt enthält:

- `Profile`,
- `ProfileSettings`,
- `ProfileSecurity`,
- ihre Operationen mit `DomainResult<T>`,
- Preconditions und Postconditions,
- `ProfileImage`,
- `AuditInformation`,
- Entity- und Value-Object-Beziehungen.

# Entities

## Überblick

Das `Profile`-Aggregate besteht aus dem Aggregate Root `Profile` und zwei untergeordneten Entities.

```text
Profile (Aggregate Root)
│
├── ProfileSettings (Entity)
│   ├── LocalizationSettings (Value Object)
│   ├── DashboardSettings (Value Object)
│   └── AppearanceSettings (Value Object)
│
├── ProfileSecurity (Entity)
│   ├── PasswordCredential? (Value Object)
│   └── LockState (Value Object)
│
├── ProfileImage? (Value Object)
├── AuditInformation (Value Object)
└── weitere grundlegende Value Objects
```

Alle öffentlichen fachlichen Änderungen werden ausschließlich über das Aggregate Root ausgeführt.

Untergeordnete Entities stellen keine öffentliche Schnittstelle außerhalb des Aggregats bereit.

Fachliche Operationen liefern ein Ergebnis vom Typ:

```text
DomainResult<T>
```

Fachlich erwartbare Fehler werden nicht über Exceptions signalisiert.

---

# Gemeinsame Regeln für Entities

Für alle Entities innerhalb des Aggregats gelten folgende Regeln:

- Entities besitzen eine fachliche Identität.
- Die Identität bleibt während des gesamten Lebenszyklus unverändert.
- Entities besitzen keine öffentlichen Setter.
- Änderungen erfolgen ausschließlich über fachlich benannte Operationen.
- Untergeordnete Entities sind außerhalb des Aggregats nicht direkt veränderbar.
- Fachliche Fehler werden über `DomainResult<T>` zurückgegeben.
- Fehlgeschlagene Operationen verändern den Zustand nicht.
- Erfolgreiche Änderungen untergeordneter Entities werden durch das Aggregate
  Root übernommen.
- Das Aggregate Root aktualisiert dabei die Auditinformationen und die
  Aggregate-Version.
- Erfolgreiche Änderungen untergeordneter Entities können das Aggregate Root
  veranlassen, passende Domain Events zu erzeugen.
- Untergeordnete Entities erzeugen und veröffentlichen selbst keine
  Profil-Domain-Events.
- Entities kennen keine Persistenztechnologie.
- Entities kennen keine UI-Technologie.
- Entities kennen keine DTO-, JSON- oder Datenbankmodelle.

---

# Entity: Profile

## Typ

Aggregate Root

---

## Zweck

`Profile` repräsentiert die fachliche Identität eines Benutzerprofils.

Es ist der einzige öffentliche Einstiegspunkt für Änderungen innerhalb des `Profile`-Aggregats.

Das Aggregate Root schützt:

- Aggregate-Invarianten,
- Statusübergänge,
- untergeordnete Entities,
- Auditinformationen,
- Aggregate-Version,
- Domain Events.

---

## Verantwortlichkeiten

`Profile` ist verantwortlich für:

- fachliche Identität,
- Profilstammdaten,
- Lebenszyklusstatus,
- Standardprofilstatus,
- Koordination der Profileinstellungen,
- Koordination des Profilschutzes,
- Verwaltung des Profilbilds,
- Aktualisierung der Auditinformationen,
- Erhöhung der Aggregate-Version,
- Sammlung von Domain Events.

---

## Attribute

| Attribut | Typ | Pflicht | Änderbar |
|---|---|---:|---:|
| profileId | ProfileId | Ja | Nein |
| name | ProfileName | Ja | Ja |
| birthYear | BirthYear | Ja | Ja |
| height | Height | Ja | Ja |
| gender | Gender | Ja | Ja |
| color | ProfileColor | Ja | Ja |
| status | ProfileStatus | Ja | Ja |
| defaultFlag | DefaultProfileFlag | Ja | Ja |
| settings | ProfileSettings | Ja | Ja |
| security | ProfileSecurity | Ja | Ja |
| image | ProfileImage? | Nein | Ja |
| audit | AuditInformation | Ja | Automatisch |
| pendingDomainEvents | DomainEventCollection | Ja | Intern |

`Gender.unspecified` repräsentiert eine fehlende Geschlechtsangabe.

Primitive Datentypen werden nach Möglichkeit ausschließlich innerhalb von Value Objects verwendet.

---

## Erzeugung

Die Erzeugung eines neuen Profils erfolgt über:

```text
DomainResult<Profile> ProfileFactory.createNew(...)
```

Direkte öffentliche Konstruktoraufrufe sind nicht vorgesehen.

Ein neu erzeugtes Profil besitzt:

- eine neue `ProfileId`,
- gültige Stammdaten,
- gültige `ProfileSettings`,
- gültige `ProfileSecurity`,
- keine oder eine gültige `ProfileImage`,
- initiale `AuditInformation`,
- den Status `inactive`,
- DefaultProfileFlag.createDisabled().

Die profilübergreifende Aktivierung des ersten Profils erfolgt anschließend durch den zuständigen Application Service und Domain Coordinator.

---

## Gemeinsame Statusregel für Stammdatenänderungen

Stammdatenänderungen sind für Profile mit dem Lebenszyklusstatus

- `inactive`,
- `active`

zulässig.

Für ein archiviertes Profil sind Stammdatenänderungen nicht zulässig.

Der Sperrzustand allein verhindert keine Stammdatenänderung.

Die Autorisierung eines Aufrufs bei einem gesperrten Profil wird vor dem
Aufruf durch den zuständigen Application Service geprüft. Sie ist keine
lokale Invariante der Stammdatenoperation.

Das Aggregate prüft bei diesen Operationen keinen `AuthenticationProof`.

---

# Stammdatenoperationen

## changeName()

```text
DomainResult<Profile> changeName(ProfileName newName)
```

### Preconditions

- `newName` ist gültig.
- Das Aggregate befindet sich in einem konsistenten Zustand.
- Die gemeinsame Statusregel für Stammdatenänderungen ist erfüllt.

### Verhalten

Ist `newName` mit dem aktuellen Namen identisch, wird keine Zustandsänderung vorgenommen.

Eine mögliche Duplikatwarnung wird außerhalb des Aggregats durch den `ProfileUniquenessService` ermittelt.

### Postconditions bei Änderung

- `name` enthält den neuen Wert.
- `AuditInformation` wurde aktualisiert.
- Die Aggregate-Version wurde erhöht.
- `ProfileNameChanged` wurde erzeugt.

### Rückgabe

Erfolg mit Änderung:

```text
DomainResult<Profile>
```

Erfolg ohne Änderung:

```text
DomainResult<Profile>
└── information: noChange
```

Fehler:

```text
DomainResult<Profile>
└── errors
```

Der Zustand bleibt bei einem Fehler unverändert.

---

## changeBirthYear()

```text
DomainResult<Profile> changeBirthYear(BirthYear newBirthYear)
```

### Preconditions

- `newBirthYear` ist gültig.
- Die gemeinsame Statusregel für Stammdatenänderungen ist erfüllt.

### Postconditions bei Änderung

- `birthYear` wurde vollständig ersetzt.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileBirthYearChanged` wurde erzeugt.

---

## changeHeight()

```text
DomainResult<Profile> changeHeight(Height newHeight)
```

### Preconditions

- `newHeight` ist gültig.
- Die gemeinsame Statusregel für Stammdatenänderungen ist erfüllt.

### Postconditions bei Änderung

- `height` enthält den neuen normalisierten Wert.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileHeightChanged` wurde erzeugt.

---

## changeGender()

```text
DomainResult<Profile> changeGender(Gender newGender)
```

### Preconditions

- `newGender` ist ein definierter Enum-Wert.
- Die gemeinsame Statusregel für Stammdatenänderungen ist erfüllt.

### Postconditions bei Änderung

- `gender` wurde ersetzt.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileGenderChanged` wurde erzeugt.

---

## changeColor()

```text
DomainResult<Profile> changeColor(ProfileColor newColor)
```

### Preconditions

- `newColor` ist gültig.
- Die Profilfarbe erfüllt die fachlichen Farbregeln.
- Die gemeinsame Statusregel für Stammdatenänderungen ist erfüllt.

### Postconditions bei Änderung

- `color` wurde ersetzt.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileColorChanged` wurde erzeugt.

---

# Lebenszyklusoperationen

## activate()

```text
DomainResult<Profile> activate()
```

### Preconditions

- Das Profil ist nicht archiviert.
- Das Profil ist nicht gesperrt.

### Postconditions

- `status` ist `active`.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileActivated` wurde erzeugt.

### No-Change-Verhalten

Ist das Profil bereits aktiv, wird ein erfolgreiches Ergebnis ohne
Zustandsänderung zurückgegeben.

In diesem Fall:

- bleiben Auditinformationen unverändert,
- bleibt die Aggregate-Version unverändert,
- wird kein `ProfileActivated`-Event erzeugt.

### Profilübergreifende Regel

Die Invariante, dass höchstens ein Profil aktiv ist, wird durch den `ActiveProfileCoordinator` geschützt.

---

## deactivate()

```text
DomainResult<Profile> deactivate()
```

### Preconditions

- Das Profil ist nicht archiviert.

### Postconditions

- `status` ist `inactive`.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileDeactivated` wurde erzeugt.

### No-Change-Verhalten

Ist das Profil bereits inaktiv, wird ein erfolgreiches Ergebnis ohne
Zustandsänderung zurückgegeben.

In diesem Fall:

- bleiben Auditinformationen unverändert,
- bleibt die Aggregate-Version unverändert,
- wird kein `ProfileDeactivated`-Event erzeugt.

---

## archive()

```text
DomainResult<Profile> archive()
```

### Preconditions

- Die profilübergreifenden Folgeoperationen wurden vorbereitet.
- Ein aktives Profil kann vor der Archivierung deaktiviert werden.

### Postconditions

- `status` ist `archived`.
- `defaultFlag` ist deaktiviert.
- Das Profil ist nicht aktiv.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileArchived` wurde erzeugt.

### Event-Reihenfolge

Ist das Profil vor der Operation aktiv, entstehen die Events in dieser
Reihenfolge:

1. `ProfileDeactivated`
2. `ProfileArchived`

### No-Change-Verhalten

Ist das Profil bereits archiviert, wird ein erfolgreiches Ergebnis ohne
Zustandsänderung zurückgegeben.

In diesem Fall:

- bleiben Auditinformationen unverändert,
- bleibt die Aggregate-Version unverändert,
- wird weder `ProfileDeactivated` noch `ProfileArchived` erzeugt.

### Fehlerfälle

Die Operation schlägt fehl, wenn:

- der aktuelle Zustand die Archivierung nicht zulässt,
- eine Invariante verletzt würde.

---

## restore()

```text
DomainResult<Profile> restore()
```

### Preconditions

- Das Profil ist archiviert.

### Postconditions

- `status` ist `inactive`.
- Profil-ID und fachliche Daten bleiben erhalten.
- Das Profil ist nicht automatisch aktiv.
- Das Profil ist nicht automatisch Standardprofil.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileRestored` wurde erzeugt.

### Fehlerfall

Ist das Profil nicht archiviert, schlägt die Operation mit einem fachlichen
Fehler fehl.

Es handelt sich nicht um einen No-Change.

---

# Standardprofiloperationen

## markAsDefault()

```text
DomainResult<Profile> markAsDefault()
```

### Preconditions

- Das Profil ist nicht archiviert.

Ein gesperrtes Profil darf Standardprofil sein.

### Postconditions

- `defaultFlag` ist aktiviert.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileMarkedAsDefault` wurde erzeugt.

### No-Change-Verhalten

Ist das Profil bereits Standardprofil, wird ein erfolgreiches Ergebnis ohne
Zustandsänderung zurückgegeben.

In diesem Fall:

- bleiben Auditinformationen unverändert,
- bleibt die Aggregate-Version unverändert,
- wird kein `ProfileMarkedAsDefault`-Event erzeugt.

### Profilübergreifende Regel

Dass höchstens ein Standardprofil existiert, wird durch den `DefaultProfileCoordinator` gewährleistet.

---

## removeDefault()

```text
DomainResult<Profile> removeDefault()
```

### Postconditions

- `defaultFlag` ist deaktiviert.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileDefaultRemoved` wurde erzeugt.



---

# Einstellungsoperationen

Das Aggregate Root delegiert Einstellungsänderungen intern an `ProfileSettings`.

Untergeordnete Operationen sind außerhalb des Aggregats nicht zugänglich.

---

## changeLanguage()

```text
DomainResult<Profile> changeLanguage(Language newLanguage)
```

### Ablauf

1. `Profile` prüft den allgemeinen Aggregatzustand.
2. `ProfileSettings.changeLanguage()` wird aufgerufen.
3. Das Ergebnis der untergeordneten Entity wird ausgewertet.
4. Bei Erfolg wird die neue Entity übernommen.
5. Auditinformationen und Version werden aktualisiert.
6. `ProfileLanguageChanged` wird erzeugt.

### Fehlerverhalten

Bei einem fehlerhaften Ergebnis von `ProfileSettings` bleibt das gesamte Aggregate unverändert.

---

## changeMeasurementSystem()

```text
DomainResult<Profile> changeMeasurementSystem(
  MeasurementSystem newMeasurementSystem
)
```

### Postconditions bei Änderung

- `ProfileSettings.localization` enthält das neue Einheitensystem.
- Andere Einstellungsbereiche bleiben unverändert.
- `ProfileMeasurementSystemChanged` wurde erzeugt.

---

## changeDashboardSettings()

```text
DomainResult<Profile> changeDashboardSettings(
  DashboardSettings newDashboardSettings
)
```

### Postconditions bei Änderung

- Dashboardeinstellungen wurden vollständig ersetzt.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileDashboardSettingsChanged` wurde erzeugt.

---

## changeAppearanceSettings()

```text
DomainResult<Profile> changeAppearanceSettings(
  AppearanceSettings newAppearanceSettings
)
```

### Postconditions bei Änderung

- Darstellungseinstellungen wurden vollständig ersetzt.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileAppearanceSettingsChanged` wurde erzeugt.

---

## resetSettings()

```text
DomainResult<Profile> resetSettings(
  ProfileSettingsDefaults defaults
)
```

### Preconditions

- Die Standardwerte sind fachlich gültig.

### Postconditions

- `ProfileSettings` befindet sich in einem vollständigen Standardzustand.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileSettingsReset` wurde erzeugt.

---

# Sicherheitsoperationen

Das Aggregate Root delegiert Sicherheitsänderungen intern an `ProfileSecurity`.

Klartextpasswörter werden niemals an das Aggregate übergeben.

---

## Verantwortung für AuthenticationProof

Das Aggregate Root `Profile` prüft vor der Delegation an `ProfileSecurity`
mindestens:

- Übereinstimmung der `ProfileId`,
- passenden `AuthenticationPurpose`,
- zeitliche Gültigkeit,
- erforderliche Wiederverwendungsregeln.

`ProfileSecurity` erhält ausschließlich einen bereits fachlich geprüften
Authentifizierungsnachweis.

Die untergeordnete Entity prüft keine profilübergreifenden oder
portabhängigen Eigenschaften des Proofs.

---

## enablePasswordProtection()

```text
DomainResult<Profile> enablePasswordProtection(
  PasswordCredential credential
)
```

### Preconditions

- Der Passwortschutz ist deaktiviert.
- `credential` ist gültig.
- Das Credential wurde über den zuständigen Security Port erzeugt.

### Postconditions

- `ProfileSecurity` enthält das Credential.
- Der Passwortschutz ist aktiviert.
- Der Sperrzustand ist fachlich konsistent.
- Auditinformationen und Version wurden aktualisiert.
- `ProfilePasswordProtectionEnabled` wurde erzeugt.

---

## disablePasswordProtection()

```text
DomainResult<Profile> disablePasswordProtection(
  AuthenticationProof proof
)
```

`AuthenticationProof` repräsentiert ausschließlich die Information, dass die erforderliche Authentifizierung erfolgreich war.

### Preconditions

- Der Passwortschutz ist aktiviert.
- `proof` ist gültig.

### Postconditions

- Das Credential ist entfernt.
- `LockState` ist `unlocked`.
- Auditinformationen und Version wurden aktualisiert.
- `ProfilePasswordProtectionDisabled` wurde erzeugt.

---

## changePassword()

```text
DomainResult<Profile> changePassword(
  PasswordCredential newCredential,
  AuthenticationProof proof
)
```

### Preconditions

- Der Passwortschutz ist aktiviert.
- Das bisherige Credential wurde erfolgreich verifiziert.
- `proof` ist gültig.
- `newCredential` ist gültig.

### Postconditions

- Das bisherige Credential wurde vollständig ersetzt.
- Nur das neue Credential ist gültig.
- Auditinformationen und Version wurden aktualisiert.
- `ProfilePasswordChanged` wurde erzeugt.

---

## lock()

```text
DomainResult<Profile> lock(Timestamp now)
```

### Preconditions

- Der Passwortschutz ist aktiviert.
- Das Profil ist nicht archiviert.
- Das Profil ist nicht bereits gesperrt.

### Postconditions

- `LockState` ist `locked`.
- Das Profil darf nicht aktiv bleiben.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileLocked` wurde erzeugt.

### Event-Reihenfolge

Ist das Profil vor der Operation aktiv, entstehen die Events in dieser
Reihenfolge:

1. `ProfileDeactivated`
2. `ProfileLocked`

### Koordination

Ist das Profil aktiv, muss die Deaktivierung atomar mit der Sperrung koordiniert werden.

---

## unlock()

```text
DomainResult<Profile> unlock(
  AuthenticationProof proof,
  Timestamp now
)
```

### Preconditions

- Das Profil ist gesperrt.
- Das Profil ist nicht archiviert.
- `proof` bestätigt eine erfolgreiche Authentifizierung.

### Postconditions

- `LockState` ist `unlocked`.
- Das Profil wird nicht automatisch aktiv.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileUnlocked` wurde erzeugt.

---

# Profilbildoperationen

## replaceProfileImage()

```text
DomainResult<Profile> replaceProfileImage(
  ProfileImage newImage
)
```

### Preconditions

- `newImage` ist fachlich gültig.
- Bildprüfung und Bildtransformation wurden außerhalb des Aggregats erfolgreich abgeschlossen.
- Die Bildreferenz ist verfügbar.

### Postconditions

- Das bisherige `ProfileImage` wurde vollständig ersetzt.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileImageReplaced` wurde erzeugt.

### Hinweis

Die Löschung der alten technischen Bilddaten erfolgt über den zuständigen Infrastrukturport und wird durch den Application Service koordiniert.

---

## removeProfileImage()

```text
DomainResult<Profile> removeProfileImage()
```

### Verhalten

Existiert kein Profilbild, kann ein erfolgreiches Ergebnis ohne Zustandsänderung zurückgegeben werden.

### Postconditions bei Änderung

- `image` ist nicht mehr vorhanden.
- Auditinformationen und Version wurden aktualisiert.
- `ProfileImageRemoved` wurde erzeugt.

---

# Löschoperation

## requestDeletion()

```text
DomainResult<ProfileDeletionDecision> requestDeletion(
  DeletionAuthorization authorization
)
```

### Zweck

Das Aggregate prüft, ob eine fachliche Löschung zulässig ist.

Es führt keine technische Löschung selbst durch.

### Preconditions

- Das Profil existiert.
- Die Löschung wurde ausdrücklich bestätigt.
- Bei geschütztem Profil liegt eine gültige Autorisierung vor.
- Der Zustand erlaubt die Löschanforderung.

### Ergebnis

Bei Erfolg enthält `ProfileDeletionDecision` mindestens:

- `profileId`,
- Hinweis auf vorhandenes Profilbild,
- aktuellen Aktivstatus,
- Standardprofilstatus,
- fachliche Freigabe zur Löschung.

### Postconditions

Die Anfrage allein verändert den Aggregate-Zustand nicht.

Das Ereignis `ProfileDeleted` wird erst nach erfolgreicher vollständiger Löschung und Commit erzeugt beziehungsweise veröffentlicht.

### Event-Verantwortung bei endgültiger Löschung

`requestDeletion()` erzeugt noch kein `ProfileDeleted`-Event, da zu diesem
Zeitpunkt keine Löschung stattgefunden hat.

`ProfileDeleted` wird durch den löschenden Application Service als
fachliches Abschlussereignis erzeugt und gemeinsam mit der vollständigen
Löschung zuverlässig gespeichert beziehungsweise über eine Outbox
bereitgestellt.

Diese Regel bildet eine ausdrücklich dokumentierte Ausnahme von der
allgemeinen Regel, dass Domain Events durch Aggregate erzeugt werden.

---

# Entity: ProfileSettings

## Typ

Untergeordnete Entity

---

## Zweck

`ProfileSettings` bündelt die fachlichen Einstellungen eines Profils.

Die Entity besitzt eine lokale Identität innerhalb des Aggregats.

Sie ist außerhalb des Aggregate Roots nicht direkt zugänglich.

Die lokale Identität bleibt über Rekonstruktionen und vollständige
Zustandsersetzungen hinweg erhalten und ermöglicht die eindeutige Zuordnung
der Entity innerhalb des Aggregats.

---

## Attribute

| Attribut | Typ |
|---|---|
| settingsId | ProfileSettingsId |
| localization | LocalizationSettings |
| dashboard | DashboardSettings |
| appearance | AppearanceSettings |

---

## Verantwortlichkeiten

`ProfileSettings` ist verantwortlich für:

- Regionalisierungspräferenzen,
- Maßeinheitensystem,
- Dashboardeinstellungen,
- Darstellungspräferenzen,
- konsistentes Zurücksetzen auf Standardwerte.

---

## Erzeugung und Rekonstruktion

Die kontrollierte Erzeugung und Rekonstruktion erfolgt ausschließlich über:

```text
DomainResult<ProfileSettings> ProfileSettings.create(
  ProfileSettingsId settingsId,
  LocalizationSettings localization,
  DashboardSettings dashboard,
  AppearanceSettings appearance
)
```

Direkte öffentliche Konstruktoraufrufe sind nicht vorgesehen.

Die Factory wird sowohl für die initiale Erzeugung als auch für die
Rekonstruktion verwendet.

Die Unterscheidung zwischen initialer Erzeugung und Rekonstruktion liegt
außerhalb der Entity. In beiden Fällen erhält `ProfileSettings` bereits eine
gültige und unveränderliche `ProfileSettingsId`.

### Preconditions

- `settingsId` ist gültig.
- `localization` ist gültig.
- `dashboard` ist gültig.
- `appearance` ist gültig.
- Sämtliche Pflichtwerte sind vorhanden.

### Postconditions

Bei Erfolg:

- wurde eine vollständige und konsistente `ProfileSettings`-Entity erzeugt,
- sind sämtliche Einstellungsbereiche vorhanden,
- ist `settingsId` unveränderlich,
- wurden keine Domain Events erzeugt,
- wurden keine Auditinformationen oder Aggregate-Versionen verändert.

Bei Fehler:

- wird keine Entity erzeugt,
- enthält `DomainResult<ProfileSettings>` mindestens einen strukturierten
  Fehler.

---

## changeLanguage()

```text
DomainResult<ProfileSettings> changeLanguage(
  Language newLanguage
)
```

### Verhalten

Es wird eine neue `LocalizationSettings`-Instanz erzeugt.

Das Maßeinheitensystem bleibt unverändert.

### Postconditions bei Änderung

- Neue gültige `ProfileSettings`-Instanz.
- Keine Domain Events werden direkt veröffentlicht.
- Das Aggregate Root erzeugt das fachliche Profilereignis.

---

## changeMeasurementSystem()

```text
DomainResult<ProfileSettings> changeMeasurementSystem(
  MeasurementSystem newMeasurementSystem
)
```

### Postconditions

- Die Sprache bleibt unverändert.
- Das Einheitensystem wurde ersetzt.
- Andere Einstellungen bleiben unverändert.

---

## changeDashboardSettings()

```text
DomainResult<ProfileSettings> changeDashboardSettings(
  DashboardSettings newDashboardSettings
)
```

### Postconditions

- Dashboardeinstellungen wurden vollständig ersetzt.
- Regionalisierung und Darstellung bleiben unverändert.

---

## changeAppearanceSettings()

```text
DomainResult<ProfileSettings> changeAppearanceSettings(
  AppearanceSettings newAppearanceSettings
)
```

### Postconditions

- Darstellungseinstellungen wurden vollständig ersetzt.
- Andere Bereiche bleiben unverändert.

---

## resetToDefaults()

```text
DomainResult<ProfileSettings> resetToDefaults(
  ProfileSettingsDefaults defaults
)
```

### Preconditions

- `defaults` ist gültig.
- `defaults` enthält einen vollständigen fachlichen Standardzustand.

### Postconditions bei Änderung

- `localization` entspricht `defaults.localization`.
- `dashboard` entspricht `defaults.dashboard`.
- `appearance` entspricht `defaults.appearance`.
- `settingsId` bleibt unverändert.
- Es wurde eine vollständige und konsistente `ProfileSettings`-Entity erzeugt.
- Die Entity erzeugt keine Domain Events.
- Auditinformationen und Aggregate-Version werden nicht durch die Entity
  verändert.

### No-Change-Verhalten

Entsprechen alle drei Einstellungsbereiche bereits den Werten aus `defaults`,
wird ein erfolgreiches `DomainResult<ProfileSettings>` ohne
Zustandsänderung zurückgegeben.

---

## Invarianten

- `settingsId` ist unveränderlich.
- Alle drei Einstellungsbereiche sind vorhanden.
- Alle enthaltenen Value Objects sind gültig.
- Änderungen liefern neue konsistente Zustände.
- Fehlgeschlagene Operationen verändern die Entity nicht.
- Die Entity erzeugt keine technischen Seiteneffekte.

---

# Entity: ProfileSecurity

## Typ

Untergeordnete Entity

---

## Zweck

`ProfileSecurity` verwaltet den fachlichen Schutz- und Sperrzustand eines Profils.

Sie enthält niemals Klartextpasswörter.

Die Validierung der Profilzuordnung und der Verwendbarkeit eines
`AuthenticationProof` gehört nicht zur Verantwortung dieser Entity.

Die lokale Identität bleibt über Rekonstruktionen und vollständige
Zustandsersetzungen hinweg erhalten und ermöglicht die eindeutige Zuordnung
der Entity innerhalb des Aggregats.

---

## Attribute

| Attribut | Typ |
|---|---|
| securityId | ProfileSecurityId |
| passwordCredential | PasswordCredential? |
| lockState | LockState |

Ein fehlendes `PasswordCredential` bedeutet:

```text
Passwortschutz deaktiviert
```

---

## Factory

Die kontrollierte initiale Erzeugung und die Rekonstruktion erfolgen
ausschließlich über:

```text
DomainResult<ProfileSecurity> create(
  ProfileSecurityId? securityId,
  PasswordCredential? passwordCredential,
  LockState? lockState
)
```

Dieselbe Factory wird sowohl für die initiale Erzeugung als auch für die
Rekonstruktion einer bestehenden `ProfileSecurity`-Entity verwendet.

Es existiert keine weitere öffentliche Factory.

### Regeln

- `securityId` muss vorhanden und gültig sein.
- `lockState` muss vorhanden und gültig sein.
- `passwordCredential` darf fehlen.
- Ein fehlendes `passwordCredential` bedeutet, dass der Passwortschutz
  deaktiviert ist.
- Ein gesperrter Zustand ohne `passwordCredential` ist unzulässig.
- Die Factory erzeugt ausschließlich einen vollständigen und fachlich
  konsistenten Zustand.
- Bei mindestens einem Validation Error wird keine Entity erzeugt.
- Fehler der enthaltenen Value Objects werden nicht als generische
  `ProfileSecurity`-Fehler dupliziert.

### Erfolgsverhalten

Bei erfolgreicher Erzeugung gilt:

- `securityId` entspricht dem übergebenen Wert.
- `passwordCredential` entspricht dem übergebenen optionalen Wert.
- `lockState` entspricht dem übergebenen Wert.
- Die Entity ist vollständig und fachlich konsistent.
- Die Entity erzeugt keine Domain Events.
- Die Entity besitzt keine eigene Audit- oder Versionslogik.

### Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird keine `ProfileSecurity`-Entity erzeugt.
- Das `DomainResult<ProfileSecurity>` enthält mindestens einen
  strukturierten Validation Error.
- Es entsteht kein teilweise gültiger Sicherheitszustand.
- Sensible Inhalte werden nicht in Domain Messages oder Fehlerparametern
  offengelegt.

---

## Verantwortlichkeiten

`ProfileSecurity` ist verantwortlich für:

- Aktivierung des Passwortschutzes,
- Deaktivierung des Passwortschutzes,
- Austausch des Credentials,
- Sperren,
- Entsperren,
- Konsistenz von Credential und LockState.

---

## enablePasswordProtection()

```text
DomainResult<ProfileSecurity> enablePasswordProtection(
  PasswordCredential credential
)
```

### Preconditions

- Es existiert kein Credential.
- `credential` ist gültig.

### Postconditions

- Das Credential ist vorhanden.
- Der Passwortschutz ist aktiviert.
- Die Entity bleibt in einem gültigen Sperrzustand.

---

## DomainResult<ProfileSecurity> disablePasswordProtection()

```text
DomainResult<ProfileSecurity> disablePasswordProtection(
  AuthenticationProof proof,
  Timestamp now
)
```

### Preconditions

- Ein Credential ist vorhanden.
- Das Aggregate Root hat die erforderliche Authentifizierung bereits geprüft.

### Postconditions

- Das Credential ist entfernt.
- `LockState` ist `unlocked`.

---

## DomainResult<ProfileSecurity> changePasswordCredential(
  PasswordCredential newCredential
)

```text
DomainResult<ProfileSecurity> changePasswordCredential(
  PasswordCredential newCredential,
  AuthenticationProof proof,
  Timestamp now
)
```

### Preconditions

- Der Passwortschutz ist aktiviert.
- Das Aggregate Root hat die erforderliche Authentifizierung bereits geprüft.
- `newCredential` ist gültig.

### Postconditions

- Das alte Credential wurde vollständig ersetzt.
- Der Sperrzustand bleibt fachlich konsistent.

---

## lock()

```text
DomainResult<ProfileSecurity> lock(Timestamp now)
```

### Preconditions

- Der Passwortschutz ist aktiviert.
- Der Zustand ist noch nicht `locked`.

### Postconditions

- `lockState` ist `locked`.
- `lockedAt` entspricht `now`.

---

## unlock()

```text
DomainResult<ProfileSecurity> unlock(
  AuthenticationProof proof,
  Timestamp now
)
```

### Preconditions

- Der Zustand ist `locked`.
- Das Aggregate Root hat die erforderliche Authentifizierung bereits geprüft.

### Postconditions

- `lockState` ist `unlocked`.
- `unlockedAt` entspricht `now`.

---

## No-Change- und Wiederholungsregeln

Für Sicherheitsoperationen gelten folgende verbindliche Regeln:

| Operation | Bereits erreichter oder widersprüchlicher Zustand | Ergebnis |
|-----------|---------------------------------------------------|----------|
| `enablePasswordProtection()` | Credential bereits vorhanden | fachlicher Fehler |
| `disablePasswordProtection()` | kein Credential vorhanden | erfolgreicher No-Change |
| `changePasswordCredential()` | kein Credential vorhanden | fachlicher Fehler |
| `changePasswordCredential()` | neues Credential fachlich identisch | erfolgreicher No-Change |
| `lock()` | bereits gesperrt | erfolgreicher No-Change |
| `lock()` | kein Credential vorhanden | fachlicher Fehler |
| `unlock()` | bereits entsperrt | erfolgreicher No-Change |
| `unlock()` | kein Credential vorhanden | erfolgreicher No-Change |

Bei einem erfolgreichen No-Change:

- bleibt die Entity unverändert,
- werden Auditinformationen nicht aktualisiert,
- wird die Aggregate-Version nicht erhöht,
- wird kein Domain Event erzeugt.

Bei einem fachlichen Fehler bleibt die Entity ebenfalls unverändert und das
`DomainResult<ProfileSecurity>` enthält mindestens einen strukturierten
Fehler.

---

## Invarianten

- `securityId` ist unveränderlich.
- Klartextpasswörter sind niemals Bestandteil der Entity.
- Ein deaktivierter Passwortschutz besitzt kein Credential.
- Ein Profil ohne Credential kann nicht fachlich gesperrt sein.
- Ein Credential wird vollständig ersetzt.
- Fehlgeschlagene Operationen verändern die Entity nicht.
- Die Entity veröffentlicht keine Events selbst.
- Das Aggregate Root übersetzt erfolgreiche Sicherheitsänderungen in Domain Events.

---

# Value Object: ProfileImage

## Zweck

`ProfileImage` beschreibt die fachliche Referenz und Metadaten eines Profilbilds.

Es enthält weder Binärdaten noch direkt interpretierbare Dateipfade.

---

## Attribute

| Attribut | Typ |
|---|---|
| reference | ImageReference |
| mediaType | MediaType |
| dimensions | ImageDimensions |
| checksum | ImageChecksum? |

---

## Erzeugung

```text
DomainResult<ProfileImage> ProfileImage.create(
  ImageReference reference,
  MediaType mediaType,
  ImageDimensions dimensions,
  ImageChecksum? checksum
)
```

### Preconditions

- Alle enthaltenen Value Objects sind gültig.
- Der Medientyp ist freigegeben.
- Die Dimensionen liegen innerhalb der fachlichen Grenzen.

### Ergebnis

Erfolg:

- gültiges unveränderliches `ProfileImage`.

Fehler:

- kein `ProfileImage`,
- strukturierte Domain Messages.

---

## Regeln

- Das Value Object besitzt keine Identität.
- Änderungen ersetzen es vollständig.
- Die technische Speicherung ist nicht Teil der Domäne.
- Die technische Löschung ist nicht Teil des Value Objects.
- Gleichheit richtet sich nach allen enthaltenen Werten.

---

# Value Object: AuditInformation

## Zweck

`AuditInformation` beschreibt die fachlichen Zeit- und Versionsinformationen des Aggregats.

---

## Attribute

| Attribut | Typ |
|---|---|
| createdAt | Timestamp |
| updatedAt | Timestamp |
| version | AggregateVersion |

---

## createInitial()

```text
DomainResult<AuditInformation> AuditInformation.createInitial(
  Timestamp now
)
```

### Ergebnis

- `createdAt` entspricht `now`.
- `updatedAt` entspricht `now`.
- `version` entspricht der initialen Aggregate-Version.

---

## touchAndIncrement()

```text
DomainResult<AuditInformation> touchAndIncrement(
  Timestamp now
)
```

### Preconditions

- `now` liegt nicht vor `createdAt`.
- `now` liegt nicht vor dem bisherigen `updatedAt`.

### Postconditions

- `createdAt` bleibt unverändert.
- `updatedAt` entspricht `now`.
- Die Version wurde genau einmal erhöht.

---

## Regeln

- Das Value Object ist unveränderlich.
- Reine Leseoperationen verändern es nicht.
- Fehlgeschlagene Operationen erzeugen keine neue Instanz.
- Eine erfolgreiche fachliche Änderung verwendet genau eine neue Instanz.
- Version und Zeitstempel werden gemeinsam aktualisiert.

---

# Interne Änderungsstrategie

Das Domänenmodell kann technisch:

- mutable Entities mit kontrollierten privaten Änderungen

oder:

- vollständig immutable Aggregate

verwenden.

Unabhängig von der Implementierung gelten fachlich dieselben Regeln:

- keine sichtbaren Teilzustände,
- kein Zustand nach fehlgeschlagener Operation,
- `DomainResult<T>` enthält nur einen konsistenten Erfolgswert,
- Value Objects bleiben unveränderlich.

Die konkrete Dart-Strategie wird im Implementierungs- und Architekturleitfaden festgelegt.

---

# DomainResult-Regeln für Entities

## Erfolgreiche Änderung

```text
DomainResult<T>
├── value
├── warnings?
├── information?
└── errors: leer
```

## Fachlicher Fehler

```text
DomainResult<T>
├── value: nicht vorhanden oder unveränderter Ausgangswert gemäß Standard
├── warnings?
├── information?
└── errors: mindestens ein Eintrag
```

## No-Change-Ergebnis

```text
DomainResult<T>
├── value: aktueller gültiger Zustand
├── information:
│   └── noChange
└── errors: leer
```

Die genaue Repräsentation wird zentral im `ERROR_HANDLING_GUIDE.md` festgelegt.

---

# Beziehungen innerhalb des Aggregats

```text
Profile
│
├── besitzt genau eine ProfileSettings-Entity
│   ├── enthält genau ein LocalizationSettings-Value-Object
│   ├── enthält genau ein DashboardSettings-Value-Object
│   └── enthält genau ein AppearanceSettings-Value-Object
│
├── besitzt genau eine ProfileSecurity-Entity
│   ├── enthält optional ein PasswordCredential-Value-Object
│   └── enthält genau ein LockState-Value-Object
│
├── enthält optional ein ProfileImage-Value-Object
│
└── enthält genau ein AuditInformation-Value-Object
```

Alle Bestandteile gehören zur selben Konsistenzgrenze.

Untergeordnete Entities werden ausschließlich über das Aggregate Root verändert.

---

# Entity-Invarianten

| ID | Invariante |
|---|---|
| PRO-EINV-001 | `ProfileSettingsId` ist unveränderlich. |
| PRO-EINV-002 | `ProfileSettings` enthält alle erforderlichen Einstellungsbereiche. |
| PRO-EINV-003 | `ProfileSecurityId` ist unveränderlich. |
| PRO-EINV-004 | Ein fehlendes Credential bedeutet deaktivierten Passwortschutz. |
| PRO-EINV-005 | Ein Profil ohne Credential ist nicht gesperrt. |
| PRO-EINV-006 | Untergeordnete Entities sind außerhalb des Aggregats nicht direkt veränderbar. |
| PRO-EINV-007 | Fehlgeschlagene Entity-Operationen verändern keinen Zustand. |
| PRO-EINV-008 | Entity-Operationen veröffentlichen keine Domain Events selbst. |
| PRO-EINV-009 | Value Objects werden bei Änderungen vollständig ersetzt. |
| PRO-EINV-010 | Jede erfolgreiche Änderung wird durch das Aggregate Root auditiert. |

---

# Status dieses Teils

Mit Teil 3 sind aktualisiert und vollständig definiert:

- `Profile` als Aggregate Root,
- Stammdatenoperationen mit `DomainResult<T>`,
- Lebenszyklusoperationen,
- Standardprofiloperationen,
- Einstellungsoperationen,
- Sicherheitsoperationen,
- Profilbildoperationen,
- Löschentscheidung,
- `ProfileSettings`,
- `ProfileSecurity`,
- `ProfileImage`,
- `AuditInformation`,
- Preconditions,
- Postconditions,
- No-Change-Verhalten,
- Entity-Invarianten,
- Beziehungen innerhalb des Aggregats.

---

# Teil 4

Der nächste aktualisierte Abschnitt enthält:

- allgemeine Value-Object-Regeln,
- Factory-Methoden mit `DomainResult<T>`,
- grundlegende fachliche Value Objects,
- Zeit-, Versions-, Bild- und Sicherheitsobjekte,
- Enumerationen,
- Equality-Regeln,
- Serialisierungsgrenzen.

# Value Objects

## Zweck

Value Objects repräsentieren fachliche Werte ohne eigene Identität.

Sie beschreiben Eigenschaften eines Profils ausschließlich über ihren fachlichen Inhalt. Zwei Value Objects sind gleich, wenn ihre enthaltenen Werte gleich sind.

Value Objects

- besitzen keine Identität,
- sind unveränderlich,
- validieren sich selbst bei der Erzeugung,
- können niemals einen ungültigen Zustand besitzen,
- enthalten keine Infrastrukturabhängigkeiten,
- enthalten keine Geschäftsprozesse.

---

# Allgemeine Regeln

## PRO-VO-001 – Unveränderlichkeit

Nach erfolgreicher Erzeugung darf sich ein Value Object nicht mehr verändern.

Jede fachliche Änderung erzeugt eine neue Instanz.

---

## PRO-VO-002 – Wertbasierte Gleichheit

Die Gleichheit richtet sich ausschließlich nach den enthaltenen fachlichen Werten.

Die Objektidentität besitzt keine fachliche Bedeutung.

---

## PRO-VO-003 – Immer gültiger Zustand

Ein Value Object existiert ausschließlich in einem gültigen Zustand.

Ungültige Instanzen dürfen niemals erzeugt werden.

---

## PRO-VO-004 – Selbstvalidierung

Die vollständige Validierung erfolgt während der Erzeugung.

Nach erfolgreicher Erzeugung sind keine weiteren Validierungen erforderlich.

---

## PRO-VO-005 – Keine Infrastruktur

Value Objects kennen keine

- Flutter-Klassen,
- Datenbanken,
- SQLite,
- Drift,
- Hive,
- REST,
- JSON,
- Dateisysteme,
- Plattform-APIs.

---

## PRO-VO-006 – Primitive Datentypen kapseln

Fachlich relevante primitive Datentypen werden grundsätzlich gekapselt.

Beispiele

```text
String        → ProfileName
UUID          → ProfileId
Integer       → BirthYear
Decimal       → Height
Integer       → ProfileColor
```

---

## PRO-VO-007 – Einheitliche Factory-Konvention

Alle Factory-Methoden folgen einer einheitlichen Benennung.

Zulässige Benennungsmuster sind:

```text
create(...)

create<Zustand>(...)

from<Repräsentation>(...)

parse<Format>(...)

generate()
```

Beispiele zulässiger Factory-Namen

```text
create()

createInitial()

createEnabled()

createDisabled()

createLocked()

createUnlocked()

createVerified()

fromString()

fromUuid()

fromValue()

fromHex()

fromArgb()

fromMeters()

fromCentimeters()

fromUtc()

fromPersistedValue()

fromPersistedValues()

parseIso8601()

generate()
```

Die konkrete Factory-Bezeichnung muss eindeutig ausdrücken,

- welcher fachliche Zustand erzeugt wird,
- aus welcher Repräsentation ein Value Object rekonstruiert wird,
- welches Eingabeformat geparst wird,
- oder dass eine neue Identität erzeugt wird.

`generate()` ist ausschließlich für Typen zulässig, deren fachliche Aufgabe die Erzeugung einer neuen Identität umfasst.

Factory-Methoden erzeugen ausschließlich gültige Value Objects.

Sie

- speichern keine Daten,
- veröffentlichen keine Domain Events,
- öffnen keine Transaktionen.

---

# DomainResult<T>

## Zweck

Alle Factory-Methoden liefern ein einheitliches Ergebnis.

```text
DomainResult<T>
```

Dadurch werden

- erfolgreiche Ergebnisse,
- Validierungsfehler,
- Business-Warnungen,
- Informationen

einheitlich beschrieben.

Die konkrete Implementierung wird projektweit im

```text
ERROR_HANDLING_GUIDE.md
```

festgelegt.

---

## Erfolgreiches Ergebnis

```text
DomainResult<ProfileName>

value vorhanden

errors leer
```

---

## Fehlerhaftes Ergebnis

```text
DomainResult<ProfileName>

value nicht vorhanden

errors vorhanden
```

---

## Warnungen

Warnungen können gemeinsam mit einem erfolgreichen Ergebnis auftreten.

Beispiel

```text
DomainResult<ProfileName>

value vorhanden

warnings vorhanden
```

---

## Informationen

Informationen verändern die fachliche Gültigkeit nicht.

Beispiel

```text
information

noChange
```

---

# Value Object

# ProfileId

## Zweck

`ProfileId` repräsentiert die dauerhafte fachliche Identität eines Profils.

Die ID besitzt keinerlei fachliche Bedeutung außer ihrer Eindeutigkeit.

---

## Interner Wert

```text
UUID
```

---

## Factory

Vorhandene IDs

DomainResult<ProfileId>

fromString(value)

Die Erzeugung neuer Profil-IDs erfolgt außerhalb des Value Objects über
eine definierte Abstraktion.

`ProfileId` validiert und kapselt ausschließlich eine bereits erzeugte UUIDv7.

---

## Regeln

Eine ProfileId

- muss vorhanden sein,
- muss ein gültiges UUID-Format besitzen,
- ist unveränderlich,
- darf niemals wiederverwendet werden,
- enthält keine personenbezogenen Informationen,
- darf nicht aus Profilnamen erzeugt werden.

---

### Zuständigkeit der Validierungsfehler

Nicht alle dokumentierten Validierungsfehler werden durch das Value Object selbst ausgelöst.

| Error Code | Zuständige Komponente |
|------------|-----------------------|
| PRO-VAL-ID-001 | ProfileId |
| PRO-VAL-ID-002 | ProfileId |
| PRO-VAL-ID-003 | Profile Aggregate |
| PRO-VAL-ID-004 | Application Service oder Repository-Port |

Das Value Object `ProfileId` prüft ausschließlich lokal validierbare Regeln.

Regeln, die einen historischen Zustand, mehrere Profile oder Persistenzinformationen benötigen, werden von der jeweils zuständigen Architekturkomponente geprüft.

---

## Equality

Zwei ProfileIds sind gleich,

wenn ihre normalisierte UUID identisch ist.

---

## Traceability

Requirements

- PRO-FR-001
- PRO-FR-003
- PRO-FR-025

Business Rules

- PRO-BR-006

Validation

- PRO-VR-011

Aggregate

- AG-INV-001

---

# Value Object

# ProfileName

## Zweck

`ProfileName` repräsentiert den sichtbaren Namen eines Profils.

---

## Interner Wert

```text
String
```

---

## Factory

```text
DomainResult<ProfileName>

create(value)
```

---

## Regeln

Der Name

- muss vorhanden sein,
- darf nach der Normalisierung nicht leer sein,
- darf nach der Normalisierung nicht ausschließlich aus Leerzeichen bestehen.

Die vollständigen Validierungsregeln werden in `PRO-VR-001` des Dokuments
`04_VALIDATION_RULES.md` definiert.

---

## Normalisierung

Vor der Validierung werden

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Leerzeichen innerhalb des Namens und die Groß-/Kleinschreibung bleiben
unverändert erhalten.

Die vollständigen Normalisierungsregeln werden in `PRO-VR-001` des Dokuments
`04_VALIDATION_RULES.md` definiert.

---

## Vergleichsschlüssel

Für Vergleiche kann optional erzeugt werden

```text
comparisonKey()
```

Der Schlüssel dient ausschließlich

- der Duplikaterkennung,
- der Groß-/Kleinschreibungsnormalisierung,
- der Leerzeichennormalisierung.

Er ersetzt nicht den sichtbaren Profilnamen.

---

## Equality

Die Gleichheit erfolgt anhand des normalisierten sichtbaren Namens.

---

## Hinweis

Die Prüfung, ob bereits ein Profil mit gleichem Namen existiert,

gehört nicht zum Value Object.

Diese Verantwortung besitzt

```text
ProfileUniquenessService
```

---

## Traceability

Requirements

- PRO-FR-011
- PRO-FR-023

Business Rules

- PRO-BR-014

Validation

- PRO-VR-001
- PRO-VR-009

Aggregate

- AG-INV-002

---

# Value Object

# BirthYear

## Zweck

`BirthYear` repräsentiert das Geburtsjahr eines Profils.

Gespeichert wird ausschließlich das Jahr.

---

## Interner Wert

```text
Integer
```

---

## Factory

```text
DomainResult<BirthYear>

create(
    value,
    currentYear
)
```

---

## Regeln

Das Geburtsjahr

- besitzt genau vier Stellen,
- ist mindestens 1900,
- überschreitet niemals das aktuelle Kalenderjahr.

---

## Zeitabhängigkeit

Die Factory liest niemals selbst die Systemzeit.

Das aktuelle Kalenderjahr wird übergeben.

Dadurch bleibt das Value Object vollständig testbar.

---

## Abgeleitete Berechnung

Optional

```text
age(referenceYear)
```

liefert

das ungefähre Alter.

Da nur das Geburtsjahr gespeichert wird,

ist keine exakte Altersberechnung möglich.

---

## Equality

Zwei BirthYears sind gleich,

wenn ihre Jahreszahl identisch ist.

---

## Traceability

Requirements

- PRO-FR-012

Business Rules

- PRO-BR-013

Validation

- PRO-VR-002

---

# Status dieses Abschnitts

Mit Teil 4A-1 sind definiert

- allgemeine Regeln für Value Objects,
- einheitliche Factory-Konvention,
- DomainResult<T>,
- ProfileId,
- ProfileName,
- BirthYear.

Alle beschriebenen Value Objects

- sind unveränderlich,
- validieren sich selbst,
- besitzen keine Infrastrukturabhängigkeiten,
- verwenden ausschließlich DomainResult<T>,
- folgen einer einheitlichen Factory-Konvention.

---

# Teil 4A-2

Der nächste Abschnitt enthält

- Height,
- ProfileColor,
- DefaultProfileFlag,
- gemeinsame Equality-Regeln,
- projektweite Factory-Richtlinien.

# Value Object

# Height

## Zweck

`Height` repräsentiert die Körpergröße eines Profils.

Die Domäne speichert Körpergrößen unabhängig von Eingabe- oder Anzeigeformaten immer in einer kanonischen Einheit.

---

## Interner Wert

```text
Decimal
```

---

## Kanonische Einheit

```text
Zentimeter
```

Alle Berechnungen innerhalb der Domäne erfolgen auf Basis des normalisierten Zentimeterwertes.

---

## Factory

### Zentimeter

```text
DomainResult<Height>

fromCentimeters(value)
```

### Meter

```text
DomainResult<Height>

fromMeters(value)
```

---

## Regeln

Eine gültige Körpergröße

- beträgt mindestens 20 cm,
- beträgt höchstens 300 cm,
- wird intern immer in Zentimetern gespeichert.

---

## Normalisierung

Unabhängig von der Eingabeeinheit wird intern derselbe normalisierte Zentimeterwert erzeugt.

Beispiele

```text
1,80 m

↓

180,0 cm
```

```text
180 cm

↓

180,0 cm
```

---

## Zugriff

```text
inCentimeters()

inMeters()
```

Diese Methoden erzeugen lediglich unterschiedliche fachliche Darstellungen desselben Wertes.

---

## Equality

Zwei `Height`-Objekte sind gleich,

wenn ihre normalisierten Zentimeterwerte identisch sind.

---

## Rundung

Rundungen erfolgen ausschließlich nach den zentral definierten Projektregeln.

Eine Eingabe darf nicht unbemerkt in einen fachlich anderen Wert verändert werden.

---

## Traceability

Requirements

- PRO-FR-013

Business Rules

- PRO-BR-013

Validation

- PRO-VR-003

Aggregate

- AG-INV-012

---

# Value Object

# ProfileColor

## Zweck

`ProfileColor` beschreibt die individuelle Akzentfarbe eines Profils.

Die Farbe dient ausschließlich der visuellen Unterscheidung von Profilen.

Sie besitzt keine fachliche Bedeutung.

---

## Interner Wert

```text
ARGB
```

Flutter-spezifische Klassen wie

```text
Color
```

gehören nicht zur Domäne.

---

## Factory

### ARGB

```text
DomainResult<ProfileColor>

fromArgb(value)
```

### Hex

```text
DomainResult<ProfileColor>

fromHex(value)
```

---

## Regeln

Eine Profilfarbe

- besitzt einen vollständigen Farbwert,
- besitzt gültige Farbkanäle,
- ersetzt keine fachlichen Statusfarben,
- muss barrierefreie Darstellung ermöglichen.

---

## Darstellung

Das Value Object kennt keine

- Widgets,
- Themes,
- Flutter-Objekte,
- Material-Farben.

Die Umwandlung erfolgt ausschließlich außerhalb der Domäne.

---

## Textuelle Repräsentation

Die kanonische Hex-Repräsentation besteht aus genau acht hexadezimalen Zeichen
im Format:

AARRGGBB

Beispiele:

FF00AA33
80000000

Präfixe wie `#` oder `0x` sind nicht Bestandteil der kanonischen
Domain-Repräsentation.

---

## Zugriff

```text
toArgb()

toHex()
```

---

## Equality

Die Gleichheit erfolgt anhand sämtlicher normalisierter Farbkanäle.

---

## Traceability

Requirements

- PRO-FR-016

Business Rules

- PRO-BR-016

Validation

- PRO-VR-005

---

# Value Object

# DefaultProfileFlag

## Zweck

`DefaultProfileFlag` beschreibt,

ob ein einzelnes Profil als Standardprofil markiert ist.

---

## Interner Wert

```text
Boolean
```

---

## Factory

Standardprofil

```text
DomainResult<DefaultProfileFlag>

createEnabled()
```

Kein Standardprofil

```text
DomainResult<DefaultProfileFlag>

createDisabled()
```

---

## Werte

```text
default
```

oder

```text
notDefault
```

---

## Regeln

Dieses Value Object beschreibt ausschließlich

den Zustand eines einzelnen Profils.

Die profilübergreifende Regel

```text
höchstens ein Standardprofil
```

kann innerhalb dieses Value Objects nicht geprüft werden.

Sie wird geschützt durch

```text
DefaultProfileCoordinator
```

---

## Equality

Die Gleichheit richtet sich ausschließlich nach dem enthaltenen Wahrheitswert.

---

## Traceability

Requirements

- PRO-FR-009

Business Rules

- PRO-BR-012

Validation

- PRO-VR-013

---

# Gemeinsame Equality-Regeln

## Allgemeine Regel

Value Objects besitzen keine Identität.

Die Gleichheit richtet sich ausschließlich nach ihren fachlichen Werten.

---

## ProfileId

Vergleich

```text
UUID
```

---

## ProfileName

Vergleich

```text
normalisierter Name
```

---

## BirthYear

Vergleich

```text
Jahreszahl
```

---

## Height

Vergleich

```text
normalisierte Zentimeter
```

---

## ProfileColor

Vergleich

```text
ARGB
```

---

## DefaultProfileFlag

Vergleich

```text
Boolean
```

---

## Referenzgleichheit

Die Speicheradresse eines Objekts besitzt keinerlei fachliche Bedeutung.

---

# Projektweite Factory-Richtlinien

Alle Value Objects verwenden dieselben Factory-Konventionen.

---

## Zulässige Factory-Benennungsmuster

Factory-Namen werden anhand ihrer fachlichen Funktion gebildet.

```text
create(...)

create<Zustand>(...)

from<Repräsentation>(...)

parse<Format>(...)

generate()
```

Beispiele:

```text
create(...)

createInitial()

createEnabled()

createDisabled()

createLocked(...)

createUnlocked(...)

createVerified(...)

fromString(...)

fromUuid(...)

fromValue(...)

fromHex(...)

fromArgb(...)

fromMeters(...)

fromCentimeters(...)

fromUtc(...)

fromPersistedValue(...)

fromPersistedValues(...)

parseIso8601(...)

generate()
```

Diese Beispiele sind nicht abschließend.

Die konkrete Factory-Bezeichnung muss eindeutig ausdrücken,

- ob ein allgemeiner gültiger Wert erzeugt wird,
- welcher fachliche Zustand erzeugt wird,
- aus welcher Repräsentation rekonstruiert wird,
- welches Format geparst wird,
- oder ob eine neue Identität erzeugt wird.

---

## Rückgabewert

Jede Factory liefert

```text
DomainResult<T>
```

---

## Factory-Verantwortung

Factories

- validieren Eingaben,
- erzeugen ausschließlich gültige Instanzen,
- normalisieren Eingabewerte,
- liefern strukturierte Fehler.

Factories

- speichern keine Daten,
- veröffentlichen keine Domain Events,
- öffnen keine Transaktionen,
- besitzen keine Infrastrukturabhängigkeiten.

---

## Fehlerbehandlung

Fachliche Fehler werden ausschließlich über

```text
DomainResult<T>
```

signalisiert.

Factory-Methoden werfen keine Exceptions für erwartbare Validierungsfehler.

---

## No-Change-Regel

Factories erzeugen immer neue Value Objects.

Ein "No Change"-Zustand existiert ausschließlich bei fachlichen Operationen von Entities oder Aggregaten.

Value Objects kennen keinen Änderungszustand.

---

## Testbarkeit

Alle Factory-Methoden müssen deterministisch sein.

Bei identischen Eingaben liefern sie stets dasselbe Ergebnis.

Zeitabhängige Informationen dürfen ausschließlich über explizite Parameter (z. B. `currentYear`) eingebracht werden.

---

# Architekturprinzipien

Für sämtliche Value Objects gelten zusätzlich folgende Prinzipien:

- keine öffentliche Mutation,
- vollständige Kapselung,
- keine Infrastrukturreferenzen,
- keine technischen Seiteneffekte,
- keine Persistenzlogik,
- keine Serialisierung,
- keine UI-Abhängigkeiten,
- vollständige Testbarkeit,
- deterministische Factory-Ergebnisse,
- unveränderliche Instanzen.

---

# Status dieses Abschnitts

Mit Teil 4A-2 sind vollständig definiert:

- `Height`
- `ProfileColor`
- `DefaultProfileFlag`
- gemeinsame Equality-Regeln
- projektweite Factory-Konventionen
- projektweite Architekturprinzipien für Value Objects

Zusammen mit **Teil 4A-1** bilden diese Abschnitte die vollständige Grundlage für alle grundlegenden Value Objects des Profilmoduls.

---

# Teil 4B

Der nächste Abschnitt enthält:

- `ProfileImage`
- `ImageReference`
- `ImageDimensions`
- `ImageChecksum`
- `PasswordCredential`
- `PasswordHash`
- `PasswordHashParameters`
- `LockState`
- `AuditInformation`
- `Timestamp`
- `AggregateVersion`
- `ProfileSettingsId`
- `ProfileSecurityId`
- sämtliche Enumerationen
- Serialisierungsgrenzen
- Abschluss des Value-Object-Modells.

# Erweiterte Value Objects

# Value Object: ProfileImage

## Zweck

`ProfileImage` beschreibt die fachliche Referenz und die Metadaten eines Profilbilds.

Das Value Object enthält keine Binärdaten und keine direkt interpretierbaren Dateipfade.

## Attribute

| Attribut | Typ | Pflicht |
|---|---|---:|
| reference | ImageReference | Ja |
| mediaType | MediaType | Ja |
| dimensions | ImageDimensions | Ja |
| checksum | ImageChecksum? | Nein |

## Factory

```text
DomainResult<ProfileImage> create(
  ImageReference reference,
  MediaType mediaType,
  ImageDimensions dimensions,
  ImageChecksum? checksum
)
```

## Preconditions

- Alle enthaltenen Value Objects sind gültig.
- Der Medientyp ist für Profilbilder zugelassen.
- Die Bilddimensionen liegen innerhalb der definierten Grenzen.
- Die Bildverarbeitung wurde außerhalb der Domäne erfolgreich abgeschlossen.
- Die referenzierten Bilddaten enthalten keine unzulässigen Metadaten.

## Postconditions

Bei Erfolg:

- Es wurde ein gültiges und unveränderliches `ProfileImage` erzeugt.
- Das Value Object enthält keine technischen Binärdaten.
- Es wurden keine Dateien gespeichert oder verändert.

Bei Fehler:

- Es wird keine Instanz erzeugt.
- `DomainResult<ProfileImage>` enthält strukturierte Domain Messages.

## Regeln

- Ein neues Profilbild ersetzt das bisherige vollständig.
- Das Value Object besitzt keine eigene fachliche Identität.
- Die Domäne kennt keine Dateipfade.
- Die Domäne kennt keine Speichertechnologie.
- Die technische Löschung eines ersetzten Bildes wird außerhalb der Domäne koordiniert.
- Die Gleichheit richtet sich nach allen enthaltenen fachlichen Werten.

## Traceability

- PRO-FR-015
- PRO-BR-017
- PRO-VR-010
- AG-INV-005

---

# Value Object: ImageReference

## Zweck

`ImageReference` stellt eine undurchsichtige, technologieunabhängige Referenz auf extern gespeicherte Bilddaten dar.

## Interner Wert

```text
Opaque String
```

## Factory

```text
DomainResult<ImageReference> create(value)
```

## Regeln

Die Referenz:

- MUSS vorhanden sein.
- DARF nicht leer sein.
- DARF keine Zugangsdaten enthalten.
- DARF keine personenbezogenen Informationen enthalten.
- DARF keinen direkt interpretierbaren Betriebssystempfad voraussetzen.
- MUSS über den zuständigen Infrastrukturport auflösbar sein.

## Zulässiges Konzept

```text
profile-image://550e8400-e29b-41d4-a716-446655440000
```

## Nicht zulässiges Domänenformat

```text
C:\Users\User\Pictures\profile.jpg
```

oder:

```text
/home/user/profile.jpg
```

## Equality

Zwei Referenzen sind gleich, wenn ihre normalisierten undurchsichtigen Kennungen identisch sind.

---

# Value Object: ImageDimensions

## Zweck

`ImageDimensions` beschreibt die Breite und Höhe eines verarbeiteten Profilbilds.

## Attribute

| Attribut | Typ |
|---|---|
| width | PositiveInteger |
| height | PositiveInteger |

## Einheit

```text
Pixel
```

## Factory

```text
DomainResult<ImageDimensions> create(
  int width,
  int height
)
```

## Regeln

- Breite und Höhe müssen größer als null sein.
- Breite und Höhe dürfen die zentral definierten Maximalwerte nicht überschreiten.
- Die Werte müssen ganzzahlig sein.
- Die Dimensionen beschreiben das bereits verarbeitete Bild.

## Abgeleitete Werte

```text
aspectRatio()
```

Das Seitenverhältnis wird deterministisch aus Breite und Höhe berechnet.

## Equality

Zwei Instanzen sind gleich, wenn Breite und Höhe identisch sind.

---

# Value Object: ImageChecksum

## Zweck

`ImageChecksum` beschreibt einen Integritätswert der verarbeiteten Bilddaten.

## Attribute

| Attribut | Typ |
|---|---|
| algorithm | ChecksumAlgorithm |
| value | String |

## Factory

```text
DomainResult<ImageChecksum> create(
  ChecksumAlgorithm algorithm,
  String value
)
```

## Regeln

- Der Algorithmus muss unterstützt werden.
- Der Wert muss vorhanden sein.
- Der Wert muss dem erwarteten Format des Algorithmus entsprechen.
- Der Wert ist unveränderlich.
- Die Checksum dient ausschließlich der Integritätsprüfung.
- Sie ist weder Passwort-Hash noch kryptographischer Schlüssel.

## Equality

Die Gleichheit richtet sich nach Algorithmus und normalisiertem Checksum-Wert.

---

# Sicherheits-Value-Objects

# Value Object: PasswordCredential

## Zweck

`PasswordCredential` repräsentiert den vollständigen fachlichen Nachweis
eines bereits kryptographisch verarbeiteten Passworts.

Das Value Object enthält ausschließlich die für eine spätere technische
Passwortverifikation erforderlichen Bestandteile.

Es enthält niemals ein Klartextpasswort.

Die Erzeugung eines neuen Credentials aus einem `PlainPassword` erfolgt
ausschließlich außerhalb der Domain durch den zuständigen Security Port.

Die Domain kann ein bereits vollständig erzeugtes Credential kontrolliert
übernehmen oder rekonstruieren.

---

## Attribute

| Attribut | Typ | Bedeutung |
|---|---|---|
| hash | PasswordHash | Bereits kryptographisch erzeugter Passwort-Hash |
| algorithm | PasswordAlgorithm | Algorithmus, mit dem der Hash erzeugt wurde |
| parameters | PasswordHashParameters | Bei der Hash-Erzeugung verwendete Parameter |
| createdAt | Timestamp | Fachlicher Erzeugungszeitpunkt des Credentials |

---

## Interne Repräsentation

```text
hash: PasswordHash
algorithm: PasswordAlgorithm
parameters: PasswordHashParameters
createdAt: Timestamp
```

Alle Attribute sind unveränderlich.

Das Value Object besitzt keine eigene fachliche Identität.

---

## Kontrollierte Erzeugung und Rekonstruktion

Die kontrollierte Übernahme eines vollständig erzeugten Credentials sowie
die Rekonstruktion eines bereits gespeicherten Credentials erfolgen
ausschließlich über:

```text
DomainResult<PasswordCredential> create(
  PasswordHash? hash,
  PasswordAlgorithm? algorithm,
  PasswordHashParameters? parameters,
  Timestamp? createdAt
)
```

Dieselbe Factory wird sowohl verwendet für

- die Übernahme eines durch einen Security Port neu erzeugten Credentials,
- die Rekonstruktion eines bereits gespeicherten Credentials.

Es existiert keine weitere öffentliche Factory.

Die Factory erzeugt selbst

- keinen Passwort-Hash,
- keinen Salt,
- keine Hashparameter,
- keinen Erzeugungszeitpunkt.

Sie übernimmt ausschließlich bereits kontrolliert erzeugte und gültige
Domänenwerte.

---

## Fachliche Regeln

Für `PasswordCredential` gilt:

- `hash` MUSS vorhanden und gültig sein.
- `algorithm` MUSS vorhanden und gültig sein.
- `parameters` MUSS vorhanden und gültig sein.
- `createdAt` MUSS vorhanden und gültig sein.
- Alle vier Bestandteile MÜSSEN gemeinsam einen vollständigen Zustand
  bilden.
- Eine teilweise erzeugte oder teilweise rekonstruierte Instanz ist
  unzulässig.
- Das Credential MUSS vollständig unveränderlich sein.
- Das Credential DARF kein `PlainPassword` enthalten.
- Das Credential DARF keine `AuthenticationProof`-Instanz enthalten.
- Das Credential DARF keine kryptographischen Schlüssel enthalten.
- Die Domain DARF keinen fehlenden Bestandteil durch einen Standardwert
  ersetzen.
- Die Domain DARF den verwendeten Algorithmus oder die Hashparameter nicht
  automatisch verändern.
- Der Hash und der Salt-Wert DÜRFEN niemals über Domain Messages,
  Fehlerparameter, Logs oder `toString()` offengelegt werden.

Für Version 1 gilt zusätzlich:

```text
algorithm = argon2id
```

Ein Credential mit einem anderen Algorithmus ist kein gültiger
`PasswordCredential`-Zustand des Profilmoduls in Version 1.

---

## Konsistenzregeln

Die Bestandteile eines Credentials müssen fachlich zusammengehören.

Es gilt:

- `hash` wurde mit dem angegebenen `algorithm` erzeugt.
- `hash` wurde mit den angegebenen `parameters` erzeugt.
- `createdAt` bezeichnet den Zeitpunkt, zu dem genau dieses Credential
  erzeugt wurde.

Die Domain kann diese kryptographischen Zusammenhänge nicht selbst
technisch verifizieren.

Die Verantwortung dafür liegt beim zuständigen Security Port.

Die Domain setzt voraus, dass ein Security Port ausschließlich konsistente
Bestandteile zu einem `PasswordCredential` zusammensetzt.

---

## Preconditions

Für `create(...)` gilt:

- `hash` ist vorhanden und gültig.
- `algorithm` ist vorhanden und gültig.
- `parameters` ist vorhanden und gültig.
- `createdAt` ist vorhanden und gültig.
- `algorithm` entspricht `argon2id`.

---

## Erfolgsverhalten

Bei erfolgreicher Erzeugung oder Rekonstruktion gilt:

- Es wurde ein vollständiges `PasswordCredential` erzeugt.
- Alle vier Attribute entsprechen den übergebenen Domänenwerten.
- Alle Attribute sind unveränderlich.
- Es wurde kein Klartextpasswort verarbeitet.
- Es wurde keine kryptographische Operation ausgeführt.
- Es wurden keine sensiblen Inhalte offengelegt.
- Es wurden keine Domain Events erzeugt.
- Es wurden keine Audit- oder Versionsinformationen verändert.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein `PasswordCredential` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Es entsteht kein teilweise gültiger Credential-Zustand.
- Hashwerte, Salt-Werte und sonstige sensible Inhalte werden nicht in
  Fehlerparametern oder Domain Messages übertragen.
- Erwartbare Validierungsfehler erzeugen keine Exception.

Die konkreten Validation Errors werden in den Validation Rules definiert.

Fehler der enthaltenen Value Objects werden nicht zusätzlich als generische
`PasswordCredential`-Fehler dupliziert.

---

## Erzeugung durch Security Ports

Die technische Erzeugung eines neuen Credentials erfolgt über den
zuständigen Security Port.

Der Security Port

- erhält ein kurzlebiges `PlainPassword`,
- erzeugt einen kryptographischen Hash,
- erzeugt einen Salt,
- bestimmt die anzuwendenden Hashparameter,
- verwendet den verbindlichen `PasswordAlgorithm`,
- ermittelt den Erzeugungszeitpunkt,
- liefert ein vollständig gültiges `PasswordCredential`.

Die konkrete Port-Signatur wird in der zuständigen
Security-Spezifikation definiert.

`PasswordCredential.create(...)` ersetzt diese technische Operation nicht.

Die Factory dient ausschließlich der kontrollierten Zusammensetzung bereits
erzeugter Domänenwerte.

---

## Verifikation

`PasswordCredential` verifiziert selbst keine Passwörter.

Die technische Passwortverifikation erfolgt ausschließlich über den
zuständigen Security Port.

Dabei werden verwendet:

- das kurzlebige `PlainPassword`,
- der gespeicherte `PasswordHash`,
- der gespeicherte `PasswordAlgorithm`,
- die gespeicherten `PasswordHashParameters`.

Das Ergebnis der technischen Verifikation darf nicht durch einen direkten
Vergleich von Klartext- und Hashwert innerhalb der Domain ersetzt werden.

---

## Equality

Zwei `PasswordCredential`-Instanzen sind fachlich gleich, wenn alle
folgenden Bestandteile fachlich gleich sind:

- `hash`,
- `algorithm`,
- `parameters`,
- `createdAt`.

Die Gleichheitsprüfung darf keine sensiblen Werte offenlegen.

---

## HashCode

Der Hashcode basiert auf allen vier Attributen.

Er muss zur Equality-Definition konsistent sein.

Der Hashcode darf nicht in sichtbaren Ausgaben verwendet werden, um
Rückschlüsse auf enthaltene Sicherheitswerte zu ermöglichen.

---

## Sichere String-Darstellung

`toString()` darf weder den Passwort-Hash noch den Salt-Wert ausgeben.

Die sichere Darstellung lautet beispielsweise:

```text
PasswordCredential(
  algorithm: argon2id,
  createdAt: <timestamp>,
  hash: <redacted>,
  parameters: <redacted>
)
```

Die vollständigen `PasswordHashParameters` werden nicht ausgegeben, da sie
den Salt-Wert enthalten.

---

## Datenschutz und Sicherheit

Folgende Inhalte dürfen niemals Bestandteil sein von

- Domain Messages,
- Validation Errors,
- Business Errors,
- Information Codes,
- Logs,
- Audit-Daten,
- Monitoringdaten,
- Exceptions,
- sichtbaren `toString()`-Ausgaben:

```text
PlainPassword
PasswordHash.value
PasswordHashParameters.salt
AuthenticationProof
kryptographische Schlüssel
```

Das Credential darf dauerhaft gespeichert werden.

Ein `PlainPassword` darf niemals gemeinsam mit dem Credential gespeichert
werden.

---

## Lebenszyklus

Ein `PasswordCredential` wird nicht verändert.

Bei einer Passwortänderung wird ein vollständig neues
`PasswordCredential` erzeugt.

Das bisherige Credential wird anschließend atomar durch das neue Credential
ersetzt.

Eine teilweise Aktualisierung einzelner Credential-Bestandteile ist
unzulässig.

Insbesondere dürfen nicht unabhängig voneinander geändert werden:

- `hash`,
- `algorithm`,
- `parameters`,
- `createdAt`.

---

## Abgrenzung

Nicht Bestandteil dieses Value Objects sind:

- Klartextpasswörter,
- Passwortvalidierung,
- Passwortbestätigung,
- Passwort-Hashing,
- Passwortverifikation,
- Auswahl kryptographischer Bibliotheken,
- Erzeugung von Salt-Werten,
- Auswahl konkreter Hashparameter,
- Migration bestehender Credentials,
- Passwort-Historie,
- Lockout,
- Rate Limiting,
- Schlüsselverwaltung,
- `AuthenticationProof`,
- Persistenzlogik.

Diese Verantwortlichkeiten liegen ausschließlich bei den zuständigen
Security Ports, technischen Sicherheitskomponenten und den dafür
vorgesehenen Business Rules.

---

# Value Object: PasswordHash

## Zweck

`PasswordHash` repräsentiert den bereits kryptographisch erzeugten Hashwert
eines Passworts.

Der Typ enthält niemals ein Klartextpasswort.

Die Erzeugung des Hashwerts erfolgt ausschließlich außerhalb der Domain über
die zuständigen Security Ports.

Die Domain behandelt den Hashwert ausschließlich als undurchsichtigen,
unveränderlichen Sicherheitswert.

---

## Interner Wert

```text
OpaqueString
```

Der interne Wert wird als unveränderlicher String gespeichert.

Die Domain

- interpretiert den Wert nicht,
- zerlegt den Wert nicht,
- verändert den Wert nicht,
- leitet keine fachlichen Informationen aus seinem Inhalt ab.

---

## Kontrollierte Rekonstruktion

Die Rekonstruktion eines bereits vorhandenen Hashwerts erfolgt ausschließlich
über:

```text
DomainResult<PasswordHash> fromPersistedValue(
  String? value
)
```

Die Factory dient ausschließlich der kontrollierten Übernahme eines bereits
erzeugten Hashwerts.

Sie erzeugt selbst keinen neuen Hash.

---

## Fachliche Regeln

Für `PasswordHash` gilt:

- `value` MUSS vorhanden sein.
- `value` DARF nach dem Trimmen nicht leer sein.
- Der Wert MUSS als undurchsichtiger Sicherheitswert behandelt werden.
- Der Wert DARF nicht fachlich interpretiert werden.
- Der Wert DARF nicht aus einem Klartextpasswort innerhalb der Domain erzeugt
  werden.
- Der Wert DARF nicht in Domain Messages, Fehlerparametern, Logs oder
  `toString()` offengelegt werden.
- Die interne Repräsentation MUSS unveränderlich sein.
- Der Wert DARF nach der Erzeugung nicht verändert werden.
- Zwei `PasswordHash`-Instanzen sind fachlich gleich, wenn ihre internen Werte
  identisch sind.

---

## Normalisierung

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

Insbesondere dürfen nicht automatisch verändert werden:

- Groß- und Kleinschreibung,
- Sonderzeichen,
- Trennzeichen,
- kodierte Parameter,
- algorithmusspezifische Präfixe.

Die Domain muss den persistierten Hashwert nach dem Trimmen unverändert
übernehmen.

---

## Erfolgsverhalten

Bei erfolgreicher Rekonstruktion gilt:

- Es wurde ein gültiger `PasswordHash` erzeugt.
- Der interne Wert entspricht dem normalisierten persistierten Wert.
- Es wurde kein Klartextpasswort verarbeitet.
- Es wurde keine kryptographische Operation ausgeführt.
- Es wurden keine sensiblen Inhalte offengelegt.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein `PasswordHash` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Der ungültige Eingabewert wird nicht in Fehlerparametern oder Domain
  Messages übertragen.
- Es wird keine Exception für erwartbare Validierungsfehler geworfen.

Die konkreten Validation Errors werden in den Validation Rules definiert.

---

## Equality

Zwei `PasswordHash`-Instanzen sind fachlich gleich, wenn ihre internen
undurchsichtigen Stringwerte identisch sind.

Die Gleichheit basiert ausschließlich auf dem internen Wert.

---

## HashCode

Der Hashcode basiert ausschließlich auf dem internen Wert.

---

## Sichere String-Darstellung

`toString()` darf den tatsächlichen Hashwert niemals ausgeben.

Die sichere Darstellung lautet:

```text
PasswordHash(<redacted>)
```

---

## Datenschutz und Sicherheit

Der interne Hashwert darf niemals Bestandteil sein von

- Domain Messages,
- Validation Errors,
- Business Errors,
- Information Codes,
- Logs,
- Audit-Daten,
- Monitoringdaten,
- Exceptions,
- `toString()`-Ausgaben.

Vergleichsoperationen dürfen ausschließlich intern erfolgen.

---

## Abgrenzung

Nicht Bestandteil dieses Value Objects sind:

- Passwort-Hashing,
- Passwortverifikation,
- Klartextpasswörter,
- `PlainPassword`,
- Auswahl des Hashalgorithmus,
- Hashparameter,
- Salt-Erzeugung,
- kryptographische Bibliotheken,
- Schlüsselverwaltung,
- Credential-Erzeugung,
- Migration kryptographischer Verfahren.

Diese Verantwortlichkeiten liegen ausschließlich bei den zuständigen
Security Ports und technischen Sicherheitskomponenten.

---

# Value Object: PasswordHashParameters

## Zweck

`PasswordHashParameters` repräsentiert die Parameter, mit denen ein
`PasswordHash` erzeugt wurde.

Die Parameter werden gemeinsam mit dem Hash gespeichert, damit ein
bestehendes `PasswordCredential` später technisch verifiziert und bei Bedarf
migriert werden kann.

Das Value Object führt selbst keine kryptographischen Operationen aus.

Die Auswahl und Bewertung konkreter Parameterwerte erfolgt außerhalb der
Domain durch die zuständigen Security Ports und den `SECURITY_GUIDE.md`.

---

## Attribute

| Attribut | Typ | Bedeutung |
|---|---|---|
| memoryCostKiB | PositiveInteger | Verwendeter Speicheraufwand in Kibibyte |
| iterations | PositiveInteger | Anzahl der Iterationen |
| parallelism | PositiveInteger | Verwendeter Parallelitätsgrad |
| salt | OpaqueString | Bei der Hash-Erzeugung verwendeter Salt-Wert |

---

## Interne Repräsentation

```text
memoryCostKiB: PositiveInteger
iterations: PositiveInteger
parallelism: PositiveInteger
salt: OpaqueString
```

Alle Attribute sind unveränderlich.

Der Salt-Wert wird ausschließlich als undurchsichtiger String behandelt.

Die Domain interpretiert, dekodiert oder verändert den Salt-Wert nicht.

---

## Kontrollierte Erzeugung

Die kontrollierte Erzeugung erfolgt über:

```text
DomainResult<PasswordHashParameters> create(
  int? memoryCostKiB,
  int? iterations,
  int? parallelism,
  String? salt
)
```

Diese Factory wird für Parameter verwendet, die durch einen zuständigen
Security Port neu erzeugt wurden.

Sie führt selbst keine Parameterermittlung und keine kryptographische
Operation aus.

---

## Kontrollierte Rekonstruktion

Die kontrollierte Rekonstruktion bereits gespeicherter Parameter erfolgt
über:

```text
DomainResult<PasswordHashParameters> fromPersistedValues(
  int? memoryCostKiB,
  int? iterations,
  int? parallelism,
  String? salt
)
```

Die Rekonstruktionsfactory validiert dieselben fachlichen Invarianten wie
`create(...)`.

Sie führt keine Migration, Anpassung oder automatische Ersetzung bestehender
Parameter durch.

---

## Fachliche Regeln

Für `PasswordHashParameters` gilt:

- `memoryCostKiB` MUSS vorhanden sein.
- `memoryCostKiB` MUSS größer als `0` sein.
- `iterations` MUSS vorhanden sein.
- `iterations` MUSS größer als `0` sein.
- `parallelism` MUSS vorhanden sein.
- `parallelism` MUSS größer als `0` sein.
- `salt` MUSS vorhanden sein.
- `salt` DARF nach dem Trimmen nicht leer sein.
- Alle Attribute MÜSSEN gemeinsam einen vollständigen Zustand bilden.
- Das Value Object MUSS vollständig unveränderlich sein.
- Die Domain DARF keine fehlenden Parameter durch Standardwerte ersetzen.
- Unbekannte oder unvollständige Parameter DÜRFEN nicht stillschweigend
  akzeptiert werden.
- Der Salt-Wert DARF nicht in Domain Messages, Fehlerparametern, Logs oder
  `toString()` offengelegt werden.

Konkrete Mindest-, Höchst- und Zielwerte für

- `memoryCostKiB`,
- `iterations`,
- `parallelism`

werden nicht durch dieses Value Object festgelegt.

Diese Werte werden ausschließlich durch den `SECURITY_GUIDE.md` und die
zuständigen technischen Security-Komponenten bestimmt.

---

## Normalisierung

Für `salt` werden vor der Validierung ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

Insbesondere dürfen nicht automatisch verändert werden:

- Groß- und Kleinschreibung,
- Zeichenkodierung,
- Trennzeichen,
- Padding,
- algorithmusspezifische Bestandteile.

Numerische Parameter werden nicht normalisiert.

---

## Erfolgsverhalten

Bei erfolgreicher Erzeugung oder Rekonstruktion gilt:

- Es wurde ein vollständiges `PasswordHashParameters` erzeugt.
- Alle numerischen Werte sind größer als `0`.
- Der Salt-Wert ist vorhanden und nicht leer.
- Sämtliche Werte entsprechen den übergebenen normalisierten Werten.
- Es wurden keine kryptographischen Operationen ausgeführt.
- Es wurden keine sensiblen Werte offengelegt.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein `PasswordHashParameters` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Es entsteht kein teilweise gültiger Parameterzustand.
- Der Salt-Wert wird nicht in Fehlerparametern oder Domain Messages
  übertragen.
- Erwartbare Validierungsfehler erzeugen keine Exception.

Die konkreten Validation Errors werden in den Validation Rules definiert.

---

## Equality

Zwei `PasswordHashParameters`-Instanzen sind fachlich gleich, wenn alle
folgenden Attribute identisch sind:

- `memoryCostKiB`,
- `iterations`,
- `parallelism`,
- `salt`.

Die Gleichheitsprüfung erfolgt intern.

Der Salt-Wert darf dabei nicht offengelegt werden.

---

## HashCode

Der Hashcode basiert auf allen vier Attributen.

Er darf keine Rückschlüsse auf den Salt-Wert in einer sichtbaren Ausgabe
ermöglichen.

---

## Sichere String-Darstellung

`toString()` darf den Salt-Wert nicht ausgeben.

Die sichere Darstellung lautet beispielsweise:

```text
PasswordHashParameters(
  memoryCostKiB: <value>,
  iterations: <value>,
  parallelism: <value>,
  salt: <redacted>
)
```

Die numerischen Parameter dürfen dargestellt werden, sofern der
`SECURITY_GUIDE.md` dies nicht weiter einschränkt.

Der Salt-Wert bleibt immer verborgen.

---

## Datenschutz und Sicherheit

Der Salt-Wert darf niemals Bestandteil sein von:

- Domain Messages,
- Validation Errors,
- Business Errors,
- Information Codes,
- Logs,
- Audit-Daten,
- Monitoringdaten,
- Exceptions,
- sichtbaren `toString()`-Ausgaben.

Das Value Object darf keine Klartextpasswörter, Hashwerte,
`AuthenticationProof`-Werte oder kryptographischen Schlüssel enthalten.

---

## Abgrenzung

Nicht Bestandteil dieses Value Objects sind:

- Auswahl konkreter Parameterwerte,
- Prüfung der aktuellen Sicherheitsempfehlungen,
- Passwort-Hashing,
- Passwortverifikation,
- Salt-Erzeugung,
- Auswahl des Hashalgorithmus,
- Migration bestehender Parameter,
- automatische Parameteraktualisierung,
- kryptographische Bibliotheken,
- Schlüsselverwaltung.

Diese Verantwortlichkeiten liegen ausschließlich bei den zuständigen
Security Ports und technischen Sicherheitskomponenten.

---

# Value Object: AuthenticationProof

## Zweck

`AuthenticationProof` bestätigt, dass eine technische Authentifizierung für
eine bestimmte `ProfileSecurity`-Entity erfolgreich abgeschlossen wurde.

Der Proof wird ausschließlich durch den zuständigen Security Port nach
erfolgreicher Authentifizierung erzeugt.

Er enthält

- kein Klartextpasswort,
- keinen Passwort-Hash,
- kein `PasswordCredential`,
- keinen technischen Authentifizierungstoken,
- keinen kryptographischen Schlüssel.

`AuthenticationProof` führt selbst keine Passwortprüfung und keine
kryptographische Operation aus.

---

## Attribute

| Attribut | Typ | Bedeutung |
|---|---|---|
| securityId | ProfileSecurityId | Sicherheits-Entity, für die die Authentifizierung bestätigt wurde |
| verifiedAt | Timestamp | Zeitpunkt der erfolgreichen Authentifizierung |
| validUntil | Timestamp | Zeitpunkt, bis zu dem der Proof fachlich verwendet werden darf |

---

## Interne Repräsentation

```text
securityId: ProfileSecurityId
verifiedAt: Timestamp
validUntil: Timestamp
```

Alle Attribute sind unveränderlich.

Das Value Object besitzt keine eigene fachliche Identität.

---

## Kontrollierte Erzeugung

Die kontrollierte Erzeugung eines bereits technisch verifizierten Proofs
erfolgt ausschließlich über:

```text
DomainResult<AuthenticationProof> createVerified(
  ProfileSecurityId? securityId,
  Timestamp? verifiedAt,
  Timestamp? validUntil
)
```

Die Factory darf ausschließlich nach einer erfolgreich abgeschlossenen
technischen Authentifizierung aufgerufen werden.

Die Factory führt selbst keine Authentifizierung durch.

Es existiert keine weitere öffentliche Factory.

---

## Fachliche Regeln

Für `AuthenticationProof` gilt:

- `securityId` MUSS vorhanden und gültig sein.
- `verifiedAt` MUSS vorhanden und gültig sein.
- `validUntil` MUSS vorhanden und gültig sein.
- `validUntil` MUSS nach `verifiedAt` liegen.
- Ein Proof mit identischem `verifiedAt` und `validUntil` ist unzulässig.
- Der Proof MUSS unveränderlich sein.
- Der Proof DARF ausschließlich für die zugehörige `ProfileSecurityId`
  verwendet werden.
- Der Proof DARF keine Passwort-, Hash-, Credential-, Salt- oder
  Tokeninformationen enthalten.
- Der Proof DARF nicht aus Profildaten oder Sicherheitsdaten abgeleitet
  werden.
- Die Domain DARF fehlende Zeitwerte nicht selbst erzeugen.
- Die Domain DARF den Gültigkeitszeitraum nicht automatisch verlängern.
- Ein abgelaufener Proof DARF nicht für eine sicherheitskritische Operation
  verwendet werden.

Die Dauer des Gültigkeitszeitraums wird nicht durch dieses Value Object
bestimmt.

Sie wird durch die zuständige Security Policy beziehungsweise den
zuständigen Security Port festgelegt.

---

## Preconditions

Für `createVerified(...)` gilt:

- Die technische Authentifizierung wurde erfolgreich abgeschlossen.
- `securityId` bezeichnet die authentifizierte `ProfileSecurity`-Entity.
- `verifiedAt` bezeichnet den Zeitpunkt der erfolgreichen Authentifizierung.
- `validUntil` wurde durch die zuständige Security Policy bestimmt.

---

## Erfolgsverhalten

Bei erfolgreicher Erzeugung gilt:

- Es wurde ein vollständiger `AuthenticationProof` erzeugt.
- Der Proof ist eindeutig einer `ProfileSecurityId` zugeordnet.
- `validUntil` liegt nach `verifiedAt`.
- Sämtliche Attribute sind unveränderlich.
- Es wurden keine sensiblen Authentifizierungsdaten übernommen.
- Es wurden keine Domain Events erzeugt.
- Es wurden keine Audit- oder Versionsinformationen verändert.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein `AuthenticationProof` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Es entsteht kein teilweise gültiger Proof.
- Sensible Authentifizierungsdaten werden nicht in Domain Messages oder
  Fehlerparametern übertragen.
- Erwartbare Validierungsfehler erzeugen keine Exception.

Die konkreten Validation Errors werden ausschließlich in den Validation
Rules definiert.

Fehler der enthaltenen Value Objects werden nicht zusätzlich als generische
`AuthenticationProof`-Fehler dupliziert.

---

## Prüfung der Verwendbarkeit

Die Verwendbarkeit eines Proofs wird über folgende Operation geprüft:

```text
DomainResult<AuthenticationProof> validateFor(
  ProfileSecurityId? expectedSecurityId,
  Timestamp? now
)
```

Die Operation prüft:

- `expectedSecurityId` ist vorhanden.
- `now` ist vorhanden.
- `expectedSecurityId` entspricht der im Proof gespeicherten `securityId`.
- `now` liegt nicht vor `verifiedAt`.
- `now` liegt nicht nach `validUntil`.

Ein Proof ist einschließlich des Zeitpunkts `validUntil` gültig.

Es gilt:

```text
verifiedAt <= now <= validUntil
```

`validateFor(...)` verändert den Proof nicht.

Bei erfolgreicher Prüfung wird derselbe unveränderte Proof zurückgegeben.

---

## Abgelaufener Proof

Ein Proof ist abgelaufen, wenn gilt:

```text
now > validUntil
```

Ein abgelaufener Proof darf nicht

- reaktiviert,
- verlängert,
- aktualisiert,
- erneut verwendet

werden.

Für eine weitere sicherheitskritische Operation muss eine neue technische
Authentifizierung durchgeführt und ein neuer `AuthenticationProof` erzeugt
werden.

---

## Falsche Zuordnung

Entspricht die im Proof gespeicherte `securityId` nicht der erwarteten
`ProfileSecurityId`, darf der Proof nicht verwendet werden.

Ein Proof darf insbesondere nicht

- für ein anderes Profil,
- für eine andere `ProfileSecurity`-Entity,
- profilübergreifend

wiederverwendet werden.

---

## Equality

Zwei `AuthenticationProof`-Instanzen sind fachlich gleich, wenn alle
folgenden Attribute fachlich gleich sind:

- `securityId`,
- `verifiedAt`,
- `validUntil`.

---

## HashCode

Der Hashcode basiert auf:

- `securityId`,
- `verifiedAt`,
- `validUntil`.

Er muss zur Equality-Definition konsistent sein.

---

## Sichere String-Darstellung

`toString()` darf keine Authentifizierungsdaten oder technischen
Proof-Inhalte offenlegen.

Eine sichere Darstellung lautet:

```text
AuthenticationProof(
  securityId: <profileSecurityId>,
  verifiedAt: <timestamp>,
  validUntil: <timestamp>
)
```

Der Proof enthält keine Passwort-, Hash-, Credential- oder Tokenwerte.

---

## Lebenszyklus

Ein `AuthenticationProof` ist kurzlebig und unveränderlich.

Er wird

1. nach erfolgreicher technischer Authentifizierung erzeugt,
2. für eine oder mehrere innerhalb seines Gültigkeitszeitraums zulässige
   Operationen verwendet,
3. nach Ablauf verworfen.

Der Proof wird nicht verlängert oder aktualisiert.

---

## Abgrenzung

Nicht Bestandteil dieses Value Objects sind:

- Klartextpasswörter,
- Passwortverifikation,
- Hashvergleich,
- Credential-Erzeugung,
- Authentifizierungstokens,
- Sessions,
- kryptographische Schlüssel,
- Security-Port-Implementierungen,
- Bestimmung der zulässigen Gültigkeitsdauer,
- Lockout,
- Rate Limiting,
- Persistenzlogik,
- Domain Events.

Diese Verantwortlichkeiten liegen bei den zuständigen Security Ports,
Security Policies und technischen Sicherheitskomponenten.

---

# Value Object: LockState

## Zweck

`LockState` repräsentiert den aktuellen fachlichen Sperrzustand einer
`ProfileSecurity`-Entity.

Das Value Object beschreibt ausschließlich den gegenwärtigen Zustand.

Es speichert keine Historie früherer Sperr- oder Entsperrvorgänge.

---

## Attribute

| Attribut | Typ | Bedeutung |
|---|---|---|
| status | ProfileLockStatus | Aktueller fachlicher Sperrzustand |
| lockedAt | Timestamp? | Zeitpunkt der aktuellen Sperrung |
| unlockedAt | Timestamp? | Zeitpunkt der aktuellen Entsperrung |

---

## Gültige Zustände

### Entsperrt

Ein entsperrter Zustand ist ausschließlich in folgender Kombination gültig:

```text
status = unlocked
lockedAt = null
unlockedAt != null
```

### Gesperrt

Ein gesperrter Zustand ist ausschließlich in folgender Kombination gültig:

```text
status = locked
lockedAt != null
unlockedAt = null
```

Andere Kombinationen sind unzulässig.

Insbesondere unzulässig sind:

```text
lockedAt = null
unlockedAt = null
```

```text
lockedAt != null
unlockedAt != null
```

```text
status = unlocked
lockedAt != null
```

```text
status = locked
unlockedAt != null
```

---

## Kontrollierte Erzeugung

### Gesperrter Zustand

```text
DomainResult<LockState> createLocked(
  Timestamp? lockedAt
)
```

Die Factory erzeugt ausschließlich einen gültigen gesperrten Zustand.

Bei Erfolg gilt:

```text
status = locked
lockedAt = übergebener Zeitpunkt
unlockedAt = null
```

### Entsperrter Zustand

```text
DomainResult<LockState> createUnlocked(
  Timestamp? unlockedAt
)
```

Die Factory erzeugt ausschließlich einen gültigen entsperrten Zustand.

Bei Erfolg gilt:

```text
status = unlocked
lockedAt = null
unlockedAt = übergebener Zeitpunkt
```

---

## Kontrollierte Rekonstruktion

Die Rekonstruktion eines gespeicherten Zustands erfolgt ausschließlich über:

```text
DomainResult<LockState> reconstruct(
  ProfileLockStatus? status,
  Timestamp? lockedAt,
  Timestamp? unlockedAt
)
```

Die Rekonstruktionsfactory prüft sämtliche Zustandsinvarianten.

Sie korrigiert keine widersprüchlichen Kombinationen automatisch.

Es existiert keine weitere öffentliche Factory.

---

## Zustandsübergänge

### Sperren

```text
DomainResult<LockState> lock(
  Timestamp? lockedAt
)
```

Bei einem erfolgreichen Übergang gilt:

```text
status = locked
lockedAt = übergebener Zeitpunkt
unlockedAt = null
```

Ein zuvor vorhandener `unlockedAt`-Wert wird nicht übernommen.

`LockState` führt keine Historie.

### Entsperren

```text
DomainResult<LockState> unlock(
  Timestamp? unlockedAt
)
```

Bei einem erfolgreichen Übergang gilt:

```text
status = unlocked
lockedAt = null
unlockedAt = übergebener Zeitpunkt
```

Ein zuvor vorhandener `lockedAt`-Wert wird nicht übernommen.

`LockState` führt keine Historie.

---

## No-Change-Verhalten

Wird `lock(...)` auf einem bereits gesperrten Zustand aufgerufen, gilt:

- Der bestehende Zustand bleibt unverändert.
- Es wird kein neuer Zeitstempel übernommen.
- Es wird kein Validation Error erzeugt.
- Die fachliche No-Change-Information wird auf Ebene von `ProfileSecurity`
  erzeugt.

Wird `unlock(...)` auf einem bereits entsperrten Zustand aufgerufen, gilt:

- Der bestehende Zustand bleibt unverändert.
- Es wird kein neuer Zeitstempel übernommen.
- Es wird kein Validation Error erzeugt.
- Die fachliche No-Change-Information wird auf Ebene von `ProfileSecurity`
  erzeugt.

`LockState` besitzt keine eigenen Information Codes.

---

## Fachliche Regeln

Für `LockState` gilt:

- `status` MUSS vorhanden und gültig sein.
- Bei `status = locked` MUSS `lockedAt` vorhanden sein.
- Bei `status = locked` MUSS `unlockedAt` fehlen.
- Bei `status = unlocked` MUSS `unlockedAt` vorhanden sein.
- Bei `status = unlocked` MUSS `lockedAt` fehlen.
- Beide Zeitstempel dürfen niemals gleichzeitig vorhanden sein.
- Beide Zeitstempel dürfen niemals gleichzeitig fehlen.
- Das Value Object MUSS unveränderlich sein.
- Das Value Object DARF keine Historie speichern.
- Ein Zustandswechsel erzeugt immer eine neue vollständige Instanz.
- Ein fachlich fehlerhafter Übergang verändert den bestehenden Zustand
  nicht.
- Fehlende Zeitstempel dürfen nicht automatisch erzeugt werden.
- Das Value Object greift nicht auf eine technische Systemuhr zu.
- Der aktuelle Zeitpunkt muss von außen als `Timestamp` übergeben werden.

---

## Regel „gesperrt und gleichzeitig aktiv“

`LockState` besitzt keinen allgemeinen Profilstatus.

Es kann daher nicht prüfen, ob ein Profil gleichzeitig

- aktiv,
- archiviert,
- deaktiviert,
- gelöscht

ist.

Eine solche Regel gehört ausschließlich zu einem Domänentyp, der sowohl den
allgemeinen Profilstatus als auch den Sicherheitszustand kennt.

Diese Regel ist nicht Bestandteil von `LockState`.

---

## Erfolgsverhalten

Bei erfolgreicher Erzeugung, Rekonstruktion oder Änderung gilt:

- Es wurde ein vollständiger und konsistenter `LockState` erzeugt.
- Genau einer der beiden Zeitstempel ist vorhanden.
- Der vorhandene Zeitstempel entspricht dem aktuellen Status.
- Der jeweils andere Zeitstempel ist `null`.
- Der bestehende Zustand wurde nicht mutiert.
- Es wurden keine Domain Events erzeugt.
- Es wurden keine Audit- oder Versionsinformationen verändert.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein neuer `LockState` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Der bestehende Zustand bleibt unverändert.
- Es entsteht kein teilweise gültiger Zustand.
- Erwartbare fachliche Fehler erzeugen keine Exception.

Die konkreten Validation Errors werden ausschließlich in den Validation
Rules definiert.

Fehler der enthaltenen Value Objects werden nicht zusätzlich als generische
`LockState`-Fehler dupliziert.

---

## Equality

Zwei `LockState`-Instanzen sind fachlich gleich, wenn folgende Attribute
fachlich gleich sind:

- `status`,
- `lockedAt`,
- `unlockedAt`.

---

## HashCode

Der Hashcode basiert auf:

- `status`,
- `lockedAt`,
- `unlockedAt`.

Er muss zur Equality-Definition konsistent sein.

---

## String-Darstellung

Eine sichere String-Darstellung darf ausschließlich enthalten:

- `status`,
- `lockedAt`,
- `unlockedAt`.

Beispiel:

```text
LockState(
  status: locked,
  lockedAt: 2026-08-06T08:30:00.000Z,
  unlockedAt: null
)
```

Das Value Object enthält keine Passwörter, Hashwerte, Credentials oder
AuthenticationProof-Inhalte.

---

## Abgrenzung

Nicht Bestandteil dieses Value Objects sind:

- allgemeiner Profilstatus,
- Aktivierung oder Deaktivierung eines Profils,
- Archivierung,
- Löschung,
- Passwortprüfung,
- Authentifizierung,
- AuthenticationProof,
- Lockout,
- Rate Limiting,
- Sperrhistorie,
- Persistenz,
- technische Systemuhren,
- Domain Events,
- AuditInformation,
- AggregateVersion.

Diese Verantwortlichkeiten liegen bei `ProfileSecurity`, dem
`Profile`-Aggregat und den zuständigen Security-Komponenten.

---

# Audit- und Zeit-Value-Objects

# Value Object: AuditInformation

## Zweck

`AuditInformation` beschreibt die fachlichen Erstellungs-, Änderungs- und Versionsinformationen des Aggregats.

Es ist nicht identisch mit einem persistenten Audit Trail.

## Attribute

| Attribut | Typ |
|---|---|
| createdAt | Timestamp |
| updatedAt | Timestamp |
| version | AggregateVersion |

## Factory

```text
DomainResult<AuditInformation> createInitial(
  Timestamp now
)
```

## Initialzustand

Bei erfolgreicher Erzeugung gilt:

- `createdAt` entspricht `now`.
- `updatedAt` entspricht `now`.
- `version` entspricht dem definierten Initialwert.

## Fachliche Operation

```text
DomainResult<AuditInformation> touchAndIncrement(
  Timestamp now
)
```

## Preconditions

- `now` liegt nicht vor `createdAt`.
- `now` liegt nicht vor dem bisherigen `updatedAt`.
- Die zugehörige fachliche Änderung war erfolgreich.

## Postconditions

- `createdAt` bleibt unverändert.
- `updatedAt` entspricht `now`.
- Die Version wurde genau einmal erhöht.
- Eine neue unveränderliche Instanz wurde erzeugt.

## Regeln

- Reine Leseoperationen verändern `AuditInformation` nicht.
- Eine fehlgeschlagene Operation verändert weder Zeitstempel noch Version.
- Zeitstempel und Version werden bei einer Änderung gemeinsam aktualisiert.
- Das Value Object enthält keine personenbezogenen Änderungsdetails.

## Traceability

- PRO-FR-003
- PRO-FR-027
- PRO-BR-007
- PRO-VR-014
- AG-INV-007
- AG-INV-008
- AG-INV-014

---

# Value Object: Timestamp

## Zweck

`Timestamp` repräsentiert einen unveränderlichen fachlichen Zeitpunkt.

Der Zeitpunkt dient ausschließlich der zeitlichen Einordnung fachlicher
Ereignisse.

Das Value Object enthält keinerlei Informationen über Zeitzonen des
Benutzers oder lokale Kalenderdarstellungen.

Innerhalb der Domain werden sämtliche Zeitpunkte ausschließlich in UTC
gespeichert.

---

## Interner Wert

```text
UTC DateTime
```

Die interne Repräsentation erfolgt ausschließlich als UTC-Zeitpunkt.

Lokale Zeitzonen gehören nicht zur fachlichen Repräsentation.

---

## Kontrollierte Erzeugung

Die kontrollierte Erzeugung eines bereits vorhandenen UTC-Zeitpunkts
erfolgt ausschließlich über:

```text
DomainResult<Timestamp> fromUtc(
  DateTime? value
)
```

Der übergebene Zeitpunkt muss bereits in UTC vorliegen.

Eine automatische Zeitzonenumrechnung erfolgt nicht.

---

## Kontrollierte Rekonstruktion

Die kontrollierte Rekonstruktion erfolgt ausschließlich über:

```text
DomainResult<Timestamp> parseIso8601(
  String? value
)
```

Der übergebene Wert muss einen gültigen ISO-8601-Zeitpunkt in UTC
repräsentieren.

---

## Fachliche Regeln

Für `Timestamp` gilt:

- `value` MUSS vorhanden sein.
- Der Zeitpunkt MUSS in UTC vorliegen.
- Der Zeitpunkt MUSS im ISO-8601-UTC-Format rekonstruiert werden können.
- Die interne Repräsentation MUSS unveränderlich sein.
- Eine lokale Zeitzone DARF nicht gespeichert werden.
- Eine automatische Umrechnung lokaler Zeitzonen erfolgt nicht.
- Das Value Object enthält keine Kalenderlogik.
- Das Value Object enthält keine Geschäftslogik.

---

## Normalisierung

Für `parseIso8601(...)` werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Weitere Transformationen sind unzulässig.

Insbesondere erfolgt keine

- Zeitzonenumrechnung,
- Kalenderkonvertierung,
- automatische Korrektur ungültiger Datumsangaben.

---

## Erfolgsverhalten

Bei erfolgreicher Erzeugung gilt:

- Es wurde ein gültiger UTC-Zeitpunkt erzeugt.
- Der interne Wert ist unveränderlich.
- Die ISO-8601-Darstellung endet mit `Z`.
- Es wurden keine Zeitzonenumrechnungen durchgeführt.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein `Timestamp` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Erwartbare Validierungsfehler erzeugen keine Exception.

Die konkreten Validation Errors werden ausschließlich in den Validation Rules
definiert.

---

## Equality

Zwei `Timestamp`-Instanzen sind fachlich gleich, wenn sie denselben UTC-
Zeitpunkt repräsentieren.

---

## HashCode

Der Hashcode basiert ausschließlich auf dem UTC-Zeitpunkt.

---

## String-Darstellung

Die kanonische Darstellung lautet:

```text
YYYY-MM-DDTHH:mm:ss.SSSZ
```

Beispiel:

```text
2026-08-05T14:37:21.123Z
```

Die Darstellung erfolgt ausschließlich im ISO-8601-UTC-Format.

---

## Abgrenzung

Nicht Bestandteil dieses Value Objects sind:

- lokale Zeitzonen,
- Sommer-/Winterzeit,
- Kalenderberechnungen,
- Zeitdifferenzen,
- Ablaufberechnungen,
- Scheduling,
- Timer,
- technische Systemuhren,
- AuditInformation,
- Versionsverwaltung.

Diese Verantwortlichkeiten liegen außerhalb dieses Value Objects.

---

# Value Object: AggregateVersion

## Zweck

`AggregateVersion` repräsentiert die Version eines fachlichen Aggregatzustands.

## Interner Wert

```text
NonNegativeInteger
```

## Factory

```text
DomainResult<AggregateVersion> createInitial()

DomainResult<AggregateVersion> fromValue(value)
```

## Operation

```text
DomainResult<AggregateVersion> next()
```

## Regeln

- Die Version darf nicht negativ sein.
- Der Initialwert wird projektweit einheitlich festgelegt.
- Die Version steigt monoton.
- Eine erfolgreiche fachliche Änderung erhöht sie genau einmal.
- Eine fehlgeschlagene oder zurückgerollte Änderung verändert sie nicht.
- Der maximale technische Wertebereich muss berücksichtigt werden.

## Verwendung

`AggregateVersion` kann verwendet werden für:

- optimistische Nebenläufigkeitskontrolle,
- Synchronisation,
- Konflikterkennung,
- Ereignisreihenfolge,
- Importprüfung.

## Equality

Die Gleichheit richtet sich nach dem enthaltenen Versionswert.

---

# Lokale Entity-IDs

# Value Object: ProfileSettingsId

## Zweck

`ProfileSettingsId` repräsentiert die unveränderliche fachliche Identität der
Entity `ProfileSettings` innerhalb eines `Profile`-Aggregates.

Die Identität besitzt ausschließlich lokale Bedeutung innerhalb des
Aggregates.

Sie darf nicht als Ersatz für `ProfileId` verwendet werden.

---

## Interner Wert

```text
UUIDv7
```

---

## Eigenschaften

- unveränderlich (immutable)
- wertbasiert
- keine fachliche Logik
- keine Domain Events
- keine Versionsinformationen
- keine Auditinformationen

---

## Factory-Methoden

### Rekonstruktion

```text
DomainResult<ProfileSettingsId> fromString(
    String? value
)
```

Rekonstruiert eine bereits vorhandene
`ProfileSettingsId`.

Die Factory validiert den übergebenen Wert gemäß
`PRO-VR-025`.

---

### Neuerzeugung

```text
DomainResult<ProfileSettingsId> generate()
```

Erzeugt eine neue gültige `ProfileSettingsId`.

Die erzeugte Identität verwendet ausschließlich UUID Version 7.

Die konkrete technische UUID-Erzeugung ist ein internes
Implementierungsdetail und nicht Bestandteil der öffentlichen
Domain-Schnittstelle.

---

## Regeln

- Jede `ProfileSettingsId` MUSS eine gültige UUID Version 7 enthalten.
- Die ID DARF niemals verändert werden.
- Zwei `ProfileSettingsId`-Instanzen sind gleich, wenn ihr UUID-Wert gleich ist.
- Die ID DARF nicht aus fachlichen Profildaten berechnet werden.
- Die ID DARF nicht als `ProfileId` verwendet werden.
- Die konkrete UUID-Bibliothek ist kein Bestandteil des Domain Models.

---

## Equality

Zwei `ProfileSettingsId`-Instanzen sind fachlich gleich,
wenn ihre UUIDv7 identisch ist.

---

## HashCode

Der HashCode basiert ausschließlich auf dem UUIDv7-Wert.

---

## String-Darstellung

```text
550e8400-e29b-71d4-a716-446655440000
```

Die String-Darstellung entspricht der kanonischen UUIDv7-Repräsentation.

---

## Fehlerbehandlung

`fromString(...)`

liefert bei ungültigen Eingaben ausschließlich die in

```text
PRO-VR-025
```

definierten Validation Errors zurück.

`generate()`

liefert bei erfolgreicher Erzeugung immer eine gültige
`ProfileSettingsId`.

Für `generate()` werden keine fachlichen Validation Errors definiert.

Ein technischer Fehler der UUID-Erzeugung gehört nicht zur
fachlichen Domäne.

---

## Traceability

**Validation Rules**

- PRO-VR-025

**Business Rules**

- PRO-BR-026

**Entity**

- ProfileSettings

---

# Value Object: ProfileSecurityId

## Zweck

`ProfileSecurityId` repräsentiert die unveränderliche lokale Identität der
untergeordneten Entity `ProfileSecurity` innerhalb eines
`Profile`-Aggregats.

Die ID besitzt ausschließlich innerhalb des Aggregats eine fachliche
Bedeutung.

Sie darf nicht als Ersatz für `ProfileId` oder eine andere fachliche
Identität verwendet werden.

---

## Interner Wert

```text
UUIDv7
```

Der interne Wert wird als kanonische UUID-Version-7-Zeichenfolge in
Kleinschreibung gespeichert.

---

## Factories

### Neuerzeugung

```text
DomainResult<ProfileSecurityId> generate()
```

Die Factory erzeugt ausschließlich eine neue gültige UUID Version 7.

Für die technische Erzeugung darf die bereits im Projekt verwendete
UUID-Bibliothek eingesetzt werden.

Die Bibliothek ist ausschließlich ein internes technisches
Implementierungsdetail.

Typen der UUID-Bibliothek dürfen nicht Bestandteil sein von

- der öffentlichen Domain-Schnittstelle,
- `DomainResult`,
- Domain Messages,
- Fehlerparametern.

Für `generate()` werden keine fachlichen Validation Errors definiert.

Ein unerwartetes technisches Versagen der UUID-Erzeugung ist kein
fachlicher Validierungsfehler.

### Rekonstruktion

```text
DomainResult<ProfileSecurityId> fromString(
  String? value
)
```

Die Factory rekonstruiert eine bereits vorhandene `ProfileSecurityId`.

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Der normalisierte Wert muss eine syntaktisch gültige UUID Version 7
repräsentieren.

Bei erfolgreicher Rekonstruktion wird der Wert in kanonischer
UUIDv7-Darstellung und in Kleinschreibung gespeichert.

---

## Preconditions

### generate()

- Die technische UUIDv7-Erzeugung ist verfügbar.

### fromString(...)

- `value` ist vorhanden.
- `value` ist nach dem Trimmen nicht leer.
- `value` repräsentiert eine syntaktisch gültige UUID Version 7.

---

## Postconditions

### Bei erfolgreicher Neuerzeugung

- Es wurde eine gültige `ProfileSecurityId` erzeugt.
- Der interne Wert ist eine UUID Version 7.
- Der interne Wert besitzt eine kanonische Darstellung.
- Es wurden keine fachlichen oder technischen Sicherheitsinformationen in
  der ID kodiert.

### Bei erfolgreicher Rekonstruktion

- Es wurde eine gültige `ProfileSecurityId` erzeugt.
- Führende und nachfolgende Leerzeichen wurden entfernt.
- Der interne Wert wurde in kanonische Kleinschreibung überführt.
- Der interne Wert ist eine UUID Version 7.

### Bei fachlichem Fehler

- Es wird keine `ProfileSecurityId` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Der ungültige Eingabewert wird nicht in Fehlerparametern offengelegt.

---

## Regeln

- Die ID ist unveränderlich.
- Neu erzeugte IDs verwenden ausschließlich UUID Version 7.
- Rekonstruierte IDs müssen UUID Version 7 entsprechen.
- Die ID ist innerhalb des Aggregats eindeutig.
- Sie besitzt außerhalb des `Profile`-Aggregats keine selbstständige
  fachliche Bedeutung.
- Sie darf nicht als Ersatz für `ProfileId`, `ProfileSettingsId` oder eine
  andere fachliche Identität verwendet werden.
- Sie darf keine sicherheitsrelevanten Informationen kodieren.
- Sie darf nicht aus Passwörtern, Credentials, Hashes,
  `AuthenticationProof`, Profilnamen oder anderen Profildaten abgeleitet
  werden.
- Die konkrete UUID-Bibliothek ist kein Bestandteil des Domain Models.
- Das Value Object veröffentlicht keine Domain Events.
- Das Value Object besitzt keine Audit- oder Versionslogik.

---

## Equality

Zwei `ProfileSecurityId`-Instanzen sind fachlich gleich, wenn ihre
kanonischen UUIDv7-Werte identisch sind.

Die Gleichheit richtet sich ausschließlich nach dem internen UUIDv7-Wert.

---

## HashCode

Der Hashcode basiert ausschließlich auf dem kanonischen UUIDv7-Wert.

---

## String-Darstellung

Die String-Darstellung entspricht ausschließlich dem kanonischen
UUIDv7-Wert.

Sie enthält keine zusätzlichen sicherheitsrelevanten Informationen.

---

## Abgrenzung

Nicht Bestandteil dieses Value Objects sind:

- profilübergreifende Eindeutigkeitsprüfungen,
- Persistenzkonflikte,
- Datenbank-Constraints,
- Repositoryzugriffe,
- JSON- oder DTO-Repräsentationen,
- Authentifizierung,
- Passwortprüfung,
- Credential-Erzeugung,
- kryptographische Schlüssel,
- technische Generatorfehler.

---

# Einstellungs-Value-Objects

# Value Object: LocalizationSettings

## Zweck

`LocalizationSettings` beschreibt Sprache und Maßeinheitensystem eines Profils.

## Attribute

| Attribut | Typ |
|---|---|
| language | Language |
| measurementSystem | MeasurementSystem |

## Factory

```text
DomainResult<LocalizationSettings> create(
  Language language,
  MeasurementSystem measurementSystem
)
```

## Regeln

- Beide Werte müssen unterstützt werden.
- Das Value Object ist vollständig und unveränderlich.
- Eine Änderung erzeugt eine neue Instanz.
- Der Wechsel des Maßeinheitensystems verändert keine kanonisch gespeicherten Gesundheitswerte.

---

# Enumeration: DashboardLayout

## Werte

```text
standard
compact
comfortable
```

## Regeln

- `standard` ist das reguläre Dashboardlayout.
- `compact` verwendet eine platzsparende Anordnung.
- `comfortable` verwendet eine großzügigere Anordnung.
- Die Enumeration beschreibt ausschließlich die fachliche Präferenz.
- Konkrete Größen, Abstände und Flutter-Layouts gehören nicht zur Domäne.

---

# Value Object: DashboardWidgetSelection

## Zweck

`DashboardWidgetSelection` beschreibt die sichtbaren Dashboard-Inhalte und
deren fachliche Reihenfolge.

## Interner Wert

```text
Ordered immutable List<String>
```

Jeder String ist ein stabiler, technologieunabhängiger Widget-Schlüssel.

## Factory

```text
DomainResult<DashboardWidgetSelection> create(
  List<String> widgetKeys
)
```

## Regeln

- Die Liste darf leer sein.
- Jeder Widget-Schlüssel muss nach dem Trimmen nicht leer sein.
- Führende und nachfolgende Leerzeichen werden entfernt.
- Doppelte Widget-Schlüssel sind unzulässig.
- Die Reihenfolge ist fachlich relevant.
- Die interne Liste ist unveränderlich.
- Flutter-Klassennamen und Laufzeitobjekte sind unzulässig.

## Equality

Zwei `DashboardWidgetSelection` sind gleich, wenn ihre normalisierten
Widget-Schlüssel in derselben Reihenfolge identisch sind.

---

# Value Object: DashboardConfigurationVersion

## Zweck

`DashboardConfigurationVersion` beschreibt die Version der gespeicherten
Dashboardkonfiguration.

## Interner Wert

```text
PositiveInteger
```

## Factory

```text
DomainResult<DashboardConfigurationVersion> create(
  int value
)
```

## Initialwert

```text
1
```

## Regeln

- Der Wert muss mindestens `1` betragen.
- Der Wert ist unveränderlich.
- Die Version dient der Kompatibilitäts- und Migrationsprüfung.
- Sie ist nicht mit der `AggregateVersion` identisch.

## Equality

Zwei Instanzen sind gleich, wenn ihr Versionswert identisch ist.

---

# Value Object: DashboardSettings

## Zweck

`DashboardSettings` beschreibt die fachliche Auswahl und Anordnung
profilbezogener Dashboard-Inhalte.

## Attribute

| Attribut | Typ |
|---|---|
| layout | DashboardLayout |
| visibleWidgets | DashboardWidgetSelection |
| configurationVersion | DashboardConfigurationVersion |

## Factory

```text
DomainResult<DashboardSettings> create(
  DashboardLayout layout,
  DashboardWidgetSelection visibleWidgets,
  DashboardConfigurationVersion configurationVersion
)
```

## Preconditions

- `layout` ist ein unterstützter Wert.
- `visibleWidgets` ist gültig.
- `configurationVersion` ist gültig.

## Postconditions

Bei Erfolg:

- wurde ein vollständiges und unveränderliches `DashboardSettings` erzeugt,
- sind Layout, Widgetauswahl und Konfigurationsversion vorhanden,
- wurden keine technischen Seiteneffekte ausgelöst.

Bei Fehler:

- wird kein `DashboardSettings` erzeugt,
- enthält `DomainResult<DashboardSettings>` mindestens einen strukturierten
  Fehler.

## Regeln

- Das Layout muss unterstützt werden.
- Widget-Schlüssel müssen gültig sein.
- Doppelte Widget-Schlüssel sind unzulässig.
- Die Reihenfolge der Widget-Schlüssel ist fachlich relevant.
- Die Konfigurationsversion muss mit den enthaltenen Einstellungen kompatibel
  sein.
- Flutter-Widgettypen gehören nicht in die Domäne.

## Equality

Zwei `DashboardSettings` sind gleich, wenn

- `layout`,
- `visibleWidgets`,
- `configurationVersion`

fachlich gleich sind.

---

# Value Object: AppearanceSettings

## Zweck

`AppearanceSettings` beschreibt profilbezogene Darstellungspräferenzen.

## Attribute

| Attribut | Typ |
|---|---|
| themePreference | ThemePreference |
| textScalePreference | TextScalePreference? |

## Factory

```text
DomainResult<AppearanceSettings> create(
  ThemePreference themePreference,
  TextScalePreference? textScalePreference
)
```

## Preconditions

- `themePreference` ist ein unterstützter Wert.
- `textScalePreference` ist entweder nicht vorhanden oder ein unterstützter
  Wert.

## Postconditions

Bei Erfolg:

- wurde ein vollständiges und unveränderliches `AppearanceSettings` erzeugt,
- ist die Theme-Präferenz vorhanden,
- wurde keine technische Darstellung ausgelöst.

Bei Fehler:

- wird kein `AppearanceSettings` erzeugt,
- enthält `DomainResult<AppearanceSettings>` mindestens einen strukturierten
  Fehler.

## Regeln

- Nur unterstützte Werte sind zulässig.
- Eine fehlende `textScalePreference` bedeutet, dass die systemweite
  Textskalierung verwendet wird.
- Barrierefreiheitsanforderungen dürfen nicht außer Kraft gesetzt werden.
- Flutter- oder Plattformtypen sind unzulässig.
- Eine Änderung ersetzt das vollständige Value Object.

## Equality

Zwei `AppearanceSettings` sind gleich, wenn

- `themePreference`,
- `textScalePreference`

fachlich gleich sind.

---

# Enumerationen

## Allgemeine Regeln

Enumerationen definieren geschlossene Mengen fachlich zulässiger Werte.

Für neue Enum-Werte sind erforderlich:

- fachliche Freigabe,
- Validierungsanpassung,
- Migrationsprüfung,
- Testanpassung,
- Prüfung der Import- und Exportkompatibilität.

Sichtbare Bezeichnungen werden niemals direkt aus Enum-Namen erzeugt, sondern über i18n/l10n bereitgestellt.

---

# Enumeration: Gender

## Zweck

`Gender` beschreibt die optionale fachliche Geschlechtsangabe eines Profils.

Eine fehlende Angabe wird durch den definierten Wert `unspecified`
repräsentiert.

---

## Zulässige Werte

```text
male
female
diverse
unspecified
```

Weitere Werte sind nicht zulässig.

---

## Kontrollierte Rekonstruktion

Die kontrollierte Rekonstruktion erfolgt über:

```text
DomainResult<Gender> Gender.fromString(
  String? value
)
```

Vor der Auswertung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Die Groß- und Kleinschreibung wird nicht verändert.

---

## Verhalten fehlender und leerer Werte

Ist `value`

- nicht vorhanden,
- leer,
- oder nach dem Trimmen leer,

wird erfolgreich

```text
Gender.unspecified
```

zurückgegeben.

Ein fehlender oder leerer Wert ist kein Validation Error.

---

## Fachliche Regeln

- Zulässig sind ausschließlich `male`, `female`, `diverse` und
  `unspecified`.
- Der normalisierte Wert muss exakt einem zulässigen Wert entsprechen.
- Unbekannte Werte dürfen nicht stillschweigend übernommen werden.
- Unbekannte Werte dürfen nicht automatisch in `unspecified` umgewandelt
  werden.
- Groß- und Kleinschreibung werden nicht automatisch normalisiert.
- `unspecified` repräsentiert ausschließlich eine fehlende Angabe.
- Die Enumeration enthält keine lokalisierten Anzeigetexte.
- Die Enumeration ist unveränderlich.

---

## Fehlerverhalten

Entspricht ein vorhandener und nicht leerer normalisierter Wert keinem
zulässigen Enumerationswert, wird ausschließlich der in `PRO-VR-004`
definierte Validation Error erzeugt.

Der ungültige Eingabewert darf nicht in Fehlerparametern oder Domain
Messages übertragen werden.

Erwartbare Validierungsfehler erzeugen keine Exception.

---

## Equality

Zwei `Gender`-Werte sind fachlich gleich, wenn sie denselben
Enumerationswert repräsentieren.

---

## String-Darstellung

Die String-Darstellung entspricht exakt einem der Werte:

```text
male
female
diverse
unspecified
```

---

## Abgrenzung

Nicht Bestandteil dieser Enumeration sind:

- lokalisierte Bezeichnungen,
- medizinische Diagnosen,
- Geschlechtsidentitätsmodelle außerhalb der definierten Werte,
- UI-Auswahlkomponenten,
- Persistenz- oder JSON-Typen.

---
# Enumeration: ProfileStatus

## Werte

```text
inactive
active
archived
```

## Regeln

- Ein Profil besitzt genau einen Lebenszyklusstatus.
- `active` und `archived` schließen sich aus.
- Ein gesperrtes Profil darf unabhängig vom Lebenszyklusstatus nicht aktiv sein.
- Der Sperrstatus ist nicht Bestandteil dieser Enumeration.

---

# Enumeration: ProfileLockStatus

## Zweck

`ProfileLockStatus` beschreibt den fachlichen Sperrzustand eines
`ProfileSecurity`-Objekts.

Die Enumeration besitzt ausschließlich die Aufgabe, eindeutig zwischen
einem gesperrten und einem entsperrten Sicherheitszustand zu unterscheiden.

Sie enthält keine Zeitstempel, keine Authentifizierungslogik und keine
Information über den allgemeinen Lebenszyklus eines Profils.

---

## Zulässige Werte

```text
unlocked
locked
```

Weitere Werte sind nicht zulässig.

---

## Fachliche Bedeutung

### unlocked

```text
unlocked
```

bedeutet:

- Der Sicherheitszustand ist fachlich entsperrt.
- Ein Zugriff kann grundsätzlich erfolgen, sofern keine andere fachliche
  oder technische Regel den Zugriff verhindert.
- Die Enumeration selbst bestätigt keine erfolgreiche Authentifizierung.
- Die Enumeration selbst kennt kein `AuthenticationProof`.

### locked

```text
locked
```

bedeutet:

- Der Sicherheitszustand ist fachlich gesperrt.
- Ein Zugriff darf erst nach erfolgreicher, durch einen gültigen
  `AuthenticationProof` nachgewiesener Authentifizierung wieder freigegeben
  werden.
- Die Enumeration selbst führt keine Authentifizierung durch.

---

## Regeln

- `ProfileLockStatus` ist unveränderlich.
- Es sind ausschließlich die Werte `unlocked` und `locked` zulässig.
- Ein unbekannter Wert darf nicht stillschweigend ersetzt werden.
- Die Enumeration enthält keine Zeitstempel.
- Die Enumeration enthält keine Passwort-, Hash-, Credential- oder
  Proof-Daten.
- Die Enumeration enthält keine UI-, Persistenz-, Plattform- oder
  Infrastrukturtypen.
- Die Enumeration beschreibt ausschließlich den Sicherheits-Sperrzustand.
- Die Enumeration beschreibt nicht, ob ein Profil allgemein aktiv,
  archiviert, gelöscht oder deaktiviert ist.
- Die Regel „gesperrt und gleichzeitig aktiv“ gehört daher nicht zu
  `ProfileLockStatus`.

---

## Kontrollierte Rekonstruktion

Die Rekonstruktion aus einem gespeicherten Wert erfolgt über:

```text
DomainResult<ProfileLockStatus> fromString(
  String? value
)
```

Vor der Validierung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Die Groß- und Kleinschreibung wird nicht automatisch verändert.

Der normalisierte Wert muss exakt einem der folgenden Werte entsprechen:

```text
unlocked
locked
```

---

## Erfolgsverhalten

Bei erfolgreicher Rekonstruktion gilt:

- Es wurde ein gültiger `ProfileLockStatus` erzeugt.
- Der Wert entspricht exakt `unlocked` oder `locked`.
- Es wurden keine Zeitstempel erzeugt oder verändert.
- Es wurden keine sicherheitsrelevanten Inhalte verarbeitet oder
  offengelegt.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein `ProfileLockStatus` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Der ungültige Eingabewert wird nicht in Fehlerparametern oder Domain
  Messages übertragen.
- Erwartbare Validierungsfehler erzeugen keine Exception.

Die konkreten Validation Errors werden ausschließlich in den Validation
Rules definiert.

---

## Equality

Zwei `ProfileLockStatus`-Werte sind fachlich gleich, wenn sie denselben
Enumerationswert repräsentieren.

---

## String-Darstellung

Die sichere String-Darstellung lautet ausschließlich:

```text
unlocked
```

oder

```text
locked
```

Sie enthält keine Zeitstempel, Credential-Inhalte oder sonstigen
Sicherheitsdaten.

---

## Abgrenzung

Nicht Bestandteil dieser Enumeration sind:

- Zeitpunkt der Sperrung,
- Zeitpunkt der Entsperrung,
- Historie von Sperr- und Entsperrvorgängen,
- Authentifizierung,
- Passwortprüfung,
- `AuthenticationProof`,
- allgemeiner Profilstatus,
- Archivierung,
- Löschung,
- Deaktivierung,
- Lockout,
- Rate Limiting,
- Persistenzlogik.

Diese Verantwortlichkeiten liegen bei `LockState`, `ProfileSecurity`, dem
`Profile`-Aggregat und den zuständigen Security-Komponenten.

---

# Enumeration: Language

## Beispielwerte

```text
de
en
```

## Regeln

- Es werden ausschließlich unterstützte Sprachcodes gespeichert.
- Die Codes orientieren sich an einem dokumentierten Standard.
- Neue Sprachen müssen migrationssicher ergänzt werden.
- Das Hinzufügen einer Sprache ändert keine bestehenden Profilwerte.

---

# Enumeration: MeasurementSystem

## Werte

```text
metric
imperial
```

## Regeln

- Die Enumeration steuert Eingabe und Darstellung.
- Kanonisch gespeicherte Werte werden dadurch nicht verändert.
- Konvertierungen müssen deterministisch sein.

---

# Enumeration: ThemePreference

## Werte

```text
system
light
dark
```

## Regeln

- Die Enumeration beschreibt ausschließlich die Präferenz.
- Plattform- oder Barrierefreiheitsanforderungen können die Darstellung übersteuern.
- Flutter-spezifische Theme-Werte gehören nicht in die Domäne.

---

# Enumeration: TextScalePreference

## Werte

```text
system
small
standard
large
```

## Regeln

- `system` übernimmt die systemweite beziehungsweise barrierefreie Vorgabe.
- `small`, `standard` und `large` beschreiben ausschließlich eine
  profilbezogene Präferenz.
- Die Präferenz darf systemweite Barrierefreiheitsvorgaben nicht
  unterschreiten oder außer Kraft setzen.
- Konkrete Skalierungsfaktoren und Flutter-Typen gehören nicht zur Domäne.

---

# Enumeration: MediaType

## Werte

```text
image/jpeg
image/png
image/webp
```

## Regeln

- Nur freigegebene Profilbildformate sind zulässig.
- Eine Dateiendung allein bestimmt den Medientyp nicht.
- Die technische Inhaltsprüfung erfolgt außerhalb der Domäne.

---

# Enumeration: PasswordAlgorithm

## Zweck

`PasswordAlgorithm` bezeichnet den kryptographischen Algorithmus, mit dem
ein `PasswordHash` erzeugt wurde.

Die Enumeration dient ausschließlich der eindeutigen fachlichen
Kennzeichnung eines bestehenden `PasswordCredential`.

Die tatsächliche kryptographische Verarbeitung erfolgt außerhalb der Domain
über die zuständigen Security Ports.

---

## Zulässige Werte

```text
argon2id
```

Für Version 1 des Profilmoduls ist ausschließlich `argon2id` zulässig.

Weitere Algorithmen dürfen erst nach einer ausdrücklichen Erweiterung des
Domain Models als zusätzliche Enumerationswerte aufgenommen werden.

---

## Regeln

- `PasswordAlgorithm` ist unveränderlich.
- Der Wert MUSS vorhanden sein.
- Der Wert MUSS einem definierten Enumerationswert entsprechen.
- Für Version 1 ist ausschließlich `argon2id` zulässig.
- Die Enumeration enthält keine kryptographische Implementierung.
- Die Enumeration enthält keine Bibliotheks-, Plattform- oder
  Infrastrukturtypen.
- Die Enumeration bestimmt keine konkreten Hashparameter.
- Die Enumeration darf nicht aus einem Klartextpasswort abgeleitet werden.
- Ein unbekannter Wert darf nicht stillschweigend durch `argon2id` ersetzt
  werden.

---

## Kontrollierte Rekonstruktion

Die Rekonstruktion aus einem gespeicherten Wert erfolgt über:

```text
DomainResult<PasswordAlgorithm> fromString(
  String? value
)
```

Vor der Prüfung werden ausschließlich

- führende Leerzeichen entfernt,
- nachfolgende Leerzeichen entfernt.

Die Groß- und Kleinschreibung wird nicht automatisch verändert.

Der normalisierte Wert muss exakt einem definierten Enumerationswert
entsprechen.

---

## Erfolgsverhalten

Bei erfolgreicher Rekonstruktion gilt:

- Es wurde ein gültiger `PasswordAlgorithm` erzeugt.
- Der Wert entspricht exakt `argon2id`.
- Es wurden keine kryptographischen Operationen ausgeführt.
- Es wurden keine sensiblen Daten verarbeitet oder offengelegt.

---

## Fehlerverhalten

Bei einem fachlichen Fehler gilt:

- Es wird kein `PasswordAlgorithm` erzeugt.
- Das Ergebnis enthält mindestens einen strukturierten Validation Error.
- Der ungültige Eingabewert darf nicht Bestandteil von Fehlerparametern
  oder Domain Messages sein.

Die konkreten Validation Errors werden in den Validation Rules definiert.

---

## Equality

Zwei `PasswordAlgorithm`-Werte sind fachlich gleich, wenn sie denselben
Enumerationswert repräsentieren.

---

## String-Darstellung

Die sichere String-Darstellung lautet:

```text
argon2id
```

Sie enthält keine Hashwerte, Parameter, Credentials oder sonstigen
Sicherheitsdaten.

---

## Abgrenzung

Nicht Bestandteil dieser Enumeration sind:

- Passwort-Hashing,
- Passwortverifikation,
- Auswahl kryptographischer Bibliotheken,
- Parametrisierung von Argon2id,
- Salt-Erzeugung,
- Schlüsselverwaltung,
- Migration bestehender Credentials,
- technische Fallback-Algorithmen.

Diese Verantwortlichkeiten liegen ausschließlich bei den zuständigen
Security Ports und technischen Sicherheitskomponenten.

---

# Enumeration: AuthenticationPurpose

## Werte

```text
unlockProfile
changePassword
disablePasswordProtection
deleteProfile
```

## Regeln

- Jeder Proof besitzt genau einen Zweck.
- Ein Proof ist nur für den zugehörigen Zweck gültig.
- Neue Zwecke erfordern eine Sicherheitsprüfung und Testanpassung.

---

# Value Object: ProfileSettingsDefaults

## Zweck

`ProfileSettingsDefaults` beschreibt einen vollständigen fachlich gültigen
Standardzustand für die Profileinstellungen.

Das Value Object wird ausschließlich für das Zurücksetzen einer
`ProfileSettings`-Entity verwendet.

## Attribute

| Attribut | Typ |
|---|---|
| localization | LocalizationSettings |
| dashboard | DashboardSettings |
| appearance | AppearanceSettings |

## Factory

```text
DomainResult<ProfileSettingsDefaults> create(
  LocalizationSettings localization,
  DashboardSettings dashboard,
  AppearanceSettings appearance
)
```

## Preconditions

- `localization` ist gültig.
- `dashboard` ist gültig.
- `appearance` ist gültig.
- Sämtliche Einstellungsbereiche sind vollständig vorhanden.

## Postconditions

Bei Erfolg:

- wurde ein vollständiger und unveränderlicher Standardzustand erzeugt,
- sind alle enthaltenen Value Objects gültig,
- wurden keine technischen Seiteneffekte ausgelöst.

Bei Fehler:

- wird kein `ProfileSettingsDefaults` erzeugt,
- enthält `DomainResult<ProfileSettingsDefaults>` mindestens einen
  strukturierten Fehler.

## Regeln

- Das Value Object besitzt keine Identität.
- Es ist vollständig unveränderlich.
- Es enthält immer alle drei Einstellungsbereiche.
- Es kennt keine ProfileSettingsId.
- Es erzeugt keine Domain Events.
- Es aktualisiert keine Auditinformationen oder Aggregate-Versionen.

## Equality

Zwei `ProfileSettingsDefaults` sind gleich, wenn

- `localization`,
- `dashboard`,
- `appearance`

fachlich gleich sind.

---

# Weitere fachliche Typen

Die folgenden Typen werden in eigenen Modul- oder UI-Spezifikationen konkretisiert:

```text
PlainPassword
```

Sie dürfen keine Flutter- oder Infrastrukturtypen enthalten.

---

# Gemeinsame Equality-Regeln

## Entities

Entities werden ausschließlich anhand ihrer fachlichen Identität verglichen.

```text
Profile          → ProfileId
ProfileSettings  → ProfileSettingsId
ProfileSecurity  → ProfileSecurityId
```

## Value Objects

Value Objects werden anhand sämtlicher fachlich relevanter Werte verglichen.

## Collections

Bei Collection-Value-Objects muss dokumentiert sein, ob:

- Reihenfolge relevant ist,
- Duplikate zulässig sind,
- Mengen- oder Listenvergleich verwendet wird.

## Referenzgleichheit

Die Speicheradresse einer Laufzeitinstanz besitzt keine fachliche Bedeutung.

---

# Factory-Regeln für erweiterte Value Objects

Alle Factory-Methoden:

- liefern `DomainResult<T>`,
- erzeugen nur gültige Instanzen,
- normalisieren zulässige Eingaben,
- besitzen keine technischen Seiteneffekte,
- speichern keine Daten,
- veröffentlichen keine Events,
- öffnen keine Transaktionen.

Zeitabhängige Factories erhalten Zeitwerte ausdrücklich als Parameter oder verwenden eine abstrahierte `Clock` außerhalb des Value Objects.

Security-bezogene Value Objects dürfen nur aus vertrauenswürdigen Security-Ergebnissen erzeugt werden.

---

# Serialisierungsgrenze

Die Domäne definiert keine konkreten:

- JSON-Strukturen,
- Datenbanktabellen,
- ORM-Modelle,
- Dateiformate,
- API-DTOs.

Die Umwandlung erfolgt außerhalb der Domäne durch:

- Mapper,
- DTOs,
- Persistenzadapter,
- Importadapter,
- Exportadapter.

## Rekonstruktionsregel

Mapper dürfen interne Zustände nicht ungeprüft wiederherstellen.

Die Rekonstruktion erfolgt ausschließlich über:

```text
DomainResult<T>
```

liefernde Factory- oder Rekonstruktionsmethoden.

Ungültige Persistenz- oder Importdaten dürfen kein Domänenobjekt erzeugen.

## Sicherheitsregel

Folgende Werte dürfen nicht in öffentliche DTOs oder Exporte gelangen:

- PasswordHash,
- PasswordHashParameters,
- PasswordCredential,
- interne AuthenticationProofs,
- sicherheitsrelevante technische Parameter.

---

# Status dieses Abschnitts

Mit Teil 4B sind definiert:

- `ProfileImage`,
- `ImageReference`,
- `ImageDimensions`,
- `ImageChecksum`,
- `PasswordCredential`,
- `PasswordHash`,
- `PasswordHashParameters`,
- `AuthenticationProof`,
- `LockState`,
- `AuditInformation`,
- `Timestamp`,
- `AggregateVersion`,
- lokale Entity-IDs,
- Einstellungs-Value-Objects,
- zentrale Enumerationen,
- Equality-Regeln,
- Factory-Regeln,
- Serialisierungs- und Rekonstruktionsgrenzen.

Zusammen mit Teil 4A-1 und Teil 4A-2 ist das Value-Object-Modell des Profilmoduls vollständig beschrieben.

---

# Teil 5

Der folgende Abschnitt beschreibt:

- Domain Services,
- Factory,
- Repository Interfaces,
- Unit of Work,
- Domain Ports,
- Specifications,
- profilübergreifende Invarianten.

# Teil 5A – Domain Services

# Domain Services

## Zweck

Domain Services kapseln fachliche Logik, die

- nicht sinnvoll einer einzelnen Entity oder einem Value Object zugeordnet werden kann,
- mehrere Profile oder Repository-Abfragen benötigt,
- profilübergreifende Invarianten schützt,
- keine technische Infrastruktur enthalten darf.

Domain Services arbeiten ausschließlich mit

- Aggregaten,
- Entities,
- Value Objects,
- Repository Interfaces,
- Domain Ports,
- Specifications,
- fachlichen Ergebnisobjekten.

Sie besitzen keinen eigenen fachlichen Zustand.

Alle Operationen liefern einheitlich:

```text
DomainResult<T>
```

Fachlich erwartbare Fehler werden nicht über Exceptions signalisiert.

---

# Allgemeine Regeln für Domain Services

## PRO-DS-001 – Ausschließlich Fachlogik

Ein Domain Service enthält ausschließlich fachliche Regeln und Entscheidungen.

Er enthält niemals

- UI-Code,
- Flutter-Code,
- Datenbankzugriffe,
- JSON-Verarbeitung,
- REST-Kommunikation,
- Dateizugriffe,
- technische Transaktionssteuerung.

---

## PRO-DS-002 – Zustandslosigkeit

Domain Services speichern keinen dauerhaften Zustand zwischen Aufrufen.

Temporäre Berechnungswerte dürfen nur während einer Operation existieren.

---

## PRO-DS-003 – Deterministisches Verhalten

Bei identischen Eingaben und identischem fachlichem Datenbestand liefert ein Domain Service dasselbe fachliche Ergebnis.

Zeitabhängige Entscheidungen verwenden eine abstrahierte `Clock`.

---

## PRO-DS-004 – Abhängigkeiten nur über Abstraktionen

Domain Services dürfen ausschließlich von

- Repository Interfaces,
- Domain Ports,
- Specifications,
- Value Objects,
- Aggregaten

abhängen.

Konkrete Infrastrukturimplementierungen sind unzulässig.

---

## PRO-DS-005 – Keine Persistenzsteuerung

Ein Domain Service darf niemals selbst

```text
Repository.save()
```

oder

```text
UnitOfWork.commit()
```

aufrufen.

Der Domain Service liefert eine fachliche Entscheidung oder einen fachlich veränderten Aggregatzustand zurück.

Die Persistierung und Transaktionssteuerung übernimmt der Application Service.

---

## PRO-DS-006 – Keine Event-Veröffentlichung

Domain Services veröffentlichen keine Domain Events.

Sie können Domain Events

- über erfolgreiche Aggregate-Operationen entstehen lassen,
- oder als Bestandteil eines fachlichen Ergebnisses vorbereiten.

Die Veröffentlichung erfolgt erst nach erfolgreichem Commit durch die Application Layer.

---

## PRO-DS-007 – Atomare Use-Case-Koordination

Benötigt eine fachliche Operation Änderungen an mehreren Aggregaten oder Referenzen, definiert der Domain Service die fachlich erforderlichen Änderungen.

Die technische atomare Ausführung erfolgt über:

```text
Application Service
        │
        ▼
UnitOfWork
```

Teilweise erfolgreiche Änderungen sind unzulässig.

---

# Domain Service: ProfileUniquenessService

## Zweck

`ProfileUniquenessService` prüft profilübergreifende Namensgleichheiten.

Der Service schützt die Regel:

> Gleiche Profilnamen sind zulässig, erzeugen jedoch eine Warnung.

## Verantwortlichkeiten

- normalisierten Vergleichsschlüssel verwenden,
- Profile mit gleichem Namen ermitteln,
- ein aktuell bearbeitetes Profil ausschließen,
- strukturierte Warnungen erzeugen,
- keine Eindeutigkeit erzwingen.

## Abhängigkeiten

```text
ProfileRepository
```

## Operation

```text
DomainResult<DuplicateProfileNameResult> checkDuplicateName(
  ProfileName profileName,
  ProfileId? excludedProfileId
)
```

## Ergebnisobjekt

`DuplicateProfileNameResult` enthält mindestens:

| Feld | Typ |
|---|---|
| duplicateFound | Boolean |
| existingProfileCount | NonNegativeInteger |
| matchingProfileIds | List<ProfileId> |

## Preconditions

- `profileName` ist gültig.
- `excludedProfileId` ist entweder leer oder gültig.
- Der fachliche Profilbestand kann abgefragt werden.

## Postconditions

- Kein Profil wurde verändert.
- Es wurde nichts gespeichert.
- Es wurden keine Domain Events erzeugt.
- Das Ergebnis enthält bei einem Treffer die Warnung:

```text
PRO-VAL-DUPNAME-001
```

## Datenschutz

Das Ergebnis soll nur die für die fachliche Entscheidung erforderlichen Informationen enthalten.

Namen oder weitere Stammdaten anderer Profile werden nicht unnötig offengelegt.

## Traceability

**Requirements**

- PRO-FR-023

**Use Cases**

- PRO-UC-023

**Business Rules**

- PRO-BR-014

**Validation Rules**

- PRO-VR-009

---

# Domain Service: DefaultProfileCoordinator

## Zweck

`DefaultProfileCoordinator` schützt die profilübergreifende Invariante:

> Es existiert höchstens ein Standardprofil.

## Verantwortlichkeiten

- Eignung eines Profils als Standardprofil prüfen,
- bisheriges Standardprofil ermitteln,
- fachlich erforderliche Änderungen bestimmen,
- Standardprofil nach Archivierung oder Löschung neu bewerten.

## Abhängigkeiten

```text
ProfileRepository
ProfileCanBeDefault
```

Der Service verwendet keine `UnitOfWork` direkt.

Die atomare Persistierung wird vom Application Service koordiniert.

## Operationen

```text
DomainResult<DefaultProfileChangePlan> planSetDefaultProfile(
  ProfileId profileId
)

DomainResult<DefaultProfileChangePlan> planRemoveDefaultProfile(
  ProfileId profileId
)

DomainResult<ProfileId?> resolveDefaultProfile()
```

## DefaultProfileChangePlan

Der Plan enthält mindestens:

| Feld | Typ |
|---|---|
| targetProfile | Profile |
| previousDefaultProfile | Profile? |
| operation | DefaultProfileOperation |

Zulässige Operationen:

```text
set
remove
replace
noChange
```

## Zulässiger Profilzustand

Ein Standardprofil darf sein:

- `inactive`,
- `active`,
- gesperrt.

Nicht zulässig sind:

- archivierte Profile,
- gelöschte Profile,
- nicht vorhandene Profile.

Ein gesperrtes Standardprofil wird beim Start nicht automatisch aktiviert, bevor es erfolgreich entsperrt wurde.

## Preconditions für das Setzen

- Das Zielprofil existiert.
- Das Zielprofil ist nicht archiviert.
- Das Zielprofil ist fachlich gültig.
- Es liegt kein ungelöster Persistenzkonflikt vor.

## Postconditions des fachlichen Plans

Der zurückgegebene Plan stellt sicher, dass nach atomarer Anwendung entweder:

- genau ein Standardprofil existiert,

oder bei einer Entfernung:

- kein Standardprofil existiert.

Mehrere Standardprofile sind unzulässig.

## Domain Events

Nach erfolgreicher Anwendung und Persistierung können entstehen:

```text
ProfileDefaultRemoved
ProfileMarkedAsDefault
DefaultProfileChanged
```

Der Domain Service veröffentlicht diese Events nicht selbst.

## Geschützte Invarianten

- `PRO-CINV-001` – Höchstens ein Standardprofil existiert.
- `PRO-CINV-002` – Archivierte Profile sind niemals Standardprofil.

## Traceability

- PRO-FR-009
- PRO-UC-009
- PRO-BR-012
- PRO-VR-013

---

# Domain Service: ActiveProfileCoordinator

## Zweck

`ActiveProfileCoordinator` koordiniert die profilübergreifende Auswahl des aktiven Profils.

## Verantwortlichkeiten

- Aktivierbarkeit prüfen,
- bisher aktives Profil ermitteln,
- fachlich erforderlichen Profilwechsel bestimmen,
- Startprofil ermitteln,
- ungültige Profilreferenzen erkennen.

## Abhängigkeiten

```text
ProfileRepository
ProfileContextRepository
ProfileCanBeActivated
```

Der Service speichert keine Profile und ändert keine Kontextreferenzen direkt.

## Operationen

```text
DomainResult<ActiveProfileChangePlan> planActivateProfile(
  ProfileId profileId
)

DomainResult<ActiveProfileChangePlan> planClearActiveProfile()

DomainResult<StartProfileResolution> resolveStartProfile()
```

## ActiveProfileChangePlan

Der Plan enthält mindestens:

| Feld | Typ |
|---|---|
| targetProfile | Profile? |
| previousActiveProfile | Profile? |
| newActiveProfileId | ProfileId? |
| newLastUsedProfileId | ProfileId? |
| operation | ActiveProfileOperation |

Zulässige Operationen:

```text
activate
switch
clear
noChange
```

## Priorität bei Programmstart

Das Startprofil wird in folgender Reihenfolge ermittelt:

1. gültiges zuletzt verwendetes Profil,
2. gültiges Standardprofil,
3. anderes verfügbares nicht archiviertes Profil,
4. kein Profil.

## Voraussetzungen für eine Aktivierung

Das Profil:

- existiert,
- ist nicht archiviert,
- ist nicht gesperrt,
- erfüllt `ProfileCanBeActivated`.

## Verhalten bei gesperrtem Startprofil

Ein gesperrtes zuletzt verwendetes oder Standardprofil kann als bevorzugtes Startprofil identifiziert werden.

Es wird jedoch nicht aktiviert, bevor eine erfolgreiche Authentifizierung vorliegt.

Das Ergebnis kann deshalb unterscheiden zwischen:

```text
readyToActivate
requiresUnlock
noAvailableProfile
```

## Postconditions des fachlichen Plans

Nach erfolgreicher atomarer Anwendung gilt:

- höchstens ein Profil ist aktiv,
- das bisher aktive Profil ist deaktiviert,
- das Zielprofil ist aktiv,
- die zuletzt verwendete Profilreferenz ist gültig.

## Domain Events

Nach erfolgreicher Persistierung können entstehen:

```text
ProfileDeactivated
ProfileActivated
ActiveProfileChanged
```

## Geschützte Invarianten

- `PRO-CINV-003` – Höchstens ein Profil ist aktiv.
- `PRO-CINV-004` – Die zuletzt verwendete ProfileId verweist nur auf ein vorhandenes Profil.

## Traceability

- PRO-FR-007
- PRO-FR-008
- PRO-FR-010
- PRO-UC-007
- PRO-UC-008
- PRO-BR-010
- PRO-BR-011
- PRO-VR-012

---

# Domain Service: ProfileLifecycleService

## Zweck

`ProfileLifecycleService` koordiniert fachliche Entscheidungen für profilübergreifende Lebenszyklusoperationen.

## Verantwortlichkeiten

- Archivierung planen,
- Wiederherstellung planen,
- endgültige Löschung bewerten,
- alternatives aktives Profil bestimmen,
- Übergang in den Initialzustand planen.

## Abhängigkeiten

```text
ProfileRepository
ProfileContextRepository
ProfileCanBeArchived
ProfileCanBeDeleted
```

Technische Löschung und Persistierung gehören nicht zum Domain Service.

## Operationen

```text
DomainResult<ProfileArchivePlan> planArchiveProfile(
  ProfileId profileId
)

DomainResult<ProfileRestorePlan> planRestoreProfile(
  ProfileId profileId
)

DomainResult<ProfileDeletionPlan> planDeleteProfile(
  ProfileId profileId,
  DeletionAuthorization authorization
)

DomainResult<InitialStatePlan> planEnterInitialState(
  InitialStateReason reason
)
```

---

## Archivierung

### Preconditions

- Das Profil existiert.
- Das Profil ist nicht bereits archiviert.
- Die Archivierung ist gemäß `ProfileCanBeArchived` zulässig.

### ProfileArchivePlan

Der Plan enthält mindestens:

- zu archivierendes Profil,
- erforderliche Deaktivierung,
- erforderliche Entfernung des Standardstatus,
- mögliches alternatives aktives Profil,
- zu bereinigende Kontextreferenzen.

### Postconditions nach atomarer Anwendung

- Das Profil ist archiviert.
- Es ist nicht aktiv.
- Es ist nicht Standardprofil.
- Zugehörige Profildaten bleiben erhalten.

---

## Wiederherstellung

### Preconditions

- Das Profil existiert.
- Das Profil ist archiviert.

### ProfileRestorePlan

Der Plan enthält:

- das wiederherzustellende Profil,
- den Zielstatus `inactive`,
- unveränderte `ProfileId`,
- unveränderte Profildaten.

### Postconditions nach atomarer Anwendung

- Das Profil ist nicht mehr archiviert.
- Es ist nicht automatisch aktiv.
- Es ist nicht automatisch Standardprofil.

---

## Endgültige Löschung

### Preconditions

- Das Profil existiert.
- Die Löschung wurde ausdrücklich bestätigt.
- Die erforderliche Sicherheitsautorisierung liegt vor.
- `ProfileCanBeDeleted` ist erfüllt.
- Abhängige Daten können vollständig ermittelt werden.

### ProfileDeletionPlan

Der Plan enthält mindestens:

| Feld | Typ |
|---|---|
| profileId | ProfileId |
| profile | Profile |
| dependentDataDeletionRequired | Boolean |
| imageDeletionRequired | Boolean |
| clearActiveReference | Boolean |
| clearLastUsedReference | Boolean |
| clearDefaultReference | Boolean |
| alternativeActiveProfileId | ProfileId? |
| enterInitialState | Boolean |

### Postconditions nach atomarer Ausführung

Entweder:

- das Profil und sämtliche zugehörigen personenbezogenen Daten sind vollständig gelöscht,
- ein anderes gültiges Profil ist aktiv,

oder:

- die Anwendung befindet sich im Initialzustand.

Eine teilweise Löschung ist unzulässig.

---

# Initialzustand

## Operation

```text
DomainResult<InitialStatePlan> planEnterInitialState(
  InitialStateReason reason
)
```

## Zulässige Gründe

```text
lastProfileDeleted
explicitFullReset
```

## Einschränkung

Diese Operation darf ausschließlich geplant werden:

- nach der erfolgreichen fachlichen Freigabe zur Löschung des letzten Profils,

oder:

- im Rahmen eines ausdrücklich spezifizierten vollständigen System-Resets.

Andere Komponenten dürfen den Initialzustand nicht beliebig herstellen.

## InitialStatePlan

Der Plan enthält mindestens:

- zu leerende Profilreferenzen,
- zu entfernende profilbezogene Zustände,
- zu erhaltende globale Einstellungen,
- Zielzustand `initial`.

## Geschützte Invariante

- `PRO-CINV-005` – Nach Löschung des letzten Profils existieren keine Profilreferenzen.

## Domain Events

Nach erfolgreichem Commit können entstehen:

```text
ProfileArchived
ProfileRestored
ProfileDeleted
ApplicationEnteredInitialState
```

## Traceability

- PRO-FR-004
- PRO-FR-005
- PRO-FR-006
- PRO-FR-026
- PRO-UC-004
- PRO-UC-005
- PRO-UC-006
- PRO-UC-026
- PRO-BR-002
- PRO-BR-003
- PRO-BR-008
- PRO-BR-026

---

# Domain Service: ProfileImportDomainService

## Zweck

`ProfileImportDomainService` bewertet einen technisch bereits gelesenen und vorgeprüften Importkandidaten fachlich.

Technische Dateiverarbeitung, Deserialisierung und Persistierung gehören nicht zu diesem Service.

## Verantwortlichkeiten

- fachliche Importvalidierung,
- profilübergreifende Invarianten prüfen,
- ID-Konflikte bewerten,
- zulässige Importstrategie bestimmen,
- fachlichen Importplan erzeugen.

## Abhängigkeiten

```text
ProfileRepository
ProfileFactory
ProfileImportPolicy
```

## Operationen

```text
DomainResult<ValidatedProfileImport> validateImport(
  ProfileImportCandidate candidate
)

DomainResult<ProfileImportPlan> planImport(
  ValidatedProfileImport validatedImport,
  ProfileImportStrategy strategy
)
```

## Zulässige Importstrategien

```text
reject
generateNewId
replaceExisting
```

Eine automatische Zusammenführung ist nicht zulässig, solange keine eigene fachliche Spezifikation dafür existiert.

## ValidatedProfileImport

Enthält ausschließlich fachlich validierte Importdaten.

Es ist noch kein persistiertes Aggregate.

## ProfileImportPlan

Der Plan enthält mindestens:

- zu erzeugendes oder zu ersetzendes `Profile`,
- endgültige `ProfileId`,
- Konfliktstrategie,
- betroffene Kontextreferenzen,
- erforderliche Migrationsinformationen.

## Preconditions

- Die technische Integritätsprüfung war erfolgreich.
- Das Dateiformat und die Version werden unterstützt.
- Der Kandidat enthält keine unzulässigen Sicherheitsdaten.
- Die Importstrategie ist zulässig.

## Postconditions nach atomarer Anwendung

Bei Erfolg:

- das vollständige Profil wurde übernommen,
- sämtliche Invarianten sind erfüllt,
- keine fremden Profile wurden unbeabsichtigt verändert.

Bei Fehler:

- keine Änderung wurde persistiert.

## Geschützte Invariante

- `PRO-CINV-006` – Ein Import verändert keine fremden Profile ohne ausdrückliche Konfliktstrategie.

## Domain Events

Nach erfolgreichem Commit:

```text
ProfileImported
```

## Traceability

- PRO-FR-025
- PRO-UC-025
- PRO-BR-022
- PRO-BR-023
- PRO-VR-015

---

# Domain Service: ProfileExportDomainService

## Zweck

`ProfileExportDomainService` bestimmt den fachlich zulässigen Exportumfang eines Profils.

Technische Serialisierung und Dateierzeugung gehören nicht zur Domäne.

## Verantwortlichkeiten

- Exportberechtigung fachlich bewerten,
- zulässige Datenbereiche bestimmen,
- fremde Profildaten ausschließen,
- sensible Sicherheitsinformationen ausschließen,
- fachliches Exportmodell vorbereiten.

## Abhängigkeiten

```text
ProfileRepository
ProfileDataQueryPort
Clock
```

Der Service liest fachliche Exportdaten, speichert oder serialisiert sie jedoch nicht.

## Operation

```text
DomainResult<ProfileExportModel> prepareExport(
  ProfileId profileId,
  ProfileExportSectionSelection requestedSections
)
```

## Preconditions

- Das Profil existiert.
- Der Zugriff auf das Profil ist fachlich zulässig.
- Die angeforderten Bereiche sind unterstützt.
- Der Profilkontext ist eindeutig.

## ProfileExportModel

Das Modell enthält mindestens:

- Exportversion,
- Exportzeitpunkt,
- ProfileId,
- freigegebene Profildaten,
- ausgewählte profilbezogene Datenbereiche,
- keine Credentials,
- keine Passwort-Hashes,
- keine Hash-Parameter,
- keine kryptographischen Schlüssel,
- keine Daten anderer Profile.

## Postconditions

- Das Ergebnis enthält ausschließlich freigegebene Daten.
- Das Profil wurde nicht verändert.
- Es erfolgte keine Persistierung.
- Es wurden keine Dateien erzeugt.

## Domain Event

`ProfileExported` wird erst nach erfolgreicher technischer Exporterzeugung und Abschluss des Use Cases veröffentlicht.

Der Domain Service veröffentlicht das Event nicht selbst.

## Traceability

- PRO-FR-024
- PRO-UC-024
- PRO-BR-021
- PRO-VR-016

---

# Verantwortungsgrenze

Domain Services liefern ausschließlich:

- fachliche Entscheidungen,
- fachliche Pläne,
- validierte Modelle,
- strukturierte `DomainResult<T>`-Ergebnisse.

Sie führen nicht selbst aus:

- `Repository.save()`,
- `Repository.delete()`,
- `UnitOfWork.commit()`,
- `UnitOfWork.rollback()`,
- Event-Publishing,
- Dateizugriffe,
- Bildlöschung,
- Datenlöschung in anderen Modulen.

Diese Aufgaben werden durch Application Services und Infrastrukturadapter koordiniert.

---

# Status dieses Abschnitts

Mit Teil 5A sind definiert:

- allgemeine Regeln für Domain Services,
- `ProfileUniquenessService`,
- `DefaultProfileCoordinator`,
- `ActiveProfileCoordinator`,
- `ProfileLifecycleService`,
- eingeschränktes Herstellen des Initialzustands,
- `ProfileImportDomainService`,
- `ProfileExportDomainService`,
- einheitliche Rückgabe über `DomainResult<T>`,
- klare Trennung zwischen fachlicher Planung und technischer Ausführung.

Die Domain Services sind zustandslos, technologieunabhängig und steuern weder Persistenz noch Transaktionen oder Event-Veröffentlichung.

# Teil 5B-1 – Factory

# ProfileFactory

## Zweck

Die `ProfileFactory` erzeugt ausschließlich fachlich gültige `Profile`-Aggregate.

Sie stellt sicher, dass ein Aggregate niemals in einem ungültigen Zustand entsteht.

Die Factory

- erzeugt neue Aggregate,
- rekonstruiert bestehende Aggregate,
- erzeugt Aggregate aus validierten Importdaten.

Sie

- speichert keine Aggregate,
- veröffentlicht keine Domain Events,
- öffnet keine Transaktionen,
- kennt keine Persistenzimplementierung.

Alle Factory-Methoden liefern

```text
DomainResult<T>
```

---

# Allgemeine Factory-Regeln

## PRO-PF-001 – Nur gültige Aggregate

Eine Factory erzeugt ausschließlich vollständig gültige Aggregate.

Ein teilweise gültiges Aggregate darf niemals entstehen.

---

## PRO-PF-002 – Keine Persistenz

Factories besitzen keinerlei Kenntnis von

- SQLite
- Drift
- Hive
- JSON
- REST
- Dateien
- Repository-Implementierungen

---

## PRO-PF-003 – Keine Geschäftsprozesse

Factories erzeugen Objekte.

Sie koordinieren keine vollständigen Use Cases.

Sie entscheiden nicht über

- Aktivierung,
- Standardprofil,
- Löschung,
- Importstrategie.

---

## PRO-PF-004 – Keine Event-Veröffentlichung

Während der Erzeugung werden keine Domain Events veröffentlicht.

Aggregate können interne Events sammeln.

Die Veröffentlichung erfolgt ausschließlich nach erfolgreichem Commit.

---

## PRO-PF-005 – Keine Transaktionssteuerung

Factories

- öffnen keine UnitOfWork,
- führen keinen Commit aus,
- führen keinen Rollback aus.

---

## PRO-PF-006 – Verwendung von Value Objects

Factories akzeptieren ausschließlich

- Value Objects,
- Enumerationen,
- fachliche Parameterobjekte.

Primitive Datentypen sollen möglichst bereits vor dem Factory-Aufruf gekapselt sein.

---

## PRO-PF-007 – DomainResult

Alle Factory-Methoden liefern

```text
DomainResult<T>
```

Fachliche Fehler werden nicht über Exceptions signalisiert.

---

# Verantwortlichkeiten

Die `ProfileFactory` ist verantwortlich für:

- Erzeugung eines neuen Aggregats
- Rekonstruktion eines Aggregats
- Erzeugung aus Importdaten
- Prüfung der Aggregate-Invarianten
- Initialisierung der AuditInformation
- Initialisierung der AggregateVersion

Nicht verantwortlich ist sie für:

- Speichern
- Laden
- Passwortprüfung
- Bildverarbeitung
- Event Publishing
- Transaktionssteuerung
- Repositoryzugriffe

---

# createNew()

## Zweck

Erzeugt ein vollständig neues Profile Aggregate.

---

## Signatur

```text
DomainResult<Profile> createNew(
    ProfileId profileId,
    ProfileName profileName,
    BirthYear birthYear,
    Height height,
    Gender gender,
    ProfileColor profileColor,
    ProfileSettings profileSettings,
    ProfileSecurity profileSecurity,
    ProfileImage? profileImage,
    Timestamp now
)
```

---

## Preconditions

Alle übergebenen Value Objects

- sind gültig,
- gehören fachlich zusammen,
- verletzen keine Aggregate-Invariante.

---

## Initialzustand

Ein neu erzeugtes Aggregate besitzt

```text
ProfileStatus.inactive

DefaultProfileFlag.createDisabled()

AggregateVersion.createInitial()

AuditInformation.createInitial(now)
```

Weiterhin

- keine ungültigen Referenzen,
- keine inkonsistenten Entities,
- leere DomainEventCollection.

---

## Postconditions

Bei Erfolg

- vollständiges Profile Aggregate
- gültige AggregateVersion
- gültige AuditInformation
- alle Invarianten erfüllt

Bei Fehler

```text
DomainResult<Profile>
```

mit Domain Messages.

---

## Domain Events

Das Aggregate kann intern

```text
ProfileCreated
```

registrieren.

Die Factory veröffentlicht dieses Event nicht.

---

# reconstitute()

## Zweck

Rekonstruiert ein bereits vorhandenes Aggregate aus einer vertrauenswürdigen Persistenzquelle.

---

## Signatur

```text
DomainResult<Profile> reconstitute(
    PersistedProfileModel model
)
```

---

## Ziel

Rekonstruktion

nicht Neuerzeugung.

---

## Regeln

Während der Rekonstruktion

- werden alle Value Objects erneut validiert,
- werden Aggregate-Invarianten geprüft,
- werden Entities vollständig aufgebaut,
- erfolgt keine Persistierung.

---

## Fehlerfälle

Die Rekonstruktion schlägt fehl,

wenn

- Pflichtfelder fehlen,
- ungültige Value Objects entstehen,
- Aggregate-Invarianten verletzt werden,
- unbekannte Enum-Werte auftreten,
- Versionen ungültig sind.

---

## Ergebnis

Erfolg

```text
DomainResult<Profile>
```

mit vollständig rekonstruiertem Aggregate.

Fehler

```text
DomainResult<Profile>
```

mit strukturierten Domain Messages.

---

## Rekonstruktionsregel

Persistierte Daten gelten niemals automatisch als gültig.

Die Factory prüft sämtliche Domänenregeln erneut.

---

# fromImport()

## Zweck

Erzeugt ein Aggregate aus einem bereits fachlich validierten Importmodell.

---

## Signatur

```text
DomainResult<Profile> fromImport(
    ValidatedProfileImport importModel
)
```

---

## Voraussetzungen

Vor dem Factory-Aufruf wurden bereits geprüft

- Dateiformat
- Versionskompatibilität
- Importstrategie
- ID-Konflikte
- Sicherheitsregeln

---

## Aufgabe der Factory

Die Factory

- erzeugt das Aggregate,
- erzeugt sämtliche Entities,
- erzeugt sämtliche Value Objects,
- initialisiert AuditInformation,
- prüft Aggregate-Invarianten.

---

## Nicht Aufgabe

Die Factory entscheidet nicht

- ob importiert werden darf,
- welche Strategie gewählt wird,
- ob bestehende Daten überschrieben werden.

---

## Ergebnis

```text
DomainResult<Profile>
```

---

# Interne Erzeugungsreihenfolge

Konzeptionell erfolgt die Erzeugung in folgender Reihenfolge:

```text
ProfileId

↓

Value Objects

↓

ProfileSettings

↓

ProfileSecurity

↓

AuditInformation

↓

Profile

↓

Aggregate Validation

↓

DomainResult
```

Während der Erzeugung existiert niemals ein teilweise gültiges Aggregate.

---

# Aggregate Validation

Vor erfolgreicher Rückgabe werden mindestens geprüft

```text
AG-INV-001

AG-INV-002

AG-INV-003

AG-INV-004

AG-INV-005

AG-INV-006

AG-INV-007

AG-INV-008

AG-INV-009
```

Erst danach wird das Aggregate zurückgegeben.

---

# Fehlerbehandlung

Fachliche Fehler

```text
↓

Domain Messages

↓

DomainResult
```

Technische Fehler

```text
↓

Exception
```

Die Factory vermischt beide Kategorien nicht.

---

# Factory-Invarianten

Während jeder Erzeugung gilt

- kein ungültiges Aggregate
- keine fehlenden Pflichtobjekte
- keine inkonsistenten Entity-Beziehungen
- keine ungültigen Value Objects
- keine fehlende AuditInformation
- keine ungültige AggregateVersion

---

# Testbarkeit

Alle Factory-Methoden sind deterministisch.

Bei identischen Eingaben entsteht stets derselbe fachliche Zustand.

Zeitabhängigkeit erfolgt ausschließlich über

```text
Timestamp

Clock
```

nicht über direkte Systemzugriffe.

---

# Architekturregeln

Die ProfileFactory

- besitzt keine Infrastrukturabhängigkeiten,
- kennt keine Repositoryimplementierung,
- kennt keine Datenbank,
- kennt keine Flutter-Klassen,
- besitzt keine Seiteneffekte,
- besitzt keinen internen Zustand,
- erzeugt ausschließlich gültige Aggregate.

---

# Traceability

## Requirements

- PRO-FR-001
- PRO-FR-003
- PRO-FR-025
- PRO-FR-027

## Business Rules

- PRO-BR-006
- PRO-BR-007
- PRO-BR-022

## Validation Rules

- PRO-VR-011
- PRO-VR-014
- PRO-VR-015

## Domain Model

- AG-INV-001
- AG-INV-009
- AG-INV-014

---

# Status dieses Abschnitts

Mit Teil **5B-1** sind vollständig definiert:

- allgemeine Factory-Regeln,
- Verantwortlichkeiten der `ProfileFactory`,
- `createNew()`,
- `reconstitute()`,
- `fromImport()`,
- Rekonstruktionsregeln,
- Aggregate-Validierung,
- Fehlerbehandlung,
- Factory-Invarianten,
- Testbarkeit,
- Architekturregeln,
- Traceability.

Die Factory erzeugt ausschließlich gültige Aggregate und trennt die Objekterzeugung konsequent von Persistenz, Transaktionssteuerung und Anwendungslogik.

---

# Teil 5B-2

Der nächste Abschnitt enthält:

- Repository-Regeln
- `ProfileRepository`
- `ProfileContextRepository`
- `UnitOfWork`
- `ApplicationService`
- Verantwortungsmatrix
- Transaktionsablauf
- Architekturregeln
- Abschluss von Teil 5B

# Teil 5B-2 – Repository, UnitOfWork und Application Layer

# Repository Interfaces

## Zweck

Repositorys bilden die fachliche Sicht auf die Persistenz.

Sie verhalten sich wie Sammlungen vollständiger Aggregate.

Ein Repository speichert und lädt ausschließlich Aggregate.

Es enthält keine Geschäftslogik.

---

# Allgemeine Repository-Regeln

## PRO-REP-001 – Aggregate statt Tabellen

Repositorys arbeiten ausschließlich mit vollständigen Aggregaten.

Sie liefern niemals

- Datenbankobjekte,
- DTOs,
- JSON,
- Tabellenzeilen.

---

## PRO-REP-002 – Keine Geschäftslogik

Repositorys

- validieren keine Business Rules,
- erzeugen keine Domain Events,
- treffen keine fachlichen Entscheidungen.

---

## PRO-REP-003 – Keine Aggregate erzeugen

Neue Aggregate entstehen ausschließlich durch

```text
ProfileFactory
```

Repositorys rekonstruieren oder speichern lediglich vorhandene Aggregate.

---

## PRO-REP-004 – Keine Transaktionssteuerung

Repositorys führen niemals

```text
commit()

rollback()
```

aus.

Diese Verantwortung besitzt ausschließlich die UnitOfWork.

---

## PRO-REP-005 – Repository = Collection

Ein Repository verhält sich fachlich wie eine Sammlung vollständiger Aggregate.

---

# ProfileRepository

## Verantwortlichkeiten

Das Repository

- lädt Profile,
- speichert Profile,
- löscht Profile,
- stellt fachliche Suchoperationen bereit.

---

## Operationen

```text
findById(ProfileId)

findAll()

findAvailable()

findArchived()

findActive()

findDefault()

exists(ProfileId)

count()

countAvailable()

save(Profile)

delete(ProfileId)
```

---

## Rückgaberegeln

Ladeoperationen liefern

```text
DomainResult<Profile>

DomainResult<List<Profile>>
```

Nicht gefunden bedeutet

```text
DomainResult
```

mit passender Domain Message,

nicht mit Exception.

---

## save()

```text
DomainResult<void>

save(Profile)
```

---

### Regeln

Es wird immer

ein vollständiges Aggregate gespeichert.

Teilpersistierungen sind unzulässig.

---

## delete()

```text
DomainResult<void>

delete(ProfileId)
```

Die fachliche Löschentscheidung wurde bereits vorher getroffen.

---

# ProfileContextRepository

## Zweck

Speichert globale Profilreferenzen.

Diese Referenzen gehören ausdrücklich nicht zum Profile Aggregate.

---

## Verantwortlichkeiten

Verwaltet

```text
ActiveProfileId

LastUsedProfileId

DefaultProfileId
```

---

## Operationen

```text
getActiveProfileId()

setActiveProfileId()

clearActiveProfileId()

getLastUsedProfileId()

setLastUsedProfileId()

clearLastUsedProfileId()

getDefaultProfileId()

setDefaultProfileId()

clearDefaultProfileId()
```

---

## Regeln

Referenzen dürfen ausschließlich

auf vorhandene Profile zeigen.

Nach Löschung des letzten Profils

existieren keine Referenzen mehr.

---

# UnitOfWork

## Zweck

Die UnitOfWork koordiniert atomare Änderungen

über mehrere Repositorys.

Sie garantiert

```text
alles

oder

nichts
```

---

# Verantwortlichkeiten

Die UnitOfWork

- beginnt Transaktionen,
- bestätigt Transaktionen,
- verwirft Transaktionen,
- koordiniert Repositorys.

---

# Regeln

## PRO-UOW-001

Commit erfolgt genau einmal.

---

## PRO-UOW-002

Rollback stellt den ursprünglichen Zustand vollständig wieder her.

---

## PRO-UOW-003

Domain Events dürfen

erst

nach erfolgreichem Commit veröffentlicht werden.

---

## PRO-UOW-004

Repositorys besitzen

keine Commit-Logik.

---

## PRO-UOW-005

Factories besitzen

keine Commit-Logik.

---

## PRO-UOW-006

Domain Services besitzen

keine Commit-Logik.

---

# Operationen

```text
begin()

commit()

rollback()

execute()
```

---

# Typische Anwendungsfälle

```text
Profil erstellen

Profil löschen

Profil archivieren

Standardprofil wechseln

Profil aktivieren

Profil importieren
```

---

# Atomarität

Während einer UnitOfWork gilt

```text
keine teilweise erfolgreiche Änderung
```

---

# Application Service

## Zweck

Application Services koordinieren

einen vollständigen Use Case.

Sie enthalten

keine eigentliche Geschäftslogik.

---

## Verantwortlichkeiten

Ein Application Service

- öffnet UnitOfWork,
- ruft Factory auf,
- ruft Domain Services auf,
- ruft Repositorys auf,
- speichert Aggregate,
- führt Commit aus,
- veröffentlicht Domain Events.

---

## Nicht verantwortlich

Application Services

- validieren keine Value Objects,
- enthalten keine Business Rules,
- speichern keine Daten selbst,
- erzeugen keine Aggregate selbst.

---

# Typischer Ablauf

```text
Use Case

↓

Application Service

↓

Factory

↓

Aggregate

↓

Domain Service

↓

Repository

↓

UnitOfWork

↓

Commit

↓

DomainEventPublisher

↓

Erfolg
```

---

# Fehlerfall

```text
Use Case

↓

Application Service

↓

Factory

↓

Repository

↓

Fehler

↓

Rollback

↓

DomainResult
```

---

# Verantwortungsmatrix

| Komponente | Verantwortung |
|------------|---------------|
| Value Object | fachlicher Wert |
| Entity | lokale Fachlogik |
| Aggregate | Konsistenzgrenze |
| Domain Service | profilübergreifende Fachlogik |
| Factory | Aggregate erzeugen |
| Repository | Aggregate laden/speichern |
| UnitOfWork | Commit/Rollback |
| Application Service | Use Case koordinieren |
| DomainEventPublisher | Events veröffentlichen |

---

# Transaktionsmodell

## Erfolgsfall

```text
Application Service

↓

Factory

↓

Aggregate

↓

Domain Service

↓

Repository

↓

UnitOfWork.begin()

↓

Repository.save()

↓

UnitOfWork.commit()

↓

DomainEventPublisher.publish()

↓

Ende
```

---

## Fehlerfall

```text
Application Service

↓

Repository

↓

Fehler

↓

UnitOfWork.rollback()

↓

DomainResult
```

---

# Domain Events

Domain Events entstehen

im Aggregate.

Sie werden

nicht

durch

- Factory,
- Repository,
- Domain Service

veröffentlicht.

Die Veröffentlichung erfolgt

ausschließlich

nach erfolgreichem Commit.

---

# Architekturprinzipien

Für Repositorys,

Factories,

Application Services

und UnitOfWork gelten gemeinsam

folgende Regeln.

---

## Trennung der Verantwortlichkeiten

Factory

```text
Objekte erzeugen
```

---

Aggregate

```text
Geschäftslogik
```

---

Repository

```text
Persistieren
```

---

UnitOfWork

```text
Transaktionen
```

---

Application Service

```text
Use Case koordinieren
```

---

DomainEventPublisher

```text
Events veröffentlichen
```

---

# Dependency Rule

Die Abhängigkeiten verlaufen ausschließlich nach innen.

```text
UI

↓

Application

↓

Domain

↓

Ports

↓

Infrastructure
```

Die Domain kennt

keine

Infrastructure.

---

# Testbarkeit

Alle Komponenten können

isoliert getestet werden.

Repositorys,

Ports,

Clock,

EventPublisher

werden

über Interfaces ersetzt.

---

# Traceability

## Requirements

- PRO-FR-001
- PRO-FR-003
- PRO-FR-024
- PRO-FR-025
- PRO-FR-026
- PRO-FR-027

---

## Business Rules

- PRO-BR-006
- PRO-BR-007
- PRO-BR-021
- PRO-BR-022

---

## Validation Rules

- PRO-VR-011
- PRO-VR-014
- PRO-VR-015
- PRO-VR-016

---

# Status dieses Abschnitts

Mit Teil **5B-2** sind vollständig definiert:

- Repository-Regeln
- ProfileRepository
- ProfileContextRepository
- UnitOfWork
- Rolle des Application Service
- Verantwortungsmatrix
- Transaktionsmodell
- Domain Event Flow
- Dependency Rule
- Architekturprinzipien
- Traceability

Zusammen mit **Teil 5A** und **Teil 5B-1** ist die fachliche Architektur des Profilmoduls vollständig beschrieben. Die Verantwortlichkeiten von Domain, Application Layer und Infrastruktur sind klar getrennt und entsprechen den Prinzipien von Domain-Driven Design und Clean Architecture.

---

# Teil 5C

Der nächste Abschnitt beschreibt:

- Domain Ports
- PasswordHashPort
- AuthenticationPort
- ProfileImageStoragePort
- ProfileImageValidationPort
- ProfileImageTransformationPort
- ProfileDataDeletionPort
- ProfileDataQueryPort
- Clock
- DomainEventPublisher
- Port-Regeln
- Infrastrukturgrenzen

# Teil 5C-1 – Security- und Authentication-Ports

# Domain Ports

## Zweck

Domain Ports beschreiben fachlich benötigte Fähigkeiten, die technisch außerhalb der Domäne umgesetzt werden.

Die Domäne kennt ausschließlich die Port-Interfaces.

Konkrete Implementierungen befinden sich im Infrastructure Layer.

Security- und Authentication-Ports kapseln insbesondere:

- Erzeugung sicherer Passwort-Credentials,
- Verifikation von Credentials,
- Anforderung und Prüfung einer Authentifizierung,
- Erzeugung eines `AuthenticationProof`,
- Bewertung sicherheitsrelevanter Ergebnisse.

Alle Port-Operationen liefern:

```text
DomainResult<T>
```

Fachlich erwartbare Fehler werden nicht über Exceptions signalisiert.

---

# Allgemeine Port-Regeln

## PRO-DP-001 – Fachliche Fähigkeiten statt technischer APIs

Ports beschreiben fachliche Fähigkeiten.

Sie bilden keine technischen Bibliotheks- oder Plattform-APIs direkt ab.

Zulässig:

```text
createCredential()

verifyCredential()

requestAuthentication()
```

Nicht zulässig:

```text
argon2Hash()

showBiometricPrompt()

callWindowsHello()
```

Die konkrete Technologie bleibt Aufgabe des Adapters.

---

## PRO-DP-002 – Abhängigkeiten zeigen nach innen

Die Domäne definiert die Port-Interfaces.

Die Infrastruktur implementiert diese Interfaces.

```text
Domain
   ▲
   │
Port Interface
   ▲
   │
Infrastructure Adapter
```

Die Domäne darf keine Infrastrukturimplementierung referenzieren.

---

## PRO-DP-003 – Technologieunabhängigkeit

Ports und ihre Rückgabemodelle enthalten keine Typen aus:

- Flutter,
- Android,
- iOS,
- Windows,
- Web APIs,
- SQLite,
- Drift,
- Hive,
- HTTP,
- Dateisystemen,
- Security-Bibliotheken.

---

## PRO-DP-004 – Domänentypen an der Schnittstelle

Port-Operationen verwenden ausschließlich:

- Value Objects,
- fachliche Ergebnisobjekte,
- Enumerationen,
- `DomainResult<T>`.

Technische DTOs oder Bibliothekstypen dürfen die Port-Grenze nicht überschreiten.

---

## PRO-DP-005 – Keine Geschäftslogik im Adapter

Ein Adapter implementiert die technische Fähigkeit eines Ports.

Er entscheidet nicht über:

- fachliche Berechtigungen,
- erlaubte Statusübergänge,
- Profil-Lebenszyklen,
- Business Rules,
- Aggregate-Invarianten.

Diese Entscheidungen verbleiben in Domäne und Application Layer.

---

## PRO-DP-006 – Strukturierte Fehler

Ports liefern technische und sicherheitsbezogene Fehler als strukturierte Domain Messages.

Beispiele:

- Credential konnte nicht erzeugt werden,
- Credential ist ungültig,
- Authentifizierung wurde abgebrochen,
- Authentifizierungsmethode ist nicht verfügbar,
- Authentifizierungsnachweis ist abgelaufen.

Sensible Werte dürfen nicht Bestandteil einer Fehlermeldung sein.

---

## PRO-DP-007 – Keine Speicherung von Klartextpasswörtern

Klartextpasswörter:

- dürfen nicht dauerhaft gespeichert werden,
- dürfen nicht protokolliert werden,
- dürfen nicht in Events erscheinen,
- dürfen nicht in Fehlermeldungen erscheinen,
- müssen nach ihrer Verwendung möglichst früh verworfen werden.

---

## PRO-DP-008 – Keine Seiteneffekte außerhalb des Port-Zwecks

Ein Security-Port darf nur die ausdrücklich definierte Fähigkeit ausführen.

Ein Credential-Port darf beispielsweise:

- ein Credential erzeugen,
- ein Credential prüfen.

Er darf nicht:

- Profile speichern,
- Profile aktivieren,
- Auditdaten verändern,
- Domain Events veröffentlichen.

---

# Value Object: PlainPassword

## Zweck

`PlainPassword` kapselt ein temporär vorliegendes Klartextpasswort an der Port-Grenze.

Es dient ausschließlich der unmittelbaren Sicherheitsverarbeitung.

## Regeln

- Das Value Object ist nur kurzlebig.
- Es darf nicht persistiert werden.
- Es darf nicht serialisiert werden.
- Es darf nicht protokolliert werden.
- Eine reguläre Textdarstellung muss den Inhalt vollständig maskieren.
- Es darf nicht Bestandteil eines Domain Events sein.
- Es darf nicht in `DomainResult`-Parametern erscheinen.

## Factory

```text
DomainResult<PlainPassword> create(
  String value
)
```

Die Factory prüft ausschließlich fachliche Mindestbedingungen.

Die eigentliche Sicherheitsrichtlinie wird durch den zuständigen Security-Port beziehungsweise `SECURITY_GUIDE.md` umgesetzt.

---

# Port: PasswordCredentialCreationPort

## Zweck

`PasswordCredentialCreationPort` erzeugt aus einem temporären Klartextpasswort ein sicheres `PasswordCredential`.

Der Port kapselt:

- Auswahl des freigegebenen Hashverfahrens,
- Erzeugung kryptographischer Parameter,
- Erzeugung des Hashwerts,
- Erstellung des vollständigen Credentials.

## Operation

```text
DomainResult<PasswordCredential> createCredential(
  PlainPassword password,
  Timestamp createdAt
)
```

## Preconditions

- `password` ist fachlich gültig.
- Das Passwort erfüllt die aktuell geltende Sicherheitsrichtlinie.
- `createdAt` ist gültig.
- Die benötigte Sicherheitsimplementierung ist verfügbar.

## Postconditions bei Erfolg

- Ein vollständiges `PasswordCredential` wurde erzeugt.
- Das Credential enthält kein Klartextpasswort.
- Hash, Algorithmus und Parameter sind konsistent.
- Das Credential besitzt einen gültigen Erstellungszeitpunkt.
- Das Klartextpasswort ist nicht Bestandteil des Ergebnisses.

## Fehlerfälle

Mögliche strukturierte Fehler:

```text
security.password.policyViolation
security.credential.creationFailed
security.algorithm.unavailable
security.parameters.invalid
```

## Nicht verantwortlich

Der Port:

- speichert das Credential nicht,
- ordnet es keinem Profil zu,
- aktiviert keinen Passwortschutz,
- veröffentlicht keine Events.

## Ergebnis

```text
DomainResult<PasswordCredential>
```

---

# Port: PasswordCredentialVerificationPort

## Zweck

`PasswordCredentialVerificationPort` prüft ein temporäres Klartextpasswort gegen ein vorhandenes `PasswordCredential`.

Die Operation liefert kein einfaches Boolean-Ergebnis, sondern ein fachlich erweiterbares Verifikationsergebnis.

## Operation

```text
DomainResult<CredentialVerificationResult> verifyCredential(
  PlainPassword password,
  PasswordCredential credential
)
```

## CredentialVerificationResult

| Feld | Typ | Bedeutung |
|---|---|---|
| verified | Boolean | Credential stimmt überein |
| rehashRecommended | Boolean | Credential sollte erneuert werden |
| algorithmStatus | CredentialAlgorithmStatus | Zustand des verwendeten Verfahrens |
| verifiedAt | Timestamp? | Zeitpunkt erfolgreicher Prüfung |

## CredentialAlgorithmStatus

Mögliche Werte:

```text
current
outdated
unsupported
```

## Preconditions

- `password` ist vorhanden.
- `credential` ist vollständig und gültig.
- Die benötigte Verifikationsimplementierung ist verfügbar.

## Postconditions bei erfolgreicher Prüfung

- `verified` ist `true`.
- Das Credential wurde nicht verändert.
- Das Klartextpasswort ist nicht Bestandteil des Ergebnisses.
- `rehashRecommended` zeigt an, ob ein neues Credential erzeugt werden sollte.

## Postconditions bei nicht erfolgreicher Prüfung

- `verified` ist `false`.
- Es werden keine Credential-Inhalte offengelegt.
- Das Ergebnis unterscheidet nach außen nicht unnötig zwischen internen Fehlerursachen.

## Fehlerfälle

Technische oder sicherheitsbezogene Fehler können sein:

```text
security.credential.invalid
security.credential.unsupportedAlgorithm
security.credential.verificationFailed
```

## Sicherheitsregel

Das Ergebnis darf niemals enthalten:

- Passwortbestandteile,
- Hashwerte,
- Salt,
- Hash-Parameter,
- Vergleichsdaten.

---

# Port: PasswordPolicyEvaluationPort

## Zweck

`PasswordPolicyEvaluationPort` bewertet ein temporäres Passwort gegen die aktuell geltende Sicherheitsrichtlinie.

Die fachliche Mindestvalidierung aus `04_VALIDATION_RULES.md` bleibt davon unberührt.

Der Port kapselt veränderliche Sicherheitsrichtlinien wie:

- Komplexitätsanforderungen,
- Sperrlisten,
- bekannte kompromittierte Passwörter,
- Passwort-Historie,
- organisationsweite Sicherheitsvorgaben.

## Operation

```text
DomainResult<PasswordPolicyEvaluationResult> evaluate(
  PlainPassword password,
  PasswordPolicyContext context
)
```

## PasswordPolicyContext

Mögliche Inhalte:

| Feld | Typ |
|---|---|
| profileId | ProfileId? |
| profileName | ProfileName? |
| previousCredentials | List<PasswordCredentialReference> |
| operation | PasswordPolicyOperation |

## PasswordPolicyOperation

```text
enableProtection
changePassword
importCredential
```

## PasswordPolicyEvaluationResult

| Feld | Typ |
|---|---|
| accepted | Boolean |
| violations | List<PasswordPolicyViolation> |
| warnings | List<PasswordPolicyWarning> |

## Regeln

- Der Port gibt keine lokalisierten Texte zurück.
- Verstöße werden über stabile Codes beschrieben.
- Die Sicherheitsrichtlinie kann geändert werden, ohne die Domain-Modelle anzupassen.
- Das Passwort selbst darf nicht in einem Ergebnis enthalten sein.

## Nicht verantwortlich

Der Port erzeugt kein Credential.

Die Trennung lautet:

```text
PasswordPolicyEvaluationPort
        │
        ▼
Passwort fachlich zulässig?
        │
        ▼
PasswordCredentialCreationPort
        │
        ▼
Credential erzeugen
```

---

# Port: AuthenticationRequestPort

## Zweck

`AuthenticationRequestPort` fordert eine konkrete Authentifizierung für einen definierten fachlichen Zweck an.

Der Port abstrahiert die technische Authentifizierungsmethode.

Mögliche Adapter können verwenden:

- Profilpasswort,
- lokale Biometrie,
- Betriebssystemauthentifizierung,
- zukünftige freigegebene Methoden.

Die Domäne kennt diese Methoden nicht.

## Operation

```text
DomainResult<AuthenticationAttemptResult> requestAuthentication(
  AuthenticationRequest request
)
```

## AuthenticationRequest

| Feld | Typ |
|---|---|
| profileId | ProfileId |
| purpose | AuthenticationPurpose |
| requestedAt | Timestamp |
| allowedMethods | AuthenticationMethodPolicy |

## AuthenticationAttemptResult

| Feld | Typ |
|---|---|
| status | AuthenticationAttemptStatus |
| proof | AuthenticationProof? |
| method | AuthenticationMethod? |
| completedAt | Timestamp? |

## AuthenticationAttemptStatus

```text
authenticated
rejected
cancelled
unavailable
expired
```

## Preconditions

- `profileId` ist gültig.
- Der Authentifizierungszweck ist definiert.
- Die Anforderung ist nicht abgelaufen.
- Mindestens eine zulässige Methode ist verfügbar.

## Postconditions bei Erfolg

- `status` ist `authenticated`.
- Ein gültiger `AuthenticationProof` liegt vor.
- Der Proof gehört zum angeforderten Profil.
- Der Proof besitzt den angeforderten Zweck.
- Der Proof enthält keine geheimen Authentifizierungsdaten.

## Postconditions bei Abbruch oder Ablehnung

- Es wird kein Proof erzeugt.
- Das Profil wird nicht verändert.
- Es werden keine sensiblen Daten offengelegt.

## Nicht verantwortlich

Der Port:

- aktiviert kein Profil,
- entsperrt kein Profil,
- ändert kein Passwort,
- speichert keinen Proof dauerhaft,
- trifft keine fachliche Entscheidung über die Folgeoperation.

---

# Port: AuthenticationProofValidationPort

## Zweck

`AuthenticationProofValidationPort` prüft, ob ein vorhandener `AuthenticationProof` für eine konkrete fachliche Operation verwendet werden darf.

Dies ist besonders relevant, wenn Proofs:

- zeitlich begrenzt,
- zweckgebunden,
- einmalig verwendbar,
- an ein bestimmtes Profil gebunden

sind.

## Operation

```text
DomainResult<AuthenticationProofValidationResult> validateProof(
  AuthenticationProof proof,
  AuthenticationProofRequirement requirement
)
```

## AuthenticationProofRequirement

| Feld | Typ |
|---|---|
| profileId | ProfileId |
| purpose | AuthenticationPurpose |
| validationTime | Timestamp |
| requireSingleUse | Boolean |

## AuthenticationProofValidationResult

| Feld | Typ |
|---|---|
| valid | Boolean |
| expirationStatus | ProofExpirationStatus |
| purposeMatches | Boolean |
| profileMatches | Boolean |
| reusable | Boolean |

## Regeln

Ein Proof ist nur gültig, wenn:

- die ProfileId übereinstimmt,
- der Zweck übereinstimmt,
- der Proof nicht abgelaufen ist,
- die Wiederverwendungsregel erfüllt ist.

## Fehlerfälle

```text
security.proof.invalid
security.proof.expired
security.proof.wrongPurpose
security.proof.wrongProfile
security.proof.alreadyUsed
```

---

# Port: AuthenticationProofConsumptionPort

## Zweck

`AuthenticationProofConsumptionPort` markiert einen einmalig verwendbaren Authentifizierungsnachweis nach erfolgreicher Nutzung als verbraucht.

Dieser Port ist nur erforderlich, wenn die Sicherheitsrichtlinie einmalig verwendbare Proofs vorsieht.

## Operation

```text
DomainResult<void> consumeProof(
  AuthenticationProof proof,
  Timestamp consumedAt
)
```

## Preconditions

- Der Proof ist gültig.
- Der Proof ist noch nicht verbraucht.
- Die zugehörige Fachoperation wurde erfolgreich abgeschlossen.

## Postconditions

- Der Proof kann nicht erneut verwendet werden.
- Es werden keine geheimen Daten gespeichert.
- Die Konsumierung ist nachvollziehbar, ohne sensible Inhalte zu protokollieren.

## Transaktionsregel

Wenn die Proof-Konsumierung Bestandteil einer sicherheitskritischen Fachoperation ist, muss sie atomar mit dieser Operation koordiniert werden.

---

# Sicherheitsbezogene Ergebnisobjekte

## CredentialVerificationResult

Beschreibt ausschließlich das Ergebnis einer Credential-Prüfung.

Es trifft keine Entscheidung darüber, ob eine Profiloperation ausgeführt werden darf.

---

## AuthenticationAttemptResult

Beschreibt das Ergebnis einer konkreten Authentifizierungsanforderung.

Nur bei `authenticated` darf ein `AuthenticationProof` enthalten sein.

---

## AuthenticationProofValidationResult

Beschreibt die Verwendbarkeit eines Proofs für eine konkrete Operation.

---

## PasswordPolicyEvaluationResult

Beschreibt die Bewertung eines Passworts gegen eine veränderliche Sicherheitsrichtlinie.

---

# Ablauf: Passwortschutz aktivieren

```text
Application Service
        │
        ▼
PlainPassword.create()
        │
        ▼
PasswordPolicyEvaluationPort.evaluate()
        │
        ├── abgelehnt → DomainResult mit Fehlern
        │
        ▼
PasswordCredentialCreationPort.createCredential()
        │
        ▼
Profile.enablePasswordProtection()
        │
        ▼
Repository.save()
        │
        ▼
UnitOfWork.commit()
        │
        ▼
Domain Events veröffentlichen
```

---

# Ablauf: Passwort ändern

```text
Application Service
        │
        ▼
AuthenticationRequestPort.requestAuthentication()
        │
        ▼
AuthenticationProofValidationPort.validateProof()
        │
        ▼
PasswordPolicyEvaluationPort.evaluate()
        │
        ▼
PasswordCredentialCreationPort.createCredential()
        │
        ▼
Profile.changePassword()
        │
        ▼
Repository.save()
        │
        ▼
UnitOfWork.commit()
        │
        ▼
Proof verbrauchen, sofern erforderlich
        │
        ▼
Events veröffentlichen
```

---

# Ablauf: Profil entsperren

```text
Application Service
        │
        ▼
AuthenticationRequestPort.requestAuthentication()
        │
        ▼
AuthenticationProofValidationPort.validateProof()
        │
        ▼
Profile.unlock()
        │
        ▼
Repository.save()
        │
        ▼
UnitOfWork.commit()
        │
        ▼
Events veröffentlichen
```

Die Authentifizierung und die fachliche Entsperrung bleiben getrennte Verantwortlichkeiten.

---

# Sicherheitsregeln

## Keine Offenlegung

Folgende Inhalte dürfen niemals in Logs, Events, Fehlerparametern oder öffentlichen DTOs erscheinen:

- Klartextpasswörter,
- Passwort-Hashes,
- Salt-Werte,
- vollständige Hash-Parameter,
- interne Vergleichsergebnisse,
- biometrische Rohdaten,
- Betriebssystem-Credentials.

---

## Zweckbindung

Ein `AuthenticationProof` darf nur für den vorgesehenen `AuthenticationPurpose` verwendet werden.

---

## Zeitliche Gültigkeit

Proofs können zeitlich begrenzt sein.

Die Prüfung erfolgt über einen ausdrücklich übergebenen `Timestamp`.

---

## Minimale Datenhaltung

Security-Adapter speichern nur die technisch zwingend erforderlichen Informationen.

---

## Kein Benutzer-Leakage

Fehlerantworten dürfen keine unnötigen Informationen darüber offenlegen:

- welches Credential existiert,
- welcher Hashalgorithmus verwendet wurde,
- warum ein Passwort intern genau abgelehnt wurde,
- welche Authentifizierungsmethode intern fehlgeschlagen ist.

---

# DomainResult-Regeln für Security-Ports

## Erfolg

```text
DomainResult<T>
├── value vorhanden
├── errors leer
├── warnings optional
└── information optional
```

## Erwartbarer Fehler

```text
DomainResult<T>
├── kein Erfolgswert
├── errors vorhanden
└── keine sensiblen Parameter
```

## Technischer Ausnahmefall

Unerwartete Infrastrukturfehler können intern als Exception entstehen.

Der Adapter übersetzt sie an der Port-Grenze in einen strukturierten technischen Fehler, sofern eine sichere Behandlung möglich ist.

Programmierfehler dürfen nicht als reguläre fachliche Ergebnisse verschleiert werden.

---

# Testbarkeit

Für Tests werden Port-Implementierungen durch Test Doubles ersetzt.

Beispiele:

```text
FakePasswordPolicyEvaluationPort
FakePasswordCredentialCreationPort
FakePasswordCredentialVerificationPort
FakeAuthenticationRequestPort
FakeAuthenticationProofValidationPort
FakeAuthenticationProofConsumptionPort
```

Test Doubles müssen:

- deterministische Ergebnisse liefern,
- keine echten Passwörter protokollieren,
- Proof-Ablaufzeiten kontrollierbar machen,
- Erfolg, Ablehnung, Abbruch und technische Fehler simulieren können.

---

# Beispieladapter

```text
PasswordCredentialCreationPort
        │
        └── Argon2idCredentialCreationAdapter
```

```text
PasswordCredentialVerificationPort
        │
        └── Argon2idCredentialVerificationAdapter
```

```text
AuthenticationRequestPort
        │
        ├── ProfilePasswordAuthenticationAdapter
        ├── LocalBiometricAuthenticationAdapter
        └── OperatingSystemAuthenticationAdapter
```

Diese Beispiele sind nicht Bestandteil der Domäne und können ausgetauscht werden.

---

# Traceability

## Requirements

- PRO-FR-017
- PRO-FR-018
- PRO-FR-019
- PRO-FR-020
- PRO-FR-021

## Use Cases

- PRO-UC-017
- PRO-UC-018
- PRO-UC-019
- PRO-UC-020
- PRO-UC-021

## Business Rules

- PRO-BR-018
- PRO-BR-019
- PRO-BR-020

## Validation Rules

- PRO-VR-006
- PRO-VR-007
- PRO-VR-008

## Domain Model

- AG-INV-004
- AG-INV-009
- AG-INV-011
- PRO-EINV-003
- PRO-EINV-004
- PRO-EINV-005

---

# Status dieses Abschnitts

Mit Teil **5C-1** sind definiert:

- allgemeine Regeln für Domain Ports,
- fachliche Port-Schnittstellen statt technischer APIs,
- `PlainPassword`,
- `PasswordCredentialCreationPort`,
- `PasswordCredentialVerificationPort`,
- `PasswordPolicyEvaluationPort`,
- `AuthenticationRequestPort`,
- `AuthenticationProofValidationPort`,
- `AuthenticationProofConsumptionPort`,
- sicherheitsbezogene Ergebnisobjekte,
- Sicherheitsabläufe,
- `DomainResult<T>`-Regeln,
- Testbarkeit,
- Adapterbeispiele,
- Traceability.

Security- und Authentication-Ports sind damit klar voneinander getrennt und vollständig von Profilfachlichkeit, Persistenz und UI entkoppelt.

---

# Teil 5C-2

Der nächste Abschnitt enthält:

- `ProfileImageValidationPort`,
- `ProfileImageTransformationPort`,
- `ProfileImageStoragePort`,
- `ProfileDataDeletionPort`,
- `ProfileDataQueryPort`,
- `Clock`,
- `DomainEventPublisher`,
- After-Commit-Regeln,
- Adapterprinzip,
- Infrastrukturgrenzen,
- Testbarkeit,
- Abschluss von Teil 5C.

# Teil 5C-2 – Infrastruktur- und Integrations-Ports

# Port: ProfileImageValidationPort

## Zweck

`ProfileImageValidationPort` prüft, ob bereitgestellte Bilddaten technisch und fachlich als Profilbild verwendet werden dürfen.

Der Port führt ausschließlich Prüfungen durch.

Er

- verändert keine Bilddaten,
- speichert keine Bilddaten,
- erzeugt keine `ImageReference`,
- verändert kein `Profile`-Aggregate.

---

## Eingabemodell

```text
ProfileImageValidationInput
```

Das Eingabemodell enthält mindestens:

| Feld | Typ |
|---|---|
| source | ImageSourceReference |
| declaredMediaType | MediaType? |
| fileSizeBytes | NonNegativeInteger? |

`ImageSourceReference` ist eine kurzlebige technische Eingabereferenz und nicht mit der dauerhaften `ImageReference` des Domänenmodells identisch.

---

## Operation

```text
DomainResult<ProfileImageValidationResult> validate(
  ProfileImageValidationInput input
)
```

---

## ProfileImageValidationResult

| Feld | Typ | Bedeutung |
|---|---|---|
| accepted | Boolean | Bild kann weiterverarbeitet werden |
| detectedMediaType | MediaType? | Tatsächlich erkannter Medientyp |
| originalDimensions | ImageDimensions? | Erkannte Ausgangsdimensionen |
| fileSizeBytes | NonNegativeInteger? | Erkannte Dateigröße |
| requiresTransformation | Boolean | Technische Aufbereitung erforderlich |
| violations | List<ImageValidationViolation> | Festgestellte Verstöße |

---

## Prüfungen

Der Port prüft mindestens:

- tatsächlichen Medientyp,
- Lesbarkeit der Bilddaten,
- Vorhandensein gültiger Bilddaten,
- maximale Dateigröße,
- maximale Bilddimensionen,
- Übereinstimmung zwischen deklariertem und erkanntem Medientyp,
- Unterstützung des erkannten Formats.

Optional können geprüft werden:

- ungewöhnliche oder beschädigte Metadaten,
- animierte Bildinhalte,
- mehrseitige Bildformate,
- Sicherheitsrisiken in Bildcontainern.

---

## Preconditions

- Die Eingabereferenz ist zugreifbar.
- Es liegen Bilddaten vor.
- Die Eingabe überschreitet keine technisch nicht verarbeitbare absolute Obergrenze.

---

## Postconditions bei Erfolg

- `accepted` ist `true`.
- Der erkannte Medientyp ist vorhanden.
- Die erkannten Dimensionen sind vorhanden.
- Die Bilddaten wurden nicht verändert.
- Es wurden keine Daten gespeichert.

---

## Postconditions bei Ablehnung

- `accepted` ist `false`.
- Mindestens eine strukturierte Verletzung ist enthalten.
- Es wurde kein `ProfileImage` erzeugt.
- Es wurden keine Bilddaten dauerhaft gespeichert.

---

## Mögliche Fehlercodes

```text
image.validation.unreadable
image.validation.unsupportedFormat
image.validation.mediaTypeMismatch
image.validation.fileTooLarge
image.validation.dimensionsTooLarge
image.validation.noImageData
image.validation.failed
```

---

## Nicht verantwortlich

Der Port ist nicht verantwortlich für:

- Skalierung,
- Komprimierung,
- Zuschneiden,
- Rotation,
- Entfernung von Metadaten,
- Speicherung,
- Löschung,
- Änderung eines Profils.

---

# Port: ProfileImageTransformationPort

## Zweck

`ProfileImageTransformationPort` bereitet bereits validierte Bilddaten technisch für die Verwendung als Profilbild auf.

Die Transformation erfolgt vor der dauerhaften Speicherung.

---

## Operation

```text
DomainResult<ProfileImageTransformationResult> transform(
  ProfileImageTransformationRequest request
)
```

---

## ProfileImageTransformationRequest

| Feld | Typ |
|---|---|
| source | ImageSourceReference |
| detectedMediaType | MediaType |
| targetPolicy | ProfileImageTransformationPolicy |

---

## ProfileImageTransformationPolicy

Die Richtlinie beschreibt mindestens:

| Feld | Typ |
|---|---|
| maximumWidth | PositiveInteger |
| maximumHeight | PositiveInteger |
| maximumFileSizeBytes | PositiveInteger |
| removeMetadata | Boolean |
| preserveAspectRatio | Boolean |
| targetMediaType | MediaType? |

Die Richtlinie wird außerhalb des Ports konfiguriert und als fachlich freigegebener Wert übergeben.

---

## Mögliche Transformationen

- Skalierung,
- Komprimierung,
- Formatkonvertierung,
- Drehung anhand sicher erkannter Orientierung,
- Entfernung von EXIF- und Standortmetadaten,
- Erhaltung des Seitenverhältnisses,
- Erzeugung einer standardisierten Bildrepräsentation.

---

## ProfileImageTransformationResult

| Feld | Typ |
|---|---|
| transformedImage | TransformedImagePayload |
| mediaType | MediaType |
| dimensions | ImageDimensions |
| fileSizeBytes | NonNegativeInteger |
| checksum | ImageChecksum |
| metadataRemoved | Boolean |

`TransformedImagePayload` ist ein kurzlebiges technisches Transferobjekt.

Es gehört nicht zum dauerhaften Domänenmodell.

---

## Preconditions

- Die Eingabe wurde erfolgreich validiert.
- Der Medientyp wird unterstützt.
- Die Transformationsrichtlinie ist gültig.
- Die Quelldaten sind verfügbar.

---

## Postconditions bei Erfolg

- Die Bilddaten entsprechen der Transformationsrichtlinie.
- Unzulässige Metadaten wurden entfernt.
- Dimensionen und Dateigröße liegen innerhalb der Grenzwerte.
- Eine Checksum wurde erzeugt.
- Es erfolgte noch keine dauerhafte Speicherung.

---

## Fehlerfälle

```text
image.transformation.failed
image.transformation.unsupportedConversion
image.transformation.outputTooLarge
image.transformation.metadataRemovalFailed
image.transformation.invalidResult
```

---

## Nicht verantwortlich

Der Port:

- speichert keine Bilddaten dauerhaft,
- erzeugt keine dauerhafte Bildreferenz,
- verändert kein `Profile`-Aggregate,
- löscht kein bisheriges Profilbild.

---

# Port: ProfileImageStoragePort

## Zweck

`ProfileImageStoragePort` speichert, liest und löscht technisch aufbereitete Profilbilddaten.

Die Domäne arbeitet nach der Speicherung ausschließlich mit einer undurchsichtigen `ImageReference`.

---

## Operationen

```text
DomainResult<ImageReference> store(
  TransformedImagePayload image,
  ImageStorageMetadata metadata
)
```

```text
DomainResult<ProfileImageBinaryResult> load(
  ImageReference reference
)
```

```text
DomainResult<Boolean> exists(
  ImageReference reference
)
```

```text
DomainResult<void> delete(
  ImageReference reference
)
```

---

## ImageStorageMetadata

| Feld | Typ |
|---|---|
| mediaType | MediaType |
| dimensions | ImageDimensions |
| checksum | ImageChecksum |
| profileId | ProfileId |

---

## Speicherregeln

- Eine erfolgreiche Speicherung erzeugt eine neue `ImageReference`.
- Die Referenz enthält keine Zugangsdaten.
- Die Referenz setzt keinen bestimmten Dateipfad voraus.
- Bilddaten eines Profils müssen anhand der `ProfileId` eindeutig zuordenbar sein.
- Fremde Profilbilder dürfen nicht überschrieben werden.
- Speichervorgänge müssen wiederholbar oder eindeutig konfliktbehandelt sein.

---

## Löschregeln

- Die Löschung erfolgt nur für die übergebene `ImageReference`.
- Das Löschen eines nicht vorhandenen Bildes darf als idempotenter Erfolg behandelt werden.
- Fremde Bilddaten dürfen nicht gelöscht werden.
- Eine Löschung darf nicht erfolgen, bevor das neue Profilbild erfolgreich gespeichert und der Profilwechsel atomar koordiniert wurde.

---

## Sichere Ersetzungsreihenfolge

Beim Ersetzen eines Profilbilds gilt:

```text
neues Bild validieren
        │
        ▼
neues Bild transformieren
        │
        ▼
neues Bild speichern
        │
        ▼
Profile.replaceProfileImage()
        │
        ▼
Aggregate speichern
        │
        ▼
Commit
        │
        ▼
altes Bild löschen
```

Schlägt der Commit fehl, muss das neu gespeicherte, aber nicht referenzierte Bild bereinigt werden.

Die technische Kompensationsstrategie wird im Application- und Infrastructure-Layer festgelegt.

---

## Fehlerfälle

```text
image.storage.storeFailed
image.storage.loadFailed
image.storage.deleteFailed
image.storage.referenceInvalid
image.storage.notFound
image.storage.integrityMismatch
```

---

# Port: ProfileDataDeletionPort

## Zweck

`ProfileDataDeletionPort` koordiniert die vollständige Löschung aller Daten, die außerhalb des `Profile`-Aggregats einer `ProfileId` zugeordnet sind.

Der Port dient insbesondere der endgültigen Profillöschung.

---

## Operationen

```text
DomainResult<ProfileDataDeletionPreview> previewDeletion(
  ProfileId profileId
)
```

```text
DomainResult<ProfileDataDeletionResult> deleteAllForProfile(
  ProfileId profileId
)
```

---

## ProfileDataDeletionPreview

Das Vorschauergebnis enthält mindestens:

| Feld | Typ |
|---|---|
| profileId | ProfileId |
| affectedDataAreas | List<ProfileDataArea> |
| estimatedRecordCount | NonNegativeInteger? |
| imageReferences | List<ImageReference> |
| deletionPossible | Boolean |
| blockers | List<ProfileDeletionBlocker> |

---

## ProfileDataArea

Beispielwerte:

```text
measurements
nutrition
medications
devices
dashboard
analysis
recommendations
cachedData
profileImages
```

---

## ProfileDataDeletionResult

| Feld | Typ |
|---|---|
| profileId | ProfileId |
| deletedDataAreas | List<ProfileDataArea> |
| deletedRecordCount | NonNegativeInteger? |
| deletedImageReferences | List<ImageReference> |
| completed | Boolean |

---

## Preconditions

- Die `ProfileId` ist gültig.
- Die fachliche Löschfreigabe liegt vor.
- Alle betroffenen Datenbereiche können ermittelt werden.
- Es bestehen keine ungelösten Löschblocker.

---

## Postconditions bei Erfolg

- Alle der ProfileId eindeutig zugeordneten Daten wurden gelöscht.
- Keine Daten anderer Profile wurden verändert.
- Das Ergebnis dokumentiert die fachlich betroffenen Bereiche.
- Es verbleiben keine ungültigen Profilreferenzen.

---

## Atomaritätsregel

Die vollständige Löschung muss atomar oder über eine fachlich gleichwertige, zuverlässig kompensierbare Strategie erfolgen.

Es gilt:

```text
alle profilbezogenen Daten gelöscht
```

oder:

```text
ursprünglicher Zustand vollständig erhalten
```

Ein teilweise gelöschter Datenbestand ist unzulässig.

---

## Fehlerfälle

```text
profileData.deletion.blocked
profileData.deletion.incomplete
profileData.deletion.failed
profileData.deletion.foreignDataDetected
profileData.deletion.dependenciesUnavailable
```

---

## Sicherheits- und Datenschutzregeln

- Gelöschte Daten dürfen nicht versehentlich in Caches verbleiben.
- Temporäre Dateien müssen berücksichtigt werden.
- Suchindizes und abgeleitete Daten müssen bereinigt werden.
- Backups und Aufbewahrungsfristen werden im Backup- und Datenschutzkonzept geregelt.
- Löschprotokolle dürfen keine vollständigen Gesundheitsdaten enthalten.

---

# Port: ProfileDataQueryPort

## Zweck

`ProfileDataQueryPort` liefert profilbezogene Daten anderer Module für fachlich erlaubte Lesevorgänge.

Typische Verwendungen:

- Export,
- Löschvorschau,
- Migration,
- Wiederherstellungsprüfung.

---

## Operationen

```text
DomainResult<ProfileDataCollection> collectForExport(
  ProfileId profileId,
  ProfileExportSectionSelection sections
)
```

```text
DomainResult<ProfileDependentDataSummary> summarizeDependencies(
  ProfileId profileId
)
```

---

## ProfileDataCollection

Das Ergebnis enthält ausschließlich fachlich freigegebene Exportmodelle.

Es enthält keine:

- Datenbankzeilen,
- ORM-Objekte,
- internen technischen DTOs,
- Daten anderer Profile,
- Sicherheits-Credentials.

---

## ProfileDependentDataSummary

| Feld | Typ |
|---|---|
| profileId | ProfileId |
| dataAreas | List<ProfileDataAreaSummary> |
| hasDependentData | Boolean |

---

## Regeln

- Der Port ist ausschließlich lesend.
- Es werden keine Aggregate verändert.
- Daten werden ausschließlich anhand der `ProfileId` ermittelt.
- Fremde Profildaten sind ausgeschlossen.
- Der angeforderte Umfang muss ausdrücklich angegeben werden.
- Nicht angeforderte Datenbereiche werden nicht geladen.

---

## Fehlerfälle

```text
profileData.query.failed
profileData.query.profileNotFound
profileData.query.sectionUnsupported
profileData.query.foreignDataDetected
```

---

# Port: Clock

## Zweck

`Clock` stellt alle zeitabhängigen Informationen für Domäne und Application Layer deterministisch bereit.

Direkte Zugriffe auf die Systemzeit sind außerhalb konkreter Clock-Adapter unzulässig.

---

## Operationen

```text
Timestamp now()
```

```text
DateValue currentDate()
```

```text
CalendarYear currentYear()
```

---

## Regeln

- `now()` liefert einen UTC-Zeitpunkt.
- `currentDate()` berücksichtigt eine ausdrücklich definierte fachliche Zeitzone.
- `currentYear()` wird aus derselben fachlichen Zeitbasis abgeleitet.
- Tests können eine feste oder steuerbare Clock verwenden.
- Zeitwerte innerhalb eines Use Cases sollen aus derselben Clock-Abfrage beziehungsweise demselben Referenzzeitpunkt abgeleitet werden.

---

## Abgrenzung

`Clock` liefert Zeitwerte.

Sie:

- startet keine Timer,
- plant keine Aufgaben,
- speichert keine Zeitstempel,
- verändert keine Aggregate.

---

## Beispieladapter

```text
Clock
  ├── SystemClock
  ├── FixedClock
  └── AdjustableTestClock
```

---

# Port: DomainEventPublisher

## Zweck

`DomainEventPublisher` veröffentlicht Domain Events nach erfolgreichem Abschluss einer fachlichen Transaktion.

Das Aggregate sammelt Events lediglich intern.

Es veröffentlicht sie nicht selbst.

---

## Operationen

```text
DomainResult<void> publishAfterCommit(
  DomainEvent event
)
```

```text
DomainResult<void> publishAllAfterCommit(
  List<DomainEvent> events
)
```

---

## Verbindliche Reihenfolge

```text
Aggregate-Operation erfolgreich
        │
        ▼
Aggregate im Repository speichern
        │
        ▼
UnitOfWork.commit()
        │
        ▼
DomainEventPublisher.publishAllAfterCommit()
        │
        ▼
Event Handler
```

Events dürfen niemals vor einem erfolgreichen Commit veröffentlicht werden.

---

## Preconditions

- Die fachliche Operation war erfolgreich.
- Der Commit wurde erfolgreich abgeschlossen.
- Die Events sind vollständig und unveränderlich.
- Die Event-Reihenfolge ist bestimmt.

---

## Postconditions

- Jedes übergebene Event wurde zur Veröffentlichung angenommen.
- Die Reihenfolge innerhalb eines Aggregats bleibt erhalten.
- Ein Event wird nicht wissentlich mehrfach fachlich verarbeitet.
- Veröffentlichungsfehler werden strukturiert gemeldet.

---

## Fehler nach erfolgreichem Commit

Schlägt die unmittelbare Veröffentlichung nach dem Commit fehl, darf der fachlich bereits gespeicherte Zustand nicht zurückgerollt werden, sofern der Commit abgeschlossen ist.

Stattdessen muss eine zuverlässige Nachlieferungsstrategie verwendet werden.

Empfohlen:

```text
Transactional Outbox
```

Ablauf:

```text
Aggregate speichern
        │
        ├── Domain Event in Outbox speichern
        │
        ▼
gemeinsamer Commit
        │
        ▼
Outbox Dispatcher
        │
        ▼
Event veröffentlichen
```

---

## Idempotenz

Event Handler müssen soweit fachlich möglich idempotent sein.

Domain Events benötigen mindestens:

- eindeutige EventId,
- AggregateId,
- AggregateVersion,
- EventType,
- OccurredAt.

Die vollständige Eventstruktur wird in Teil 6 definiert.

---

## Sicherheitsregeln

Events dürfen nicht enthalten:

- Klartextpasswörter,
- Passwort-Hashes,
- Credentials,
- AuthenticationProofs,
- Bildbinärdaten,
- unnötige Gesundheitsdaten,
- kryptographische Schlüssel.

---

## Fehlerfälle

```text
event.publish.failed
event.publish.invalidEvent
event.publish.orderViolation
event.publish.duplicateDetected
event.publish.outboxUnavailable
```

---

# Infrastrukturgrenzen

Die Domäne kennt keine konkreten:

- Datenbanken,
- Dateisysteme,
- Cloudspeicher,
- Bildbibliotheken,
- Event Broker,
- Message Queues,
- Betriebssystem-APIs,
- HTTP-Clients,
- Plattformdienste.

Diese Kenntnisse befinden sich ausschließlich in Adaptern.

---

# Adapterprinzip

```text
Domain / Application Layer
        │
        ▼
Port Interface
        │
        ▼
Infrastructure Adapter
        │
        ▼
Konkrete Technologie
```

Beispiele:

```text
ProfileImageValidationPort
        │
        └── ImageLibraryValidationAdapter
```

```text
ProfileImageStoragePort
        │
        ├── LocalFileImageStorageAdapter
        └── EncryptedMediaStorageAdapter
```

```text
ProfileDataDeletionPort
        │
        └── MultiModuleProfileDeletionAdapter
```

```text
DomainEventPublisher
        │
        ├── InProcessEventPublisher
        └── OutboxEventPublisher
```

---

# Austauschbarkeit

Jeder Adapter muss austauschbar sein, ohne:

- Aggregate zu verändern,
- Value Objects zu verändern,
- Business Rules anzupassen,
- Domain Services umzuschreiben.

Technologiespezifische Details dürfen nicht durch die Port-Grenze nach innen gelangen.

---

# Fehlerübersetzung an Port-Grenzen

Adapter können technische Fehler erhalten, beispielsweise:

- Dateisystemfehler,
- Datenbankfehler,
- Bibliotheksfehler,
- Netzwerkfehler,
- Speicherfehler.

Diese werden an der Port-Grenze in sichere, strukturierte Ergebnisnachrichten übersetzt.

Beispiel:

```text
FileSystemException
        │
        ▼
image.storage.storeFailed
```

Interne technische Details dürfen nur in geschützten technischen Logs erscheinen.

Sie dürfen nicht ungefiltert an UI oder Domain weitergegeben werden.

---

# DomainResult-Regeln

Alle Port-Operationen verwenden:

```text
DomainResult<T>
```

## Erfolgsfall

```text
DomainResult<T>
├── value
├── warnings optional
├── information optional
└── errors leer
```

## Erwartbarer Fehlerfall

```text
DomainResult<T>
├── kein Erfolgswert
├── errors vorhanden
└── keine sensiblen Parameter
```

## Teilresultate

Port-Operationen dürfen keine unklaren Teilresultate als Erfolg zurückgeben.

Ein fachlich unvollständiges Ergebnis ist ein Fehler.

---

# Seiteneffekte

Ports mit Schreiboperationen müssen ihre Seiteneffekte ausdrücklich dokumentieren.

| Port | Lesen | Schreiben | Löschen |
|---|---:|---:|---:|
| ProfileImageValidationPort | Ja | Nein | Nein |
| ProfileImageTransformationPort | Ja | Temporäres Ergebnis | Nein |
| ProfileImageStoragePort | Ja | Ja | Ja |
| ProfileDataDeletionPort | Ja | Nein | Ja |
| ProfileDataQueryPort | Ja | Nein | Nein |
| Clock | Ja | Nein | Nein |
| DomainEventPublisher | Nein | Ja | Nein |

---

# Testbarkeit

Alle Ports werden in Unit- und Application-Tests durch Test Doubles ersetzt.

Beispiele:

```text
FakeProfileImageValidationPort
FakeProfileImageTransformationPort
InMemoryProfileImageStoragePort
FakeProfileDataDeletionPort
FakeProfileDataQueryPort
FixedClock
FakeDomainEventPublisher
```

---

## Erforderliche Testszenarien

### Bildvalidierung

- unterstütztes Bild,
- falscher Medientyp,
- beschädigte Daten,
- zu große Datei,
- zu große Dimensionen.

### Bildtransformation

- erfolgreiche Skalierung,
- Entfernung von Metadaten,
- Transformationsfehler,
- Ergebnis weiterhin zu groß.

### Bildspeicherung

- Speicherung erfolgreich,
- Laden erfolgreich,
- Löschen idempotent,
- Integritätsfehler,
- Bereinigung nach fehlgeschlagenem Commit.

### Datenlöschung

- vollständige Löschung,
- keine abhängigen Daten,
- Löschblocker,
- Fehler in einem Datenbereich,
- Schutz fremder Profildaten,
- Übergang in den Initialzustand.

### Clock

- fester Zeitpunkt,
- Jahreswechsel,
- UTC-Verhalten,
- fachliche Zeitzone.

### Event-Publishing

- Veröffentlichung nach Commit,
- keine Veröffentlichung vor Commit,
- Outbox-Nachlieferung,
- Reihenfolge,
- Idempotenz,
- Veröffentlichungsfehler.

---

# Traceability

## Requirements

- PRO-FR-015
- PRO-FR-024
- PRO-FR-025
- PRO-FR-026
- PRO-FR-027

## Use Cases

- PRO-UC-015
- PRO-UC-024
- PRO-UC-025
- PRO-UC-026
- PRO-UC-027

## Business Rules

- PRO-BR-017
- PRO-BR-021
- PRO-BR-022
- PRO-BR-023
- PRO-BR-026

## Validation Rules

- PRO-VR-010
- PRO-VR-014
- PRO-VR-015
- PRO-VR-016

## Domain Model

- PRO-DM-002
- PRO-DM-004
- PRO-DM-008
- AG-INV-005
- AG-INV-008
- AG-INV-012
- AG-INV-013
- AG-INV-015
- PRO-CINV-005
- PRO-CINV-006

---

# Status dieses Abschnitts

Mit Teil **5C-2** sind definiert:

- `ProfileImageValidationPort`,
- `ProfileImageTransformationPort`,
- `ProfileImageStoragePort`,
- sichere Ersetzungs- und Kompensationsabläufe für Profilbilder,
- `ProfileDataDeletionPort`,
- Löschvorschau und vollständige profilbezogene Datenlöschung,
- `ProfileDataQueryPort`,
- `Clock`,
- `DomainEventPublisher`,
- verbindliche After-Commit-Regeln,
- Outbox-Empfehlung,
- Adapterprinzip,
- Infrastrukturgrenzen,
- strukturierte Fehlerübersetzung,
- Seiteneffekte,
- Testbarkeit,
- Traceability.

Zusammen mit **Teil 5C-1** ist Teil 5C vollständig beschrieben.

---

# Teil 5D

Der nächste Abschnitt enthält:

- Specification Pattern,
- kombinierbare Specifications,
- `ProfileCanBeActivated`,
- `ProfileCanBeArchived`,
- `ProfileCanBeDeleted`,
- `ProfileCanBeDefault`,
- Domain Policies,
- `PRO-CINV-001` bis `PRO-CINV-006`,
- Abgrenzung zwischen Domain Service und Application Service,
- Abschluss von Teil 5.

# Teil 5D-1 – Specifications

# Specification Pattern

## Zweck

Specifications kapseln fachliche Entscheidungsregeln, die

- mehrfach verwendet werden,
- unabhängig von einem konkreten Use Case gelten,
- keinen eigenen Zustand besitzen,
- keine Seiteneffekte verursachen.

Sie beantworten ausschließlich die Frage:

> Darf eine bestimmte fachliche Aktion durchgeführt werden?

Specifications verändern niemals den Zustand eines Aggregats.

---

# Allgemeine Regeln

## PRO-SP-001 – Reine Entscheidungslogik

Eine Specification enthält ausschließlich fachliche Entscheidungslogik.

Sie

- verändert keine Aggregate,
- speichert keine Daten,
- veröffentlicht keine Events,
- startet keine Transaktionen.

---

## PRO-SP-002 – Zustandslosigkeit

Specifications besitzen keinen dauerhaften Zustand.

Alle Entscheidungen basieren ausschließlich auf den übergebenen Parametern und gegebenenfalls auf Repository-Abfragen.

---

## PRO-SP-003 – Determinismus

Bei identischen Eingaben liefert eine Specification immer dasselbe Ergebnis.

Zeitabhängige Entscheidungen verwenden ausschließlich den `Clock`-Port.

---

## PRO-SP-004 – Wiederverwendbarkeit

Specifications dürfen von

- Aggregaten,
- Domain Services,
- Application Services,
- anderen Specifications

verwendet werden.

---

## PRO-SP-005 – Keine Infrastruktur

Specifications kennen ausschließlich

- Value Objects,
- Entities,
- Aggregate,
- Repository Interfaces,
- Domain Ports.

---

# Basisschnittstelle

```text
Specification<T>
```

## Operation

```text
DomainResult<SpecificationResult>

isSatisfiedBy(
    T candidate
)
```

---

# SpecificationResult

## Zweck

Beschreibt das Ergebnis einer fachlichen Entscheidung.

---

## Attribute

| Feld | Typ |
|------|-----|
| satisfied | Boolean |
| violations | List<DomainMessage> |
| warnings | List<DomainMessage> |

---

## Regeln

Ein erfolgreiches Ergebnis

```text
satisfied = true
```

kann dennoch Warnungen enthalten.

Ein negatives Ergebnis

```text
satisfied = false
```

enthält mindestens eine Verletzung.

---

# Composite Specifications

## Zweck

Mehrere Specifications können zu komplexeren Regeln kombiniert werden.

Dadurch entstehen wiederverwendbare Entscheidungsmodelle.

---

# AndSpecification

```text
A

UND

B
```

Ergebnis

```text
true

nur wenn

beide erfüllt sind.
```

---

# OrSpecification

```text
A

ODER

B
```

Ergebnis

```text
true

wenn

mindestens eine Specification erfüllt ist.
```

---

# NotSpecification

```text
NICHT A
```

Ergebnis

```text
true

wenn

A nicht erfüllt ist.
```

---

# Kombinationsregeln

Composite Specifications

- verändern keine Einzelergebnisse,
- sammeln sämtliche Verletzungen,
- bleiben deterministisch.

---

# ProfileCanBeActivated

## Zweck

Prüft,

ob ein Profil aktiviert werden darf.

---

## Verantwortlichkeiten

Prüft unter anderem

- Profil existiert
- nicht archiviert
- nicht gesperrt
- fachlich vollständig
- alle Aggregate-Invarianten erfüllt

---

## Operation

```text
DomainResult<SpecificationResult>

isSatisfiedBy(
    Profile profile
)
```

---

## Mögliche Verletzungen

```text
profile.archived

profile.locked

profile.invalidState
```

---

## Traceability

Requirements

- PRO-FR-007

Business Rules

- PRO-BR-010

Validation

- PRO-VR-012

---

# ProfileCanBeArchived

## Zweck

Prüft,

ob ein Profil archiviert werden darf.

---

## Verantwortlichkeiten

Prüft beispielsweise

- Profil existiert
- nicht bereits archiviert
- keine fachlichen Sperrgründe

---

## Ergebnis

```text
SpecificationResult
```

---

## Typische Verletzungen

```text
profile.alreadyArchived

profile.archiveForbidden
```

---

## Traceability

- PRO-FR-004
- PRO-BR-002

---

# ProfileCanBeDeleted

## Zweck

Prüft,

ob ein Profil endgültig gelöscht werden darf.

---

## Verantwortlichkeiten

Prüft

- Löschfreigabe
- Authentifizierung vorhanden
- abhängige Daten bestimmbar
- keine offenen Blocker

---

## Operation

```text
DomainResult<SpecificationResult>

isSatisfiedBy(
    ProfileDeletionCandidate candidate
)
```

---

## Typische Verletzungen

```text
authentication.required

dependentDataUnknown

deletionBlocked
```

---

## Hinweis

Die Specification

entscheidet

nicht

über

die technische Löschung.

---

## Traceability

- PRO-FR-006
- PRO-BR-003

---

# ProfileCanBeDefault

## Zweck

Prüft,

ob ein Profil als Standardprofil geeignet ist.

---

## Verantwortlichkeiten

Ein zulässiges Profil

- existiert
- ist nicht archiviert
- erfüllt die Aggregate-Invarianten

---

## Nicht Bestandteil

Nicht geprüft wird,

ob bereits ein anderes Standardprofil existiert.

Diese profilübergreifende Entscheidung trifft

```text
DefaultProfileCoordinator
```

---

## Verletzungen

```text
profile.archived

profile.invalid
```

---

## Traceability

- PRO-FR-009
- PRO-BR-012

---

# ProfileCanBeRestored

## Zweck

Prüft,

ob ein archiviertes Profil wiederhergestellt werden darf.

---

## Verantwortlichkeiten

Prüft

- Profil existiert
- Profil archiviert
- Wiederherstellung zulässig

---

## Ergebnis

```text
SpecificationResult
```

---

## Typische Verletzungen

```text
profile.notArchived

profile.restoreForbidden
```

---

## Traceability

- PRO-FR-005
- PRO-BR-008

---

# ProfileCanBeUnlocked

## Zweck

Prüft,

ob ein gesperrtes Profil fachlich entsperrt werden darf.

---

## Verantwortlichkeiten

Prüft

- Profil besitzt Passwortschutz
- gültiger AuthenticationProof vorhanden
- Proof nicht abgelaufen
- Zweck passt

---

## Verletzungen

```text
authentication.missing

authentication.expired

authentication.invalidPurpose
```

---

## Hinweis

Die eigentliche Passwortprüfung erfolgt

nicht

durch die Specification,

sondern über

```text
AuthenticationProofValidationPort
```

---

# Verwendung im Domain Model

```text
Application Service

↓

Domain Service

↓

Specification

↓

SpecificationResult

↓

fachliche Entscheidung
```

---

# Architekturregeln

Specifications

- besitzen keine Seiteneffekte,
- verändern keine Aggregate,
- erzeugen keine Aggregate,
- speichern keine Daten,
- veröffentlichen keine Domain Events,
- sind vollständig testbar,
- sind deterministisch.

---

# Testbarkeit

Jede Specification

kann

isoliert getestet werden.

Repositorys

werden

durch Test Doubles ersetzt.

Clock

durch

```text
FixedClock
```

---

# Traceability

## Requirements

- PRO-FR-004
- PRO-FR-005
- PRO-FR-006
- PRO-FR-007
- PRO-FR-009

---

## Business Rules

- PRO-BR-002
- PRO-BR-003
- PRO-BR-008
- PRO-BR-010
- PRO-BR-012

---

## Validation Rules

- PRO-VR-012
- PRO-VR-013

---

# Status dieses Abschnitts

Mit Teil **5D-1** sind vollständig definiert:

- Specification Pattern
- `Specification<T>`
- `SpecificationResult`
- Composite Specifications
- `AndSpecification`
- `OrSpecification`
- `NotSpecification`
- `ProfileCanBeActivated`
- `ProfileCanBeArchived`
- `ProfileCanBeDeleted`
- `ProfileCanBeDefault`
- `ProfileCanBeRestored`
- `ProfileCanBeUnlocked`
- Architekturregeln
- Testbarkeit
- Traceability

Specifications bilden damit die wiederverwendbare Entscheidungslogik der Domäne und trennen fachliche Prüfungen konsequent von Geschäftsprozessen und Zustandsänderungen.

---

# Teil 5D-2

Der nächste Abschnitt enthält:

- Domain Policies
- `PRO-CINV-001` bis `PRO-CINV-006`
- Aggregate-übergreifende Invarianten
- Abgrenzung zwischen Specification, Domain Service und Domain Policy
- Architekturprinzipien
- Abschluss des gesamten `05_DOMAIN_MODEL.md`

# Teil 5D-2 – Domain Policies, Aggregate-übergreifende Invarianten und Abschluss

# Domain Policies

## Zweck

Domain Policies kapseln fachliche Regeln, die

- variabel sein können,
- aus mehreren Specifications bestehen können,
- nicht einem einzelnen Aggregate zugeordnet sind,
- eine fachliche Entscheidung oder Strategie beschreiben.

Im Gegensatz zu einer Specification beantworten Policies nicht nur die Frage

> „Ist etwas erlaubt?"

sondern können zusätzlich festlegen,

- wie entschieden wird,
- welche Strategie gewählt wird,
- welche Priorität gilt.

Policies besitzen keinen dauerhaften Zustand.

---

# Allgemeine Regeln

## PRO-POL-001 – Keine Zustandsänderung

Domain Policies verändern niemals Aggregate.

Sie liefern ausschließlich fachliche Entscheidungen.

---

## PRO-POL-002 – Wiederverwendbarkeit

Policies dürfen verwendet werden von

- Application Services,
- Domain Services,
- anderen Policies.

Sie werden nicht direkt von UI-Komponenten verwendet.

---

## PRO-POL-003 – Kombination von Specifications

Policies dürfen beliebig viele Specifications kombinieren.

Beispiel

```text
ProfileCanBeActivated

AND

ProfileCanBeDefault

AND

ProfileCanBeUnlocked
```

---

## PRO-POL-004 – Keine Infrastruktur

Policies besitzen ausschließlich Abhängigkeiten zu

- Specifications,
- Repository Interfaces,
- Domain Ports,
- Value Objects.

---

# DefaultProfileSelectionPolicy

## Zweck

Legt fest,

welches Profil Standardprofil werden soll.

---

## Priorität

```text
Benutzerwahl

↓

bisheriges Standardprofil

↓

erstes geeignetes Profil

↓

kein Standardprofil
```

---

## Ergebnis

```text
DefaultProfileDecision
```

---

## Verantwortlichkeiten

Die Policy

entscheidet,

welches Profil geeignet ist.

Der

```text
DefaultProfileCoordinator
```

setzt die Entscheidung um.

---

# ActiveProfileSelectionPolicy

## Zweck

Bestimmt,

welches Profil beim Programmstart verwendet werden soll.

---

## Priorität

```text
LastUsedProfile

↓

DefaultProfile

↓

erstes verfügbares Profil

↓

kein Profil
```

---

## Ergebnis

```text
StartProfileDecision
```

---

# ProfileImportPolicy

## Zweck

Bestimmt,

wie Importkonflikte behandelt werden.

---

## Mögliche Strategien

```text
reject

generateNewId

replaceExisting
```

---

## Hinweis

Die Policy

entscheidet

nicht

über

das technische Einlesen.

---

# Aggregate-übergreifende Invarianten

## Zweck

Diese Regeln gelten

über sämtliche Profile hinweg.

Sie können

nicht

durch ein einzelnes Aggregate garantiert werden.

---

# PRO-CINV-001

## Höchstens ein Standardprofil

Es existiert

niemals

mehr als

ein

Standardprofil.

---

## Verantwortlich

```text
DefaultProfileCoordinator
```

---

# PRO-CINV-002

## Archivierte Profile

Archivierte Profile

dürfen

niemals

Standardprofil sein.

---

## Verantwortlich

```text
ProfileLifecycleService

DefaultProfileCoordinator
```

---

# PRO-CINV-003

## Höchstens ein aktives Profil

Zu jedem Zeitpunkt

ist

höchstens

ein

Profil aktiv.

---

## Verantwortlich

```text
ActiveProfileCoordinator
```

---

# PRO-CINV-004

## LastUsedProfile

LastUsedProfile

verweist

ausschließlich

auf

ein vorhandenes Profil.

---

## Verantwortlich

```text
ActiveProfileCoordinator
```

---

# PRO-CINV-005

## Initialzustand

Nach Löschung

des letzten Profils

existieren

keine

Profilreferenzen.

---

## Verantwortlich

```text
ProfileLifecycleService
```

---

# PRO-CINV-006

## Import

Ein Import

verändert

niemals

fremde Profile

ohne

ausdrückliche Konfliktstrategie.

---

## Verantwortlich

```text
ProfileImportDomainService
```

---

# Verantwortungsgrenzen

## Value Object

Verantwortlich für

```text
fachliche Werte
```

---

## Entity

Verantwortlich für

```text
lokale Geschäftslogik
```

---

## Aggregate

Verantwortlich für

```text
Konsistenzgrenze
```

---

## Specification

Verantwortlich für

```text
fachliche Entscheidung
```

---

## Domain Policy

Verantwortlich für

```text
fachliche Strategie
```

---

## Domain Service

Verantwortlich für

```text
profilübergreifende Geschäftslogik
```

---

## Factory

Verantwortlich für

```text
Aggregate erzeugen
```

---

## Repository

Verantwortlich für

```text
Persistenz
```

---

## Application Service

Verantwortlich für

```text
Use Case koordinieren
```

---

# Zusammenarbeit

```text
Application Service

↓

Domain Service

↓

Specification

↓

Policy

↓

Aggregate

↓

Repository

↓

UnitOfWork

↓

EventPublisher
```

---

# Architekturprinzipien

## Single Responsibility

Jede Komponente

besitzt

genau

eine

fachliche Verantwortung.

---

## Dependency Rule

```text
UI

↓

Application

↓

Domain

↓

Ports

↓

Infrastructure
```

---

## Aggregate First

Geschäftslogik

gehört

immer

zuerst

ins Aggregate.

Nur wenn dies fachlich nicht möglich ist,

werden Domain Services,

Policies

oder Specifications verwendet.

---

## Side Effect Free

Specifications

und

Policies

besitzen

keine

Seiteneffekte.

---

## Determinismus

Alle fachlichen Entscheidungen

sind

deterministisch.

---

## Testbarkeit

Alle Komponenten

können

isoliert getestet werden.

---

# Architekturübersicht

```text
Value Objects
        │
        ▼
Entities
        │
        ▼
Aggregate
        │
        ▼
Specifications
        │
        ▼
Policies
        │
        ▼
Domain Services
        │
        ▼
Repositories
        │
        ▼
Application Services
        │
        ▼
Infrastructure
```

---

# Vollständigkeit der Teile 1 bis 5D

Mit den Teilen 1 bis 5D sind bis zu diesem Stand beschrieben:

## Aggregate

- Profile

---

## Entities

- ProfileSettings
- ProfileSecurity

---

## Value Objects

- Identitäten
- Stammdaten
- Bilder
- Sicherheit
- Audit
- Einstellungen
- Zeit
- Versionierung

---

## Enumerationen

sämtliche fachlichen Enumerationen.

---

## Domain Services

- Profilverwaltung
- Aktivierung
- Standardprofil
- Lebenszyklus
- Import
- Export

---

## Factory

- ProfileFactory

---

## Repository Interfaces

- ProfileRepository
- ProfileContextRepository

---

## Domain Ports

- Security
- Authentication
- Bilder
- Daten
- Zeit
- Events

---

## Specifications

- Aktivierung
- Archivierung
- Löschung
- Standardprofil
- Wiederherstellung
- Entsperrung

---

## Policies

- Standardprofil
- Startprofil
- Import

---

## Aggregate-Invarianten

PRO-CINV-001

bis

PRO-CINV-006

---

# Qualitätsziele der Teile 1 bis 5D

Die bisher beschriebenen Teile des Domain Models erfüllen

- Domain-Driven Design
- Clean Architecture
- SOLID
- Dependency Rule
- vollständige Testbarkeit
- deterministische Geschäftslogik
- Infrastrukturunabhängigkeit
- klare Verantwortlichkeiten
- nachvollziehbare Traceability

---

# Traceability

## Requirements

Alle Requirements

PRO-FR-001

bis

PRO-FR-027

werden

durch das Domain Model

abgedeckt.

---

## Business Rules

Alle Business Rules

PRO-BR

werden

durch

Aggregate,

Services,

Specifications

oder Policies

realisiert.

---

## Validation Rules

Alle Validation Rules

PRO-VR

werden

durch

Value Objects,

Factories,

Specifications

oder Domain Services

umgesetzt.

---

# Abschluss

Mit Teil **5D-2** ist der fachliche Kern des Domain Models abgeschlossen.

Die nachfolgenden Teile **5E-1** und **5E-2** ergänzen die
projekteinheitliche Ereignisarchitektur (Domain Events) und schließen das
Dokument vollständig ab.

Das Domain Model definiert:

- die fachliche Struktur des Profilmoduls,
- sämtliche Aggregate, Entities und Value Objects,
- Domain Services,
- Factory,
- Repository Interfaces,
- Domain Ports,
- Specifications,
- Domain Policies,
- Aggregate-übergreifende Invarianten,
- Architekturprinzipien,
- Verantwortungsgrenzen,
- Traceability.

Es bildet die verbindliche Grundlage für die Implementierung des Profilmoduls sowie für alle nachfolgenden Architektur- und Implementierungsdokumente.

# Teil 5E-1 – Domain Events

# Domain Events

## Zweck

Domain Events beschreiben fachlich bedeutsame Ereignisse, die innerhalb der Domäne bereits erfolgreich eingetreten sind.

Ein Domain Event beschreibt ausschließlich etwas, das **geschehen ist**.

Es beschreibt niemals:

- einen Befehl,
- eine Benutzeraktion,
- eine Absicht,
- einen zukünftigen Zustand.

Beispiele:

```text
ProfileCreated
ProfileArchived
ProfileDeleted
ProfileActivated
PasswordProtectionEnabled
ProfileImageReplaced
```

---

# Allgemeine Regeln

## PRO-DE-001 – Vergangenheitsform

Ein Domain Event wird immer in der Vergangenheitsform benannt.

Zulässig:

```text
ProfileCreated
ProfileDeleted
ProfilePasswordChanged
```

Nicht zulässig:

```text
CreateProfile
DeleteProfile
ChangePassword
```

---

## PRO-DE-002 – Fachliche Bedeutung

Ein Event beschreibt ausschließlich ein fachlich relevantes Ereignis.

Technische Ereignisse gehören nicht zur Domäne.

Nicht zulässig:

```text
DatabaseSaved
JsonExportFinished
FileWritten
ImageUploaded
```

---

## PRO-DE-003 – Unveränderlichkeit

Domain Events sind vollständig unveränderlich.

Nach ihrer Erzeugung dürfen keine Attribute geändert werden.

---

## PRO-DE-004 – Vergangene Tatsache

Ein Event stellt immer eine bereits eingetretene Tatsache dar.

Ein Event darf niemals bedeuten:

- "wird ausgeführt",
- "soll ausgeführt werden",
- "könnte ausgeführt werden".

---

## PRO-DE-005 – Keine Geschäftslogik

Ein Event enthält keinerlei Entscheidungslogik.

Es beschreibt ausschließlich den eingetretenen Sachverhalt.

---

## PRO-DE-006 – Keine technischen Daten

Domain Events enthalten keine:

- Datenbank-IDs,
- ORM-Objekte,
- UI-Zustände,
- Flutter-Typen,
- Dateipfade,
- HTTP-Informationen.

---

# Basisklasse

## DomainEvent

### Zweck

`DomainEvent` ist die gemeinsame Basisklasse aller fachlichen Ereignisse.

---

## Attribute

| Attribut | Typ |
|-----------|-----|
| eventId | DomainEventId |
| eventType | EventType |
| category | EventCategory |
| aggregateId | AggregateId |
| aggregateVersion | AggregateVersion |
| occurredAt | Timestamp |
| metadata | EventMetadata |

---

## Regeln

Alle Attribute sind Pflichtattribute.

Die Basisklasse besitzt keinerlei Änderungsoperationen.

---

# DomainEventId

## Zweck

Eindeutige Identität eines Domain Events.

---

## Typ

```text
UUID
```

---

## Factory

```text
DomainResult<DomainEventId>

generate()

fromString(value)
```

---

## Regeln

- eindeutig
- unveränderlich
- weltweit eindeutig
- niemals wiederverwendbar

---

# EventType

## Zweck

Beschreibt den fachlichen Ereignistyp.

---

## Beispiele

```text
ProfileCreated

ProfileDeleted

ProfileArchived

ProfileActivated

ProfilePasswordChanged

ProfileImageReplaced
```

---

## Regeln

Der Typ

- ist stabil,
- wird versioniert,
- enthält keine Lokalisierung.

---

# EventCategory

## Zweck

Ordnet Events fachlichen Kategorien zu.

---

## Beispielwerte

```text
ProfileLifecycle

ProfileSecurity

ProfileImage

ProfileSettings

Import

Export
```

---

## Nutzen

Erleichtert

- Routing,
- Filterung,
- Monitoring,
- Dokumentation.

---

# AggregateId

## Zweck

Referenz auf das Aggregate,

welches das Event erzeugt hat.

---

## Regeln

Die ID

identifiziert genau

ein

Aggregate.

---

# AggregateVersion

## Zweck

Beschreibt,

bei welcher Aggregate-Version

das Event entstanden ist.

---

## Regeln

Die Version

muss

genau

der Version

des erfolgreich geänderten Aggregates entsprechen.

---

# OccurredAt

## Zweck

Zeitpunkt,

an dem das Ereignis fachlich eingetreten ist.

---

## Typ

```text
Timestamp
```

---

## Regeln

Der Zeitpunkt

stammt

ausschließlich

aus

```text
Clock
```

---

# EventMetadata

## Zweck

Zusätzliche Informationen,

die

nicht

zum eigentlichen Fachinhalt gehören.

---

## Attribute

| Attribut | Typ |
|-----------|-----|
| correlationId | CorrelationId? |
| causationId | CausationId? |
| producer | EventProducer |
| schemaVersion | EventSchemaVersion |

---

## Regeln

Metadata

darf

niemals

fachliche Informationen ersetzen.

---

# CorrelationId

## Zweck

Verknüpft mehrere Events,

die

zum selben Use Case gehören.

---

## Beispiel

```text
Profil löschen

↓

ProfileArchived

↓

MeasurementsDeleted

↓

MedicationDeleted

↓

ProfileDeleted
```

Alle Events

teilen dieselbe

CorrelationId.

---

# CausationId

## Zweck

Beschreibt,

welches Event

ein weiteres Event ausgelöst hat.

---

## Beispiel

```text
ProfileDeleted

↓

HealthDataDeleted

↓

DashboardReset
```

---

# EventProducer

## Zweck

Kennzeichnet,

welche fachliche Komponente

das Event erzeugt hat.

---

## Beispiele

```text
Profile Aggregate

ProfileLifecycleService
```

---

## Regeln

Der Producer

ist

fachlich,

nicht technisch.

---

# EventSchemaVersion

## Zweck

Versioniert

die Struktur

des Events.

---

## Regeln

Neue Versionen

dürfen

ältere Eventdaten

nicht

ungültig machen.

---

# DomainEventCollection

## Zweck

Ein Aggregate sammelt erzeugte Events,

bis sie veröffentlicht werden.

---

## Attribute

```text
List<DomainEvent>
```

---

## Operationen

```text
add()

all()

clear()

count()
```

---

## Regeln

Events

werden

in Erzeugungsreihenfolge gespeichert.

---

# Erzeugung von Events

Ein Domain Event entsteht grundsätzlich durch eine erfolgreiche
Aggregate-Operation.

Ausnahme:

`ProfileDeleted` wird nach erfolgreicher vollständiger Löschung durch den
zuständigen Application Service als fachliches Abschlussereignis erzeugt.

Diese Ausnahme ist im Abschnitt `requestDeletion()` verbindlich definiert.

---

## Beispiel

```text
Profile.activate()

↓

ProfileActivated
```

---

Nicht zulässig

```text
Repository

↓

Event
```

---

# Event-Lebenszyklus

```text
Aggregate

↓

Event erzeugen

↓

EventCollection

↓

Repository.save()

↓

Commit

↓

Publisher

↓

Handler
```

---

# Reihenfolge

Events

werden

genau

in

der Reihenfolge

veröffentlicht,

in der sie erzeugt wurden.

---

# Idempotenz

Ein Event

besitzt

eine eindeutige

```text
DomainEventId
```

Dadurch

kann

Mehrfachverarbeitung

erkannt werden.

---

# Versionierung

Alle Events

besitzen

eine

SchemaVersion.

Änderungen

dürfen

vorhandene gespeicherte Events

nicht

ungültig machen.

---

# Beispiele

## ProfileCreated

```text
eventType

ProfileCreated
```

---

## ProfileActivated

```text
eventType

ProfileActivated
```

---

## ProfilePasswordChanged

```text
eventType

ProfilePasswordChanged
```

---

## ProfileDeleted

```text
eventType

ProfileDeleted
```

---

# Nicht zulässige Inhalte

Ein Domain Event

darf niemals enthalten

- Passwort
- PasswortHash
- Credential
- AuthenticationProof
- Bilddaten
- Dateipfade
- personenbezogene Gesundheitsdaten,
  sofern diese für das Ereignis nicht erforderlich sind
- interne Infrastrukturinformationen

---

# Testbarkeit

Domain Events

sind

reine Datenobjekte.

Sie

benötigen

keine

Mocks.

Tests prüfen

- Inhalt,
- Reihenfolge,
- Version,
- AggregateVersion,
- EventType.

---

# Architekturregeln

Domain Events

- besitzen keine Logik,
- besitzen keine Seiteneffekte,
- kennen keine Infrastruktur,
- sind vollständig immutable,
- werden grundsätzlich durch Aggregate erzeugt,
- dürfen ausschließlich in der ausdrücklich dokumentierten Ausnahme
  `ProfileDeleted` durch den zuständigen Application Service erzeugt werden,
- werden erst nach erfolgreichem Commit veröffentlicht.

---

# Traceability

## Requirements

- PRO-FR-003
- PRO-FR-004
- PRO-FR-005
- PRO-FR-006
- PRO-FR-007
- PRO-FR-009
- PRO-FR-017
- PRO-FR-025
- PRO-FR-027

---

## Business Rules

- PRO-BR-006
- PRO-BR-007
- PRO-BR-021
- PRO-BR-022

---

## Validation Rules

- PRO-VR-014
- PRO-VR-015

---

# Status dieses Abschnitts

Mit Teil **5E-1** sind definiert:

- allgemeine Regeln für Domain Events,
- `DomainEvent`,
- `DomainEventId`,
- `EventType`,
- `EventCategory`,
- `OccurredAt`,
- `AggregateId`,
- `AggregateVersion`,
- `EventMetadata`,
- `CorrelationId`,
- `CausationId`,
- `EventProducer`,
- `EventSchemaVersion`,
- `DomainEventCollection`,
- Event-Erzeugung,
- Event-Lebenszyklus,
- Reihenfolge,
- Idempotenz,
- Versionierung,
- Architekturregeln,
- Traceability.

Dieses Kapitel definiert die fachliche Struktur aller Domain Events und bildet die Grundlage für das Event-Publishing in Teil **5E-2**.

---

# Teil 5E-2

Der nächste Abschnitt enthält:

- Event Publishing
- After-Commit-Regeln
- Transactional Outbox Pattern
- Event Ordering
- Event Replay
- Event Correlation
- Event Causation
- Event-Versionierung und Migration
- Event Handler
- Testbarkeit
- Architekturprinzipien
- Abschluss des gesamten `05_DOMAIN_MODEL.md`

# Teil 5E-2 – Event Publishing, Event Processing und Abschluss

# Event Publishing

## Zweck

Das Event Publishing stellt sicher, dass Domain Events ausschließlich nach einer erfolgreich abgeschlossenen fachlichen Transaktion veröffentlicht werden.

Die Veröffentlichung gehört ausdrücklich **nicht** zum Aggregate.

Ebenso wenig gehört sie zu

- Entities,
- Value Objects,
- Specifications,
- Domain Policies,
- Domain Services,
- Repositories.

Die Verantwortung liegt beim Application Layer in Zusammenarbeit mit dem `DomainEventPublisher`.

---

# Allgemeine Regeln

## PRO-EP-001 – Veröffentlichung ausschließlich nach Commit

Ein Domain Event darf erst veröffentlicht werden, wenn

- sämtliche fachlichen Änderungen erfolgreich persistiert wurden,
- die UnitOfWork erfolgreich abgeschlossen wurde,
- keine Rollback-Situation mehr möglich ist.

---

## PRO-EP-002 – Keine Veröffentlichung vor Commit

Während einer laufenden Transaktion dürfen Domain Events ausschließlich innerhalb der `DomainEventCollection` eines Aggregats gespeichert werden.

Eine Veröffentlichung ist unzulässig.

---

## PRO-EP-003 – Rollback

Schlägt die Transaktion fehl,

dann gilt:

```text
kein Commit

↓

keine Event-Veröffentlichung
```

Alle erzeugten Domain Events werden verworfen.

---

# Standardablauf

```text
Aggregate

↓

Business Operation

↓

DomainEventCollection

↓

Repository.save()

↓

UnitOfWork.commit()

↓

DomainEventPublisher.publishAllAfterCommit()

↓

Event Handler
```

---

# DomainEventPublisher

## Verantwortlichkeiten

Der Publisher

- veröffentlicht Domain Events,
- garantiert die Reihenfolge,
- verhindert keine Geschäftslogik,
- verändert keine Aggregate.

---

## Nicht verantwortlich

Der Publisher

- erzeugt keine Events,
- speichert keine Aggregate,
- führt keinen Commit aus,
- entscheidet nicht über fachliche Regeln.

---

# Transactional Outbox Pattern

## Zweck

Die zuverlässige Event-Auslieferung erfolgt über eine Transactional Outbox.

Dadurch werden

- verlorene Events,
- doppelte Zustände,
- Inkonsistenzen

vermieden.

---

## Ablauf

```text
Aggregate

↓

Repository.save()

↓

Outbox speichern

↓

Commit

↓

Outbox Dispatcher

↓

DomainEventPublisher

↓

Event Handler
```

---

## Eigenschaften

Die Outbox wird

atomar

mit dem Aggregate gespeichert.

Dadurch gilt

```text
Aggregate gespeichert

UND

Event gespeichert
```

oder

```text
nichts gespeichert
```

---

# Event Queue

## Zweck

Die Event Queue hält veröffentlichungsbereite Events.

---

## Eigenschaften

- FIFO
- deterministische Reihenfolge
- keine fachliche Logik

---

# Event Ordering

## Regeln

Innerhalb eines Aggregates

bleibt

die Erzeugungsreihenfolge

immer erhalten.

Beispiel

```text
ProfileActivated

↓

ProfileMarkedAsDefault

↓

ProfileExported
```

Diese Reihenfolge darf nicht verändert werden.

---

# Aggregate-Grenzen

Zwischen verschiedenen Aggregaten

existiert

keine globale Reihenfolgegarantie.

Nur die Reihenfolge

innerhalb eines Aggregates

ist verbindlich.

---

# Event Replay

## Zweck

Bereits gespeicherte Events

können erneut verarbeitet werden.

---

## Voraussetzungen

Alle Event Handler

müssen

idempotent

arbeiten.

---

# Replay-Regeln

Ein Replay

darf

keine

unerwarteten Seiteneffekte erzeugen.

---

# Event Handler

## Zweck

Ein Event Handler reagiert

auf

bereits eingetretene Ereignisse.

---

## Regeln

Handler

- verändern niemals das ursprüngliche Event,
- erzeugen gegebenenfalls neue Events,
- besitzen keine Kenntnis der UI.

---

## Beispiel

```text
ProfileDeleted

↓

HealthDataCleanupHandler

↓

MeasurementsDeleted
```

---

# Event Correlation

## Zweck

Mehrere Events,

die zu einem Use Case gehören,

werden über

```text
CorrelationId
```

verbunden.

---

## Beispiel

```text
Delete Profile

↓

ProfileDeleted

↓

MeasurementsDeleted

↓

MedicationDeleted

↓

DashboardReset
```

Alle Events

besitzen dieselbe

CorrelationId.

---

# Event Causation

## Zweck

Die

```text
CausationId
```

beschreibt,

welches Event

ein weiteres Event ausgelöst hat.

---

## Beispiel

```text
ProfileDeleted

↓

DashboardReset
```

DashboardReset

enthält

als

CausationId

die EventId

von

ProfileDeleted.

---

# Event Versionierung

## Regeln

Jedes Event besitzt

```text
EventSchemaVersion
```

Neue Versionen

dürfen

ältere gespeicherte Events

nicht ungültig machen.

---

# Event Migration

Bei Änderungen

muss

eine Migrationsstrategie definiert werden.

Möglichkeiten

```text
Upcaster

Migration Adapter

Mehrere Versionen parallel
```

---

# Event Naming

Events werden ausschließlich

in Vergangenheitsform benannt.

Beispiele

```text
ProfileCreated

ProfileArchived

ProfileDeleted

ProfilePasswordChanged

ProfileImageReplaced
```

---

# Event Payload

Ein Event enthält ausschließlich

fachlich notwendige Informationen.

Nicht enthalten sein dürfen

- Passwörter
- Hashwerte
- Credentials
- AuthenticationProof
- Binärdaten
- Dateipfade
- technische Stacktraces
- ORM-Objekte

---

# Idempotenz

Alle Handler

müssen

Mehrfachverarbeitung

erkennen können.

Verwendet werden mindestens

```text
DomainEventId

AggregateId

AggregateVersion
```

---

# Fehler beim Publishing

## Vor Commit

```text
Rollback

↓

kein Event
```

---

## Nach Commit

Der fachliche Zustand

bleibt bestehen.

Fehlgeschlagene Veröffentlichungen

werden

über die Outbox

erneut versucht.

---

# Retry-Regeln

Ein fehlgeschlagenes Event

darf

mehrfach

gesendet werden.

Deshalb

müssen Handler

idempotent arbeiten.

---

# Monitoring

Folgende Informationen

dürfen überwacht werden

- veröffentlichte Events
- fehlgeschlagene Veröffentlichungen
- Retry-Anzahl
- Outbox-Größe
- durchschnittliche Veröffentlichungszeit

---

# Sicherheitsregeln

Events

dürfen niemals

personenbezogene Informationen enthalten,

wenn diese

für den fachlichen Zweck

nicht erforderlich sind.

Gesundheitsdaten

werden grundsätzlich

nicht

über Domain Events übertragen,

sondern ausschließlich

über explizite fachliche Datenmodelle.

---

# Testbarkeit

Folgende Szenarien

müssen getestet werden

## Erfolgsfall

```text
Commit

↓

Publish
```

---

## Rollback

```text
Rollback

↓

kein Publish
```

---

## Outbox

```text
Commit

↓

Outbox

↓

Dispatcher

↓

Publish
```

---

## Retry

Mehrfache Zustellung

führt

zu

keiner

fachlichen Doppelverarbeitung.

---

## Reihenfolge

Events

werden

in Aggregate-Reihenfolge

verarbeitet.

---

# Architekturregeln

## Aggregate

erzeugen grundsätzlich Domain Events.

Die ausdrücklich dokumentierte Ausnahme ist `ProfileDeleted`.

Dieses Abschlussereignis wird nach erfolgreicher vollständiger Löschung durch
den zuständigen Application Service erzeugt.

---

## Repository

speichert

Aggregate.

---

## UnitOfWork

koordiniert

Commit.

---

## Publisher

veröffentlicht

Events.

---

## Handler

reagieren

auf

Events.

---

Keine Komponente

übernimmt

die Verantwortung

einer anderen.

---

# Vollständigkeit des Domain Models

Mit Teil **5E-2** sind nun vollständig definiert:

## Domänenstruktur

- Aggregate
- Entities
- Value Objects
- Enumerationen

---

## Fachliche Regeln

- Aggregate-Invarianten
- Entity-Invarianten
- Cross-Aggregate-Invarianten
- Business Rules
- Validation Rules

---

## Fachliche Logik

- Aggregate
- Domain Services
- Specifications
- Domain Policies

---

## Infrastrukturabstraktion

- Factory
- Repository Interfaces
- UnitOfWork
- Domain Ports
- Domain Events

---

## Event-System

- DomainEvent
- DomainEventCollection
- DomainEventPublisher
- Event Ordering
- Event Replay
- Event Correlation
- Event Causation
- Event Versionierung
- Transactional Outbox
- Event Handler

---

# Qualitätsziele

Das Domain Model erfüllt:

- Domain-Driven Design
- Clean Architecture
- SOLID
- Single Responsibility Principle
- Dependency Rule
- vollständige Infrastrukturunabhängigkeit
- deterministische Geschäftslogik
- vollständige Testbarkeit
- klare Verantwortungsgrenzen
- vollständige Traceability

---

# Traceability

## Requirements

Alle Requirements

```text
PRO-FR-001
...
PRO-FR-027
```

werden durch das Domain Model vollständig unterstützt.

---

## Business Rules

Alle Business Rules

werden durch

- Aggregate,
- Domain Services,
- Specifications,
- Policies,
- Domain Events

abgebildet.

---

## Validation Rules

Alle Validation Rules

werden durch

- Value Objects,
- Factory,
- Specifications,
- Domain Services

durchgesetzt.

---

# Status von Teil 5D

Mit Teil **5D-2** ist Teil 5 vollständig beschrieben.

Definiert sind damit:

- Domain Services,
- ProfileFactory,
- Repository Interfaces,
- UnitOfWork,
- Domain Ports,
- Specifications,
- Domain Policies,
- Aggregate-übergreifende Invarianten,
- Architekturprinzipien,
- Verantwortungsgrenzen,
- Traceability.

Das vollständige Domain Model ist an dieser Stelle noch nicht abgeschlossen.

Die folgenden Teile **5E-1** und **5E-2** definieren zusätzlich:

- Domain Events,
- Event-Metadaten,
- Event-Erzeugung,
- Event Publishing,
- Transactional Outbox,
- Event Ordering,
- Event Replay,
- Event Handler.

---

# Nächstes Dokument

```text
06_ERROR_HANDLING_GUIDE.md
```

Dieses Dokument definiert systemweit:

- `DomainResult<T>`
- `DomainMessage`
- `DomainError`
- `DomainWarning`
- `DomainInformation`
- Fehlercodes
- Exception Policy
- Logging Policy
- Fehlerübersetzung an Port-Grenzen
- Validierungsfehler
- Repository- und Event-Fehler
- Internationalisierung von Meldungen

Damit beginnt der nächste Architekturbaustein der Systemdokumentation.