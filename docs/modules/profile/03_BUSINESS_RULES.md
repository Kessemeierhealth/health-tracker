# 03_BUSINESS_RULES.md

> Modul: Profile

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-PRO-BR-001 |
| Dokumenttyp | Modulspezifikation |
| Modul | Profile |
| Version | 1.0.0 |
| Status | Ready for Review |
| Owner | HealthTracker Team |
| Reviewer | HealthTracker Team |
| Letzte Änderung | 2026-08-01 |
| Reviewintervall | Bei jeder fachlichen Änderung |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|---------|-------|----------|-------|-------|
| 1.0.0 | 2026-08-01 | Erste Fassung erstellt | Zentrale Definition der Geschäftsregeln des Profilmoduls | HealthTracker Team |

---

# Zweck

Dieses Dokument definiert die verbindlichen Geschäftsregeln des Moduls **Profile**.

Die Business Rules beschreiben fachliche Bedingungen und Einschränkungen, die unabhängig von Benutzeroberfläche, Persistenztechnologie und Plattform gelten.

Sie bilden die Grundlage für:

- Functional Requirements
- Use Cases
- Validation Rules
- Domain-Modell
- Implementierung
- Testfälle
- Traceability

---

# Geltungsbereich

Die Regeln gelten für:

- Erstellung von Profilen
- Anzeige und Auswahl von Profilen
- Bearbeitung von Profilstammdaten
- Archivierung und Wiederherstellung
- endgültige Löschung
- Profilschutz
- Import und Export
- Initialzustand der Anwendung
- Audit Trail
- Zuordnung von Gesundheitsdaten

---

# Verbindlichkeit

Die Begriffe werden wie folgt verwendet:

| Begriff | Bedeutung |
|---------|-----------|
| MUSS | Verbindliche Anforderung |
| DARF NICHT | Verbindliches Verbot |
| SOLL | Empfohlene Regel, Abweichung muss begründet werden |
| KANN | Optionale Regel |

Eine Verletzung einer MUSS- oder DARF-NICHT-Regel verhindert die fachliche Freigabe.

---

# Regelstruktur

Jede Business Rule enthält:

- eindeutige ID
- Titel
- verbindliche Regel
- fachliche Begründung
- Auswirkungen
- Ausnahmen
- Traceability

---

# Profilbestand und Anwendungszustand

## PRO-BR-001 – Anzahl vorhandener Profile

### Regel

Eine Installation DARF null oder mehr Profile enthalten.

### Begründung

Die Anwendung muss sowohl den Erststart ohne Profile als auch den Betrieb mit mehreren Profilen unterstützen.

### Auswirkungen

- Ohne Profil befindet sich die Anwendung im Initialzustand.
- Mit mindestens einem verfügbaren Profil befindet sich die Anwendung im Normalbetrieb.
- Die Fachlogik darf keine feste Obergrenze für die Profilanzahl voraussetzen.

### Ausnahmen

Technische Plattformgrenzen dürfen dokumentiert werden, dürfen aber nicht als fachliche Obergrenze modelliert sein.

### Traceability

- PRO-FR-001
- PRO-FR-002
- PRO-FR-026
- PRO-UC-001
- PRO-UC-002
- PRO-UC-026
- PRO-TC-001
- PRO-TC-026

---

## PRO-BR-002 – Löschen des letzten Profils

### Regel

Das letzte vorhandene Profil DARF endgültig gelöscht werden.

Nach der erfolgreichen Löschung MUSS die Anwendung in den Initialzustand wechseln.

### Begründung

Der Benutzer muss sämtliche personenbezogenen Daten entfernen können, ohne die Anwendung neu installieren zu müssen.

### Auswirkungen

Nach der Löschung:

- existiert kein Profil,
- existiert kein aktives Profil,
- existiert kein zuletzt verwendetes Profil,
- existiert kein Standardprofil,
- werden keine Gesundheitsdaten angezeigt,
- wird der Einrichtungsmodus geöffnet.

### Ausnahmen

Globale Einstellungen ohne Personenbezug dürfen erhalten bleiben.

### Traceability

- PRO-FR-004
- PRO-FR-026
- PRO-UC-004
- PRO-UC-026
- PRO-TC-004
- PRO-TC-026

---

## PRO-BR-003 – Einrichtungsmodus ohne Profil

### Regel

Existiert kein verfügbares Profil, MUSS die Anwendung im Einrichtungsmodus starten.

### Mindestfunktionen

Der Einrichtungsmodus MUSS mindestens anbieten:

- erstes Profil erstellen,
- Profil oder Backup importieren,
- Hilfe anzeigen.

### Auswirkungen

Profilabhängige Navigation und Gesundheitsdatenfunktionen bleiben deaktiviert.

### Traceability

- PRO-FR-008
- PRO-FR-026
- PRO-UC-002
- PRO-UC-008
- PRO-UC-026
- PRO-TC-008
- PRO-TC-026

---

## PRO-BR-004 – Aktives Profil als Nutzungsvoraussetzung

### Regel

Ohne aktives und erforderlichenfalls entsperrtes Profil DÜRFEN keine profilbezogenen Gesundheitsdaten angezeigt, erfasst, verändert oder analysiert werden.

### Begründung

Alle Gesundheitsdaten müssen eindeutig einem Profilkontext zugeordnet sein.

### Auswirkungen

Ohne aktives Profil sind mindestens deaktiviert:

- Messwerterfassung
- Medikamentenverwaltung
- Ernährungserfassung
- Analysen
- Empfehlungen
- profilbezogenes Dashboard

### Traceability

- PRO-FR-007
- PRO-FR-010
- PRO-FR-018
- PRO-UC-007
- PRO-UC-010
- PRO-UC-018
- PRO-TC-007
- PRO-TC-010

---

# Datenzuordnung und Identität

## PRO-BR-005 – Eindeutige Profilzuordnung

### Regel

Jeder profilbezogene Gesundheitsdatensatz MUSS genau einem Profil zugeordnet sein.

### Begründung

Eine eindeutige Zuordnung verhindert die Vermischung personenbezogener Gesundheitsdaten.

### Auswirkungen

Jeder Datensatz enthält eine gültige Profilreferenz.

Beispiele:

- Messwerte
- Medikamente
- Ernährungseinträge
- Diagnosen
- Empfehlungen
- Dashboard-Konfigurationen

### Verboten

- Gesundheitsdatensätze ohne Profilreferenz
- Gesundheitsdatensätze mit mehreren Profilreferenzen
- Anzeige fremder Profildaten im aktiven Profil

### Traceability

- PRO-FR-004
- PRO-FR-007
- PRO-FR-010
- PRO-UC-004
- PRO-UC-007
- PRO-UC-010
- PRO-TC-004
- PRO-TC-007

---

## PRO-BR-006 – Unveränderliche Profil-ID

### Regel

Jedes Profil MUSS eine projektweit eindeutige ID besitzen.

Die Profil-ID DARF nach der Erstellung nicht verändert oder wiederverwendet werden.

### Begründung

Die ID ist die stabile Grundlage für Persistenz, Traceability und Datenzuordnung.

### Auswirkungen

- Profilnamen dürfen sich ändern.
- Profilfarben dürfen sich ändern.
- Archivierung verändert die ID nicht.
- Importierte Profile müssen bei ID-Konflikten sicher behandelt werden.
- Gelöschte IDs bleiben historisch reserviert, sofern dies technisch unterstützt wird.

### Traceability

- PRO-FR-001
- PRO-FR-003
- PRO-FR-006
- PRO-FR-025
- PRO-UC-001
- PRO-UC-003
- PRO-UC-006
- PRO-UC-025
- PRO-TC-001
- PRO-TC-025

---

## PRO-BR-007 – Änderungszeitpunkt

### Regel

Jede fachliche Änderung eines Profils MUSS den Änderungszeitpunkt aktualisieren.

### Fachliche Änderungen

Hierzu zählen insbesondere:

- Stammdatenänderung
- Änderung der Profilfarbe
- Änderung des Profilbilds
- Aktivierung oder Entfernung des Profilschutzes
- Passwortänderung
- Archivierung
- Wiederherstellung

### Keine fachlichen Änderungen

Reines Anzeigen oder Auswählen eines Profils verändert den Änderungszeitpunkt des Profils nicht.

### Traceability

- PRO-FR-003
- PRO-FR-019
- PRO-FR-020
- PRO-FR-027
- PRO-UC-003
- PRO-UC-019
- PRO-UC-020
- PRO-UC-027
- PRO-TC-003

---

# Archivierung

## PRO-BR-008 – Verhalten archivierter Profile

### Regel

Archivierte Profile DÜRFEN nicht in der Standardprofilauswahl erscheinen.

Sie MÜSSEN über eine getrennte Archivansicht zugänglich bleiben.

### Eigenschaften archivierter Profile

Ein archiviertes Profil:

- behält seine Profil-ID,
- behält seine Profildaten,
- behält seine Gesundheitsdaten,
- kann wiederhergestellt werden,
- kann endgültig gelöscht werden,
- kann nicht als Standardprofil verwendet werden,
- kann nicht ohne Wiederherstellung aktiviert werden.

### Traceability

- PRO-FR-002
- PRO-FR-005
- PRO-FR-006
- PRO-FR-009
- PRO-UC-002
- PRO-UC-005
- PRO-UC-006
- PRO-UC-009
- PRO-TC-005
- PRO-TC-006

---

## PRO-BR-009 – Archivierung des einzigen verfügbaren Profils

### Regel

Das einzige nicht archivierte Profil KANN archiviert werden, sofern der Benutzer die Folgen ausdrücklich bestätigt.

### Auswirkungen

Nach der Archivierung:

- existiert kein aktives Profil,
- die Anwendung wechselt in den Einrichtungsmodus,
- das archivierte Profil und seine Daten bleiben erhalten,
- die Anwendung befindet sich nicht im vollständigen Auslieferungszustand.

### Abgrenzung

Archivierung ist keine Löschung.

Der Einrichtungsmodus muss in diesem Fall zusätzlich auf vorhandene archivierte Profile hinweisen.

### Traceability

- PRO-FR-005
- PRO-UC-005
- PRO-TC-005

---

# Profilauswahl

## PRO-BR-010 – Auswahl des aktiven Profils

### Regel

Zu einem Zeitpunkt DARF höchstens ein Profil aktiv sein.

### Auswirkungen

Bei einem Profilwechsel:

- wird der bisherige Profilkontext beendet,
- wird der neue Profilkontext geladen,
- werden profilabhängige Zustände aktualisiert,
- wird die neue Profil-ID als zuletzt verwendet gespeichert.

### Sicherheitsbedingung

Ein geschütztes Profil darf erst nach erfolgreicher Entsperrung aktiviert werden.

### Traceability

- PRO-FR-007
- PRO-FR-008
- PRO-FR-010
- PRO-FR-018
- PRO-UC-007
- PRO-UC-008
- PRO-UC-010
- PRO-UC-018
- PRO-TC-007

---

## PRO-BR-011 – Ermittlung des Startprofils

### Regel

Beim Anwendungsstart MUSS das Startprofil in folgender Reihenfolge ermittelt werden:

1. gültiges zuletzt verwendetes Profil,
2. gültiges Standardprofil,
3. anderes verfügbares nicht archiviertes Profil,
4. Profilauswahl oder Einrichtungsmodus.

### Sicherheitsbedingung

Ein geschütztes Startprofil bleibt gesperrt, bis die Authentifizierung erfolgreich abgeschlossen wurde.

### Ungültige Verweise

Verweise auf gelöschte oder archivierte Profile müssen bereinigt werden.

### Traceability

- PRO-FR-008
- PRO-FR-009
- PRO-UC-008
- PRO-UC-009
- PRO-TC-008
- PRO-TC-009

---

## PRO-BR-012 – Standardprofil

### Regel

Es DARF höchstens ein Standardprofil existieren.

### Bedingungen

Ein Standardprofil MUSS:

- existieren,
- nicht archiviert sein,
- dauerhaft gespeichert sein.

Ein geschütztes Profil darf Standardprofil sein, muss aber vor der Nutzung entsperrt werden.

### Traceability

- PRO-FR-009
- PRO-UC-009
- PRO-TC-009

---

# Profilstammdaten

## PRO-BR-013 – Pflichtangaben eines Profils

### Regel

Ein speicherbares Profil MUSS mindestens folgende Angaben enthalten:

- Profilname
- Geburtsjahr
- Körpergröße
- Profilfarbe

### Auswirkungen

Fehlt mindestens eine Pflichtangabe, darf das Profil nicht gespeichert werden.

### Traceability

- PRO-FR-001
- PRO-FR-011
- PRO-FR-012
- PRO-FR-013
- PRO-FR-016
- PRO-FR-022
- PRO-UC-001
- PRO-UC-022
- PRO-TC-022

---

## PRO-BR-014 – Eindeutigkeit von Profilnamen

### Regel

Profilnamen MÜSSEN nicht eindeutig sein.

### Verhalten

Bei einem bereits vorhandenen normalisierten Namen MUSS die Anwendung warnen.

Der Benutzer KANN den gleichen Namen nach ausdrücklicher Bestätigung speichern.

### Eindeutigkeit

Die Identität eines Profils wird ausschließlich durch die Profil-ID bestimmt.

### Traceability

- PRO-FR-011
- PRO-FR-023
- PRO-UC-011
- PRO-UC-023
- PRO-TC-011
- PRO-TC-023

---

## PRO-BR-015 – Optionale Profildaten

### Regel

Folgende Profildaten KÖNNEN optional sein:

- Geschlecht
- Profilbild
- Profilschutz

Das Fehlen optionaler Daten darf die Nutzung des Profils nicht verhindern.

### Darstellung

Fehlende optionale Daten müssen eindeutig und neutral dargestellt werden.

Beispiel:

- Profilbild fehlt → Standardplatzhalter
- Geschlecht fehlt → „Keine Angabe“

### Traceability

- PRO-FR-014
- PRO-FR-015
- PRO-FR-017
- PRO-UC-014
- PRO-UC-015
- PRO-UC-017
- PRO-TC-014
- PRO-TC-015

---

## PRO-BR-016 – Profilfarbe und Statusfarben

### Regel

Die Profilfarbe dient ausschließlich der visuellen Zuordnung des Profils.

Sie DARF semantische Statusfarben nicht ersetzen oder verändern.

### Semantische Farben

Hierzu zählen insbesondere:

- Erfolg
- Warnung
- Fehler
- Information
- medizinische Statusdarstellungen

### Barrierefreiheit

Profilunterscheidungen dürfen nicht ausschließlich über Farbe erfolgen.

### Traceability

- PRO-FR-016
- PRO-UC-016
- PRO-NFR-004
- PRO-NFR-005
- PRO-TC-016

---

## PRO-BR-017 – Lokale Verarbeitung des Profilbilds

### Regel

Ein Profilbild MUSS lokal und profilbezogen gespeichert werden.

### Datenschutzregeln

Vor der Speicherung SOLL das Bild:

- auf die definierte Maximalgröße skaliert,
- komprimiert,
- von nicht benötigten Metadaten bereinigt werden.

EXIF-Metadaten, insbesondere Standortinformationen, DÜRFEN nicht übernommen werden.

### Löschung

Wird ein Profilbild entfernt oder das Profil gelöscht, MUSS die zugehörige lokale Datei gelöscht werden.

### Traceability

- PRO-FR-015
- PRO-UC-015
- PRO-NFR-002
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-015

---

# Profilschutz

## PRO-BR-018 – Optionaler Profilschutz

### Regel

Der Passwortschutz KANN für jedes Profil unabhängig aktiviert oder deaktiviert werden.

### Auswirkungen

- Ungeschützte Profile können ohne zusätzliche Authentifizierung geöffnet werden.
- Geschützte Profile müssen vor der Aktivierung entsperrt werden.
- Der Schutz eines Profils beeinflusst andere Profile nicht.

### Traceability

- PRO-FR-017
- PRO-FR-018
- PRO-FR-020
- PRO-UC-017
- PRO-UC-018
- PRO-UC-020
- PRO-TC-017
- PRO-TC-018

---

## PRO-BR-019 – Speicherung von Passwörtern

### Regel

Passwörter DÜRFEN niemals im Klartext gespeichert oder protokolliert werden.

Gespeichert werden darf ausschließlich ein sicher erzeugter Passwort-Hash einschließlich erforderlicher kryptographischer Parameter.

### Verboten

- Klartextpasswort in Datenbank
- Klartextpasswort in Shared Preferences
- Passwort im Log
- Passwort im Audit Trail
- Passwort im Export
- selbst entwickelte Hash-Verfahren

### Traceability

- PRO-FR-017
- PRO-FR-019
- PRO-FR-020
- PRO-FR-024
- PRO-FR-027
- PRO-UC-017
- PRO-UC-019
- PRO-UC-020
- PRO-UC-024
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-017
- PRO-TC-019

---

## PRO-BR-020 – Gültigkeit von Profilsitzungen

### Regel

Die Entsperrung eines geschützten Profils gilt nur für die definierte lokale Sitzung.

### Eine Sitzung endet mindestens bei:

- expliziter Profilsperrung,
- Abmeldung,
- Beendigung der Anwendung, sofern so konfiguriert,
- Gerätesperre, sofern technisch unterstützt,
- Ablauf einer konfigurierten Inaktivitätszeit.

### Auswirkungen

Nach Sitzungsende muss das Profil erneut entsperrt werden.

### Traceability

- PRO-FR-018
- PRO-UC-018
- PRO-NFR-007
- PRO-TC-018

---

# Import und Export

## PRO-BR-021 – Exportinhalt

### Regel

Ein Profilexport MUSS eindeutig angeben:

- Exportformat
- Exportversion
- Exportzeitpunkt
- Profil-ID
- enthaltene Datenbereiche

### Verboten

Ein Export DARF niemals enthalten:

- Klartextpasswörter
- Passwort-Hashes
- kryptographische Schlüssel
- temporäre Dateien
- nicht ausgewählte fremde Profildaten

### Traceability

- PRO-FR-024
- PRO-UC-024
- PRO-NFR-007
- PRO-NFR-008
- PRO-TC-024

---

## PRO-BR-022 – Importvalidierung

### Regel

Importierte Daten gelten grundsätzlich als nicht vertrauenswürdig und MÜSSEN vor der Übernahme vollständig validiert werden.

### Mindestprüfungen

- Format
- Version
- Integrität
- Pflichtfelder
- Wertebereiche
- Profil-ID
- Datenzuordnungen

### Auswirkungen

Ein unvollständig validierter Import darf nicht persistiert werden.

### Traceability

- PRO-FR-025
- PRO-FR-021
- PRO-UC-025
- PRO-UC-021
- PRO-TC-025

---

## PRO-BR-023 – Behandlung von Profil-ID-Konflikten

### Regel

Ein Import mit bereits vorhandener Profil-ID MUSS kontrolliert behandelt werden.

### Zulässige Strategien

Je nach Importkonzept:

- Import abbrechen
- neue Profil-ID erzeugen
- bestehendes Profil nach ausdrücklicher Bestätigung ersetzen

Eine automatische Zusammenführung darf nur erfolgen, wenn dafür eine dokumentierte fachliche Regel existiert.

### Sicherheitsanforderung

Andere Profile dürfen durch den Konflikt nicht verändert werden.

### Traceability

- PRO-FR-025
- PRO-UC-025
- PRO-BR-006
- PRO-TC-025

---

# Audit Trail

## PRO-BR-024 – Protokollierung von Profilereignissen

### Regel

Sicherheits- und verwaltungsrelevante Profilereignisse SOLLEN in einem datensparsamen Audit Trail protokolliert werden.

### Mindestinformationen

Ein Audit-Eintrag enthält:

- Zeitstempel
- Ereignistyp
- Profil-ID, sofern nach der Löschung zulässig
- Ergebnis
- technische Version

### Nicht zulässige Inhalte

- Passwort
- Passwort-Hash
- Gesundheitswerte
- Profilname
- Freitexte
- Profilbild
- sonstige personenbezogene Inhalte

### Traceability

- PRO-FR-027
- PRO-UC-027
- PRO-NFR-008
- PRO-NFR-010
- PRO-TC-027

---

## PRO-BR-025 – Auditfehler und Fachoperation

### Regel

Ein nicht verfügbarer Audit Service darf eine fachlich erfolgreiche Operation grundsätzlich nicht nachträglich ungültig machen.

### Bedingungen

- Der Auditfehler muss separat behandelt werden.
- Sicherheitskritische Vorgänge können strengere Regeln definieren.
- Es dürfen keine sensiblen Ersatzlogs erzeugt werden.

### Beispiele

Ein erfolgreich gespeichertes Profil bleibt gespeichert, auch wenn der Audit-Eintrag nicht geschrieben werden konnte.

### Traceability

- PRO-FR-027
- PRO-UC-027
- PRO-NFR-010
- PRO-TC-027

---

# Löschung und Datenbereinigung

## PRO-BR-026 – Vollständigkeit der Profillöschung

### Regel

Eine endgültige Profillöschung MUSS alle eindeutig dem Profil zugeordneten personenbezogenen Daten entfernen.

### Zu löschen sind mindestens:

- Profilstammdaten
- Gesundheitsdaten
- Profilschutzdaten
- profilbezogene Einstellungen
- Dashboard-Konfiguration
- Profilbild
- Cache-Daten
- temporäre Dateien
- Verweise auf aktives, letztes oder Standardprofil

### Integritätsregel

Eine teilweise Löschung darf nicht als erfolgreich gemeldet werden.

### Traceability

- PRO-FR-004
- PRO-FR-026
- PRO-UC-004
- PRO-UC-026
- PRO-TC-004
- PRO-TC-026

---

## PRO-BR-027 – Erhaltene globale Einstellungen

### Regel

Beim Übergang in den Initialzustand KÖNNEN globale, nicht personenbezogene Einstellungen erhalten bleiben.

### Beispiele

- Sprache
- Theme
- Hell-/Dunkelmodus
- technische Darstellungsoptionen
- App-Version
- nicht personenbezogene Zugänglichkeitseinstellungen

### Nicht erhalten bleiben dürfen:

- aktive Profil-ID
- letzte Profil-ID
- Standardprofil-ID
- profilbezogene Dashboard-Layouts
- Profilpasswörter
- personenbezogene Einstellungen

### Traceability

- PRO-FR-026
- PRO-UC-026
- PRO-TC-026

---

# PRO-BR-028

## Titel

Passwortschutz verwalten

### Zweck

Diese Business Rule beschreibt die fachlichen Regeln für das Aktivieren und
Deaktivieren des Passwortschutzes eines Profils.

Die Regel beschreibt ausschließlich das fachliche Verhalten.

Authentifizierung, Kryptographie, Hashverfahren und technische
Credential-Erzeugung sind nicht Bestandteil dieser Regel.

---

## Geltungsbereich

Diese Regel gilt für

- `Profile.enablePasswordProtection(...)`
- `Profile.disablePasswordProtection(...)`

sowie die zugehörige `ProfileSecurity`-Entity.

---

## Aktivieren des Passwortschutzes

### Voraussetzungen

- Das Profil besitzt einen gültigen Sicherheitszustand.
- Ein gültiges `PasswordCredential` liegt vor.

### Erfolgsfall

Ist aktuell kein Passwortschutz aktiviert,

dann gilt:

- das Credential wird übernommen,
- der Passwortschutz ist anschließend aktiviert,
- der bestehende Sperrzustand bleibt erhalten,
- die `ProfileSecurityId` bleibt unverändert.

---

## Bereits aktivierter Passwortschutz

Besitzt das Profil bereits ein Credential,

ist ein erneutes Aktivieren fachlich unzulässig.

Es entsteht ein Business Error.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Deaktivieren des Passwortschutzes

### Erfolgsfall

Besitzt das Profil ein Credential,

dann gilt:

- das Credential wird entfernt,
- der Passwortschutz ist anschließend deaktiviert,
- das Profil befindet sich anschließend im entsperrten Zustand,
- die `ProfileSecurityId` bleibt unverändert.

---

## Bereits deaktivierter Passwortschutz

Besitzt das Profil bereits kein Credential,

liegt kein fachlicher Fehler vor.

Die Operation liefert einen erfolgreichen No-Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Allgemeine Regeln

Für beide Operationen gilt:

- Fehlgeschlagene Operationen verändern den bestehenden Zustand nicht.
- Erfolgreiche Änderungen erzeugen einen vollständigen konsistenten
  Sicherheitszustand.
- No-Change ist kein Fehler.
- Validation Errors werden nicht durch diese Regel erzeugt.
- AuthenticationProof wird durch die dafür zuständigen Regeln behandelt.
- `ProfileSecurity` erzeugt keine Domain Events.

---

## Traceability

### Domain Model

- `Profile.enablePasswordProtection(...)`
- `Profile.disablePasswordProtection(...)`
- `ProfileSecurity`
- `PasswordCredential`

### Validation Rules

- PRO-VR-024

### Requirements

- PRO-FR-013

### Invarianten

- AG-INV-012

---

# PRO-BR-029

## Titel

Profil sperren

### Zweck

Diese Business Rule beschreibt das fachliche Sperren eines Profils.

Sie regelt ausschließlich die Änderung des fachlichen Sperrzustands.

Authentifizierung, Passwortprüfung, Kryptographie und technische
Sicherheitsmechanismen sind nicht Bestandteil dieser Regel.

---

## Geltungsbereich

Diese Regel gilt für

- `Profile.lock(...)`

sowie die zugehörige `ProfileSecurity`-Entity.

---

## Voraussetzungen

Für das Sperren gilt:

- das Profil besitzt einen gültigen Sicherheitszustand,
- ein gültiges `PasswordCredential` ist vorhanden,
- ein gültiger Zeitstempel liegt vor.

---

## Erfolgsfall

Ist das Profil aktuell entsperrt,

dann gilt:

- der Sperrzustand wird auf „gesperrt" gesetzt,
- der Sperrzeitpunkt wird übernommen,
- das vorhandene Credential bleibt unverändert,
- die `ProfileSecurityId` bleibt unverändert.

---

## Bereits gesperrtes Profil

Ist das Profil bereits gesperrt,

liegt kein fachlicher Fehler vor.

Die Operation liefert einen erfolgreichen No-Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Sperren ohne Passwortschutz

Besitzt das Profil kein `PasswordCredential`,

ist das Sperren fachlich unzulässig.

Die Operation liefert einen Business Error.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Allgemeine Regeln

Für die Sperroperation gilt:

- Fehlgeschlagene Operationen verändern den bestehenden Zustand nicht.
- Erfolgreiche Änderungen erzeugen einen vollständigen konsistenten
  Sicherheitszustand.
- No-Change ist kein Fehler.
- Validation Errors werden nicht durch diese Regel erzeugt.
- `ProfileSecurity` erzeugt keine Domain Events.

Die Erzeugung fachlicher Domain Events erfolgt ausschließlich durch das
Aggregate Root.

---

## Traceability

### Domain Model

- `Profile.lock(...)`
- `ProfileSecurity.lock(...)`
- `ProfileSecurity`
- `LockState`

### Validation Rules

- PRO-VR-024

### Requirements

- PRO-FR-013

### Invarianten

- AG-INV-012

---

# PRO-BR-030

## Titel

Profil entsperren

### Zweck

Diese Business Rule beschreibt das fachliche Entsperren eines Profils.

Sie regelt ausschließlich die Änderung des fachlichen Sperrzustands.

Authentifizierung, Passwortprüfung, Kryptographie, technische
Credential-Verifikation sowie die Prüfung eines `AuthenticationProof`
sind nicht Bestandteil dieser Regel.

---

## Geltungsbereich

Diese Regel gilt für

- `Profile.unlock(...)`

sowie die zugehörige `ProfileSecurity`-Entity.

---

## Voraussetzungen

Für das Entsperren gilt:

- das Profil besitzt einen gültigen Sicherheitszustand,
- ein gültiger Zeitstempel liegt vor,
- die Prüfung eines `AuthenticationProof` erfolgt außerhalb dieser
  Business Rule.

---

## Erfolgsfall

Ist das Profil aktuell gesperrt,

dann gilt:

- der Sperrzustand wird aufgehoben,
- der Entsperrzeitpunkt wird übernommen,
- das vorhandene `PasswordCredential` bleibt unverändert,
- die `ProfileSecurityId` bleibt unverändert.

---

## Bereits entsperrtes Profil

Ist das Profil bereits entsperrt,

liegt kein fachlicher Fehler vor.

Die Operation liefert einen erfolgreichen No-Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Entsperren ohne Passwortschutz

Besitzt das Profil kein `PasswordCredential`,

liegt kein fachlicher Fehler vor.

Die Operation liefert einen erfolgreichen No-Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Allgemeine Regeln

Für die Entsperroperation gilt:

- Fehlgeschlagene Operationen verändern den bestehenden Zustand nicht.
- Erfolgreiche Änderungen erzeugen einen vollständigen konsistenten
  Sicherheitszustand.
- No-Change ist kein Fehler.
- Validation Errors werden nicht durch diese Regel erzeugt.
- `ProfileSecurity` erzeugt keine Domain Events.

Die Erzeugung fachlicher Domain Events erfolgt ausschließlich durch das
Aggregate Root.

---

## Abgrenzung

Nicht Bestandteil dieser Regel sind:

- Prüfung des `AuthenticationProof`,
- Authentifizierung,
- Passwortverifikation,
- Kryptographie,
- technische Sicherheitsports,
- Application Services.

Diese Verantwortlichkeiten sind im Domain Model separat beschrieben.

---

## Traceability

### Domain Model

- `Profile.unlock(...)`
- `ProfileSecurity.unlock(...)`
- `ProfileSecurity`
- `LockState`
- `AuthenticationProof`

### Validation Rules

- PRO-VR-024

### Requirements

- PRO-FR-013

### Invarianten

- AG-INV-012

---

# PRO-BR-031

## Titel

Passwort ändern

### Zweck

Diese Business Rule beschreibt das fachliche Ändern eines
Profilpasswortes.

Sie regelt ausschließlich den Austausch eines vorhandenen
`PasswordCredential`.

Die technische Erzeugung eines Credentials, Kryptographie,
Hashverfahren, Passwortprüfung und die Prüfung eines
`AuthenticationProof` sind nicht Bestandteil dieser Regel.

---

## Geltungsbereich

Diese Regel gilt für

- `Profile.changePasswordCredential(...)`

sowie die zugehörige `ProfileSecurity`-Entity.

---

## Voraussetzungen

Für das Ändern eines Passwortes gilt:

- das Profil besitzt einen gültigen Sicherheitszustand,
- ein gültiges `PasswordCredential` ist bereits vorhanden,
- ein neues gültiges `PasswordCredential` liegt vor,
- die Prüfung eines `AuthenticationProof` erfolgt außerhalb dieser
  Business Rule.

---

## Erfolgsfall

Besitzt das Profil bereits ein Credential,

und unterscheidet sich das neue Credential fachlich,

dann gilt:

- das bisherige Credential wird vollständig ersetzt,
- der Passwortschutz bleibt aktiviert,
- der Sperrzustand bleibt unverändert,
- die `ProfileSecurityId` bleibt unverändert.

---

## Passwortschutz nicht aktiviert

Besitzt das Profil kein `PasswordCredential`,

ist ein Passwortwechsel fachlich unzulässig.

Die Operation liefert einen Business Error.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Unverändertes Credential

Entspricht das neue Credential fachlich bereits dem vorhandenen
Credential,

liegt kein fachlicher Fehler vor.

Die Operation liefert einen erfolgreichen No-Change.

Der bestehende Zustand bleibt vollständig unverändert.

---

## Allgemeine Regeln

Für den Passwortwechsel gilt:

- Fehlgeschlagene Operationen verändern den bestehenden Zustand nicht.
- Erfolgreiche Änderungen erzeugen einen vollständigen konsistenten
  Sicherheitszustand.
- Das Credential wird vollständig ersetzt.
- No-Change ist kein Fehler.
- Validation Errors werden nicht durch diese Regel erzeugt.
- `ProfileSecurity` erzeugt keine Domain Events.

Die Erzeugung fachlicher Domain Events erfolgt ausschließlich durch das
Aggregate Root.

---

## Abgrenzung

Nicht Bestandteil dieser Regel sind:

- Passwortstärke,
- Passwortkomplexität,
- Klartextpasswörter,
- Kryptographie,
- Hashverfahren,
- technische Credential-Erzeugung,
- Passwortverifikation,
- AuthenticationProof,
- technische Security-Ports,
- Application Services.

Diese Verantwortlichkeiten werden an anderer Stelle des Domain Models
beschrieben.

---

## Traceability

### Domain Model

- `Profile.changePasswordCredential(...)`
- `ProfileSecurity.changePasswordCredential(...)`
- `ProfileSecurity`
- `PasswordCredential`
- `AuthenticationProof`

### Validation Rules

- PRO-VR-024

### Requirements

- PRO-FR-013

### Invarianten

- AG-INV-012

---

# Regelabhängigkeiten

```text
PRO-BR-001
   │
   ├── PRO-BR-002
   └── PRO-BR-003

PRO-BR-004
   │
   ├── PRO-BR-005
   ├── PRO-BR-010
   └── PRO-BR-020

PRO-BR-006
   │
   ├── PRO-BR-014
   └── PRO-BR-023

PRO-BR-008
   │
   ├── PRO-BR-009
   ├── PRO-BR-011
   └── PRO-BR-012

PRO-BR-018
   │
   ├── PRO-BR-019
   └── PRO-BR-020

PRO-BR-021
   │
   ├── PRO-BR-022
   └── PRO-BR-023

PRO-BR-026
   │
   └── PRO-BR-027