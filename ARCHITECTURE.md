# HealthTracker Architektur

## Ziel

HealthTracker ist ein persönlicher Gesundheitsassistent für Einzelpersonen
und Familien.

Die App soll nicht nur Daten speichern, sondern den Nutzer unterstützen,
Zusammenhänge erkennen und sinnvolle Hinweise geben.

---

# Grundprinzipien

## 1. Wenig Eingaben, viel Unterstützung

Die App soll den Nutzer möglichst wenig belasten.

Beispiele:

- Automatische Berechnungen
- Automatische Trends
- Geräteintegration
- Erinnerungen
- Gesundheitsinformationen aus vorhandenen Daten ableiten

---

# 2. Datenschutz und Sicherheit

Gesundheitsdaten sind besonders geschützt.

Grundsätze:

- Daten gehören dem Nutzer
- Lokale Speicherung bevorzugt
- Keine Speicherung von Passwörtern im Klartext
- Optionale Profilsicherheit
- Vorbereitung für biometrische Anmeldung

---

# 3. Profilstruktur

HealthTracker unterstützt mehrere Profile.

Beispiele:

- Eigene Nutzung
- Partner
- Kinder
- Familienmitglieder

Das zuletzt verwendete Profil wird beim Start bevorzugt geöffnet.

---

# 4. Modulare Architektur

Die App wird in unabhängige Bereiche gegliedert.

Geplante Module:

- Profile
- Dashboard
- Messwerte
- Ernährung
- Medikamente
- Bewegung
- Schlaf
- Geräteintegration
- Analyse

Jedes Modul besitzt eigene:

- Models
- Services / Repositorys
- Views
- Widgets
- Validierungen

---

# 5. Validierung und Plausibilität

Es wird zwischen zwei Prüfungen unterschieden.

## Validierung

Verhindert technisch falsche Eingaben.

Beispiele:

- Leere Pflichtfelder
- Ungültige Zahlen
- Werte außerhalb erlaubter Grenzen


## Plausibilitätsprüfung

Erkennt ungewöhnliche, aber mögliche Werte.

Beispiele:

- Sehr große Körpergröße
- Stark verändertes Gewicht
- Auffällige Messwerte

Die App warnt, verhindert aber nicht automatisch die Eingabe.

---

# 6. Ereignisbasierte Architektur

Neue Daten erzeugen Ereignisse.

Beispiel:

Gewicht geändert

↓

- Verlauf aktualisieren
- Diagramm aktualisieren
- Ziele prüfen
- Dashboard aktualisieren
- Analyse ausführen

---

# 7. Entwicklungsschritte

## Alpha 0.1

Grundlage:

- Profile
- Speicherung
- Validierung
- Dashboard-Grundlage
- Erste Messwerte


## Weitere Versionen

Ausbau:

- Ernährung
- Medikamente
- Geräte
- Analyse
- Familienfunktionen

---

# 8. Qualitätsprinzip

Neue Funktionen werden erst integriert, wenn:

1. Der Nutzen für den Nutzer klar ist.
2. Die Funktion zur Architektur passt.
3. Datenschutz berücksichtigt wurde.