# SECURITY_GUIDE.md

> HealthTracker Security Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-SEC-001 |
| Dokumenttyp | Projektstandard |
| Kategorie | Informationssicherheit |
| Version | 1.0.0 |
| Status | In Bearbeitung |
| Owner | HealthTracker Team |
| Reviewer | HealthTracker Team |
| Freigegeben | — |
| Letzte Änderung | 2026-07-31 |
| Reviewintervall | Vor jedem Major Release |

---

# Dokumenthistorie

| Version | Datum | Änderung | Grund | Autor |
|---------|-------|----------|-------|-------|
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Einführung eines projektweiten Sicherheitsstandards | HealthTracker Team |

---

# Dokumentqualität

| Kriterium | Status |
|-----------|:------:|
| Vollständigkeit | ⏳ |
| Konsistenz | ✅ |
| Verständlichkeit | ✅ |
| Beispiele | ✅ |
| Review | ⏳ |
| Freigabe | ⏳ |

**Qualitätsindex:** 30 %

Der Qualitätsindex wird nach Abschluss aller vier Teile auf mindestens **95 %** angehoben.

---

# Zweck

Dieses Dokument definiert den verbindlichen Sicherheitsstandard für das HealthTracker-Projekt.

Der Standard beschreibt alle organisatorischen und technischen Maßnahmen zum Schutz von

- Gesundheitsdaten,
- personenbezogenen Daten,
- Benutzerprofilen,
- Backups,
- Systemkomponenten
- und Kommunikationsschnittstellen.

Ziel ist ein hohes Sicherheitsniveau über den gesamten Lebenszyklus der Anwendung.

---

# Ziele

Die Sicherheitsstrategie verfolgt folgende Ziele:

- Vertraulichkeit personenbezogener Daten sicherstellen
- Integrität aller gespeicherten Informationen gewährleisten
- Verfügbarkeit der Anwendung erhalten
- Datenschutz gemäß DSGVO unterstützen
- Missbrauch verhindern
- Sicherheitsrisiken minimieren
- Sichere Erweiterbarkeit ermöglichen
- Sicherheitsbewusstsein im gesamten Projekt fördern

---

# Geltungsbereich

Dieser Standard gilt für sämtliche Bestandteile des HealthTracker-Projekts.

Insbesondere für:

- Profile
- Gesundheitsdaten
- Medikamente
- Ernährung
- Messwerte
- Empfehlungen
- Einstellungen
- Backups
- Import/Export
- Synchronisation
- Architektur
- Quellcode
- Dokumentation
- Tests

---

# Sicherheitsprinzipien

## Security by Design

Sicherheit wird bereits während der Architektur und Entwicklung berücksichtigt.

Sie ist kein nachträglich ergänzbares Merkmal.

---

## Privacy by Design

Datenschutz ist Bestandteil aller Architektur- und Designentscheidungen.

Bereits bei der Planung wird geprüft,

- welche Daten notwendig sind,
- wie sie geschützt werden,
- wie lange sie gespeichert werden.

---

## Privacy by Default

Standardmäßig werden ausschließlich die für die jeweilige Funktion erforderlichen Daten verarbeitet.

Optionale Daten müssen bewusst aktiviert werden.

---

## Least Privilege

Jede Komponente erhält ausschließlich die Berechtigungen,

die sie tatsächlich benötigt.

Überflüssige Berechtigungen sind unzulässig.

---

## Defense in Depth

Mehrere unabhängige Schutzmechanismen ergänzen sich.

Beispiele:

- Profilschutz
- Verschlüsselung
- Zugriffskontrolle
- Backup
- Validierung
- Sicherheitsreviews

---

## Fail Secure

Bei Fehlern wird grundsätzlich der sicherste Zustand gewählt.

Beispiele:

- Zugriff verweigern
- Profil sperren
- Daten nicht anzeigen
- Export abbrechen

---

## Secure Defaults

Neue Funktionen müssen standardmäßig sicher konfiguriert sein.

Unsichere Voreinstellungen sind nicht zulässig.

---

# Schutzziele

Die Sicherheitsarchitektur orientiert sich an den klassischen Schutzzielen.

---

## Vertraulichkeit (Confidentiality)

Nur berechtigte Personen dürfen Gesundheitsdaten einsehen.

---

## Integrität (Integrity)

Gesundheitsdaten dürfen nicht unbemerkt verändert werden.

Alle Änderungen müssen nachvollziehbar sein.

---

## Verfügbarkeit (Availability)

Benutzer müssen jederzeit auf ihre lokal gespeicherten Daten zugreifen können.

Backup- und Wiederherstellungsmechanismen unterstützen dieses Ziel.

---

# Datenschutzgrundsätze

Folgende Grundsätze gelten verbindlich.

---

## Datenminimierung

Es werden ausschließlich Daten erhoben,

die für die jeweilige Funktion erforderlich sind.

---

## Zweckbindung

Personenbezogene Daten dürfen ausschließlich für den dokumentierten Zweck verwendet werden.

---

## Speicherbegrenzung

Daten werden nicht länger gespeichert als notwendig.

---

## Transparenz

Der Benutzer kann jederzeit nachvollziehen,

- welche Daten gespeichert werden,
- warum sie gespeichert werden,
- wie sie exportiert werden können,
- wie sie gelöscht werden.

---

## Richtigkeit

Gespeicherte Daten müssen aktuell und korrekt sein.

---

## Rechenschaftspflicht

Sicherheits- und Datenschutzmaßnahmen werden dokumentiert und regelmäßig überprüft.

---

# Sicherheitsklassifizierung

Alle Daten werden einer Sicherheitsklasse zugeordnet.

| Klasse | Beschreibung | Beispiele |
|---------|--------------|-----------|
| Öffentlich | Frei zugängliche Informationen | Versionsnummer, Lizenz |
| Intern | Technische Konfiguration | Einstellungen |
| Vertraulich | Personenbezogene Daten | Profile |
| Hoch vertraulich | Gesundheitsdaten | Messwerte, Medikamente, Empfehlungen |

Die Sicherheitsklasse bestimmt die anzuwendenden Schutzmaßnahmen.

---

# Schutz sensibler Gesundheitsdaten

Gesundheitsdaten besitzen die höchste Schutzklasse.

Hierzu zählen insbesondere:

- Gewicht
- Körpergröße
- Bauchumfang
- Blutdruck
- Puls
- Blutzucker
- Medikamente
- Diagnosen
- Laborwerte
- Ernährung
- Gesundheitsanalysen

Für diese Daten gelten verschärfte Sicherheitsanforderungen.

---

# Rollen und Verantwortlichkeiten

## Projektleitung

Verantwortlich für:

- Sicherheitsstrategie
- Freigabe von Sicherheitsrichtlinien
- Risikobewertung

---

## Architekt

Verantwortlich für:

- Sicherheitsarchitektur
- Bedrohungsmodell
- Architekturentscheidungen
- Sicherheitsreviews

---

## Entwickler

Verantwortlich für:

- sichere Implementierung
- Einhaltung dieses Standards
- sichere Fehlerbehandlung
- sichere Datenverarbeitung

---

## Reviewer

Prüft:

- Einhaltung der Sicherheitsregeln
- Datenschutz
- Verschlüsselung
- Architekturkonformität

---

## Tester

Verantwortlich für:

- Sicherheitsprüfungen
- Datenschutztests
- Regressionstests sicherheitsrelevanter Funktionen

---

# Sicherheitsrisiken

Im Rahmen des Projekts werden insbesondere folgende Risiken betrachtet:

- unberechtigter Zugriff
- Datenverlust
- Manipulation lokaler Daten
- fehlerhafte Backups
- unverschlüsselte Speicherung
- unsichere Exporte
- Offenlegung personenbezogener Daten
- Fehlkonfigurationen
- versehentliche Datenlöschung

Alle identifizierten Risiken werden im weiteren Verlauf dieses Dokuments mit geeigneten Schutzmaßnahmen adressiert.

---

# Verbindlichkeit

Die in diesem Dokument verwendeten Begriffe besitzen folgende Bedeutung:

| Begriff | Bedeutung |
|----------|-----------|
| MUSS | Verpflichtende Anforderung |
| DARF NICHT | Ausnahmslos verboten |
| SOLLTE | Empfohlene Vorgehensweise |
| KANN | Optionale Maßnahme |

Diese Terminologie ist für alle Sicherheitsanforderungen verbindlich.

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Dokumenthistorie
- Dokumentqualität
- Zweck
- Ziele
- Geltungsbereich
- Sicherheitsprinzipien
- Schutzziele (CIA)
- Datenschutzgrundsätze
- Sicherheitsklassifizierung
- Schutz sensibler Gesundheitsdaten
- Rollen und Verantwortlichkeiten
- Sicherheitsrisiken
- Verbindliche Terminologie

---

## Teil 2

Der nächste Abschnitt behandelt:

- Authentifizierung
- Autorisierung
- Profilschutz
- Passwortschutz
- PIN
- Biometrische Anmeldung
- Verschlüsselung
- Schlüsselverwaltung
- Sichere Datenspeicherung
- Sichere Kommunikation
- Session Management

# Authentifizierung

Die Authentifizierung stellt sicher, dass ausschließlich berechtigte Benutzer auf geschützte Funktionen und Daten zugreifen können.

---

## Grundprinzipien

Die Authentifizierung MUSS

- eindeutig,
- sicher,
- nachvollziehbar
- und reproduzierbar

sein.

---

## Unterstützte Verfahren

HealthTracker unterstützt folgende Verfahren.

| Verfahren | Status |
|-----------|--------|
| Gerätezugriff | Pflicht |
| Profilpasswort | Optional |
| PIN | Geplant |
| Biometrie (Face ID / Touch ID / Windows Hello) | Geplant |
| Multi-Faktor-Authentifizierung | Zukunftserweiterung |

---

# Profilschutz

HealthTracker unterstützt mehrere Benutzerprofile.

Jedes Profil kann unabhängig geschützt werden.

---

## Anforderungen

Ein Profil KANN

- öffentlich,
- passwortgeschützt,
- PIN-geschützt,
- biometrisch geschützt

sein.

---

## Regeln

Für passwortgeschützte Profile gilt:

- Passwort MUSS verschlüsselt gespeichert werden.
- Passwörter dürfen niemals im Klartext gespeichert werden.
- Passwörter dürfen niemals protokolliert werden.

---

# Passwortschutz

Passwörter schützen den Zugriff auf einzelne Profile.

---

## Anforderungen

Passwörter SOLLTEN

- mindestens 12 Zeichen lang sein,
- Groß- und Kleinbuchstaben enthalten,
- Zahlen enthalten,
- Sonderzeichen enthalten.

Die Mindestanforderungen können projektabhängig angepasst werden.

---

## Speicherung

Passwörter dürfen ausschließlich als sicherer Hash gespeichert werden.

Verbindliche Regeln:

- Klartextspeicherung ist verboten.
- Eigene Hash-Verfahren sind verboten.
- Bewährte Bibliotheken sind zu verwenden.

---

# PIN-Schutz

Optional kann ein Profil durch eine PIN geschützt werden.

---

## Regeln

Die PIN

- wird niemals im Klartext gespeichert,
- wird ebenfalls gehasht,
- ist ausschließlich lokal gültig.

---

# Biometrische Anmeldung

Biometrische Verfahren stellen eine Komfortfunktion dar.

Sie ersetzen nicht die sichere Speicherung der Zugangsdaten.

---

## Unterstützte Plattformen

- Face ID
- Touch ID
- Windows Hello
- Android Biometric Prompt

---

## Regeln

Biometrische Daten werden niemals durch HealthTracker gespeichert.

Es werden ausschließlich die Betriebssystemfunktionen verwendet.

---

# Autorisierung

Nach erfolgreicher Authentifizierung wird geprüft,

welche Funktionen verfügbar sind.

---

## Grundsatz

Ein Profil darf ausschließlich auf seine eigenen Daten zugreifen.

---

## Verboten

Nicht zulässig sind

- Zugriff auf andere Profile,
- gemeinsame Datenbereiche ohne Freigabe,
- ungeschützte Administrationsfunktionen.

---

# Session Management

Nach erfolgreicher Anmeldung wird eine lokale Sitzung aufgebaut.

---

## Anforderungen

Eine Sitzung endet

- nach expliziter Abmeldung,
- nach Sperrung des Geräts,
- nach konfigurierbarer Inaktivität (optional).

---

## Regeln

Während einer aktiven Sitzung

- dürfen keine Zugangsdaten erneut gespeichert werden,
- dürfen keine Passwörter im Speicher protokolliert werden.

---

# Verschlüsselung

Alle sensiblen Gesundheitsdaten MÜSSEN verschlüsselt gespeichert werden.

---

## Ziel

Schutz vor

- Geräteverlust,
- Datendiebstahl,
- Manipulation,
- unberechtigtem Zugriff.

---

## Verbindliche Regeln

HealthTracker verwendet ausschließlich etablierte kryptographische Verfahren.

Nicht zulässig:

- Eigenentwicklungen kryptographischer Algorithmen
- veraltete Verfahren
- unsichere Zufallszahlengeneratoren

---

## Lokale Speicherung

Empfohlen wird eine symmetrische Verschlüsselung mit einem modernen, anerkannten Verfahren (z. B. AES mit 256-Bit-Schlüsseln), umgesetzt über etablierte Bibliotheken und die Sicherheitsmechanismen des jeweiligen Betriebssystems.

---

# Schlüsselverwaltung

Kryptographische Schlüssel besitzen denselben Schutzbedarf wie die verschlüsselten Daten.

---

## Regeln

Schlüssel

- dürfen niemals im Quellcode gespeichert werden,
- dürfen nicht in Git eingecheckt werden,
- dürfen nicht im Klartext gespeichert werden.

---

## Sichere Speicherung

Schlüssel SOLLTEN in den sicheren Speichermechanismen des Betriebssystems abgelegt werden.

Beispiele

- iOS Keychain
- Android Keystore
- Windows Credential Locker

---

# Sichere Datenspeicherung

Alle Gesundheitsdaten werden ausschließlich lokal gespeichert,

solange keine Cloud-Synchronisation aktiviert wurde.

---

## Anforderungen

Die Speicherung MUSS

- verschlüsselt,
- konsistent,
- nachvollziehbar

sein.

---

## Integrität

Schreibvorgänge dürfen keine inkonsistenten Daten hinterlassen.

Fehlgeschlagene Operationen müssen sauber zurückgerollt werden.

---

# Sichere Kommunikation

Kommunikation mit externen Diensten erfolgt ausschließlich über gesicherte Verbindungen.

---

## Regeln

- Ausschließlich verschlüsselte Verbindungen verwenden.
- Zertifikatsprüfungen dürfen nicht deaktiviert werden.
- Unsichere Protokolle sind verboten.

---

# Backup-Sicherheit

Backups enthalten Gesundheitsdaten und besitzen daher dieselbe Schutzklasse.

---

## Anforderungen

Backups

- MÜSSEN verschlüsselt werden,
- SOLLTEN versioniert werden,
- DÜRFEN keine unverschlüsselten Gesundheitsdaten enthalten.

---

## Wiederherstellung

Vor dem Import eines Backups wird geprüft:

- Dateiintegrität
- Dateiformat
- Versionskompatibilität

---

# Import- und Exportsicherheit

Importierte Dateien gelten grundsätzlich als nicht vertrauenswürdig.

---

## Regeln

Vor jedem Import erfolgt eine Prüfung auf:

- Dateiformat
- Datenstruktur
- Pflichtfelder
- unterstützte Version

Ungültige Dateien werden abgelehnt.

---

## Export

Exportierte Dateien

- enthalten ausschließlich ausgewählte Daten,
- werden nachvollziehbar erstellt,
- können optional verschlüsselt werden.

---

# Sicherheitsprotokollierung

Sicherheitsrelevante Ereignisse werden dokumentiert.

---

## Beispiele

- Anmeldung
- fehlgeschlagene Anmeldung
- Passwortänderung
- Backup erstellt
- Backup wiederhergestellt
- Profil gelöscht

---

## Verboten

Nicht protokolliert werden dürfen:

- Passwörter
- PINs
- kryptographische Schlüssel
- Gesundheitsdaten
- personenbezogene Inhalte

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Authentifizierung
- Autorisierung
- Profilschutz
- Passwortschutz
- PIN-Schutz
- Biometrische Anmeldung
- Session Management
- Verschlüsselung
- Schlüsselverwaltung
- Sichere Datenspeicherung
- Sichere Kommunikation
- Backup-Sicherheit
- Import- und Exportsicherheit
- Sicherheitsprotokollierung

---

## Teil 3

Der nächste Abschnitt behandelt:

- DSGVO
- Datenschutzmanagement
- Audit Trail
- Logging
- Datenexport
- Datenlöschung
- Aufbewahrungsfristen
- Bedrohungsmodell
- Sicherheitsvorfälle
- Incident Response
- Sicherheits-Tests
- Schwachstellenmanagement

# Datenschutzmanagement

Der Schutz personenbezogener Daten ist integraler Bestandteil der Sicherheitsarchitektur.

HealthTracker verarbeitet Gesundheitsdaten ausschließlich unter Beachtung der geltenden Datenschutzanforderungen.

---

# Datenschutzgrundsätze

Folgende Grundsätze gelten für sämtliche personenbezogenen Daten.

## Rechtmäßigkeit

Die Verarbeitung erfolgt ausschließlich auf einer dokumentierten Rechtsgrundlage.

---

## Transparenz

Benutzer müssen nachvollziehen können,

- welche Daten gespeichert werden,
- warum sie gespeichert werden,
- wie lange sie gespeichert werden,
- wie sie exportiert werden können,
- wie sie gelöscht werden.

---

## Datenminimierung

Es werden ausschließlich Daten verarbeitet,

die für die jeweilige Funktion notwendig sind.

---

## Speicherbegrenzung

Personenbezogene Daten werden nicht länger gespeichert als erforderlich.

---

## Integrität

Daten dürfen nicht unbemerkt verändert werden.

---

## Vertraulichkeit

Gesundheitsdaten sind ausschließlich für berechtigte Benutzer zugänglich.

---

# DSGVO-Anforderungen

HealthTracker unterstützt insbesondere folgende Anforderungen.

## Auskunft

Benutzer können ihre gespeicherten Daten einsehen.

---

## Datenexport

Benutzer können ihre Daten exportieren.

Exportformate

- JSON
- CSV
- zukünftige Formate

---

## Berichtigung

Fehlerhafte Daten können korrigiert werden.

---

## Löschung

Benutzer können ihre Daten vollständig löschen.

Nach erfolgreicher Löschung dürfen keine personenbezogenen Daten mehr verfügbar sein.

---

## Datenübertragbarkeit

Exportierte Daten müssen in einem strukturierten Format bereitgestellt werden.

---

# Audit Trail

Sicherheitsrelevante Aktionen werden nachvollziehbar dokumentiert.

---

## Beispiele

- Profil erstellt
- Profil gelöscht
- Passwort geändert
- Backup erstellt
- Backup importiert
- Datenexport durchgeführt
- Sicherheitseinstellungen geändert

---

## Anforderungen

Ein Audit-Eintrag enthält mindestens

- Zeitstempel
- Ereignis
- Profil-ID
- Ergebnis
- Version

---

## Datenschutz

Der Audit Trail darf keine sensiblen Inhalte enthalten.

Nicht protokolliert werden

- Passwörter
- PINs
- Gesundheitsdaten
- kryptographische Schlüssel

---

# Logging

Logging dient ausschließlich

- Diagnose,
- Fehleranalyse,
- Wartung.

---

## Log-Level

```text
ERROR

WARNING

INFO

DEBUG
```

---

## Regeln

Logs dürfen niemals enthalten

- Gesundheitsdaten
- personenbezogene Inhalte
- Passwörter
- Tokens
- Schlüssel

---

# Datenexport

Vor jedem Export wird geprüft

- Berechtigung
- Datenumfang
- Exportformat
- Verschlüsselungsoption

---

## Exportprotokoll

Dokumentiert werden

- Zeitpunkt
- Profil
- Format
- Ergebnis

---

# Datenlöschung

Löschvorgänge müssen vollständig und nachvollziehbar erfolgen.

---

## Prüfen

- lokale Daten
- Backups (falls möglich)
- Cache
- temporäre Dateien

---

## Löschbestätigung

Nach erfolgreicher Löschung erhält der Benutzer eine Bestätigung.

---

# Aufbewahrungsfristen

Personenbezogene Daten werden grundsätzlich nur so lange gespeichert,

wie sie benötigt werden.

---

## Regeln

- temporäre Dateien regelmäßig entfernen
- veraltete Backups kennzeichnen
- exportierte Dateien nicht automatisch dauerhaft speichern

---

# Bedrohungsmodell

Das Projekt bewertet regelmäßig mögliche Bedrohungen.

---

## Identifizierte Risiken

- Geräteverlust
- unberechtigter Zugriff
- Manipulation lokaler Daten
- beschädigte Backups
- kompromittierte Exporte
- Schadsoftware
- Social Engineering
- Fehlkonfiguration

---

## Schutzmaßnahmen

Für jede Bedrohung werden dokumentiert

- Eintrittswahrscheinlichkeit
- Auswirkung
- Schutzmaßnahme
- Restrisiko

---

# Sicherheitsvorfälle

Sicherheitsvorfälle werden dokumentiert und bewertet.

---

## Beispiele

- Datenverlust
- fehlgeschlagene Wiederherstellung
- unberechtigter Zugriff
- beschädigte Datenbank
- kompromittiertes Backup

---

## Dokumentation

Ein Sicherheitsvorfall enthält mindestens

- Incident-ID
- Datum
- Beschreibung
- Ursache
- Auswirkungen
- Maßnahmen
- Status

---

# Incident Response

Für Sicherheitsvorfälle gilt ein standardisierter Ablauf.

```text
Erkennen

↓

Bewerten

↓

Eindämmen

↓

Beheben

↓

Wiederherstellen

↓

Nachbereitung
```

---

## Ziele

- Schaden begrenzen
- Daten schützen
- Wiederherstellung beschleunigen
- Ursachen dauerhaft beseitigen

---

# Schwachstellenmanagement

Bekannte Schwachstellen werden dokumentiert.

---

## Klassifizierung

| Schwere | Reaktion |
|----------|-----------|
| Kritisch | Sofort |
| Hoch | Schnellstmöglich |
| Mittel | Geplant |
| Niedrig | Bei nächster Wartung |

---

## Nachverfolgung

Für jede Schwachstelle werden dokumentiert

- Beschreibung
- Risiko
- Priorität
- Verantwortlicher
- Status

---

# Sicherheits-Tests

Alle sicherheitsrelevanten Funktionen werden regelmäßig getestet.

---

## Prüfen

- Authentifizierung
- Autorisierung
- Verschlüsselung
- Backup
- Restore
- Import
- Export
- Datenschutz
- Profilschutz

---

## Regression

Jede behobene Sicherheitslücke erhält mindestens einen Regressionstest.

---

# Sicherheitsüberwachung

Vor jedem Release werden zusätzlich geprüft

- neue Abhängigkeiten
- bekannte Sicherheitslücken
- veraltete Bibliotheken
- kryptographische Verfahren
- Berechtigungen

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Datenschutzmanagement
- DSGVO-Anforderungen
- Audit Trail
- Logging
- Datenexport
- Datenlöschung
- Aufbewahrungsfristen
- Bedrohungsmodell
- Sicherheitsvorfälle
- Incident Response
- Schwachstellenmanagement
- Sicherheits-Tests
- Sicherheitsüberwachung

---

## Teil 4

Der letzte Abschnitt behandelt:

- Sicherheitsreviews
- Sicherheitsmetriken
- Security Compliance
- Anti-Patterns
- Best Practices
- Review-Checkliste
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Sicherheitsreviews

Jede sicherheitsrelevante Änderung MUSS vor ihrer Freigabe einem dokumentierten Sicherheitsreview unterzogen werden.

Das Sicherheitsreview ergänzt den allgemeinen Reviewprozess gemäß `REVIEW_GUIDE.md`.

---

# Ziele

Das Sicherheitsreview überprüft insbesondere:

- Einhaltung dieses Sicherheitsstandards
- Umsetzung der Datenschutzanforderungen
- Einhaltung der Architekturvorgaben
- Sichere Implementierung
- Sichere Datenhaltung
- Sichere Kommunikation
- Sichere Konfiguration
- Vollständigkeit der Sicherheitsdokumentation

---

# Auslöser eines Sicherheitsreviews

Ein Sicherheitsreview ist verpflichtend bei:

- Einführung neuer Authentifizierungsverfahren
- Änderungen an Verschlüsselungsmechanismen
- Änderungen der Schlüsselverwaltung
- Änderungen am Profilschutz
- Einführung neuer Berechtigungen
- Änderungen an Import- oder Exportfunktionen
- Änderungen an Backup oder Restore
- Einführung neuer externer Schnittstellen
- Verarbeitung neuer Kategorien personenbezogener Daten
- Änderungen an Sicherheitsbibliotheken

---

# Security Compliance

Vor jeder Freigabe wird geprüft:

- Sicherheitsanforderungen erfüllt
- Datenschutzanforderungen erfüllt
- Verschlüsselung aktiviert
- Schlüsselverwaltung korrekt umgesetzt
- Logging geprüft
- Audit Trail vollständig
- Backup erfolgreich getestet
- Restore erfolgreich getestet
- Sicherheits-Tests erfolgreich
- Traceability vollständig

Kritische Sicherheitsmängel verhindern grundsätzlich eine Freigabe.

---

# Sicherheitsmetriken

Zur Bewertung des Sicherheitsniveaus werden folgende Kennzahlen erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Kritische Sicherheitslücken | 0 |
| Offene High-Risk-Schwachstellen | 0 |
| Erfolgreiche Sicherheitsreviews | 100 % |
| Erfolgreiche Restore-Tests | 100 % |
| Verschlüsselte Backups | 100 % |
| Unverschlüsselte Gesundheitsdaten | 0 |
| Datenschutzverstöße | 0 |
| Sicherheitsregressionen | 0 |
| Kritische Sicherheitsvorfälle | 0 |

---

# Anti-Patterns

Folgende Vorgehensweisen sind projektweit verboten.

---

## SEC-AP-001 – Klartextspeicherung

Gesundheitsdaten, Passwörter, PINs oder kryptographische Schlüssel dürfen niemals unverschlüsselt gespeichert werden.

---

## SEC-AP-002 – Hardcodierte Geheimnisse

Nicht zulässig sind:

- API-Schlüssel
- Tokens
- Passwörter
- kryptographische Schlüssel
- Zugangsdaten

im Quellcode oder Repository.

---

## SEC-AP-003 – Sensible Daten im Logging

Nicht protokolliert werden dürfen:

- Gesundheitsdaten
- Passwörter
- PINs
- Tokens
- kryptographische Schlüssel
- personenbezogene Inhalte

---

## SEC-AP-004 – Umgehung der Autorisierung

Direkte Zugriffe auf Daten anderer Profile sind unzulässig.

Alle Zugriffe erfolgen ausschließlich über definierte Schnittstellen.

---

## SEC-AP-005 – Eigene Kryptographie

Eigene kryptographische Verfahren dürfen nicht entwickelt oder eingesetzt werden.

Es werden ausschließlich etablierte und geprüfte Bibliotheken verwendet.

---

## SEC-AP-006 – Fehlende Eingabevalidierung

Alle externen Eingaben müssen validiert werden.

Nicht validierte Eingaben stellen ein Sicherheitsrisiko dar.

---

## SEC-AP-007 – Unsichere Standardkonfiguration

Neue Funktionen dürfen niemals mit unsicheren Standardeinstellungen ausgeliefert werden.

---

## SEC-AP-008 – Fehlende Sicherheitsdokumentation

Sicherheitsrelevante Architekturentscheidungen ohne ADR oder Traceability sind nicht zulässig.

---

# Best Practices

Empfohlene Vorgehensweisen:

## Security by Design

Sicherheit wird bereits in der Architektur berücksichtigt.

---

## Privacy by Design

Datenschutz wird bereits bei der Konzeption umgesetzt.

---

## Least Privilege

Komponenten erhalten ausschließlich die minimal erforderlichen Berechtigungen.

---

## Defense in Depth

Mehrere unabhängige Schutzmechanismen ergänzen sich.

---

## Sichere Bibliotheken

Es werden ausschließlich etablierte, gepflegte und regelmäßig aktualisierte Bibliotheken verwendet.

---

## Regelmäßige Sicherheitsprüfungen

Sicherheitsrelevante Bereiche werden regelmäßig überprüft und getestet.

---

## Dokumentierte Architekturentscheidungen

Sicherheitsrelevante Architekturentscheidungen werden grundsätzlich durch ADRs dokumentiert.

---

# Review-Checkliste

Vor jeder Freigabe sind mindestens folgende Punkte zu prüfen.

## Authentifizierung

- [ ] Profilschutz vorhanden
- [ ] Passwortschutz korrekt
- [ ] Sitzungsverwaltung geprüft

---

## Autorisierung

- [ ] Profiltrennung gewährleistet
- [ ] Berechtigungen korrekt
- [ ] Keine unzulässigen Zugriffe

---

## Kryptographie

- [ ] Verschlüsselung aktiv
- [ ] Schlüsselverwaltung korrekt
- [ ] Keine Klartextspeicherung

---

## Datenschutz

- [ ] Datenminimierung umgesetzt
- [ ] Zweckbindung dokumentiert
- [ ] Export geprüft
- [ ] Löschung geprüft

---

## Datensicherheit

- [ ] Backup verschlüsselt
- [ ] Restore erfolgreich
- [ ] Migration geprüft

---

## Logging und Audit

- [ ] Keine sensiblen Daten im Log
- [ ] Audit Trail vollständig

---

## Dokumentation

- [ ] ADR vorhanden (falls erforderlich)
- [ ] Traceability vollständig
- [ ] Sicherheitsdokumentation aktuell

---

# Sicherheits-KPIs

| Kennzahl | Ziel |
|-----------|------|
| Erfolgreiche Sicherheitsreviews | 100 % |
| Kritische Sicherheitsfehler | 0 |
| Erfolgreiche Restore-Tests | 100 % |
| Verschlüsselte Datensätze | 100 % |
| Datenschutzverstöße | 0 |
| Kritische Sicherheitsvorfälle | 0 |
| Vollständige Audit-Trails | 100 % |
| Vollständige Traceability | 100 % |

---

# Kontinuierliche Verbesserung

Der Sicherheitsstandard wird regelmäßig überprüft.

Verbesserungen stammen aus:

- Sicherheitsreviews
- Architekturreviews
- Testberichten
- Schwachstellenanalysen
- Incident-Analysen
- Release-Retrospektiven
- Änderungen gesetzlicher Anforderungen

Anpassungen erfolgen ausschließlich über eine neue Dokumentversion.

---

# Referenzen

Dieser Standard baut auf folgenden Projektdokumenten auf:

- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REVIEW_GUIDE.md
- TRACEABILITY_GUIDE.md
- ARCHITECTURE_GUIDE.md
- TESTING_GUIDE.md
- REQUIREMENTS_GUIDE.md

Zusätzlich gelten:

- Architecture Decision Records (ADR)
- Moduldokumentationen
- Sicherheits- und Datenschutzrichtlinien des Projekts

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-SEC-001 |
| Version | 1.0.0 |
| Status | **Approved** |
| Freigegeben am | 2026-07-31 |
| Gültig ab | 2026-07-31 |
| Nächstes Review | Vor dem nächsten Major Release |

---

# Änderungsstopp

Mit der Freigabe der Version **1.0.0** gilt dieses Dokument als abgeschlossen.

Änderungen erfolgen ausschließlich durch:

1. Erstellung einer neuen Dokumentversion.
2. Aktualisierung der Dokumenthistorie.
3. Anpassung des Änderungsverlaufs.
4. Erneutes Sicherheitsreview.
5. Dokumentation sicherheitsrelevanter Architekturänderungen über einen Architecture Decision Record (ADR).

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.

---

# Status

**Dokument:** `docs/standards/SECURITY_GUIDE.md`

**Version:** 1.0.0

**Status:** ✅ Approved