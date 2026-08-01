# NAMING_CONVENTIONS.md

> HealthTracker Naming Conventions

---

# Dokumentinformationen

| Feld            | Wert                             |
| --------------- | -------------------------------- |
| Dokument-ID     | DOC-STD-NAMING-001               |
| Dokumenttyp     | Projektstandard                  |
| Kategorie       | Coding & Documentation Standards |
| Version         | 1.1.0                            |
| Status          | In Bearbeitung                   |
| Owner           | HealthTracker Team               |
| Reviewer        | HealthTracker Team               |
| Freigegeben     | —                                |
| Letzte Änderung | 2026-07-31                       |
| Reviewintervall | Vor jedem Major Release          |

---

# Dokumenthistorie

| Version | Datum      | Änderung                                                    | Grund                                              | Autor              |
| ------- | ---------- | ----------------------------------------------------------- | -------------------------------------------------- | ------------------ |
| 1.0.0   | 2026-07-31 | Erste Fassung erstellt                                      | Einführung eines einheitlichen Benennungsstandards | HealthTracker Team |
| 1.1.0   | 2026-07-31 | Riverpod-, Test- und Modulstruktur-Konventionen aufgenommen | Finale Vereinheitlichung des Standards             | HealthTracker Team |

---

# Dokumentqualität

| Kriterium        | Status |
| ---------------- | :----: |
| Vollständigkeit  |    ⏳   |
| Konsistenz       |    ✅   |
| Verständlichkeit |    ✅   |
| Beispiele        |    ✅   |
| Review           |    ⏳   |
| Freigabe         |    ⏳   |

**Qualitätsindex:** 35 %

Der Qualitätsindex wird nach Abschluss aller vier Teile auf mindestens 95 Prozent angehoben.

---

# Zweck

Dieses Dokument definiert die verbindlichen Benennungsregeln für das gesamte HealthTracker-Projekt.

Die Regeln gelten für:

* Quellcode
* Dokumentation
* Architekturartefakte
* Tests
* Datenmodelle
* Assets
* Git-Branches
* Commits
* Build- und Konfigurationsdateien

Einheitliche Benennungen verbessern:

* Lesbarkeit
* Wartbarkeit
* Wiederverwendbarkeit
* Nachvollziehbarkeit
* automatisierte Analyse
* Code Reviews
* Zusammenarbeit mit Codex und anderen Entwicklungswerkzeugen

---

# Ziele

Dieser Standard verfolgt folgende Ziele:

* Alle Namen besitzen eine eindeutige Bedeutung.
* Gleiche Sachverhalte werden konsistent benannt.
* Quellcode folgt idiomatischen Dart- und Flutter-Konventionen.
* Dokumente und fachliche Artefakte sind projektweit eindeutig identifizierbar.
* Die festgelegte Projektarchitektur wird durch die Benennung unterstützt.
* Unspezifische Sammelbezeichnungen werden vermieden.
* Neue Module können ohne zusätzliche Benennungsentscheidungen ergänzt werden.

---

# Geltungsbereich

Dieser Standard gilt verbindlich für alle Bestandteile des HealthTracker-Projekts.

Dazu gehören insbesondere:

```text
lib/
test/
integration_test/
assets/
docs/
scripts/
.github/
```

Der Standard gilt ebenfalls für zukünftig ergänzte Plattformen und Module.

Abweichungen sind ausschließlich zulässig, wenn:

* eine externe Technologie eine feste Benennung verlangt,
* die Abweichung dokumentiert wird,
* ein Review erfolgt,
* und die Entscheidung bei grundlegender Bedeutung durch einen ADR festgehalten wird.

---

# Grundprinzipien

## Verständlichkeit

Jeder Name muss seine fachliche oder technische Verantwortung eindeutig beschreiben.

Ein Name darf keine zusätzliche Erklärung benötigen, um seine grundlegende Bedeutung zu verstehen.

Richtig:

```text
CreateProfileUseCase
ProfileRepository
birthYear
profileEditorPage
```

Nicht zulässig:

```text
Process
Manager
Stuff
DataObject
Thing
```

---

## Konsistenz

Gleiche Sachverhalte erhalten im gesamten Projekt dieselbe Bezeichnung.

Beispielsweise wird eine innerhalb der App verwaltete Person immer als `Profile` bezeichnet.

Folgende alternativen Begriffe dürfen dafür nicht parallel verwendet werden:

```text
Person
Patient
Member
Account
HealthUser
```

Abweichende Begriffe sind nur zulässig, wenn sie fachlich tatsächlich etwas anderes beschreiben.

---

## Fachlichkeit vor Technik

Namen sollen bevorzugt die fachliche Verantwortung beschreiben.

Eine fachliche Schnittstelle darf nicht nach der aktuell verwendeten Datenbank benannt werden.

Richtig:

```dart
abstract interface class ProfileRepository {}
```

Konkrete technische Implementierung:

```dart
class IsarProfileRepository implements ProfileRepository {}
```

Nicht zulässig:

```dart
abstract interface class IsarRepository {}
```

wenn die Schnittstelle fachlich Profile verwaltet.

---

## Eine Verantwortung

Ein Name beschreibt genau eine Verantwortung.

Richtig:

```text
CreateProfileUseCase
UpdateProfileUseCase
DeleteProfileUseCase
SelectProfileUseCase
```

Zu vermeiden:

```text
ProfileManager
ProfileHandler
ProfileProcessor
ProfileLogic
```

Solche Sammelbezeichnungen lassen nicht erkennen, welche konkrete Aufgabe das Artefakt besitzt.

---

## Langfristige Stabilität

Namen sollen möglichst unabhängig von kurzfristigen Implementierungsdetails bleiben.

Eine fachliche Datei darf deshalb beispielsweise heißen:

```text
profile_repository.dart
```

Die technische Implementierung darf heißen:

```text
isar_profile_repository.dart
```

Wird die Datenbank später ausgetauscht, bleibt die fachliche Schnittstelle unverändert.

---

## Keine unnötigen Abkürzungen

Bezeichnungen werden grundsätzlich ausgeschrieben.

Nicht zulässig:

```text
prof
meas
med
cfg
mgr
svc
repo
tmp
obj
```

Ausnahmen gelten nur für projektweit definierte Codes und allgemein etablierte technische Begriffe.

Zulässige Beispiele:

```text
API
ID
JSON
URL
HTTP
UI
UX
UTC
BMI
PIN
```

Modulcodes wie `PRO`, `MEA` oder `MED` werden ausschließlich für Dokument- und Artefaktkennungen verwendet.

Sie werden nicht als Präfixe für Dart-Klassen eingesetzt.

---

# Projektsprache

Für die verschiedenen Projektbereiche gelten folgende Sprachen:

| Bereich            | Sprache                                                 |
| ------------------ | ------------------------------------------------------- |
| Quellcode          | Englisch                                                |
| Klassen            | Englisch                                                |
| Methoden           | Englisch                                                |
| Variablen          | Englisch                                                |
| Dateinamen         | Englisch                                                |
| Verzeichnisnamen   | Englisch                                                |
| Dokumentation      | Deutsch                                                 |
| Benutzeroberfläche | Deutsch in Version 1.x                                  |
| Kommentare         | Innerhalb einer Datei einheitlich Deutsch oder Englisch |
| Git-Commits        | Englisch                                                |
| Git-Branches       | Englisch                                                |

> Hinweis

Medizinische Fachbegriffe dürfen ihre international gebräuchliche Bezeichnung behalten, wenn eine Übersetzung zu Mehrdeutigkeit führen würde.

---

# Modulcodes

Jedes Fachmodul besitzt einen eindeutigen Code.

| Modul        | Code |
| ------------ | ---- |
| Profile      | PRO  |
| Dashboard    | DAS  |
| Measurements | MEA  |
| Medication   | MED  |
| Nutrition    | NUT  |
| Analysis     | ANA  |
| Devices      | DEV  |
| Settings     | SET  |
| Core         | COR  |
| Shared       | SHA  |

Die Modulcodes werden verwendet für:

* Functional Requirements
* Non-Functional Requirements
* Use Cases
* Business Rules
* Validation Rules
* Events
* Interfaces
* Module APIs
* Test Cases
* Qualitätsattribute
* modulspezifische Dokument-IDs

Beispiele:

```text
PRO-FR-001
MEA-UC-004
MED-BR-008
ANA-TC-012
```

Die Modulcodes werden nicht in normalen Dart-Klassennamen verwendet.

Nicht zulässig:

```dart
class PROProfile {}
class MEAMeasurementRepository {}
```

Richtig:

```dart
class Profile {}
class MeasurementRepository {}
```

---

# Dokument-IDs

Jedes verbindliche Dokument besitzt eine eindeutige Dokument-ID.

## Format

```text
DOC-<BEREICH>-<TYP>-<NUMMER>
```

## Beispiele

```text
DOC-STD-NAMING-001
DOC-STD-STYLE-001
DOC-PRO-REQ-001
DOC-PRO-API-001
DOC-MEA-DATA-001
DOC-ANA-TEST-001
```

## Regeln

Dokument-IDs:

* müssen projektweit eindeutig sein,
* dürfen niemals geändert werden,
* dürfen niemals wiederverwendet werden,
* bleiben auch nach Archivierung reserviert,
* müssen im Dokumentkopf angegeben werden.

Eine Änderung des Dateinamens darf die Dokument-ID nicht verändern.

---

# Artefakt-IDs

Alle fachlichen Artefakte besitzen eine projektweit eindeutige Kennung.

## Functional Requirements

Format:

```text
<MODUL>-FR-XXX
```

Beispiel:

```text
PRO-FR-001
```

---

## Non-Functional Requirements

Format:

```text
<MODUL>-NFR-XXX
```

Beispiel:

```text
PRO-NFR-001
```

---

## Use Cases

Format:

```text
<MODUL>-UC-XXX
```

Beispiel:

```text
PRO-UC-001
```

---

## Business Rules

Format:

```text
<MODUL>-BR-XXX
```

Beispiel:

```text
PRO-BR-001
```

---

## Validation Rules

Format:

```text
<MODUL>-VR-XXX
```

Beispiel:

```text
PRO-VR-001
```

---

## Events

Format:

```text
<MODUL>-EV-XXX
```

Beispiel:

```text
PRO-EV-001
```

---

## Interfaces

Format:

```text
<MODUL>-IF-XXX
```

Beispiel:

```text
PRO-IF-001
```

---

## Module APIs

Format:

```text
<MODUL>-API-XXX
```

Beispiel:

```text
PRO-API-001
```

---

## Test Cases

Format:

```text
<MODUL>-TC-XXX
```

Beispiel:

```text
PRO-TC-001
```

---

## Qualitätsattribute

Format:

```text
<MODUL>-QA-XXX
```

Beispiel:

```text
PRO-QA-001
```

---

## Architecture Decision Records

Format:

```text
ADR-XXX
```

Beispiele:

```text
ADR-001
ADR-002
ADR-003
```

Die ADR-Nummerierung erfolgt projektweit fortlaufend und ist nicht an ein einzelnes Modul gebunden.

---

# Regeln für Kennungen

Alle Kennungen:

* sind eindeutig,
* verwenden Großbuchstaben,
* verwenden Bindestriche als Trennzeichen,
* verwenden dreistellige fortlaufende Nummern,
* werden nach ihrer Vergabe nicht mehr geändert,
* werden nach Entfernung eines Artefakts nicht wiederverwendet.

Richtig:

```text
PRO-FR-001
PRO-FR-002
PRO-FR-003
```

Nicht zulässig:

```text
PRO-FR-1
pro-fr-001
PRO_FR_001
PROFILE-FR-001
```

---

# Status dieses Teils

Mit Teil 1 sind folgende Bereiche verbindlich definiert:

* Zweck und Geltungsbereich
* Grundprinzipien
* Projektsprache
* Modulcodes
* Dokument-IDs
* Artefakt-IDs
* Regeln für eindeutige Kennungen

Die folgenden Teile ergänzen diesen Standard.

## Teil 2

* Verzeichnisstruktur
* Fachmodul-Struktur
* Dart-Dateien
* Klassen und Schnittstellen
* Repositorys und Services
* Use Cases
* Riverpod-Provider und Notifier
* Widgets, Pages, Dialoge und Formulare

## Teil 3

* Methoden und Variablen
* Konstanten
* `final` und `const`
* Testdateien
* Assets
* Datenbank und JSON
* Imports
* Kommentare
* Null Safety
* Logging

## Teil 4

* Git-Branches und Commits
* Release-Tags
* Dokumentnamen
* Diagramme und Screenshots
* Review-Checkliste
* Qualitätsmetriken
* Referenzen
* Freigabe und Änderungsstopp

# Verzeichnisstruktur

Die Projektstruktur folgt der für HealthTracker definierten Architektur.

Verzeichnisnamen werden:

- ausschließlich in Englisch geschrieben,
- vollständig ausgeschrieben,
- in Kleinbuchstaben (`snake_case`) angelegt.

## Standardstruktur

```text
lib/
├── app/
├── core/
├── domain/
├── features/
├── models/
├── providers/
├── repositories/
├── services/
└── shared/
```

Nicht zulässig:

```text
Core/
Feature/
Repository/
Srv/
Util/
Misc/
```

---

# Fachmodul-Struktur

Die Projektstruktur trennt fachliche Modelle, Benutzeroberfläche und Infrastruktur.

## Domain

Die Domain enthält ausschließlich fachliche Logik.

```text
domain/
└── profile/
    ├── entities/
    ├── value_objects/
    ├── repositories/
    ├── use_cases/
    ├── rules/
    └── services/
```

Domain-Code:

- kennt Flutter nicht,
- kennt keine Widgets,
- kennt keine Datenbank,
- kennt keine UI.

---

## Features

Features enthalten ausschließlich UI-nahe Komponenten.

```text
features/
└── profiles/
    ├── pages/
    ├── widgets/
    ├── dialogs/
    ├── forms/
    └── providers/
```

Features dürfen:

- Flutter verwenden,
- Riverpod verwenden,
- Theme verwenden.

Features dürfen **keine** Business-Logik enthalten.

---

## Repositories

Technische Repository-Implementierungen liegen unter

```text
repositories/
```

Beispiel

```text
repositories/
└── profile/
    ├── isar_profile_repository.dart
    ├── memory_profile_repository.dart
    └── encrypted_profile_repository.dart
```

---

## Services

Technische Services liegen unter

```text
services/
```

Beispiel

```text
services/
└── backup/
└── security/
└── import_export/
```

---

# Dart-Dateien

Alle Dart-Dateien verwenden

```text
snake_case.dart
```

Beispiele

```text
profile.dart

profile_repository.dart

profile_notifier.dart

profile_provider.dart

profile_editor_page.dart

profile_avatar_widget.dart

create_profile_use_case.dart

backup_service.dart
```

Nicht zulässig

```text
Profile.dart

ProfileRepository.dart

profileService.dart

profile-service.dart

ProfileEditor.dart
```

---

# Klassen

Alle Klassen verwenden

```text
PascalCase
```

Beispiele

```dart
Profile

ProfileRepository

ProfileNotifier

CreateProfileUseCase

BackupService

ProfileEditorPage
```

Nicht zulässig

```dart
profile

profileRepository

createprofile

profile_editor
```

---

# Interfaces

Interfaces verwenden denselben Namen wie ihre fachliche Verantwortung.

Keine Präfixe.

Keine Suffixe wie Impl.

Richtig

```dart
abstract interface class ProfileRepository {}
```

Nicht zulässig

```dart
IProfileRepository

AbstractProfileRepository

BaseProfileRepository
```

---

# Implementierungen

Implementierungen beschreiben ihre technische Umsetzung.

Beispiele

```dart
IsarProfileRepository

MemoryProfileRepository

EncryptedProfileRepository

MockProfileRepository
```

Nicht zulässig

```dart
ProfileRepositoryImpl

RepositoryImpl

ProfileImpl
```

---

# Repositorys

Repository-Schnittstellen enden immer auf

```text
Repository
```

Beispiele

```dart
ProfileRepository

MeasurementRepository

MedicationRepository

NutritionRepository
```

Repositorys definieren ausschließlich fachliche Operationen.

---

# Services

Service-Klassen enden immer auf

```text
Service
```

Beispiele

```dart
AuthenticationService

BackupService

ImportExportService

AnalysisService
```

Services kapseln fachliche oder technische Dienste.

---

# Use Cases

Use Cases enden immer auf

```text
UseCase
```

Ein Use Case besitzt genau eine Verantwortung.

Beispiele

```dart
CreateProfileUseCase

DeleteProfileUseCase

UpdateProfileUseCase

SelectProfileUseCase

AuthenticateProfileUseCase
```

Nicht zulässig

```dart
ProfileManager

ProfileLogic

ProfileHandler
```

---

# Riverpod

Riverpod ist das Standard-State-Management des Projekts.

Alle Provider enden auf

```text
Provider
```

---

## Dependency Provider

Repositorys und Services werden als Dependency Provider bereitgestellt.

```dart
final profileRepositoryProvider =
    Provider<ProfileRepository>(
  (ref) => IsarProfileRepository(),
);
```

```dart
final authenticationServiceProvider =
    Provider<AuthenticationService>(
  (ref) => AuthenticationService(),
);
```

---

## Datenprovider

Provider, die Daten liefern, verwenden fachliche Namen.

Beispiele

```dart
profilesProvider

activeProfileProvider

measurementsProvider

dashboardProvider
```

Nicht zulässig

```dart
provider1

profileState

dataProvider
```

---

## Notifier Provider

Notifier Provider verwenden den Namen ihres Notifiers.

```dart
final profileNotifierProvider =
    NotifierProvider<
        ProfileNotifier,
        ProfileState>(
      ProfileNotifier.new,
    );
```

---

# Notifier

Notifier enden auf

```text
Notifier
```

Beispiele

```dart
ProfileNotifier

DashboardNotifier

MeasurementNotifier

SettingsNotifier
```

---

# State-Klassen

State-Klassen enden auf

```text
State
```

Beispiele

```dart
ProfileState

DashboardState

SettingsState
```

Für abgeschlossene Zustandsmodelle werden bevorzugt

```dart
sealed class
```

oder immutable Klassen verwendet.

---

# Controller

Controller werden grundsätzlich vermieden.

Business-Logik gehört in

- Domain
- Use Cases
- Services

Controller sind nur zulässig, wenn Flutter sie benötigt.

Beispiele

```dart
TextEditingController

AnimationController

ScrollController
```

---

# Widgets

Wiederverwendbare Widgets enden auf

```text
Widget
```

Beispiele

```dart
ProfileCardWidget

ProfileAvatarWidget

MeasurementChartWidget

DashboardTileWidget
```

---

# Pages

Komplette Bildschirme enden auf

```text
Page
```

Beispiele

```dart
DashboardPage

ProfileEditorPage

SettingsPage

MedicationPage
```

---

# Dialoge

Dialoge enden auf

```text
Dialog
```

Beispiele

```dart
DeleteProfileDialog

ProfileSettingsDialog

BackupDialog
```

---

# Bottom Sheets

Bottom Sheets enden auf

```text
BottomSheet
```

Beispiele

```dart
ProfileSelectionBottomSheet

MedicationFilterBottomSheet
```

---

# Formulare

Formulare enden auf

```text
Form
```

Beispiele

```dart
ProfileForm

MedicationForm

NutritionForm
```

---

# Extensions

Extensions enden auf

```text
Extension
```

Dateiname

```text
profile_extension.dart
```

Beispiel

```dart
extension ProfileExtension on Profile {

  int get age => ...

}
```

---

# Mixins

Mixins enden auf

```text
Mixin
```

Beispiele

```dart
ValidationMixin

LoggingMixin
```

---

# Enums

Enums verwenden PascalCase.

Enumwerte verwenden camelCase.

```dart
enum Gender {

  male,

 female,

 diverse,

 unknown,

}
```

---

# Exceptions

Technische Ausnahmen enden auf

```text
Exception
```

Beispiele

```dart
ValidationException

BackupException

AuthenticationException
```

---

# Failure-Klassen

Domänenfehler enden auf

```text
Failure
```

Beispiele

```dart
ValidationFailure

StorageFailure

NetworkFailure
```

---

# Mapper

Mapper enden auf

```text
Mapper
```

Beispiele

```dart
ProfileMapper

MeasurementMapper
```

---

# Converter

Converter enden auf

```text
Converter
```

Beispiele

```dart
WeightConverter

TemperatureConverter

DateConverter
```

---

# Serializer

Serializer enden auf

```text
Serializer
```

Beispiele

```dart
ProfileSerializer

BackupSerializer
```

---

# Status dieses Teils

Mit Teil 2 sind folgende Bereiche definiert:

- Verzeichnisstruktur
- Fachmodul-Struktur
- Dart-Dateien
- Klassen
- Interfaces
- Repositorys
- Services
- Use Cases
- Riverpod-Provider
- Notifier
- State-Klassen
- Widgets
- Pages
- Dialoge
- Formulare
- Extensions
- Mixins
- Enums
- Exceptions
- Failure
- Mapper
- Converter
- Serializer

## Teil 3

Im nächsten Abschnitt folgen:

- Methoden
- Variablen
- Konstanten
- `final` und `const`
- Testdateien
- Assets
- Datenbank
- JSON
- Imports
- Kommentare
- Null Safety
- Business-Logik
- Logging

# Methoden

Methodennamen verwenden ausschließlich

```text
camelCase()
```

Methoden beginnen immer mit einem Verb.

## Beispiele

```dart
createProfile()

updateProfile()

deleteProfile()

loadProfiles()

calculateBmi()

saveMeasurement()

validateInput()

exportBackup()

restoreBackup()
```

Nicht zulässig

```dart
profile()

profileData()

calculation()

newProfile()

measurement()
```

---

# Getter

Getter beschreiben einen Zustand oder einen berechneten Wert.

Sie verwenden keine Präfixe wie `get`.

Beispiele

```dart
bool get isProtected

int get age

String get displayName

double get bmi
```

Nicht zulässig

```dart
getAge()

getDisplayName()

getIsProtected()
```

---

# Setter

Setter werden möglichst vermieden.

Objekte sollen bevorzugt immutable sein.

Änderungen erfolgen über

- Konstruktoren
- copyWith()
- Use Cases
- Repositorys

---

# Variablen

Variablen verwenden

```text
camelCase
```

Beispiele

```dart
activeProfile

birthYear

bodyHeight

selectedMedication

dashboardItems

dailyCalories
```

---

# Boolean-Variablen

Boolean-Namen beginnen mit

```text
is

has

can

should
```

Beispiele

```dart
isProtected

isActive

hasPassword

hasMeasurements

canDelete

shouldBackup
```

Nicht zulässig

```dart
password

delete

enabled

measurement
```

---

# Konstanten

Projektweite Konstanten folgen den offiziellen Dart-Konventionen.

Sie verwenden

```text
lowerCamelCase
```

Beispiele

```dart
const minHeightCm = 20.0;

const maxHeightCm = 250.0;

const defaultDashboardColumns = 2;

const maxProfileCount = 20;
```

Keine Magic Numbers verwenden.

---

# final

`final` wird standardmäßig verwendet.

Beispiel

```dart
final repository =
    ref.watch(profileRepositoryProvider);
```

---

# var

`var` wird ausschließlich verwendet,

wenn der Typ offensichtlich ist und die Variable verändert wird.

Beispiel

```dart
var currentIndex = 0;

currentIndex++;
```

---

# const

`const` wird immer verwendet,

wenn ein Objekt zur Compile-Zeit konstant sein kann.

Beispiele

```dart
const SizedBox(height: 16);

const EdgeInsets.all(8);

const Text("HealthTracker");
```

---

# Eine öffentliche Klasse pro Datei

Jede Dart-Datei besitzt genau ein öffentliches Hauptelement.

Private Hilfsklassen sind zulässig.

Beispiel

```text
profile_repository.dart
```

```dart
class ProfileRepository {}
```

Nicht zulässig

```dart
class ProfileRepository {}

class MeasurementRepository {}

class SettingsRepository {}
```

---

# Dateiverantwortung

Jede Datei besitzt genau eine Verantwortung.

Nicht zulässig

```text
helpers.dart

utils.dart

misc.dart

common.dart
```

Besser

```text
profile_validator.dart

date_formatter.dart

weight_converter.dart
```

---

# Testdateien

Testdateien verwenden denselben Namen wie die getestete Datei.

Suffix

```text
_test.dart
```

Beispiele

```text
profile_repository_test.dart

profile_service_test.dart

profile_notifier_test.dart

create_profile_use_case_test.dart

profile_editor_page_test.dart
```

---

## Teststruktur

Die Struktur unter

```text
test/
```

spiegelt die Struktur unter

```text
lib/
```

Beispiel

```text
lib/
└── domain/
    └── profile/
        └── use_cases/
            └── create_profile_use_case.dart

test/
└── domain/
    └── profile/
        └── use_cases/
            └── create_profile_use_case_test.dart
```

---

## Test Doubles

Mocks

```text
MockProfileRepository
```

Datei

```text
mock_profile_repository.dart
```

Fakes

```text
FakeProfileRepository
```

Datei

```text
fake_profile_repository.dart
```

Stubs

```text
StubAuthenticationService
```

Datei

```text
stub_authentication_service.dart
```

---

# Assets

Assets verwenden

```text
snake_case
```

Beispiele

```text
profile_placeholder.png

dashboard_background.png

heart_rate_icon.svg

app_logo.png
```

Nicht zulässig

```text
Image1.png

Photo2.png

Logo.PNG
```

---

# Icons

Icons enden bevorzugt auf

```text
_icon
```

Beispiele

```text
profile_icon.svg

backup_icon.svg

heart_icon.svg
```

---

# Bilder

Bilder beschreiben ihren Inhalt.

Nicht

```text
image.png
```

Sondern

```text
waist_measurement.png

profile_placeholder.png
```

---

# Datenbanktabellen

Tabellen bzw. Collections verwenden

```text
snake_case
```

Pluralformen werden bevorzugt.

Beispiele

```text
profiles

measurements

medications

nutrition_entries
```

---

# Datenbankfelder

Felder verwenden

```text
camelCase
```

Beispiele

```text
birthYear

createdAt

updatedAt

isProtected

lastProfileId
```

---

# JSON

JSON verwendet

```text
camelCase
```

Beispiel

```json
{
  "birthYear": 1980,
  "heightCm": 182,
  "isProtected": true
}
```

---

# API-Methoden

API-Methoden beginnen mit einem Verb.

Beispiele

```text
createProfile

updateProfile

deleteProfile

loadMeasurements

calculateRisk
```

---

# Import-Reihenfolge

Imports erfolgen in folgender Reihenfolge.

```dart
// Dart SDK
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';

// Externe Pakete
import 'package:flutter_riverpod/flutter_riverpod.dart';

// App
import '../../core/...';
import '../../domain/...';
import '../...';
```

Zwischen den Gruppen wird jeweils eine Leerzeile eingefügt.

Nicht verwendete Imports werden entfernt.

---

# Kommentare

Kommentare erklären

- warum etwas geschieht,
- nicht was geschieht.

Nicht hilfreich

```dart
// Counter erhöhen
counter++;
```

Hilfreich

```dart
// Nach erfolgreicher Synchronisation wird die lokale Version erhöht.
counter++;
```

---

# Dokumentationskommentare

Öffentliche Klassen, Methoden und Erweiterungen erhalten bei Bedarf DartDoc-Kommentare.

Beispiel

```dart
/// Speichert ein Profil dauerhaft.
Future<void> saveProfile(Profile profile);
```

---

# TODOs

TODOs enthalten immer eine Referenz.

Beispiel

```dart
// TODO(PRO-FR-014):
// Passwort-Reset implementieren.
```

Nicht zulässig

```dart
// TODO
```

---

# Magic Numbers

Magic Numbers sind nicht zulässig.

Nicht

```dart
if (heightCm < 20)
```

Sondern

```dart
const minHeightCm = 20.0;

if (heightCm < minHeightCm)
```

---

# Null Safety

Null Safety ist verpflichtend.

Nullable Typen werden ausschließlich verwendet,

wenn das Fehlen eines Wertes fachlich zulässig ist.

Nicht

```dart
String?
```

wenn immer ein Wert vorhanden sein muss.

---

# Business-Logik

Business-Logik gehört niemals in

- Widgets
- Pages
- Dialoge
- Forms

Business-Logik gehört ausschließlich in

- Domain
- Use Cases
- Services

---

# Repository-Zugriffe

Widgets greifen niemals direkt auf Repositorys zu.

Zulässiger Ablauf

```text
Widget
    │
    ▼
Provider / Notifier
    │
    ▼
Use Case
    │
    ▼
Repository
```

---

# Logging

Logs besitzen immer denselben Aufbau.

```text
[Profile] Profile loaded

[Backup] Backup completed

[Analysis] BMI calculated
```

Gesundheitsdaten,

Passwörter,

PINs,

Tokens

dürfen niemals protokolliert werden.

---

# Verbotene Namen

Nicht verwenden

```text
temp

tmp

misc

common

manager

controller

util

utils
```

Jeder Name beschreibt seine konkrete Verantwortung.

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Methoden
- Getter
- Setter
- Variablen
- Konstanten
- final / var / const
- Testdateien
- Teststruktur
- Test Doubles
- Assets
- Datenbank
- JSON
- Imports
- Kommentare
- DartDoc
- TODOs
- Magic Numbers
- Null Safety
- Business-Logik
- Repository-Zugriffe
- Logging

## Teil 4

Der letzte Teil enthält:

- Git-Branches
- Commit-Konventionen
- Release-Tags
- Dokumentnamen
- Diagramme
- Screenshots
- Review-Checkliste
- Qualitätsmetriken
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Git-Branches

Für die Versionsverwaltung wird eine einheitliche Branch-Strategie verwendet.

## Branchtypen

| Typ | Beispiel | Verwendung |
|-----|----------|------------|
| feature | feature/profile-management | Neue Funktionen |
| bugfix | bugfix/profile-validation | Fehlerbehebungen |
| hotfix | hotfix/startup-crash | Kritische Fehler |
| refactor | refactor/profile-service | Codeverbesserungen |
| docs | docs/requirements-guide | Dokumentation |
| release | release/v1.0.0 | Releasevorbereitung |

---

# Branch-Namen

Branch-Namen verwenden ausschließlich

- Kleinbuchstaben
- Bindestriche
- englische Begriffe

Richtig

```text
feature/profile-management

bugfix/dashboard-refresh

docs/profile-module

release/v1.0.0
```

Nicht zulässig

```text
Feature/Profile

BugFix

MeinBranch

Test123
```

---

# Commit-Konventionen

Es werden **Conventional Commits** verwendet.

## Format

```text
<type>(<scope>): <description>
```

---

## Commit-Typen

| Typ | Bedeutung |
|------|-----------|
| feat | Neue Funktion |
| fix | Fehlerbehebung |
| docs | Dokumentation |
| refactor | Refactoring |
| style | Formatierung |
| test | Tests |
| build | Buildsystem |
| ci | Continuous Integration |
| perf | Performance |
| chore | Wartung |

---

## Beispiele

```text
feat(profile): add profile editor

fix(profile): validate birth year

docs(architecture): update clean architecture

refactor(profile): simplify validation

test(profile): add repository tests

chore: update dependencies
```

---

# Release-Tags

Versionen verwenden Semantic Versioning.

```text
vMAJOR.MINOR.PATCH
```

Beispiele

```text
v1.0.0

v1.1.0

v2.0.0
```

---

# Dokumentnamen

Projektweite Standarddokumente verwenden Großbuchstaben.

Beispiele

```text
README.md

CHANGELOG.md

LICENSE

CONTRIBUTING.md

CODE_OF_CONDUCT.md

SECURITY.md

DOCUMENTATION_STANDARD.md

STYLE_GUIDE.md

NAMING_CONVENTIONS.md
```

---

# Moduldokumente

Alle Module verwenden dieselbe Dokumentstruktur.

```text
README.md

01_REQUIREMENTS.md

02_USE_CASES.md

03_BUSINESS_RULES.md

04_VALIDATION_RULES.md

05_DATA_MODEL.md

06_UI_SPECIFICATION.md

07_STATE_MODEL.md

08_EVENTS.md

09_INTERFACES.md

10_MODULE_API.md

11_TEST_SPECIFICATION.md

12_TRACEABILITY.md

13_CHANGELOG.md
```

Diese Reihenfolge ist für alle Module verbindlich.

---

# Diagramme

Diagrammdateien verwenden

```text
snake_case
```

Beispiele

```text
profile_state.drawio

profile_data_flow.drawio

dashboard_navigation.drawio

profile_state.mmd
```

Diagramme erhalten:

- Titel
- Versionsstand
- Änderungsdatum

---

# Screenshots

Screenshots beschreiben ihren Inhalt.

Beispiele

```text
profile_editor.png

dashboard_overview.png

backup_settings.png

measurement_chart.png
```

Nicht zulässig

```text
image1.png

photo.png

screen.png
```

---

# Temporäre Dateien

Temporäre Dateien werden niemals versioniert.

Beispiele

```text
*.tmp

*.bak

*.cache

*.log
```

Diese Dateien gehören in

```text
.gitignore
```

---

# Review-Checkliste

Vor jedem Merge wird geprüft:

## Projektstruktur

- [ ] Verzeichnis korrekt
- [ ] Dateiname korrekt
- [ ] Eine öffentliche Hauptklasse pro Datei
- [ ] Verantwortlichkeit eindeutig

---

## Benennung

- [ ] Klassen verwenden PascalCase
- [ ] Dateien verwenden snake_case
- [ ] Methoden verwenden camelCase
- [ ] IDs korrekt
- [ ] Keine verbotenen Namen

---

## Riverpod

- [ ] Provider enden auf Provider
- [ ] Notifier enden auf Notifier
- [ ] State-Klassen enden auf State
- [ ] Widgets greifen nicht direkt auf Repositorys zu

---

## Architektur

- [ ] Repository als Schnittstelle
- [ ] Implementierungen sprechend benannt
- [ ] Business-Logik außerhalb der UI
- [ ] Domain unabhängig von Flutter

---

## Dart

- [ ] dart format ausgeführt
- [ ] flutter analyze fehlerfrei
- [ ] Keine Analyzer-Warnungen
- [ ] const sinnvoll verwendet
- [ ] final als Standard verwendet
- [ ] Keine Magic Numbers

---

## Tests

- [ ] Testdateien korrekt benannt
- [ ] Teststruktur entspricht lib/
- [ ] Mocks korrekt benannt
- [ ] Fakes korrekt benannt
- [ ] Stubs korrekt benannt

---

## Dokumentation

- [ ] Dokumentation aktualisiert
- [ ] Changelog gepflegt
- [ ] Traceability aktualisiert
- [ ] TODOs besitzen Referenzen

---

# Qualitätsmetriken

Folgende Kennzahlen werden regelmäßig überprüft.

| Kennzahl | Ziel |
|-----------|------|
| Analysefehler | 0 |
| Lint-Warnungen | 0 |
| Magic Numbers | 0 |
| TODO ohne Referenz | 0 |
| Verbotene Namen | 0 |
| Dokumentqualität | ≥ 95 % |

---

# Ausnahmen

Abweichungen von diesem Standard sind ausschließlich zulässig,

wenn

- sie fachlich oder technisch notwendig sind,
- dokumentiert werden,
- reviewed wurden,
- und über einen Architecture Decision Record (ADR) begründet werden.

---

# Verbindlichkeit

Dieser Standard ist für das gesamte HealthTracker-Projekt verbindlich.

Er gilt für

- Quellcode
- Dokumentation
- Architektur
- Tests
- Assets
- Buildsystem
- CI/CD

Neue Module und Erweiterungen müssen diesen Standard vollständig einhalten.

---

# Referenzen

- DOC-STD-001 – Documentation Standard
- DOC-STD-STYLE-001 – Style Guide
- DOC-STD-REVIEW-001 – Review Guide
- DOC-STD-TRACE-001 – Traceability Guide
- DOC-STD-REQ-001 – Requirements Guide

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|---------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste Version | Projektstandard |
| 1.1.0 | 2026-07-31 | Riverpod-, Test- und Modulstruktur-Konventionen ergänzt | Konsolidierung des Standards |

---

# Freigabe

**Dokument-ID:** DOC-STD-NAMING-001

**Version:** 1.1.0

**Status:** **Approved**

**Freigabedatum:** 2026-07-31

**Reviewintervall:** Vor jedem Major Release

---

# Änderungsstopp

Mit der Freigabe der Version **1.1.0** gilt dieses Dokument als abgeschlossen.

Änderungen an diesem Standard erfolgen künftig ausschließlich durch:

1. Erstellung einer neuen Dokumentversion (z. B. 1.2.0 oder 2.0.0)
2. Dokumentierte Freigabe im Reviewprozess
3. Anpassung der Dokumenthistorie
4. Aktualisierung des Änderungsverlaufs
5. Verweis auf einen zugehörigen Architecture Decision Record (ADR), sofern die Änderung Auswirkungen auf Architektur oder Projektstandards hat.

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.