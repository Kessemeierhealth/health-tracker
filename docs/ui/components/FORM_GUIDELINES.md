# FORM_GUIDELINES.md

**Status:** Verbindliche UI-Spezifikation  
**Version:** 1.0 (Draft)  
**Stand:** 3. August 2026

---

# 1. Zweck

Diese Spezifikation definiert die verbindlichen Regeln für alle Formulare, Eingaben und Validierungen des Health Trackers.

Sie ergänzt den `UI_GUIDE.md` sowie die `COMPONENT_LIBRARY.md` und stellt sicher, dass alle Eingaben in der Anwendung einheitlich funktionieren.

Geschäftsregeln und fachliche Validierungen werden weiterhin in den jeweiligen Modulspezifikationen definiert.

---

# 2. Grundprinzipien

Alle Formulare sollen

- möglichst wenig Eingaben erfordern,
- den Benutzer aktiv unterstützen,
- Fehler früh erkennen,
- automatische Eingaben bevorzugen,
- konsistent aussehen,
- auf allen Geräten gleich funktionieren.

Die Anwendung soll vorhandene Daten wiederverwenden und unnötige Eingaben vermeiden.

---

# 3. Formularaufbau

Ein Formular besteht grundsätzlich aus:

- Titel
- kurzer Beschreibung (optional)
- Eingabebereich
- Primäraktion
- Sekundäraktion (optional)

Lange Formulare werden logisch in Abschnitte gegliedert.

---

# 4. Eingabefelder

Jedes Eingabefeld besitzt mindestens:

- Bezeichnung
- Eingabewert
- Einheit (falls erforderlich)
- Hilfetext (optional)
- Fehlermeldung (bei Bedarf)

Placeholder ersetzen niemals die Feldbezeichnung.

---

# 5. Pflichtfelder

Pflichtfelder werden eindeutig gekennzeichnet.

Regeln:

- nur notwendige Informationen verpflichtend verlangen,
- Pflichtfelder möglichst früh sichtbar machen,
- nach Möglichkeit sinnvolle Standardwerte verwenden.

---

# 6. Optionale Felder

Optionale Felder werden nicht besonders hervorgehoben.

Sie dürfen

- leer bleiben,
- später ergänzt werden,
- keinen Abschluss verhindern.

---

# 7. Validierung

Es gelten zwei Validierungsarten.

## Sofortige Validierung

Bereits während der Eingabe.

Beispiele:

- ungültige Zeichen
- Zahlenformat
- Datumsformat

---

## Abschlussvalidierung

Beim Speichern.

Beispiele:

- Pflichtfelder
- fachliche Regeln
- Wertebereiche
- Plausibilitätsprüfungen

---

# 8. Fehlermeldungen

Fehlermeldungen sollen

- konkret,
- verständlich,
- lösungsorientiert

formuliert werden.

Beispiel:

✔︎

Bitte gib eine Körpergröße zwischen 20 cm und 300 cm ein.

Nicht:

✘

Ungültige Eingabe.

---

# 9. Einheiten

Einheiten werden immer angezeigt.

Beispiele:

- cm
- kg
- mmHg
- mg/dl

Die Einheit gehört visuell zum Eingabefeld.

---

# 10. Standardwerte

Wo sinnvoll, verwendet die Anwendung automatisch

- zuletzt verwendete Werte,
- Standardprofile,
- aktuelles Datum,
- aktuelle Uhrzeit,
- bekannte Geräte.

---

# 11. Automatische Erfassung

Automatisch übernommene Werte werden eindeutig gekennzeichnet.

Mögliche Quellen:

- Smartwatch
- Waage
- Blutdruckmessgerät
- Blutzuckermessgerät
- Gesundheitsplattform

Der Benutzer kann automatisch erkannte Werte vor dem Speichern prüfen.

---

# 12. Speichern

Speichern erfolgt

- bewusst,
- nachvollziehbar,
- eindeutig.

Nach erfolgreichem Speichern erhält der Benutzer eine kurze Bestätigung.

---

# 13. Abbrechen

Abbrechen verwirft ungespeicherte Änderungen.

Bei geänderten Daten erfolgt eine Nachfrage.

---

# 14. Löschen

Löschen ist eine destruktive Aktion.

Regeln:

- deutlich kennzeichnen,
- bestätigen lassen,
- Auswirkungen erklären.

---

# 15. Fokus und Tastatur

Die Fokusreihenfolge folgt der sichtbaren Reihenfolge.

Desktop und Web unterstützen:

- Tab
- Shift + Tab
- Enter
- Escape (Dialoge)

---

# 16. Barrierefreiheit

Formulare unterstützen

- Screenreader,
- große Schrift,
- ausreichende Kontraste,
- vollständige Tastaturbedienung.

Fehlermeldungen werden semantisch angekündigt.

---

# 17. Responsive Verhalten

Smartphone

- einspaltige Formulare

Tablet

- ein oder zwei Spalten

Desktop

- mehrere Spalten nur bei klarer Lesbarkeit

Die Lesereihenfolge bleibt immer eindeutig.

---

# 18. Datenschutz

Sensible Eingaben

- werden nicht unnötig angezeigt,
- erscheinen nicht in Benachrichtigungen,
- respektieren den Profilschutz.

Passwörter und sicherheitsrelevante Eingaben verwenden geeignete Maskierung.

---

# 19. Flutter-Regeln

Formulare verwenden ausschließlich gemeinsame Komponenten.

Fachliche Validierungen gehören nicht in Widgets.

Jede Validierung besitzt eine eindeutige Quelle:

- UI-Validierung
- Domain-Validierung
- Business Rule

---

# 20. Prüfliste

Vor Freigabe eines Formulars prüfen:

- Sind nur notwendige Pflichtfelder vorhanden?
- Werden Einheiten angezeigt?
- Sind Fehlermeldungen verständlich?
- Werden automatische Eingaben genutzt?
- Funktioniert das Formular responsiv?
- Ist die Tastaturbedienung vollständig?
- Unterstützt das Formular Screenreader?
- Sind Datenschutzregeln eingehalten?
- Werden fachliche Regeln nicht im Widget implementiert?

Nur wenn alle Punkte erfüllt sind, gilt ein Formular als freigegeben.