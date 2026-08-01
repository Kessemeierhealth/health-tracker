# HealthTracker – Projektregeln

Version: 1.0
Status: Verbindlich

---

# Projektziel

HealthTracker ist eine datenschutzorientierte Gesundheitsplattform für Einzelpersonen und Familien.

Die App soll:

- möglichst viele Daten automatisch erfassen
- unnötige Eingaben vermeiden
- Gesundheitsdaten verständlich darstellen
- Trends erkennen
- nachvollziehbare Empfehlungen geben
- niemals Diagnosen stellen

---

# Architektur

Es gilt folgende Schichtenarchitektur:

```text
View
    │
    ▼
Provider (Riverpod)
    │
    ▼
Repository
    │
    ▼
Data Source
    │
    ▼
Database / Geräte / Import
```

Geschäftslogik gehört niemals in Widgets.

---

# Projektstruktur

Neue Dateien werden grundsätzlich innerhalb der Feature-Struktur angelegt.

```text
app/
core/
domain/
features/
shared/
```

Root-Ordner wie

```
models
providers
repositories
services
```

werden nur noch während der Migration verwendet.

---

# Programmiersprache

Code

→ Englisch

Kommentare

→ Deutsch

Benutzeroberfläche

→ Deutsch
(später Internationalisierung)

---

# State Management

Riverpod

Es werden keine globalen Singleton-Services verwendet.

---

# Navigation

go_router

Keine direkte Navigator-Logik in Widgets.

---

# Datenhaltung

Große Daten

→ Isar

Kleine Einstellungen

→ SharedPreferences

Beispiele:

✔ Theme

✔ Letztes Profil

✔ Sprache

✘ Messwerte

✘ Medikamente

✘ Ernährung

---

# Validierung

Alle Eingaben werden zentral validiert.

Keine Validatoren direkt in Widgets.

Beispiel:

ProfileValidator

MeasurementValidator

MedicationValidator

NutritionValidator

---

# Widgets

Widgets zeigen Daten an.

Sie enthalten keine Fachlogik.

Ein Widget sollte möglichst kleiner als 300 Zeilen bleiben.

---

# Sicherheit

Gesundheitsdaten haben höchste Priorität.

Passwörter werden niemals im Klartext gespeichert.

Unterstützte Authentifizierung:

- PIN
- Passwort
- Face ID
- Touch ID
- Fingerabdruck

Profile können optional geschützt werden.

Beim Appstart wird automatisch das zuletzt verwendete Profil geöffnet.

---

# Gesundheitsdaten

Alle Gesundheitsdaten gehören genau einem Profil.

Es gibt keine globalen Messwerte.

---

# Analyse

Die App

✔ erkennt Trends

✔ erkennt Zusammenhänge

✔ bewertet Datenqualität

✔ gibt Empfehlungen

Die App

✘ stellt keine Diagnosen

✘ ersetzt keinen Arzt

---

# Automatisierung

Bevor eine neue Eingabemaske entwickelt wird, sind drei Fragen zu beantworten:

1.
Kann die Information automatisch übernommen werden?

2.
Kann sie berechnet werden?

3.
Muss der Nutzer sie überhaupt eingeben?

Nur wenn alle drei Fragen mit Nein beantwortet werden, wird eine neue Eingabe erstellt.

---

# Familienmodus

Ein Benutzer kann mehrere Profile verwalten.

Beispiele

- Selbst
- Partner
- Kind
- Elternteil

Jedes Profil besitzt eigene Gesundheitsdaten.

---

# Timeline

Jedes relevante Ereignis wird automatisch in der Gesundheitschronik gespeichert.

Beispiele

- Gewicht
- Blutdruck
- Medikamente
- Ernährung
- Schritte
- Schlaf
- Arztbesuch

---

# Geräte

Alle Geräte liefern Daten über dieselbe Schnittstelle.

Unterstützte Quellen:

- Apple Health
- Health Connect
- Garmin
- Fitbit
- Polar
- Withings
- Bluetooth-Geräte

---

# Codequalität

Vor jedem Commit:

✔ flutter analyze

✔ flutter test

✔ dart format

müssen erfolgreich laufen.

---

# Dokumentation

Jede größere Architekturänderung erhält einen ADR.

Neue Module erhalten vor der Implementierung:

- Datenmodell
- UI-Konzept
- Ablauf
- Validierung

---

# Git

Commit-Konvention

feat:

Neue Funktion

fix:

Fehlerbehebung

refactor:

Umstrukturierung

docs:

Dokumentation

test:

Tests

chore:

Werkzeuge

---

# Grundprinzip

HealthTracker soll dem Nutzer Arbeit abnehmen.

Nicht:

"Wo muss ich das eingeben?"

Sondern:

"Die App weiß das bereits."

Dieses Prinzip hat bei allen Architektur- und Designentscheidungen Vorrang.