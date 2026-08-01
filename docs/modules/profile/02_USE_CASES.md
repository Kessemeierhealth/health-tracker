# 02_USE_CASES.md

> Modul: Profile

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-PRO-UC-001 |
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
| 1.0.0 | 2026-08-01 | Erste Fassung erstellt | Spezifikation der Anwendungsfälle des Profilmoduls | HealthTracker Team |

---

# Zweck

Dieses Dokument beschreibt die fachlichen Anwendungsfälle des Moduls **Profile**.

Die Use Cases konkretisieren die Functional Requirements aus `01_REQUIREMENTS.md` und bilden die Grundlage für:

- Business Rules
- Validation Rules
- Datenmodell
- UI-Spezifikation
- State Model
- Implementierung
- Testfälle
- Traceability

---

# Geltungsbereich

Dieses Dokument beschreibt die Interaktionen zur:

- Verwaltung von Profilen
- Auswahl des aktiven Profils
- Verwaltung von Profilstammdaten
- Absicherung geschützter Profile
- Validierung von Eingaben
- Archivierung und Wiederherstellung
- Ein- und Ausfuhr von Profildaten
- Rückkehr in den Initialzustand
- Protokollierung relevanter Profilereignisse

---

# Akteure

| Akteur | Beschreibung |
|--------|--------------|
| Benutzer | Person, die HealthTracker bedient |
| Anwendung | HealthTracker-Anwendung |
| Profilmodul | Fachmodul zur Verwaltung der Profile |
| Persistenz | Technische Komponente zur dauerhaften Speicherung |
| Security Service | Komponente für Passwortprüfung und Schutzmechanismen |
| Audit Service | Komponente zur datensparsamen Ereignisprotokollierung |
| Import-/Export-Service | Komponente zum Einlesen und Ausgeben von Profildaten |

---

# Allgemeine Vorbedingungen

Für alle Use Cases gelten, soweit nicht anders beschrieben:

- Die Anwendung wurde erfolgreich gestartet.
- Das Profilmodul wurde initialisiert.
- Der lokale Datenspeicher ist verfügbar.
- Der Benutzer besitzt Zugriff auf die Anwendung.
- Technische Fehler werden kontrolliert behandelt.
- Sensible Daten werden nicht protokolliert.

---

# Allgemeine Nachbedingungen

Nach einer erfolgreichen Änderung:

- ist der neue Zustand dauerhaft gespeichert,
- sind betroffene Ansichten aktualisiert,
- ist die Traceability gewährleistet,
- wurde gegebenenfalls ein datensparsamer Audit-Eintrag erstellt.

---

# Use Cases

# Profilverwaltung

## PRO-UC-001 – Profil anlegen

### Ziel

Der Benutzer erstellt ein neues Profil und kann anschließend mit diesem Profil arbeiten.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer wählt die Aktion **„Profil anlegen“**.

### Vorbedingungen

- Der Einrichtungsmodus oder die Profilverwaltung ist geöffnet.
- Der lokale Datenspeicher ist verfügbar.

### Eingaben

Pflichtfelder:

- Name
- Geburtsjahr
- Körpergröße
- Profilfarbe

Optionale Felder:

- Geschlecht
- Profilbild
- Passwortschutz

### Hauptablauf

1. Die Anwendung öffnet das Profilformular.
2. Der Benutzer gibt die Profildaten ein.
3. Die Anwendung validiert die Pflichtfelder.
4. Die Anwendung validiert die fachlichen Wertebereiche.
5. Die Anwendung prüft, ob der Profilname bereits verwendet wird.
6. Bei einem doppelten Namen zeigt die Anwendung eine Warnung an.
7. Der Benutzer bestätigt gegebenenfalls die Verwendung des doppelten Namens.
8. Die Anwendung erzeugt eine eindeutige Profil-ID.
9. Die Anwendung erstellt das Profil.
10. Die Persistenz speichert das Profil dauerhaft.
11. Ist es das erste Profil, wird es automatisch aktiviert.
12. Die Anwendung aktualisiert die Profilliste.
13. Die Anwendung zeigt eine Erfolgsbestätigung.
14. Der Audit Service protokolliert das Ereignis `ProfileCreated`.

### Alternativabläufe

#### A1 – Doppelter Profilname

1. Die Anwendung erkennt einen bereits vorhandenen Profilnamen.
2. Sie zeigt eine Warnung an.
3. Der Benutzer kann:
   - den Namen ändern oder
   - die doppelte Verwendung bestätigen.
4. Nach Bestätigung wird der Hauptablauf fortgesetzt.

#### A2 – Passwortschutz aktivieren

1. Der Benutzer aktiviert den Passwortschutz.
2. Die Anwendung fordert Passwort und Bestätigung an.
3. Der Security Service validiert das Passwort.
4. Es wird ausschließlich ein sicherer Passwort-Hash gespeichert.

#### A3 – Vorgang abbrechen

1. Der Benutzer bricht die Erstellung ab.
2. Die Anwendung verwirft alle nicht gespeicherten Eingaben.
3. Es wird kein Profil erstellt.

### Fehlerfälle

#### E1 – Ungültige Eingaben

- Die Anwendung speichert das Profil nicht.
- Fehler werden unmittelbar an den betroffenen Feldern angezeigt.
- Der Benutzer kann die Eingaben korrigieren.

#### E2 – Speicherung fehlgeschlagen

- Das Profil gilt als nicht erstellt.
- Die Anwendung zeigt eine verständliche Fehlermeldung.
- Unvollständige Datensätze werden nicht beibehalten.

### Nachbedingungen

- Ein neues Profil ist dauerhaft gespeichert.
- Das Profil besitzt eine eindeutige ID.
- Das erste Profil ist aktiv.
- Die Anwendung befindet sich bei mindestens einem Profil im Normalbetrieb.

### Traceability

- PRO-FR-001
- PRO-FR-011 bis PRO-FR-017
- PRO-FR-021 bis PRO-FR-023
- PRO-BR-001
- PRO-BR-006
- PRO-BR-009
- PRO-BR-010
- PRO-TC-001

---

## PRO-UC-002 – Profile anzeigen

### Ziel

Der Benutzer erhält eine Übersicht aller verfügbaren, nicht archivierten Profile.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer öffnet die Profilauswahl oder Profilverwaltung.

### Vorbedingungen

- Das Profilmodul ist initialisiert.

### Hauptablauf

1. Die Anwendung fordert alle nicht archivierten Profile an.
2. Die Persistenz liefert die Profile.
3. Die Anwendung sortiert die Profile nach der festgelegten Sortierregel.
4. Für jedes Profil werden mindestens Name und Profilfarbe angezeigt.
5. Das aktive Profil wird eindeutig gekennzeichnet.
6. Geschützte Profile erhalten eine Schutzkennzeichnung.
7. Die verfügbaren Profilaktionen werden angezeigt.

### Alternativabläufe

#### A1 – Keine Profile vorhanden

1. Die Anwendung erkennt, dass kein Profil existiert.
2. Sie öffnet den Einrichtungsmodus.
3. Sie bietet mindestens folgende Aktionen an:
   - erstes Profil erstellen,
   - Profil oder Backup importieren,
   - Hilfe anzeigen.

#### A2 – Nur archivierte Profile vorhanden

1. Die Standardliste bleibt leer.
2. Die Anwendung weist auf vorhandene archivierte Profile hin.
3. Der Benutzer kann die Archivansicht öffnen.

### Fehlerfälle

#### E1 – Profile können nicht geladen werden

- Die Anwendung zeigt einen Fehlerzustand.
- Der Benutzer kann den Ladevorgang wiederholen.
- Es werden keine veralteten oder unvollständigen Profildaten als aktuell dargestellt.

### Nachbedingungen

- Die Profilliste ist sichtbar oder der Einrichtungsmodus wurde geöffnet.
- Es wurden keine Profildaten geändert.

### Traceability

- PRO-FR-002
- PRO-BR-003
- PRO-BR-008
- PRO-TC-002

---

## PRO-UC-003 – Profil bearbeiten

### Ziel

Der Benutzer ändert die Stammdaten oder Einstellungen eines vorhandenen Profils.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer wählt bei einem Profil die Aktion **„Bearbeiten“**.

### Vorbedingungen

- Das Profil existiert.
- Ein geschütztes Profil wurde erfolgreich entsperrt.
- Der Benutzer besitzt Zugriff auf das Profil.

### Hauptablauf

1. Die Anwendung lädt die aktuellen Profildaten.
2. Die Anwendung öffnet das Profilformular.
3. Die vorhandenen Werte werden angezeigt.
4. Der Benutzer ändert mindestens einen Wert.
5. Die Anwendung validiert alle geänderten und verpflichtenden Felder.
6. Die Anwendung prüft einen geänderten Profilnamen auf Duplikate.
7. Der Benutzer bestätigt die Speicherung.
8. Die Anwendung übernimmt die Änderungen.
9. Die Profil-ID bleibt unverändert.
10. Der Änderungszeitpunkt wird aktualisiert.
11. Die Persistenz speichert das geänderte Profil.
12. Alle betroffenen Ansichten werden aktualisiert.
13. Der Audit Service protokolliert `ProfileUpdated`.

### Alternativabläufe

#### A1 – Keine Änderung vorgenommen

1. Die Anwendung erkennt, dass keine Daten verändert wurden.
2. Es erfolgt kein Schreibvorgang.
3. Das Formular wird geschlossen oder bleibt geöffnet.

#### A2 – Doppelter Profilname

1. Die Anwendung zeigt eine Warnung an.
2. Der Benutzer kann den Namen ändern oder bestätigen.
3. Nach Bestätigung wird gespeichert.

#### A3 – Änderungen verwerfen

1. Der Benutzer verlässt das Formular.
2. Die Anwendung erkennt ungespeicherte Änderungen.
3. Sie fordert eine Bestätigung an.
4. Nach Bestätigung werden die Änderungen verworfen.

### Fehlerfälle

#### E1 – Ungültige Eingabe

- Die Daten werden nicht gespeichert.
- Das betroffene Feld erhält eine verständliche Fehlermeldung.

#### E2 – Speicherung fehlgeschlagen

- Der vorherige Profilzustand bleibt erhalten.
- Die Anwendung zeigt eine Fehlermeldung.
- Der Benutzer kann den Vorgang wiederholen.

### Nachbedingungen

- Das Profil enthält die validierten neuen Werte.
- Profil-ID und Erstellungszeitpunkt bleiben unverändert.
- Der Änderungszeitpunkt wurde aktualisiert.

### Traceability

- PRO-FR-003
- PRO-FR-011 bis PRO-FR-020
- PRO-FR-021 bis PRO-FR-023
- PRO-BR-006
- PRO-BR-007
- PRO-BR-009
- PRO-BR-010
- PRO-TC-003

---

## PRO-UC-004 – Profil endgültig löschen

### Ziel

Der Benutzer löscht ein Profil und alle eindeutig zugeordneten personenbezogenen Daten dauerhaft.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer wählt die Aktion **„Profil endgültig löschen“**.

### Vorbedingungen

- Das Profil existiert.
- Das Profil wurde bei bestehendem Profilschutz entsperrt.
- Die Anwendung kann die abhängigen Daten ermitteln.

### Hauptablauf

1. Die Anwendung zeigt eine eindeutige Warnung an.
2. Die Anwendung beschreibt, welche Daten gelöscht werden.
3. Der Benutzer bestätigt die endgültige Löschung.
4. Die Anwendung ermittelt alle dem Profil zugeordneten Daten.
5. Die Anwendung löscht:
   - das Profil,
   - Gesundheitsdaten,
   - profilbezogene Dashboard-Konfigurationen,
   - Profilschutzdaten,
   - profilbezogene Einstellungen,
   - temporäre profilbezogene Daten.
6. Ein Verweis auf das zuletzt verwendete Profil wird entfernt.
7. Ein gegebenenfalls gesetzter Standardprofilverweis wird entfernt.
8. Die Anwendung prüft, ob weitere nicht archivierte Profile vorhanden sind.
9. Existiert ein weiteres Profil, wird ein zulässiges Profil aktiviert.
10. Existiert kein weiteres Profil, wird PRO-UC-026 ausgeführt.
11. Die Benutzeroberfläche wird aktualisiert.
12. Der Audit Service protokolliert `ProfileDeleted`, ohne gelöschte Inhalte zu übernehmen.

### Alternativabläufe

#### A1 – Benutzer bricht ab

1. Der Benutzer bestätigt die Löschung nicht.
2. Es werden keine Daten verändert.

#### A2 – Weitere Profile vorhanden

1. Die Anwendung wählt das Standardprofil oder ein anderes verfügbares Profil.
2. Das ausgewählte Profil wird aktiviert.
3. Die Anwendung wechselt in dessen Dashboard.

#### A3 – Letztes Profil gelöscht

1. Die Anwendung erkennt, dass kein Profil mehr existiert.
2. Die Anwendung führt den Rücksetzprozess gemäß PRO-UC-026 aus.
3. Der Einrichtungsmodus wird geöffnet.

### Fehlerfälle

#### E1 – Löschung unvollständig

- Die Transaktion wird zurückgerollt, sofern technisch möglich.
- Das Profil gilt nicht als erfolgreich gelöscht.
- Die Anwendung zeigt eine Fehlermeldung.
- Der Fehler wird ohne sensible Inhalte protokolliert.

#### E2 – Abhängige Daten können nicht ermittelt werden

- Die Löschung wird nicht begonnen.
- Die Anwendung informiert den Benutzer.
- Ein inkonsistenter Teilzustand ist unzulässig.

### Nachbedingungen

Entweder:

- das Profil und alle zugeordneten Daten wurden vollständig gelöscht und ein anderes Profil ist aktiv,

oder:

- die Anwendung befindet sich im Initialzustand.

### Traceability

- PRO-FR-004
- PRO-FR-026
- PRO-FR-027
- PRO-BR-002 bis PRO-BR-005
- PRO-TC-004
- PRO-TC-026

---

## PRO-UC-005 – Profil archivieren

### Ziel

Der Benutzer blendet ein Profil aus dem Normalbetrieb aus, ohne dessen Daten zu löschen.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer wählt die Aktion **„Archivieren“**.

### Vorbedingungen

- Das Profil existiert.
- Das Profil ist nicht bereits archiviert.
- Ein geschütztes Profil wurde entsperrt.

### Hauptablauf

1. Die Anwendung zeigt eine Bestätigung an.
2. Der Benutzer bestätigt die Archivierung.
3. Die Anwendung kennzeichnet das Profil als archiviert.
4. Die Persistenz speichert den neuen Status.
5. Das Profil verschwindet aus der Standardansicht.
6. Alle zugeordneten Daten bleiben erhalten.
7. Der Audit Service protokolliert `ProfileArchived`.

### Alternativabläufe

#### A1 – Aktives Profil und weitere Profile vorhanden

1. Vor der Archivierung wird ein anderes Profil aktiviert.
2. Anschließend wird das bisher aktive Profil archiviert.

#### A2 – Einziges nicht archiviertes Profil

1. Die Anwendung weist darauf hin, dass danach kein aktives Profil vorhanden ist.
2. Nach Bestätigung wird das Profil archiviert.
3. Die Anwendung wechselt in den Einrichtungsmodus.
4. Die archivierten Daten bleiben erhalten.

#### A3 – Vorgang abbrechen

- Das Profil bleibt unverändert.

### Fehlerfälle

#### E1 – Speicherung fehlgeschlagen

- Der Archivstatus bleibt unverändert.
- Die Anwendung zeigt eine Fehlermeldung.

### Nachbedingungen

- Das Profil ist archiviert.
- Die Daten sind weiterhin vorhanden.
- Das Profil erscheint nicht in der Standardansicht.

### Traceability

- PRO-FR-005
- PRO-BR-008
- PRO-TC-005

---

## PRO-UC-006 – Archiviertes Profil wiederherstellen

### Ziel

Der Benutzer führt ein archiviertes Profil in den Normalbetrieb zurück.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer öffnet die Archivansicht und wählt **„Wiederherstellen“**.

### Vorbedingungen

- Das Profil existiert.
- Das Profil ist archiviert.

### Hauptablauf

1. Die Anwendung zeigt die archivierten Profile.
2. Der Benutzer wählt ein Profil.
3. Die Anwendung zeigt eine Bestätigung an.
4. Der Benutzer bestätigt die Wiederherstellung.
5. Die Anwendung entfernt den Archivstatus.
6. Die Persistenz speichert die Änderung.
7. Das Profil erscheint wieder in der Standardansicht.
8. Die zugeordneten Daten bleiben unverändert.
9. Der Audit Service protokolliert `ProfileRestored`.

### Alternativabläufe

#### A1 – Kein anderes aktives Profil vorhanden

1. Das wiederhergestellte Profil wird automatisch aktiviert.
2. Die Anwendung verlässt den Einrichtungsmodus.

#### A2 – Geschütztes Profil

1. Das Profil wird wiederhergestellt, aber nicht automatisch entsperrt.
2. Vor der Aktivierung ist PRO-UC-018 auszuführen.

### Fehlerfälle

#### E1 – Profil nicht mehr vorhanden

- Die Anwendung entfernt den ungültigen Listeneintrag.
- Sie zeigt eine verständliche Meldung.

#### E2 – Speicherung fehlgeschlagen

- Das Profil bleibt archiviert.
- Die Anwendung zeigt einen Fehlerzustand.

### Nachbedingungen

- Das Profil ist nicht mehr archiviert.
- Es ist in der Standardansicht verfügbar.
- Die Profil-ID und zugeordneten Daten sind unverändert.

### Traceability

- PRO-FR-006
- PRO-BR-008
- PRO-TC-006

---

# Profilauswahl

## PRO-UC-007 – Profil auswählen

### Ziel

Der Benutzer wechselt in den fachlichen Kontext eines anderen Profils.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer wählt ein Profil aus der Profilauswahl.

### Vorbedingungen

- Mindestens ein nicht archiviertes Profil existiert.
- Das ausgewählte Profil ist verfügbar.

### Hauptablauf

1. Die Anwendung zeigt die Profilauswahl.
2. Der Benutzer wählt ein Profil.
3. Die Anwendung prüft, ob das Profil geschützt ist.
4. Bei einem ungeschützten Profil wird es aktiviert.
5. Die Profil-ID wird als zuletzt verwendet gespeichert.
6. Profilabhängige Provider und Zustände werden aktualisiert.
7. Das Dashboard wird für das neue Profil geladen.
8. Die Profilfarbe wird übernommen.
9. Der Audit Service protokolliert `ActiveProfileChanged`.

### Alternativabläufe

#### A1 – Profil ist geschützt

1. Die Anwendung führt PRO-UC-018 aus.
2. Nur nach erfolgreicher Entsperrung wird das Profil aktiviert.

#### A2 – Bereits aktives Profil gewählt

1. Es erfolgt kein Profilwechsel.
2. Die aktuelle Ansicht bleibt bestehen.

### Fehlerfälle

#### E1 – Profil wurde zwischenzeitlich gelöscht oder archiviert

- Das Profil wird nicht aktiviert.
- Die Anwendung aktualisiert die Profilliste.
- Der Benutzer erhält eine Meldung.

#### E2 – Profilabhängige Daten können nicht geladen werden

- Die Anwendung zeigt einen Fehlerzustand.
- Sensible Daten des vorherigen Profils werden nicht fälschlich weiter angezeigt.
- Der Benutzer kann den Ladevorgang wiederholen oder ein anderes Profil wählen.

### Nachbedingungen

- Das gewählte Profil ist aktiv.
- Alle fachlichen Aktionen verwenden dessen Profil-ID.
- Das Profil ist als zuletzt verwendet gespeichert.

### Traceability

- PRO-FR-007
- PRO-FR-010
- PRO-BR-004
- PRO-BR-005
- PRO-TC-007

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Zweck und Geltungsbereich
- Akteure
- allgemeine Vor- und Nachbedingungen
- PRO-UC-001 – Profil anlegen
- PRO-UC-002 – Profile anzeigen
- PRO-UC-003 – Profil bearbeiten
- PRO-UC-004 – Profil endgültig löschen
- PRO-UC-005 – Profil archivieren
- PRO-UC-006 – Archiviertes Profil wiederherstellen
- PRO-UC-007 – Profil auswählen

---

# Folgende Teile

## Teil 2

- PRO-UC-008 bis PRO-UC-016
- Startprofil, Standardprofil und Profilstammdaten

## Teil 3

- PRO-UC-017 bis PRO-UC-023
- Profilschutz und Datenqualität

## Teil 4

- PRO-UC-024 bis PRO-UC-027
- Import, Export, Initialzustand und Audit Trail
- Abhängigkeiten, Risiken, Freigabe und Änderungsverlauf

# PRO-UC-008 – Zuletzt verwendetes Profil automatisch öffnen

## Ziel

Die Anwendung stellt beim Start den zuletzt verwendeten Profilkontext wieder her.

## Primärer Akteur

Anwendung

## Sekundärer Akteur

Benutzer

## Auslöser

Die Anwendung wird gestartet.

## Vorbedingungen

- Das Profilmodul wurde initialisiert.
- Der lokale Datenspeicher ist verfügbar.
- Der Verweis auf das zuletzt verwendete Profil kann gelesen werden.

## Hauptablauf

1. Die Anwendung liest den Verweis auf das zuletzt verwendete Profil.
2. Die Anwendung prüft, ob das referenzierte Profil existiert.
3. Die Anwendung prüft, ob das Profil archiviert ist.
4. Die Anwendung prüft, ob das Profil geschützt ist.
5. Ist das Profil ungeschützt, wird es aktiviert.
6. Die Anwendung lädt die profilbezogenen Daten.
7. Das Dashboard wird für das aktive Profil aufgebaut.
8. Die Profilfarbe wird übernommen.
9. Die Anwendung wechselt in den Normalbetrieb.

## Alternativabläufe

### A1 – Profil ist geschützt

1. Die Anwendung zeigt den Entsperrbildschirm.
2. Der Benutzer führt PRO-UC-018 aus.
3. Nach erfolgreicher Entsperrung wird das Profil aktiviert.

### A2 – Verweis ist ungültig

1. Die Anwendung erkennt, dass das referenzierte Profil nicht mehr existiert.
2. Der ungültige Verweis wird entfernt.
3. Existiert ein gültiges Standardprofil, wird dieses ausgewählt.
4. Andernfalls wird die Profilauswahl geöffnet.

### A3 – Profil ist archiviert

1. Das archivierte Profil wird nicht automatisch aktiviert.
2. Der Verweis auf das zuletzt verwendete Profil wird entfernt.
3. Ein gültiges Standardprofil oder ein anderes verfügbares Profil wird verwendet.

### A4 – Kein Profil vorhanden

1. Die Anwendung erkennt, dass kein Profil existiert.
2. Der Einrichtungsmodus wird geöffnet.
3. Es werden keine Gesundheitsdaten geladen.

## Fehlerfälle

### E1 – Profildaten können nicht geladen werden

- Das Profil wird nicht als vollständig aktiv dargestellt.
- Die Anwendung zeigt einen Fehlerzustand.
- Der Benutzer kann den Ladevorgang wiederholen oder ein anderes Profil wählen.

### E2 – Letzter Profilverweis kann nicht gelesen werden

- Die Anwendung verwendet das Standardprofil, sofern vorhanden.
- Andernfalls wird die Profilauswahl geöffnet.
- Ein technischer Fehler wird ohne sensible Inhalte protokolliert.

## Nachbedingungen

Entweder:

- ein gültiges Profil ist aktiv,

oder:

- die Profilauswahl beziehungsweise der Einrichtungsmodus ist geöffnet.

## Traceability

- PRO-FR-008
- PRO-FR-010
- PRO-BR-003
- PRO-BR-004
- PRO-TC-008

---

# PRO-UC-009 – Standardprofil festlegen

## Ziel

Der Benutzer definiert ein Profil, das als Fallback beim Anwendungsstart verwendet wird.

## Primärer Akteur

Benutzer

## Auslöser

Der Benutzer wählt bei einem Profil die Aktion **„Als Standardprofil festlegen“**.

## Vorbedingungen

- Das Profil existiert.
- Das Profil ist nicht archiviert.
- Das Profil ist für den Benutzer zugänglich.

## Hauptablauf

1. Die Anwendung zeigt die Profilaktionen.
2. Der Benutzer wählt die Standardprofilfunktion.
3. Die Anwendung prüft, ob bereits ein anderes Standardprofil existiert.
4. Ein vorhandener Standardprofilstatus wird entfernt.
5. Das ausgewählte Profil wird als Standardprofil gekennzeichnet.
6. Die Persistenz speichert die Änderung.
7. Die Benutzeroberfläche aktualisiert die Kennzeichnung.
8. Der Audit Service protokolliert `DefaultProfileChanged`.

## Alternativabläufe

### A1 – Profil ist bereits Standardprofil

1. Die Anwendung erkennt den unveränderten Zustand.
2. Es erfolgt kein Schreibvorgang.
3. Die aktuelle Kennzeichnung bleibt bestehen.

### A2 – Standardprofil entfernen

1. Der Benutzer entfernt die Standardprofilkennzeichnung.
2. Danach existiert kein Standardprofil.
3. Beim Start wird weiterhin zuerst das zuletzt verwendete Profil berücksichtigt.

## Fehlerfälle

### E1 – Profil ist archiviert

- Die Aktion wird nicht angeboten oder abgelehnt.
- Die Anwendung erklärt, dass archivierte Profile kein Standardprofil sein können.

### E2 – Speicherung fehlgeschlagen

- Der bisherige Standardprofilzustand bleibt erhalten.
- Die Anwendung zeigt eine verständliche Fehlermeldung.

## Nachbedingungen

- Höchstens ein nicht archiviertes Profil ist als Standardprofil definiert.

## Traceability

- PRO-FR-009
- PRO-BR-008
- PRO-TC-009

---

# PRO-UC-010 – Aktives Profil anzeigen

## Ziel

Der Benutzer erkennt jederzeit eindeutig, in welchem Profilkontext er arbeitet.

## Primärer Akteur

Benutzer

## Auslöser

Eine profilabhängige Seite wird geöffnet oder das aktive Profil ändert sich.

## Vorbedingungen

- Die Anwendung befindet sich im Normalbetrieb.
- Ein aktives Profil ist vorhanden.

## Hauptablauf

1. Die Anwendung liest den aktiven Profilzustand.
2. Name und Profilfarbe werden im vorgesehenen Profilbereich angezeigt.
3. Das Profil wird visuell als aktiv gekennzeichnet.
4. Die Profilauswahl ist erreichbar.
5. Profilabhängige Inhalte verwenden ausschließlich die aktive Profil-ID.
6. Bei einem Profilwechsel wird die Anzeige sofort aktualisiert.

## Alternativabläufe

### A1 – Profil ist geschützt, aber nicht entsperrt

1. Der Profilname kann gemäß Sicherheitskonzept eingeschränkt angezeigt werden.
2. Gesundheitsdaten bleiben verborgen.
3. Die Anwendung fordert zur Entsperrung auf.

### A2 – Kein aktives Profil

1. Profilabhängige Inhalte werden nicht angezeigt.
2. Die Anwendung öffnet die Profilauswahl oder den Einrichtungsmodus.

## Fehlerfälle

### E1 – Aktiver Profilzustand ist inkonsistent

- Die Anwendung entfernt den ungültigen aktiven Profilverweis.
- Es werden keine Gesundheitsdaten eines früheren Profils angezeigt.
- Ein gültiges Profil oder der Einrichtungsmodus wird gewählt.

## Nachbedingungen

- Der aktive Profilkontext ist für den Benutzer eindeutig erkennbar.
- Alle sichtbaren Gesundheitsdaten gehören zum aktiven Profil.

## Traceability

- PRO-FR-010
- PRO-BR-004
- PRO-BR-005
- PRO-TC-010

---

# Profilstammdaten

# PRO-UC-011 – Profilnamen verwalten

## Ziel

Der Benutzer legt den sichtbaren Namen eines Profils fest oder ändert ihn.

## Primärer Akteur

Benutzer

## Auslöser

Der Benutzer erstellt oder bearbeitet ein Profil.

## Vorbedingungen

- Das Profilformular ist geöffnet.
- Bei einer Bearbeitung existiert das Profil bereits.

## Hauptablauf

1. Der Benutzer gibt einen Profilnamen ein.
2. Die Anwendung entfernt führende und nachfolgende Leerzeichen.
3. Die Anwendung validiert Länge und zulässige Zeichen.
4. Die Anwendung prüft, ob der Name bereits verwendet wird.
5. Ist der Name nicht vorhanden, wird die Eingabe akzeptiert.
6. Der Name wird gemeinsam mit dem Profil gespeichert.

## Alternativabläufe

### A1 – Doppelter Profilname

1. Die Anwendung zeigt eine Warnung an.
2. Sie weist darauf hin, dass Profile über ihre ID unterschieden werden.
3. Der Benutzer kann:
   - den Namen ändern oder
   - die doppelte Verwendung bestätigen.
4. Nach Bestätigung wird der Name akzeptiert.

### A2 – Name unverändert

- Bei der Profilbearbeitung erfolgt keine erneute Duplikatwarnung für das eigene Profil.

## Fehlerfälle

### E1 – Name ist leer

- Die Anwendung zeigt eine Pflichtfeldmeldung.
- Das Speichern wird verhindert.

### E2 – Name ist ungültig

- Die Anwendung zeigt eine konkrete Korrekturmeldung.
- Die ungültige Eingabe wird nicht gespeichert.

## Nachbedingungen

- Das Profil besitzt einen validierten sichtbaren Namen.

## Traceability

- PRO-FR-011
- PRO-FR-021
- PRO-FR-022
- PRO-FR-023
- PRO-BR-010
- PRO-VR-001
- PRO-TC-011

---

# PRO-UC-012 – Geburtsjahr speichern

## Ziel

Der Benutzer hinterlegt das Geburtsjahr eines Profils.

## Primärer Akteur

Benutzer

## Auslöser

Der Benutzer erstellt oder bearbeitet ein Profil.

## Vorbedingungen

- Das Profilformular ist geöffnet.

## Hauptablauf

1. Der Benutzer gibt das Geburtsjahr ein.
2. Die Anwendung prüft, ob die Eingabe eine gültige vierstellige Jahreszahl ist.
3. Die Anwendung vergleicht das Jahr mit dem aktuellen Kalenderjahr.
4. Die Anwendung prüft die definierte fachliche Untergrenze.
5. Bei gültiger Eingabe wird das Geburtsjahr übernommen.
6. Das Geburtsjahr wird mit dem Profil gespeichert.

## Alternativabläufe

### A1 – Eingabe über Auswahlkomponente

1. Der Benutzer wählt das Jahr aus einer Liste oder einem Jahresselektor.
2. Die Anwendung übernimmt den ausgewählten Wert.
3. Die gleiche fachliche Validierung wird ausgeführt.

## Fehlerfälle

### E1 – Jahr liegt in der Zukunft

- Die Anwendung zeigt eine verständliche Fehlermeldung.
- Das Profil wird nicht gespeichert.

### E2 – Jahr unterschreitet die Untergrenze

- Die Anwendung weist auf den zulässigen Bereich hin.
- Die Eingabe muss korrigiert werden.

### E3 – Eingabe ist nicht numerisch

- Die Anwendung lehnt die Eingabe ab oder markiert das Feld als ungültig.

## Nachbedingungen

- Das Profil enthält ein fachlich gültiges Geburtsjahr.

## Traceability

- PRO-FR-012
- PRO-FR-021
- PRO-FR-022
- PRO-VR-002
- PRO-TC-012

---

# PRO-UC-013 – Körpergröße speichern

## Ziel

Der Benutzer speichert die Körpergröße eines Profils in Zentimetern.

## Primärer Akteur

Benutzer

## Auslöser

Der Benutzer erstellt oder bearbeitet ein Profil.

## Vorbedingungen

- Das Profilformular ist geöffnet.

## Hauptablauf

1. Der Benutzer gibt die Körpergröße ein.
2. Die Anwendung interpretiert die Eingabe in Zentimetern.
3. Die Anwendung prüft den Mindestwert von 20 cm.
4. Die Anwendung prüft den Höchstwert von 300 cm.
5. Die Anwendung prüft das Zahlenformat.
6. Bei gültiger Eingabe wird der Wert übernommen.
7. Die Körpergröße wird mit dem Profil gespeichert.

## Alternativabläufe

### A1 – Dezimalwert

1. Der Benutzer gibt einen Dezimalwert ein.
2. Die Anwendung normalisiert das lokale Dezimaltrennzeichen.
3. Der Wert wird mit der definierten Genauigkeit gespeichert.

### A2 – Eingabe in anderer Einheit

Sofern später unterstützt:

1. Der Benutzer gibt die Größe in einer alternativen Einheit ein.
2. Die Anwendung konvertiert den Wert in Zentimeter.
3. Gespeichert wird ausschließlich der normalisierte Zentimeterwert.

## Fehlerfälle

### E1 – Wert unter 20 cm

- Die Anwendung zeigt den zulässigen Mindestwert an.
- Das Speichern wird verhindert.

### E2 – Wert über 300 cm

- Die Anwendung zeigt den zulässigen Höchstwert an.
- Das Speichern wird verhindert.

### E3 – Kein gültiger Zahlenwert

- Das Feld wird als ungültig markiert.
- Eine verständliche Fehlermeldung wird angezeigt.

## Nachbedingungen

- Das Profil enthält eine validierte Körpergröße in Zentimetern.

## Traceability

- PRO-FR-013
- PRO-FR-021
- PRO-FR-022
- PRO-VR-003
- PRO-TC-013

---

# PRO-UC-014 – Geschlecht speichern

## Ziel

Der Benutzer hinterlegt optional eine Geschlechtsangabe.

## Primärer Akteur

Benutzer

## Auslöser

Der Benutzer erstellt oder bearbeitet ein Profil.

## Vorbedingungen

- Das Profilformular ist geöffnet.

## Hauptablauf

1. Die Anwendung zeigt die zentral definierten Auswahlwerte.
2. Der Benutzer wählt einen Wert.
3. Die Anwendung übernimmt die Auswahl.
4. Die Angabe wird mit dem Profil gespeichert.

## Alternativabläufe

### A1 – Keine Angabe

1. Der Benutzer wählt **„Keine Angabe“** oder lässt das Feld leer.
2. Das Profil wird ohne fachlich bestimmte Geschlechtsangabe gespeichert.

### A2 – Bestehende Angabe entfernen

1. Der Benutzer setzt das Feld auf **„Keine Angabe“**.
2. Die bisherige Angabe wird entfernt.

## Fehlerfälle

### E1 – Nicht unterstützter Wert

- Die Anwendung übernimmt den Wert nicht.
- Die gültige Auswahlliste wird erneut angezeigt.

## Nachbedingungen

- Das Profil enthält entweder einen unterstützten Wert oder keine Angabe.

## Traceability

- PRO-FR-014
- PRO-VR-004
- PRO-TC-014

---

# PRO-UC-015 – Profilbild verwalten

## Ziel

Der Benutzer fügt einem Profil ein lokales Profilbild hinzu, ändert es oder entfernt es.

## Primärer Akteur

Benutzer

## Auslöser

Der Benutzer wählt im Profilformular die Profilbildfunktion.

## Vorbedingungen

- Das Profilformular ist geöffnet.
- Die Anwendung besitzt die erforderliche Dateizugriffs- oder Medienberechtigung, sofern notwendig.

## Hauptablauf – Bild hinzufügen oder ändern

1. Der Benutzer wählt **„Profilbild auswählen“**.
2. Die Anwendung öffnet eine geeignete lokale Auswahlmöglichkeit.
3. Der Benutzer wählt eine Bilddatei.
4. Die Anwendung prüft Dateityp und Dateigröße.
5. Die Anwendung entfernt nicht benötigte Metadaten, insbesondere EXIF-Daten.
6. Die Anwendung skaliert und komprimiert das Bild gemäß den zentralen Vorgaben.
7. Die optimierte Bilddatei wird profilbezogen lokal gespeichert.
8. Eine Vorschau wird angezeigt.
9. Beim Speichern des Profils wird die Bildreferenz übernommen.

## Alternativabläufe

### A1 – Profilbild entfernen

1. Der Benutzer wählt **„Profilbild entfernen“**.
2. Die Anwendung zeigt eine Bestätigung an.
3. Nach Bestätigung wird die Bildreferenz entfernt.
4. Die lokale profilbezogene Bilddatei wird gelöscht.
5. Der Standardplatzhalter wird angezeigt.

### A2 – Vorgang abbrechen

- Das bisherige Profilbild bleibt unverändert.

## Fehlerfälle

### E1 – Nicht unterstütztes Format

- Die Anwendung lehnt die Datei ab.
- Sie zeigt die unterstützten Formate an.

### E2 – Datei kann nicht gelesen werden

- Das bestehende Bild bleibt unverändert.
- Die Anwendung zeigt eine verständliche Fehlermeldung.

### E3 – Bildoptimierung schlägt fehl

- Die Originaldatei wird nicht als Profilbild übernommen.
- Es werden keine unvollständigen temporären Dateien beibehalten.

## Nachbedingungen

- Das Profil besitzt ein optimiertes lokales Profilbild oder den Standardplatzhalter.
- Nicht benötigte Bildmetadaten wurden nicht übernommen.

## Traceability

- PRO-FR-015
- PRO-NFR-002
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-015

---

# PRO-UC-016 – Profilfarbe verwalten

## Ziel

Der Benutzer legt eine individuelle Akzentfarbe für ein Profil fest.

## Primärer Akteur

Benutzer

## Auslöser

Der Benutzer öffnet die Farbauswahl im Profilformular.

## Vorbedingungen

- Das Profilformular ist geöffnet.

## Hauptablauf

1. Die Anwendung zeigt die zulässigen Profilfarben.
2. Der Benutzer wählt eine Farbe.
3. Die Anwendung zeigt eine Vorschau.
4. Der Benutzer bestätigt die Profildaten.
5. Die Farbe wird mit dem Profil gespeichert.
6. Bei einem aktiven Profil wird die Profilkennzeichnung sofort aktualisiert.
7. Profilabhängige UI-Komponenten verwenden die neue Akzentfarbe.

## Alternativabläufe

### A1 – Benutzerdefinierte Farbe

Sofern unterstützt:

1. Der Benutzer öffnet einen Farbwähler.
2. Die Anwendung prüft die Farbe auf ausreichenden Kontrast.
3. Ungeeignete Farben werden abgelehnt oder angepasst.

### A2 – Standardfarbe verwenden

1. Der Benutzer setzt die Farbe auf den Standardwert zurück.
2. Die zentrale Standardprofilfarbe wird gespeichert.

## Fehlerfälle

### E1 – Farbe besitzt unzureichenden Kontrast

- Die Anwendung weist auf das Problem hin.
- Die Farbe wird nicht übernommen oder durch eine geeignete Variante ersetzt.

### E2 – Speicherung fehlgeschlagen

- Die bisherige Profilfarbe bleibt erhalten.
- Die Anwendung zeigt eine Fehlermeldung.

## Nachbedingungen

- Das Profil besitzt eine gültige, dauerhaft gespeicherte Akzentfarbe.
- Semantische Statusfarben bleiben unabhängig von der Profilfarbe.

## Traceability

- PRO-FR-016
- PRO-NFR-004
- PRO-NFR-005
- PRO-TC-016

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- PRO-UC-008 – Zuletzt verwendetes Profil automatisch öffnen
- PRO-UC-009 – Standardprofil festlegen
- PRO-UC-010 – Aktives Profil anzeigen
- PRO-UC-011 – Profilnamen verwalten
- PRO-UC-012 – Geburtsjahr speichern
- PRO-UC-013 – Körpergröße speichern
- PRO-UC-014 – Geschlecht speichern
- PRO-UC-015 – Profilbild verwalten
- PRO-UC-016 – Profilfarbe verwalten

---

# Folgende Teile

## Teil 3

- PRO-UC-017 bis PRO-UC-023
- Passwortschutz
- Entsperrung
- Passwortänderung
- Entfernen des Passwortschutzes
- Validierung
- Pflichtfelder
- doppelte Profilnamen

## Teil 4

- PRO-UC-024 bis PRO-UC-027
- Export
- Import
- Initialzustand
- Audit Trail
- Abhängigkeiten
- Risiken
- Freigabe
- Änderungsverlauf

# Profilschutz

## PRO-UC-017 – Profil mit Passwort schützen

### Ziel

Der Benutzer aktiviert einen optionalen Passwortschutz für ein Profil.

### Primärer Akteur

Benutzer

### Sekundärer Akteur

Security Service

### Auslöser

Der Benutzer aktiviert im Profilformular oder in den Profileinstellungen den Passwortschutz.

### Vorbedingungen

- Das Profil existiert oder wird gerade erstellt.
- Der Benutzer besitzt Zugriff auf das Profil.
- Der Security Service ist verfügbar.

### Eingaben

- neues Passwort
- Passwortbestätigung

### Hauptablauf

1. Der Benutzer aktiviert die Option **„Profil schützen“**.
2. Die Anwendung zeigt die Felder für Passwort und Passwortbestätigung an.
3. Der Benutzer gibt das Passwort zweimal ein.
4. Die Anwendung prüft, ob beide Eingaben übereinstimmen.
5. Der Security Service prüft das Passwort anhand der definierten Sicherheitsregeln.
6. Der Security Service erzeugt einen sicheren Passwort-Hash.
7. Das Klartextpasswort wird nicht dauerhaft gespeichert.
8. Der Passwort-Hash wird dem Profil zugeordnet.
9. Die Persistenz speichert den aktualisierten Schutzstatus.
10. Das Profil wird als geschützt gekennzeichnet.
11. Der Audit Service protokolliert `ProfileProtectionEnabled`.
12. Die Anwendung zeigt eine Erfolgsbestätigung.

### Alternativabläufe

#### A1 – Aktivierung bei Profilerstellung

1. Der Benutzer aktiviert den Schutz während PRO-UC-001.
2. Der Passwort-Hash wird gemeinsam mit dem Profil gespeichert.
3. Das neu erstellte Profil kann nach Abschluss der Erstellung als entsperrt gelten, bis die aktuelle Sitzung endet.

#### A2 – Benutzer bricht ab

1. Der Benutzer deaktiviert die Schutzoption oder verlässt den Vorgang.
2. Es wird kein Passwort-Hash gespeichert.
3. Der bisherige Schutzstatus bleibt unverändert.

### Fehlerfälle

#### E1 – Passwörter stimmen nicht überein

- Die Anwendung zeigt eine feldbezogene Fehlermeldung.
- Es wird kein Passwort-Hash erzeugt.
- Der Benutzer kann die Eingaben korrigieren.

#### E2 – Passwort erfüllt die Sicherheitsregeln nicht

- Die Anwendung zeigt die nicht erfüllten Anforderungen an.
- Der Schutz wird nicht aktiviert.

#### E3 – Hash-Erzeugung schlägt fehl

- Das Profil bleibt ungeschützt beziehungsweise behält seinen bisherigen Schutzstatus.
- Das Klartextpasswort wird verworfen.
- Die Anwendung zeigt eine verständliche Fehlermeldung.

#### E4 – Speicherung schlägt fehl

- Der neue Schutzstatus wird nicht übernommen.
- Der bisherige Zustand bleibt erhalten.
- Sensible Eingaben werden aus dem Speicher entfernt, sobald sie nicht mehr benötigt werden.

### Nachbedingungen

- Das Profil ist mit einem sicheren Passwort-Hash geschützt.
- Das Klartextpasswort ist nicht gespeichert.
- Der Schutzstatus ist dauerhaft gespeichert.

### Traceability

- PRO-FR-017
- PRO-FR-027
- PRO-BR-009
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-017

---

## PRO-UC-018 – Profil entsperren

### Ziel

Der Benutzer entsperrt ein geschütztes Profil, um auf dessen Daten zugreifen zu können.

### Primärer Akteur

Benutzer

### Sekundärer Akteur

Security Service

### Auslöser

Der Benutzer wählt ein geschütztes Profil oder die Anwendung versucht, ein geschütztes zuletzt verwendetes Profil zu öffnen.

### Vorbedingungen

- Das Profil existiert.
- Das Profil ist nicht archiviert.
- Der Passwortschutz ist aktiviert.
- Das Profil ist derzeit gesperrt.

### Eingaben

- Passwort

### Hauptablauf

1. Die Anwendung zeigt den Entsperrbildschirm.
2. Sensible Profildaten bleiben verborgen.
3. Der Benutzer gibt das Passwort ein.
4. Die Anwendung übergibt das Passwort sicher an den Security Service.
5. Der Security Service vergleicht das Passwort mit dem gespeicherten Passwort-Hash.
6. Die Prüfung ist erfolgreich.
7. Das Klartextpasswort wird aus dem Speicher entfernt.
8. Das Profil wird für die aktuelle Sitzung entsperrt.
9. Das Profil wird zum aktiven Profil.
10. Profilabhängige Daten werden geladen.
11. Die Anwendung zeigt das Dashboard des Profils.
12. Der Audit Service protokolliert `ProfileUnlocked`.

### Alternativabläufe

#### A1 – Vorgang abbrechen

1. Der Benutzer bricht die Entsperrung ab.
2. Das Profil bleibt gesperrt.
3. Das bisherige aktive Profil bleibt aktiv oder die Profilauswahl wird angezeigt.

#### A2 – Erneuter Versuch

1. Das eingegebene Passwort ist falsch.
2. Die Anwendung zeigt eine neutrale Fehlermeldung.
3. Der Benutzer kann einen weiteren Versuch durchführen.

#### A3 – Zukünftige biometrische Entsperrung

Sofern später unterstützt:

1. Der Benutzer wählt eine biometrische Entsperrmethode.
2. Das Betriebssystem führt die biometrische Prüfung durch.
3. HealthTracker speichert keine biometrischen Daten.
4. Nach erfolgreicher Betriebssystemprüfung wird das Profil entsperrt.

### Fehlerfälle

#### E1 – Falsches Passwort

- Das Profil bleibt gesperrt.
- Gesundheitsdaten bleiben verborgen.
- Das Passwort wird nicht protokolliert.
- Der Fehlversuch kann datensparsam als Sicherheitsereignis erfasst werden.

#### E2 – Profil wurde gelöscht oder archiviert

- Die Entsperrung wird abgebrochen.
- Die Profilliste wird aktualisiert.
- Die Anwendung zeigt eine verständliche Meldung.

#### E3 – Security Service nicht verfügbar

- Das Profil bleibt gesperrt.
- Es erfolgt kein unsicherer Fallback.
- Die Anwendung zeigt einen sicheren Fehlerzustand.

### Nachbedingungen

Bei Erfolg:

- das Profil ist für die aktuelle Sitzung entsperrt,
- das Profil ist aktiv,
- seine Daten können angezeigt und bearbeitet werden.

Bei Abbruch oder Fehler:

- das Profil bleibt gesperrt.

### Traceability

- PRO-FR-007
- PRO-FR-008
- PRO-FR-018
- PRO-BR-004
- PRO-BR-009
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-018

---

## PRO-UC-019 – Passwort ändern

### Ziel

Der Benutzer ersetzt das bestehende Passwort eines geschützten Profils durch ein neues Passwort.

### Primärer Akteur

Benutzer

### Sekundärer Akteur

Security Service

### Auslöser

Der Benutzer wählt in den Profileinstellungen **„Passwort ändern“**.

### Vorbedingungen

- Das Profil existiert.
- Das Profil ist geschützt.
- Der Benutzer besitzt Zugriff auf das Profil.
- Der bisherige Passwort-Hash ist verfügbar.

### Eingaben

- aktuelles Passwort
- neues Passwort
- Bestätigung des neuen Passworts

### Hauptablauf

1. Die Anwendung fordert das aktuelle Passwort an.
2. Der Benutzer gibt das aktuelle Passwort ein.
3. Der Security Service prüft das aktuelle Passwort.
4. Die Anwendung fordert das neue Passwort und dessen Bestätigung an.
5. Der Benutzer gibt beide Werte ein.
6. Die Anwendung prüft die Übereinstimmung.
7. Der Security Service validiert das neue Passwort.
8. Der Security Service erzeugt einen neuen Passwort-Hash.
9. Der bisherige Hash wird durch den neuen Hash ersetzt.
10. Die Persistenz speichert die Änderung.
11. Das alte Passwort verliert seine Gültigkeit.
12. Alle Klartextpasswörter werden aus dem Speicher entfernt.
13. Der Audit Service protokolliert `ProfilePasswordChanged`.
14. Die Anwendung zeigt eine Erfolgsbestätigung.

### Alternativabläufe

#### A1 – Benutzer bricht nach Prüfung des alten Passworts ab

1. Es wird kein neuer Hash erzeugt.
2. Der bisherige Passwortschutz bleibt unverändert.

#### A2 – Neues Passwort entspricht dem alten Passwort

1. Die Anwendung kann eine Warnung anzeigen.
2. Abhängig von der Sicherheitsregel wird die Änderung abgelehnt oder nach Bestätigung zugelassen.

### Fehlerfälle

#### E1 – Aktuelles Passwort ist falsch

- Die Änderung wird nicht fortgesetzt.
- Der bisherige Passwort-Hash bleibt unverändert.
- Die Anwendung zeigt eine neutrale Fehlermeldung.

#### E2 – Neue Passwörter stimmen nicht überein

- Es wird kein neuer Hash erzeugt.
- Die Anwendung markiert die betroffenen Felder.

#### E3 – Neues Passwort ist unzulässig

- Die Anwendung beschreibt die nicht erfüllten Sicherheitsregeln.
- Der bisherige Schutz bleibt bestehen.

#### E4 – Speicherung schlägt fehl

- Der bisherige Passwort-Hash bleibt gültig.
- Der neue Hash wird nicht als aktiv behandelt.
- Die Anwendung zeigt eine Fehlermeldung.

### Nachbedingungen

- Das Profil ist weiterhin geschützt.
- Nur das neue Passwort ist gültig.
- Der bisherige Passwort-Hash wurde sicher ersetzt.

### Traceability

- PRO-FR-019
- PRO-FR-027
- PRO-BR-009
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-019

---

## PRO-UC-020 – Passwortschutz entfernen

### Ziel

Der Benutzer entfernt den Passwortschutz eines Profils.

### Primärer Akteur

Benutzer

### Sekundärer Akteur

Security Service

### Auslöser

Der Benutzer deaktiviert in den Profileinstellungen den Passwortschutz.

### Vorbedingungen

- Das Profil existiert.
- Das Profil ist geschützt.
- Der Benutzer besitzt Zugriff auf das Profil.

### Eingaben

- aktuelles Passwort

### Hauptablauf

1. Die Anwendung zeigt eine Sicherheitsabfrage.
2. Der Benutzer bestätigt, dass der Schutz entfernt werden soll.
3. Die Anwendung fordert das aktuelle Passwort an.
4. Der Benutzer gibt das Passwort ein.
5. Der Security Service prüft das Passwort.
6. Die Prüfung ist erfolgreich.
7. Der gespeicherte Passwort-Hash wird entfernt.
8. Der Schutzstatus wird deaktiviert.
9. Die Persistenz speichert die Änderung.
10. Das Klartextpasswort wird verworfen.
11. Der Audit Service protokolliert `ProfileProtectionDisabled`.
12. Die Anwendung zeigt eine Erfolgsbestätigung.

### Alternativabläufe

#### A1 – Benutzer bricht ab

- Der Schutzstatus bleibt unverändert.
- Der Passwort-Hash bleibt gespeichert.

### Fehlerfälle

#### E1 – Falsches Passwort

- Der Passwortschutz bleibt aktiv.
- Der Hash wird nicht entfernt.
- Die Anwendung zeigt eine neutrale Fehlermeldung.

#### E2 – Speicherung schlägt fehl

- Der Passwortschutz bleibt aktiv.
- Der bisherige Hash bleibt gültig.
- Die Anwendung zeigt einen Fehlerzustand.

### Nachbedingungen

- Das Profil ist nicht mehr passwortgeschützt.
- Es ist kein Passwort-Hash für das Profil gespeichert.
- Das Profil kann ohne Passwort aktiviert werden.

### Traceability

- PRO-FR-020
- PRO-FR-027
- PRO-BR-009
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-020

---

# Datenqualität

## PRO-UC-021 – Profildaten validieren

### Ziel

Das System stellt sicher, dass ausschließlich fachlich gültige Profildaten gespeichert werden.

### Primärer Akteur

Anwendung

### Sekundärer Akteur

Benutzer

### Auslöser

Der Benutzer versucht, ein Profil anzulegen oder zu bearbeiten.

### Vorbedingungen

- Das Profilformular enthält Eingaben.
- Die zentralen Validation Rules sind verfügbar.

### Hauptablauf

1. Die Anwendung liest alle Profilfelder.
2. Die Anwendung normalisiert Eingaben, soweit zulässig.
3. Die Anwendung prüft die Pflichtfelder.
4. Die Anwendung prüft den Profilnamen.
5. Die Anwendung prüft das Geburtsjahr.
6. Die Anwendung prüft die Körpergröße.
7. Die Anwendung prüft optionale Werte.
8. Die Anwendung prüft gegebenenfalls den Passwortschutz.
9. Alle Prüfungen sind erfolgreich.
10. Die Anwendung gibt die Daten zur Speicherung frei.

### Validierungsbereiche

Mindestens geprüft werden:

- Profilname
- Geburtsjahr
- Körpergröße
- Profilfarbe
- Geschlechtsangabe
- Profilbildformat
- Passwort und Passwortbestätigung

### Alternativabläufe

#### A1 – Mehrere Fehler gleichzeitig

1. Die Anwendung sammelt alle bekannten Validierungsfehler.
2. Die Fehler werden den jeweiligen Feldern zugeordnet.
3. Der Fokus wird auf das erste ungültige Feld gesetzt.
4. Der Benutzer kann alle Fehler korrigieren.

#### A2 – Warnung statt Fehler

1. Die Anwendung erkennt einen doppelten Profilnamen.
2. Die Eingabe bleibt fachlich zulässig.
3. Die Anwendung zeigt eine Warnung.
4. Der Benutzer entscheidet über die Fortsetzung.

### Fehlerfälle

#### E1 – Zentrale Validierungsregel nicht verfügbar

- Die Daten werden nicht gespeichert.
- Die Anwendung verwendet keinen unsicheren oder inkonsistenten Fallback.
- Ein technischer Fehler wird ohne sensible Inhalte protokolliert.

#### E2 – Inkonsistente Validierung zwischen UI und Domain

- Die Domain-Validierung besitzt Vorrang.
- Ungültige Daten werden nicht persistiert.
- Die Abweichung wird als Fehler behandelt.

### Nachbedingungen

Bei erfolgreicher Validierung:

- die Profildaten sind zur Speicherung freigegeben.

Bei fehlgeschlagener Validierung:

- es wurden keine ungültigen Daten gespeichert,
- die Fehler sind verständlich dargestellt.

### Traceability

- PRO-FR-021
- PRO-FR-022
- PRO-FR-023
- PRO-VR-001 bis PRO-VR-006
- PRO-NFR-009
- PRO-TC-021

---

## PRO-UC-022 – Pflichtfelder prüfen

### Ziel

Die Anwendung verhindert das Speichern eines Profils, solange verpflichtende Angaben fehlen.

### Primärer Akteur

Anwendung

### Sekundärer Akteur

Benutzer

### Auslöser

Der Benutzer versucht, das Profilformular zu speichern.

### Vorbedingungen

- Das Profilformular ist geöffnet.

### Pflichtfelder

- Name
- Geburtsjahr
- Körpergröße
- Profilfarbe

### Hauptablauf

1. Die Anwendung prüft den Profilnamen.
2. Die Anwendung prüft das Geburtsjahr.
3. Die Anwendung prüft die Körpergröße.
4. Die Anwendung prüft die Profilfarbe.
5. Alle Pflichtfelder sind vorhanden.
6. Die weitere fachliche Validierung wird ausgeführt.
7. Das Speichern kann fortgesetzt werden.

### Alternativabläufe

#### A1 – Ein Pflichtfeld fehlt

1. Die Anwendung markiert das Feld.
2. Eine verständliche Pflichtfeldmeldung wird angezeigt.
3. Der Fokus wird auf das erste fehlende Feld gesetzt.
4. Das Speichern wird verhindert.

#### A2 – Mehrere Pflichtfelder fehlen

1. Alle fehlenden Felder werden markiert.
2. Der Fokus wird auf das erste fehlende Feld gesetzt.
3. Die übrigen Markierungen bleiben sichtbar.

### Fehlerfälle

#### E1 – Feld enthält nur Leerzeichen

- Das Feld gilt als leer.
- Die Anwendung entfernt führende und nachfolgende Leerzeichen.
- Das Speichern bleibt gesperrt.

#### E2 – Profilfarbe kann nicht bestimmt werden

- Das Feld gilt als nicht ausgefüllt.
- Eine Standardfarbe darf nur verwendet werden, wenn dies fachlich ausdrücklich vorgesehen ist.

### Nachbedingungen

- Alle Pflichtfelder sind vorhanden und können fachlich validiert werden,

oder:

- das Speichern wurde verhindert und die fehlenden Angaben sind sichtbar.

### Traceability

- PRO-FR-001
- PRO-FR-022
- PRO-VR-001
- PRO-VR-002
- PRO-VR-003
- PRO-VR-005
- PRO-TC-022

---

## PRO-UC-023 – Doppelte Profilnamen behandeln

### Ziel

Die Anwendung erkennt gleiche Profilnamen, ohne sie grundsätzlich zu verbieten.

### Primärer Akteur

Benutzer

### Auslöser

Der Benutzer speichert einen neuen oder geänderten Profilnamen.

### Vorbedingungen

- Mindestens ein weiteres Profil kann existieren.
- Der eingegebene Name hat die allgemeine Namensvalidierung bestanden.

### Hauptablauf

1. Die Anwendung normalisiert den eingegebenen Namen.
2. Die Anwendung vergleicht ihn mit den Namen vorhandener Profile.
3. Beim Bearbeiten wird das aktuelle Profil vom Vergleich ausgeschlossen.
4. Es existiert kein gleichlautender Name.
5. Das Speichern wird ohne Warnung fortgesetzt.

### Alternativabläufe

#### A1 – Doppelter Name erkannt

1. Die Anwendung zeigt eine Warnung.
2. Die Warnung erklärt, dass Profile weiterhin über ihre eindeutige ID unterschieden werden.
3. Der Benutzer kann:
   - den Namen ändern,
   - den Vorgang abbrechen oder
   - den doppelten Namen bestätigen.
4. Nach Bestätigung wird das Speichern fortgesetzt.

#### A2 – Unterschiede nur durch Groß-/Kleinschreibung

1. Die Anwendung behandelt die Namen gemäß zentraler Vergleichsregel.
2. Bei einem case-insensitiven Vergleich wird eine Warnung angezeigt.

#### A3 – Unterschiede nur durch Leerzeichen

1. Die Anwendung normalisiert führende, nachfolgende und gegebenenfalls mehrfache Leerzeichen.
2. Ergibt sich danach ein gleicher Name, wird eine Warnung angezeigt.

### Fehlerfälle

#### E1 – Profilbestand kann nicht geprüft werden

- Die Anwendung zeigt an, dass die Duplikatprüfung nicht möglich ist.
- Abhängig von der fachlichen Sicherheitsentscheidung wird das Speichern verhindert oder nach ausdrücklicher Bestätigung zugelassen.
- Die Eindeutigkeit der Profil-ID bleibt gewährleistet.

### Nachbedingungen

- Der Profilname ist gespeichert,

oder:

- der Benutzer hat die Eingabe geändert beziehungsweise den Vorgang abgebrochen.

Ein doppelter Name verändert niemals die eindeutige Profil-ID.

### Traceability

- PRO-FR-011
- PRO-FR-023
- PRO-BR-006
- PRO-BR-010
- PRO-VR-001
- PRO-TC-023

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- PRO-UC-017 – Profil mit Passwort schützen
- PRO-UC-018 – Profil entsperren
- PRO-UC-019 – Passwort ändern
- PRO-UC-020 – Passwortschutz entfernen
- PRO-UC-021 – Profildaten validieren
- PRO-UC-022 – Pflichtfelder prüfen
- PRO-UC-023 – Doppelte Profilnamen behandeln

---

# Teil 4

Der abschließende Teil enthält:

- PRO-UC-024 – Profil exportieren
- PRO-UC-025 – Profil importieren
- PRO-UC-026 – Anwendung in den Initialzustand zurücksetzen
- PRO-UC-027 – Profilereignisse protokollieren
- Use-Case-Beziehungen
- Abhängigkeiten
- Risiken
- Definition of Ready
- Definition of Done
- Referenzen
- Änderungsverlauf
- Freigabe

# Import und Export

---

## PRO-UC-024 – Profil exportieren

### Ziel

Der Benutzer exportiert ein vollständiges Profil einschließlich aller zugehörigen Daten.

### Primärer Akteur

Benutzer

### Sekundärer Akteur

Export Service

### Auslöser

Der Benutzer wählt **„Profil exportieren“**.

### Vorbedingungen

- Das Profil existiert.
- Das Profil ist vollständig geladen.
- Genügend Speicherplatz steht zur Verfügung.

### Hauptablauf

1. Der Benutzer startet den Export.
2. Die Anwendung ermittelt alle zum Profil gehörenden Daten.
3. Die Anwendung erstellt ein vollständiges Exportobjekt.
4. Versionsinformationen werden ergänzt.
5. Integritätsinformationen werden erzeugt.
6. Passwörter werden nicht exportiert.
7. Der Export wird gespeichert.
8. Der Benutzer erhält eine Erfolgsmeldung.
9. Der Audit Service protokolliert **ProfileExported**.

### Exportumfang

- Profil
- Stammdaten
- Gesundheitsdaten
- Dashboard-Konfiguration
- Einstellungen
- Verlauf

### Alternativabläufe

#### A1 – Export abbrechen

Der Benutzer bricht den Export ab.

Es wird keine Datei erzeugt.

### Fehlerfälle

#### E1 – Speicherfehler

Der Export wird verworfen.

Es entsteht keine unvollständige Datei.

#### E2 – Integritätsprüfung fehlgeschlagen

Der Export wird abgebrochen.

### Nachbedingungen

Ein vollständiges Exportpaket wurde erstellt.

### Traceability

- PRO-FR-024
- PRO-TC-024

---

# PRO-UC-025 – Profil importieren

### Ziel

Ein zuvor exportiertes Profil wird vollständig wiederhergestellt.

### Primärer Akteur

Benutzer

### Sekundärer Akteur

Import Service

### Auslöser

Der Benutzer wählt **„Profil importieren“**.

### Vorbedingungen

- Exportdatei vorhanden.
- Datei lesbar.

### Hauptablauf

1. Datei auswählen.
2. Format prüfen.
3. Versionsnummer prüfen.
4. Integrität prüfen.
5. ID-Konflikte behandeln.
6. Profil importieren.
7. Gesundheitsdaten importieren.
8. Dashboard importieren.
9. Einstellungen importieren.
10. Profil anzeigen.
11. Audit Service protokolliert **ProfileImported**.

### Alternativabläufe

#### A1 – Erstes Profil

Nach erfolgreichem Import verlässt die Anwendung automatisch den Einrichtungsmodus.

#### A2 – Profil bereits vorhanden

Die Anwendung fragt den Benutzer, ob

- überschrieben,
- zusammengeführt oder
- abgebrochen

werden soll.

### Fehlerfälle

#### E1 – Beschädigte Datei

Import wird abgebrochen.

#### E2 – Nicht unterstützte Version

Import wird verweigert.

### Nachbedingungen

Das importierte Profil steht vollständig zur Verfügung.

### Traceability

- PRO-FR-025
- PRO-TC-025

---

# Initialzustand

---

## PRO-UC-026 – Anwendung in Initialzustand zurücksetzen

### Ziel

Nach dem Löschen des letzten Profils befindet sich die Anwendung wieder im Auslieferungszustand.

### Primärer Akteur

Anwendung

### Auslöser

Das letzte Profil wurde gelöscht.

### Vorbedingungen

- Kein weiteres Profil vorhanden.

### Hauptablauf

1. Alle Profile entfernen.
2. Gesundheitsdaten entfernen.
3. Passwortinformationen entfernen.
4. Dashboard-Konfiguration entfernen.
5. Letztes Profil entfernen.
6. Standardprofil entfernen.
7. Profilcache leeren.
8. Auditdaten des Profils abschließen.
9. Einrichtungsmodus starten.
10. Begrüßungsbildschirm anzeigen.

### Erhalten bleiben

- Sprache
- Design
- Theme
- App-Einstellungen
- technische Konfiguration

### Alternativabläufe

Keine.

### Fehlerfälle

#### E1 – Reset unvollständig

Die Anwendung beendet den Reset nicht.

Es verbleiben keine inkonsistenten Daten.

### Nachbedingungen

Die Anwendung befindet sich im Initialzustand.

### Traceability

- PRO-FR-026
- PRO-BR-001
- PRO-BR-002
- PRO-BR-003
- PRO-TC-026

---

# Audit Trail

---

## PRO-UC-027 – Profilereignisse protokollieren

### Ziel

Wichtige Profilereignisse werden nachvollziehbar protokolliert.

### Primärer Akteur

Audit Service

### Auslöser

Profilereignis.

### Zu protokollierende Ereignisse

- Profil erstellt
- Profil bearbeitet
- Profil gelöscht
- Profil archiviert
- Profil wiederhergestellt
- Profil ausgewählt
- Passwort geändert
- Passwortschutz aktiviert
- Passwortschutz deaktiviert
- Profil exportiert
- Profil importiert

### Nicht protokolliert

- Passwörter
- Passwort-Hashes
- Gesundheitsdaten
- Freitexte
- personenbezogene Inhalte

### Hauptablauf

1. Ereignis empfangen.
2. Zeitstempel erzeugen.
3. Profil-ID speichern.
4. Ereignistyp speichern.
5. Auditdatensatz erzeugen.
6. Auditdatensatz dauerhaft speichern.

### Fehlerfälle

#### E1 – Audit-Service nicht verfügbar

Das eigentliche Fachereignis bleibt erfolgreich.

Der Auditfehler wird separat behandelt.

### Nachbedingungen

Das Ereignis wurde nachvollziehbar dokumentiert.

### Traceability

- PRO-FR-027
- PRO-NFR-010
- PRO-TC-027

---

# Beziehungen zwischen den Use Cases

```text
PRO-UC-001 ─────► PRO-UC-021
       │
       ├────────► PRO-UC-022
       ├────────► PRO-UC-023
       └────────► PRO-UC-017

PRO-UC-003 ─────► PRO-UC-021
       │
       ├────────► PRO-UC-022
       ├────────► PRO-UC-023
       └────────► PRO-UC-017

PRO-UC-007 ─────► PRO-UC-018

PRO-UC-004 ─────► PRO-UC-026

PRO-UC-024 ─────► PRO-UC-027

PRO-UC-025 ─────► PRO-UC-027

Alle fachlichen Änderungen
        │
        ▼
PRO-UC-027
```

---

# Abhängigkeiten

Das Profilmodul verwendet:

- Security Service
- Validation Service
- Persistenz
- Navigation
- Audit Service
- Import-/Export-Service

Das Profilmodul wird verwendet von:

- Dashboard
- Measurements
- Nutrition
- Medication
- Analysis
- Devices
- Backup
- Settings

---

# Risiken

| Risiko | Gegenmaßnahme |
|---------|---------------|
| Versehentliches Löschen | Sicherheitsabfrage |
| Datenverlust | Export und Backup |
| Ungültige Eingaben | Zentrale Validierung |
| Passwortverlust | Optionaler Passwortschutz |
| Fehlerhafter Import | Integritätsprüfung |
| Inkonsistente Daten | Business Rules und Transaktionen |

---

# Definition of Ready

Ein Use Case ist bereit zur Implementierung, wenn:

- Ziel definiert ist.
- Vorbedingungen bekannt sind.
- Hauptablauf beschrieben ist.
- Alternativabläufe dokumentiert sind.
- Fehlerfälle beschrieben sind.
- Nachbedingungen definiert sind.
- Traceability vollständig ist.

---

# Definition of Done

Ein Use Case gilt als umgesetzt, wenn:

- Implementierung abgeschlossen.
- Unit Tests erfolgreich.
- Widget Tests erfolgreich.
- Integration Tests erfolgreich.
- Review abgeschlossen.
- Dokumentation aktualisiert.
- Traceability vollständig.

---

# Referenzen

- 01_REQUIREMENTS.md
- TRACEABILITY_GUIDE.md
- ARCHITECTURE_GUIDE.md
- SECURITY_GUIDE.md
- TESTING_GUIDE.md
- UI_GUIDE.md
- REVIEW_GUIDE.md

---

# Änderungsverlauf

| Version | Datum | Änderung |
|----------|-------|-----------|
| 1.0.0 | 2026-08-01 | Erste Version |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument | 02_USE_CASES.md |
| Modul | Profile |
| Version | 1.0.0 |
| Status | Ready for Review |

---

# Dokumentstatus

**Datei:** `docs/modules/profile/02_USE_CASES.md`

## Inhalt

- ✅ 27 vollständig spezifizierte Use Cases
- ✅ Hauptabläufe
- ✅ Alternativabläufe
- ✅ Fehlerfälle
- ✅ Nachbedingungen
- ✅ Traceability
- ✅ Abhängigkeiten
- ✅ Zuständigkeiten
- ✅ Risiken
- ✅ Definition of Ready
- ✅ Definition of Done
- ✅ Review-Status

Dieses Dokument bildet die fachliche Grundlage für die weitere Spezifikation des Profilmoduls.