# 01_REQUIREMENTS.md

> Modul: Profile

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-PRO-REQ-001 |
| Dokumenttyp | Modulspezifikation |
| Modul | Profile |
| Version | 1.1.0 |
| Status | Draft |
| Owner | HealthTracker Team |
| Reviewer | HealthTracker Team |
| Letzte Änderung | 2026-07-31 |
| Reviewintervall | Bei jeder fachlichen Änderung |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|---------|-------|----------|-------|-------|
| 1.0.0 | 2026-07-31 | Erste Version | Initiale Spezifikation des Profilmoduls | HealthTracker Team |
| 1.1.0 | 2026-07-31 | Erweiterung der Anforderungen, Business Rules und Initialzustand | Vorbereitung der Implementierung | HealthTracker Team |

---

# Zweck

Dieses Dokument beschreibt sämtliche funktionalen und nichtfunktionalen Anforderungen des Moduls **Profile**.

Das Profilmodul bildet die Grundlage der gesamten Anwendung. Sämtliche Gesundheitsdaten sind genau einem Profil zugeordnet. Andere Module dürfen ausschließlich im Kontext eines aktiven Profils arbeiten.

---

# Ziele

Das Profilmodul ermöglicht:

- Anlegen beliebig vieler Profile
- Bearbeiten vorhandener Profile
- Archivieren und Löschen von Profilen
- Auswahl eines aktiven Profils
- automatisches Öffnen des zuletzt verwendeten Profils
- optionalen Passwortschutz
- Validierung sämtlicher Eingaben
- Import und Export von Profilen
- Rückkehr in den Initialzustand nach dem Löschen des letzten Profils

---

# Geltungsbereich

Dieses Dokument beschreibt ausschließlich das Profilmodul.

Enthalten sind:

- Profilverwaltung
- Profilauswahl
- Stammdaten
- Profilschutz
- Archivierung
- Import
- Export
- Initialzustand

Nicht Bestandteil dieses Dokuments:

- Messwerte
- Ernährung
- Medikamente
- Dashboard
- Analyse
- Geräteintegration
- Cloud-Synchronisation

---

# Priorisierung

| Priorität | Bedeutung |
|-----------|-----------|
| Must | Verpflichtend für Version 1.0 |
| Should | Hohe Priorität |
| Could | Optionale Erweiterung |
| Won't | Nicht Bestandteil der aktuellen Version |

---

# Functional Requirements

---

# Profilverwaltung

---

## PRO-FR-001

### Titel

Profil anlegen

### Priorität

**Must**

### Beschreibung

Das System muss das Anlegen eines neuen Profils ermöglichen.

### Eingaben

Pflichtfelder

- Name
- Geburtsjahr
- Körpergröße
- Profilfarbe

Optionale Felder

- Geschlecht
- Profilbild
- Passwortschutz

### Akzeptanzkriterien

- Das Profil erhält eine eindeutige Profil-ID.
- Pflichtfelder werden validiert.
- Das Profil wird dauerhaft gespeichert.
- Das Profil erscheint unmittelbar in der Profilliste.
- Das erste angelegte Profil wird automatisch zum aktiven Profil.

### Traceability

Use Case

- PRO-UC-001

Business Rules

- PRO-BR-001
- PRO-BR-006

Testfälle

- PRO-TC-001

---

## PRO-FR-002

### Titel

Profile anzeigen

### Priorität

**Must**

### Beschreibung

Alle vorhandenen und nicht archivierten Profile werden angezeigt.

### Akzeptanzkriterien

- Name wird angezeigt.
- Profilfarbe wird angezeigt.
- Aktives Profil ist gekennzeichnet.
- Archivierte Profile erscheinen nicht in der Standardansicht.
- Änderungen werden sofort sichtbar.

### Traceability

Use Case

- PRO-UC-002

Business Rules

- PRO-BR-008

Testfälle

- PRO-TC-002

---

## PRO-FR-003

### Titel

Profil bearbeiten

### Priorität

**Must**

### Beschreibung

Vorhandene Profile können geändert werden.

### Änderbare Daten

- Name
- Geburtsjahr
- Körpergröße
- Geschlecht
- Profilbild
- Profilfarbe
- Passwortschutz

### Akzeptanzkriterien

- Änderungen werden validiert.
- Änderungen werden gespeichert.
- Profil-ID bleibt unverändert.
- Änderungszeitpunkt wird aktualisiert.
- Alle betroffenen Ansichten aktualisieren sich automatisch.

### Traceability

Use Case

- PRO-UC-003

Business Rules

- PRO-BR-006
- PRO-BR-007

Testfälle

- PRO-TC-003

---

## PRO-FR-004

### Titel

Profil endgültig löschen

### Priorität

**Must**

### Beschreibung

Ein Profil kann dauerhaft gelöscht werden.

### Akzeptanzkriterien

- Vor dem Löschen erfolgt eine Sicherheitsabfrage.
- Das Profil wird vollständig entfernt.
- Alle zugehörigen Gesundheitsdaten werden entfernt.
- Existieren weitere Profile, wird automatisch ein anderes Profil aktiviert.
- Wird das letzte Profil gelöscht, wechselt die Anwendung automatisch in den Initialzustand.

### Traceability

Use Case

- PRO-UC-004

Business Rules

- PRO-BR-002
- PRO-BR-003
- PRO-BR-004

Testfälle

- PRO-TC-004

---

## PRO-FR-005

### Titel

Profil archivieren

### Priorität

**Should**

### Beschreibung

Ein Profil kann archiviert werden, ohne seine Daten zu löschen.

### Akzeptanzkriterien

- Archivierte Profile erscheinen nicht in der Standardansicht.
- Alle Gesundheitsdaten bleiben erhalten.
- Archivierte Profile können später wiederhergestellt werden.

### Traceability

Use Case

- PRO-UC-005

Business Rules

- PRO-BR-008

Testfälle

- PRO-TC-005

---

## PRO-FR-006

### Titel

Archiviertes Profil wiederherstellen

### Priorität

**Could**

### Beschreibung

Ein archiviertes Profil kann wieder aktiviert werden.

### Akzeptanzkriterien

- Das Profil erscheint wieder in der Standardansicht.
- Alle Daten bleiben unverändert erhalten.
- Die Profil-ID bleibt identisch.

### Traceability

Use Case

- PRO-UC-006

Business Rules

- PRO-BR-008

Testfälle

- PRO-TC-006

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Dokumenthistorie
- Zweck
- Ziele
- Geltungsbereich
- Priorisierung
- Functional Requirements
  - PRO-FR-001 bis PRO-FR-006

---

## Teil 2

Der nächste Abschnitt behandelt:

- PRO-FR-007 bis PRO-FR-016

mit den Themen:

- Profilauswahl
- Standardprofil
- Stammdaten
- Profilbild
- Profilfarbe

# Profilauswahl

---

## PRO-FR-007

### Titel

Profil auswählen

### Priorität

**Must**

### Beschreibung

Der Benutzer kann jederzeit zwischen vorhandenen Profilen wechseln.

### Akzeptanzkriterien

- Das ausgewählte Profil wird sofort aktiv.
- Alle geöffneten Ansichten werden aktualisiert.
- Alle zukünftigen Eingaben erfolgen im aktiven Profil.
- Das aktive Profil wird eindeutig gekennzeichnet.

### Traceability

Use Case

- PRO-UC-007

Business Rules

- PRO-BR-004

Testfälle

- PRO-TC-007

---

## PRO-FR-008

### Titel

Zuletzt verwendetes Profil automatisch öffnen

### Priorität

**Must**

### Beschreibung

Beim Start der Anwendung wird automatisch das zuletzt verwendete Profil geöffnet.

### Akzeptanzkriterien

- Das zuletzt verwendete Profil wird automatisch aktiviert.
- Existiert das Profil nicht mehr, wird das Standardprofil geöffnet.
- Existiert kein Profil, startet die Anwendung im Einrichtungsmodus.
- Geschützte Profile müssen vor der Aktivierung entsperrt werden.

### Traceability

Use Case

- PRO-UC-008

Business Rules

- PRO-BR-002
- PRO-BR-003

Testfälle

- PRO-TC-008

---

## PRO-FR-009

### Titel

Standardprofil festlegen

### Priorität

**Should**

### Beschreibung

Ein Profil kann als Standardprofil definiert werden.

### Akzeptanzkriterien

- Es existiert maximal ein Standardprofil.
- Das Standardprofil wird verwendet, wenn kein zuletzt verwendetes Profil vorhanden ist.
- Ein archiviertes Profil kann nicht Standardprofil sein.

### Traceability

Use Case

- PRO-UC-009

Business Rules

- PRO-BR-008

Testfälle

- PRO-TC-009

---

## PRO-FR-010

### Titel

Aktives Profil anzeigen

### Priorität

**Must**

### Beschreibung

Das aktuell aktive Profil wird jederzeit eindeutig dargestellt.

### Akzeptanzkriterien

- Profilname sichtbar.
- Profilfarbe sichtbar.
- Profilwechsel jederzeit möglich.
- Ohne aktives Profil werden keine Gesundheitsdaten angezeigt.

### Traceability

Use Case

- PRO-UC-010

Business Rules

- PRO-BR-004

Testfälle

- PRO-TC-010

---

# Stammdaten

---

## PRO-FR-011

### Titel

Profilname verwalten

### Priorität

**Must**

### Beschreibung

Jedes Profil besitzt einen frei wählbaren Namen.

### Akzeptanzkriterien

- Name darf nicht leer sein.
- Führende und nachfolgende Leerzeichen werden entfernt.
- Doppelte Namen werden erkannt und als Warnung angezeigt.
- Die Speicherung bleibt nach Bestätigung möglich.

### Traceability

Use Case

- PRO-UC-011

Business Rules

- PRO-BR-010

Testfälle

- PRO-TC-011

---

## PRO-FR-012

### Titel

Geburtsjahr speichern

### Priorität

**Must**

### Beschreibung

Das Geburtsjahr wird dauerhaft gespeichert.

### Akzeptanzkriterien

- Das Geburtsjahr ist eine vierstellige Jahreszahl.
- Das Geburtsjahr beträgt mindestens 1900.
- Das Geburtsjahr darf nicht in der Zukunft liegen.
- Die Untergrenze wird zentral in den Validierungsregeln des Profilmoduls definiert.

### Traceability

Use Case

- PRO-UC-012

Validation Rules

- PRO-VR-002

Testfälle

- PRO-TC-012

---

## PRO-FR-013

### Titel

Körpergröße speichern

### Priorität

**Must**

### Beschreibung

Die Körpergröße wird in Zentimetern gespeichert.

### Akzeptanzkriterien

- Mindestwert 20 cm.
- Höchstwert 300 cm.
- Einheit wird angezeigt.
- Eingabe wird validiert.

### Traceability

Use Case

- PRO-UC-013

Validation Rules

- PRO-VR-003

Testfälle

- PRO-TC-013

---

## PRO-FR-014

### Titel

Geschlecht speichern

### Priorität

**Could**

### Beschreibung

Optional kann das Geschlecht gespeichert werden.

### Akzeptanzkriterien

- Eingabe freiwillig.
- Auswahl "Keine Angabe" vorhanden.
- Werte werden zentral definiert.

### Traceability

Use Case

- PRO-UC-014

Testfälle

- PRO-TC-014

---

## PRO-FR-015

### Titel

Profilbild verwalten

### Priorität

**Could**

### Beschreibung

Ein Profil kann ein optionales Profilbild besitzen.

### Akzeptanzkriterien

- Bild auswählen.
- Bild ändern.
- Bild entfernen.
- Ohne Bild wird ein Platzhalter angezeigt.

### Traceability

Use Case

- PRO-UC-015

Testfälle

- PRO-TC-015

---

## PRO-FR-016

### Titel

Profilfarbe verwalten

### Priorität

**Must**

### Beschreibung

Jedes Profil besitzt eine individuelle Profilfarbe.

Die Farbe dient ausschließlich der visuellen Zuordnung eines Profils.

### Akzeptanzkriterien

- Farbe dauerhaft gespeichert.
- Dashboard übernimmt Profilfarbe.
- Farbe jederzeit änderbar.
- Systemfarben bleiben unverändert.

### Traceability

Use Case

- PRO-UC-016

Testfälle

- PRO-TC-016

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- PRO-FR-007 bis PRO-FR-016
- Profilauswahl
- Standardprofil
- Aktives Profil
- Profilname
- Geburtsjahr
- Körpergröße
- Geschlecht
- Profilbild
- Profilfarbe

---

## Teil 3

Der nächste Abschnitt behandelt:

- PRO-FR-017 bis PRO-FR-026

mit den Themen:

- Passwortschutz
- Profil entsperren
- Passwort ändern
- Passwort entfernen
- Validierung
- Pflichtfelder
- Doppelte Namen
- Profilimport
- Profilexport
- Rückkehr in den Initialzustand

# Sicherheit

---

## PRO-FR-017

### Titel

Profil mit Passwort schützen

### Priorität

**Should**

### Beschreibung

Ein Profil kann optional mit einem Passwort geschützt werden.

Der Passwortschutz verhindert den unberechtigten Zugriff auf die Gesundheitsdaten eines Profils.

### Akzeptanzkriterien

- Passwortschutz kann aktiviert werden.
- Passwortschutz kann deaktiviert werden.
- Passwörter werden niemals im Klartext gespeichert.
- Es wird ausschließlich ein sicherer Passwort-Hash gespeichert.
- Nach Aktivierung ist das Profil gesperrt.

### Traceability

Use Case

- PRO-UC-017

Business Rules

- PRO-BR-009

Testfälle

- PRO-TC-017

---

## PRO-FR-018

### Titel

Profil entsperren

### Priorität

**Should**

### Beschreibung

Geschützte Profile müssen vor dem Öffnen entsperrt werden.

### Akzeptanzkriterien

- Passwort wird geprüft.
- Falsche Passwörter öffnen das Profil nicht.
- Erfolgreiche Anmeldung aktiviert das Profil.
- Gesundheitsdaten bleiben bis zur erfolgreichen Anmeldung verborgen.

### Traceability

Use Case

- PRO-UC-018

Testfälle

- PRO-TC-018

---

## PRO-FR-019

### Titel

Passwort ändern

### Priorität

**Should**

### Beschreibung

Der Benutzer kann das Passwort eines geschützten Profils ändern.

### Akzeptanzkriterien

- Altes Passwort muss eingegeben werden.
- Neues Passwort wird validiert.
- Neuer Passwort-Hash ersetzt den alten.
- Das alte Passwort verliert sofort seine Gültigkeit.

### Traceability

Use Case

- PRO-UC-019

Testfälle

- PRO-TC-019

---

## PRO-FR-020

### Titel

Passwortschutz entfernen

### Priorität

**Should**

### Beschreibung

Der Passwortschutz eines Profils kann entfernt werden.

### Akzeptanzkriterien

- Authentifizierung erforderlich.
- Passwort-Hash wird gelöscht.
- Profil kann anschließend ohne Passwort geöffnet werden.

### Traceability

Use Case

- PRO-UC-020

Testfälle

- PRO-TC-020

---

# Datenqualität

---

## PRO-FR-021

### Titel

Eingaben validieren

### Priorität

**Must**

### Beschreibung

Alle Profildaten werden vor dem Speichern validiert.

### Akzeptanzkriterien

- Ungültige Daten werden nicht gespeichert.
- Fehlermeldungen werden direkt am Eingabefeld angezeigt.
- Fachliche Regeln werden zentral verwendet.
- UI und Domain verwenden dieselben Validierungsregeln.

### Traceability

Use Case

- PRO-UC-021

Validation Rules

- PRO-VR-001 bis PRO-VR-006

Testfälle

- PRO-TC-021

---

## PRO-FR-022

### Titel

Pflichtfelder prüfen

### Priorität

**Must**

### Beschreibung

Alle Pflichtfelder werden vor dem Speichern geprüft.

### Pflichtfelder

- Name
- Geburtsjahr
- Körpergröße
- Profilfarbe

### Akzeptanzkriterien

- Leere Pflichtfelder verhindern das Speichern.
- Pflichtfelder werden eindeutig gekennzeichnet.
- Der Fokus springt zum ersten fehlerhaften Feld.

### Traceability

Use Case

- PRO-UC-022

Testfälle

- PRO-TC-022

---

## PRO-FR-023

### Titel

Doppelte Profilnamen erkennen

### Priorität

**Should**

### Beschreibung

Doppelte Profilnamen werden erkannt.

### Akzeptanzkriterien

- Warnung wird angezeigt.
- Speichern bleibt möglich.
- Die Eindeutigkeit wird ausschließlich über die Profil-ID sichergestellt.

### Traceability

Use Case

- PRO-UC-023

Business Rules

- PRO-BR-010

Testfälle

- PRO-TC-023

---

# Import und Export

---

## PRO-FR-024

### Titel

Profil exportieren

### Priorität

**Should**

### Beschreibung

Ein vollständiges Profil kann exportiert werden.

### Exportumfang

- Profil
- Gesundheitsdaten
- Dashboard-Konfiguration
- Einstellungen
- Verlauf

### Akzeptanzkriterien

- Exportformat besitzt Versionsnummer.
- Export wird validiert.
- Export enthält keine Klartext-Passwörter.
- Export kann später wieder importiert werden.

### Traceability

Use Case

- PRO-UC-024

Testfälle

- PRO-TC-024

---

## PRO-FR-025

### Titel

Profil importieren

### Priorität

**Should**

### Beschreibung

Ein zuvor exportiertes Profil kann importiert werden.

### Akzeptanzkriterien

- Dateiformat wird geprüft.
- Versionsnummer wird geprüft.
- Beschädigte Dateien werden abgelehnt.
- ID-Konflikte werden automatisch behandelt.
- Nach erfolgreichem Import erscheint das Profil in der Profilliste.
- Wird das erste Profil importiert, verlässt die Anwendung automatisch den Einrichtungsmodus.

### Traceability

Use Case

- PRO-UC-025

Testfälle

- PRO-TC-025

---

# Initialzustand

---

## PRO-FR-026

### Titel

Anwendung in Initialzustand zurücksetzen

### Priorität

**Must**

### Beschreibung

Wird das letzte vorhandene Profil gelöscht, wechselt die Anwendung automatisch in den Initialzustand.

### Gelöscht werden

- alle Profile
- alle Gesundheitsdaten
- alle Profilpasswörter
- Dashboard-Konfigurationen
- zuletzt verwendetes Profil
- Standardprofil

### Erhalten bleiben

- Spracheinstellungen
- Hell-/Dunkelmodus
- technische App-Einstellungen
- Versionsinformationen
- sonstige nicht personenbezogene Einstellungen

### Akzeptanzkriterien

- Kein Profil vorhanden.
- Kein aktives Profil vorhanden.
- Keine Gesundheitsdaten vorhanden.
- Der Einrichtungsbildschirm wird geöffnet.
- Der Benutzer kann:
  - ein erstes Profil anlegen,
  - ein Profil importieren,
  - ein Backup wiederherstellen.

### Traceability

Use Case

- PRO-UC-026

Business Rules

- PRO-BR-001
- PRO-BR-002
- PRO-BR-003
- PRO-BR-004

Testfälle

- PRO-TC-026

---

# Nachvollziehbarkeit

---

## PRO-FR-027

### Titel

Profilereignisse protokollieren

### Priorität

**Should**

### Beschreibung

Das System protokolliert wichtige Profilereignisse in einem datensparsamen Audit Trail.

### Zu protokollierende Ereignisse

- Profil erstellt
- Profil bearbeitet
- Profil archiviert
- Profil wiederhergestellt
- Profil gelöscht
- Profil ausgewählt
- Passwortschutz aktiviert
- Passwortschutz deaktiviert
- Passwort geändert
- Profil importiert
- Profil exportiert

### Nicht protokolliert werden

- Passwörter
- Passwort-Hashes
- Gesundheitsdaten
- Freitexteingaben
- personenbezogene Inhalte

### Akzeptanzkriterien

- Jeder Eintrag enthält Zeitstempel.
- Jeder Eintrag enthält die Profil-ID.
- Jeder Eintrag enthält den Ereignistyp.
- Das Audit Log ist gegen unbeabsichtigte Änderungen geschützt.
- Das Audit Log enthält keine sensiblen Inhalte.
- Audit-Einträge können für Diagnosezwecke exportiert werden.

### Traceability

Use Case

- PRO-UC-027

Business Rules

- PRO-BR-007

Non-Functional Requirements

- PRO-NFR-008
- PRO-NFR-010

Testfälle

- PRO-TC-027

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- PRO-FR-017 bis PRO-FR-027
- Passwortschutz
- Profil entsperren
- Passwort ändern
- Passwortschutz entfernen
- Eingabevalidierung
- Pflichtfelder
- Doppelte Profilnamen
- Profilimport
- Profilexport
- Initialzustand der Anwendung
- Audit Trail für Profilereignisse

---

## Teil 4

Der letzte Abschnitt enthält:

- Non-Functional Requirements
- Business Rules
- Zustandsdiagramm
- Abhängigkeiten
- Risiken
- Definition of Ready
- Definition of Done
- Änderungsverlauf

# Non-Functional Requirements

Die folgenden Anforderungen beschreiben Qualitätsmerkmale des Profilmoduls.

---

## PRO-NFR-001

### Titel

Offline-Betrieb

### Beschreibung

Das Profilmodul muss vollständig ohne Internetverbindung funktionieren.

---

## PRO-NFR-002

### Titel

Lokale Datenspeicherung

### Beschreibung

Alle Profildaten werden lokal gespeichert.

Eine Cloud-Anbindung ist optional und darf die lokale Nutzung nicht voraussetzen.

---

## PRO-NFR-003

### Titel

Performance

### Beschreibung

Ein Profilwechsel soll unter normalen Bedingungen innerhalb einer Sekunde abgeschlossen sein.

---

## PRO-NFR-004

### Titel

Barrierefreiheit

### Beschreibung

Alle Funktionen des Profilmoduls müssen gemäß den Anforderungen des ../../ui/UI_GUIDE.md bedienbar sein.

Dazu gehören insbesondere:

- Tastaturbedienung
- Screenreader-Unterstützung
- ausreichende Kontraste
- skalierbare Schriftgrößen

---

## PRO-NFR-005

### Titel

Responsive Darstellung

### Beschreibung

Das Profilmodul unterstützt

- Web
- Windows
- iPad

und zukünftige Smartphone-Versionen.

---

## PRO-NFR-006

### Titel

Skalierbarkeit

### Beschreibung

Die Fachlogik darf keine feste Begrenzung der Profilanzahl enthalten.

---

## PRO-NFR-007

### Titel

Datensicherheit

### Beschreibung

Passwörter und andere sensible Daten werden ausschließlich entsprechend SECURITY_GUIDE.md gespeichert.

---

## PRO-NFR-008

### Titel

Datenschutz

### Beschreibung

Personenbezogene Daten und Gesundheitsdaten dürfen niemals protokolliert werden.

---

## PRO-NFR-009

### Titel

Testbarkeit

### Beschreibung

Alle Komponenten des Profilmoduls müssen unabhängig testbar sein.

Mindestens

- Domain
- Use Cases
- Repository
- Riverpod Notifier
- Widgets

werden automatisiert getestet.

---

## PRO-NFR-010

### Titel

Nachvollziehbarkeit

### Beschreibung

Sicherheitsrelevante Profilereignisse werden im Audit Trail dokumentiert.

---

# Business Rules

---

## PRO-BR-001

Eine Installation darf null oder mehr Profile enthalten.

---

## PRO-BR-002

Das letzte vorhandene Profil darf gelöscht werden.

Nach dem Löschen wechselt die Anwendung automatisch in den Initialzustand.

---

## PRO-BR-003

Existiert kein Profil, startet die Anwendung im Einrichtungsmodus.

---

## PRO-BR-004

Ohne aktives Profil dürfen keine Gesundheitsdaten angezeigt oder bearbeitet werden.

---

## PRO-BR-005

Jeder Gesundheitsdatensatz gehört genau einem Profil.

---

## PRO-BR-006

Profil-IDs sind eindeutig und nach ihrer Erstellung unveränderlich.

---

## PRO-BR-007

Jede Änderung eines Profils aktualisiert den Änderungszeitpunkt.

---

## PRO-BR-008

Archivierte Profile erscheinen nicht in der Standardansicht.

Sie können wiederhergestellt oder endgültig gelöscht werden.

---

## PRO-BR-009

Der Passwortschutz ist optional und wird pro Profil verwaltet.

---

## PRO-BR-010

Profilnamen müssen nicht eindeutig sein.

Doppelte Namen lösen eine Warnung aus, verhindern das Speichern jedoch nicht.

---

# Zustandsmodell

```text
                      ┌────────────────────────┐
                      │   Initialzustand       │
                      │   Kein Profil          │
                      └────────────┬───────────┘
                                   │
                    Profil anlegen / importieren
                                   │
                                   ▼
                   ┌──────────────────────────┐
                   │      Normalbetrieb       │
                   │ mindestens 1 Profil      │
                   └───────────┬──────────────┘
                               │
                     Profil auswählen
                               │
                               ▼
                   ┌──────────────────────────┐
                   │      Aktives Profil      │
                   └───────────┬──────────────┘
                               │
               letztes Profil löschen
                               │
                               ▼
                      ┌────────────────────────┐
                      │   Initialzustand       │
                      └────────────────────────┘
```

---

# Abhängigkeiten

Das Profilmodul wird verwendet von

- Dashboard
- Measurements
- Nutrition
- Medication
- Analysis
- Devices
- Backup
- Settings

Das Profilmodul verwendet

- Security
- Validation
- Persistenz
- Navigation
- Shared UI

---

# Risiken

| Risiko | Gegenmaßnahme |
|---------|---------------|
| Versehentliches Löschen | Sicherheitsabfrage |
| Datenverlust | Backup und Archivierung |
| Unsicherer Passwortschutz | Hashing und sichere Speicherung |
| Fehlerhafter Import | Versions- und Integritätsprüfung |
| Fehlende Datenkonsistenz | Validierung und Business Rules |
| Daten anderer Profile sichtbar | Strikte Profiltrennung |

---

# Definition of Ready

Eine Requirement ist bereit zur Implementierung, wenn

- Beschreibung vollständig ist,
- Akzeptanzkriterien definiert sind,
- Business Rules bekannt sind,
- Testfälle geplant sind,
- Review erfolgt ist.

---

# Definition of Done

Eine Requirement gilt als abgeschlossen, wenn

- Implementierung abgeschlossen,
- Unit Tests erfolgreich,
- Widget Tests erfolgreich,
- Integration Tests erfolgreich,
- Review abgeschlossen,
- Dokumentation aktualisiert,
- Traceability vollständig.

---

# Offene Punkte

Zurzeit keine.

---

# Referenzen

- REQUIREMENTS_GUIDE.md
- TRACEABILITY_GUIDE.md
- ARCHITECTURE_GUIDE.md
- TESTING_GUIDE.md
- SECURITY_GUIDE.md
- ../../ui/UI_GUIDE.md
- REVIEW_GUIDE.md

---

# Änderungsverlauf

| Version | Datum | Änderung | Autor |
|----------|-------|-----------|-------|
| 1.0.0 | 2026-07-31 | Erste Version | HealthTracker Team |
| 1.1.0 | 2026-07-31 | Erweiterung auf 27 Functional Requirements sowie Business Rules, NFRs und Initialzustand | HealthTracker Team |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument | 01_REQUIREMENTS.md |
| Modul | Profile |
| Version | 1.1.0 |
| Status | Ready for Review |
| Nächstes Review | Vor Implementierungsbeginn |

---

# Status

**Dokument:** `docs/modules/profile/01_REQUIREMENTS.md`

**Version:** **1.1.0**

**Umfang**

- ✅ 27 Functional Requirements
- ✅ 10 Non-Functional Requirements
- ✅ 10 Business Rules
- ✅ Zustandsmodell
- ✅ Risiken
- ✅ Definition of Ready
- ✅ Definition of Done
- ✅ Referenzen
- ✅ Änderungsverlauf
- ✅ Freigabe