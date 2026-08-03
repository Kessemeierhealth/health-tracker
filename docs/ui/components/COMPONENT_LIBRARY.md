# COMPONENT_LIBRARY.md

**Status:** Verbindliche UI-Komponentenspezifikation  
**Version:** 1.0 (Draft)  
**Stand:** 3. August 2026

---

# 1. Zweck

Diese Spezifikation definiert alle wiederverwendbaren UI-Komponenten des Health Trackers.

Sie ergänzt den `UI_GUIDE.md` und legt fest:

- welche Komponenten existieren,
- wann sie verwendet werden,
- welche Varianten zulässig sind,
- welche Zustände unterstützt werden,
- welche Barrierefreiheitsanforderungen gelten.

Geschäftslogik gehört niemals in UI-Komponenten.

---

# 2. Allgemeine Regeln

Alle Komponenten müssen

- ausschließlich Theme-Tokens verwenden,
- responsiv funktionieren,
- große Schrift unterstützen,
- per Touch, Tastatur und Screenreader bedienbar sein,
- in allen Erscheinungsbildern funktionieren,
- keine fachliche Logik enthalten.

Komponenten dürfen nur ihre Darstellung und Benutzerinteraktion kapseln.

---

# 3. Komponentenübersicht

Die Komponentenbibliothek umfasst mindestens:

- Buttons
- Karten
- Listen
- Banner
- Dialoge
- Bottom Sheets
- Eingabefelder
- Navigation
- Ladezustände
- Leere Zustände
- Profil-Komponenten
- Messwert-Komponenten

---

# 4. Buttons

## 4.1 Primary Button

Verwendung:

- wichtigste Aktion eines Bildschirms

Eigenschaften:

- Bereichsfarbe
- volle Breite oder definierte Standardbreite
- optional Icon
- Ladezustand möglich

Beispiele:

- Messwert speichern
- Profil anlegen
- Training starten

---

## 4.2 Secondary Button

Verwendung:

- alternative Aktion

Beispiele:

- Abbrechen
- Später

---

## 4.3 Text Button

Verwendung:

- weniger wichtige Aktionen

---

## 4.4 Icon Button

Verwendung:

- Einstellungen
- Bearbeiten
- Löschen
- Favoriten

Icons benötigen immer eine zugängliche Beschreibung.

---

# 5. Karten

## 5.1 Section Card

Gruppiert zusammengehörige Informationen.

Beispiele:

- Messwerte
- Medikamente
- Termine

---

## 5.2 Metric Card

Darstellung einzelner Messwerte.

Enthält:

- Symbol
- Titel
- Wert
- Einheit
- Status
- Zeit

---

## 5.3 Information Card

Nicht interaktive Informationen.

---

# 6. Banner

## Information Banner

Neutral.

## Success Banner

Erfolgreiche Aktionen.

## Warning Banner

Hinweise.

## Error Banner

Fehler.

Alle Banner besitzen:

- Icon
- Titel
- Beschreibung
- optionale Aktion

---

# 7. Dialoge

Dialoge verwenden immer dieselbe Struktur.

Bestandteile:

- Titel
- Beschreibung
- Primäraktion
- Sekundäraktion

Destruktive Aktionen benötigen eine Bestätigung.

---

# 8. Bottom Sheets

Bottom Sheets dienen

- Auswahl kleiner Optionen,
- Schnellaktionen,
- Filtern.

Sie ersetzen keine vollständigen Seiten.

---

# 9. Listen

Listen unterstützen:

- leere Zustände,
- Laden,
- Fehler,
- Gruppierung,
- Sortierung,
- optionale Suche.

---

# 10. Ladezustände

Es werden Skeletons bevorzugt.

Spinner werden nur verwendet,

- wenn keine sinnvolle Skeleton-Darstellung möglich ist.

---

# 11. Empty State

Ein leerer Zustand enthält mindestens:

- Illustration oder Symbol,
- Titel,
- kurze Erklärung,
- Primäraktion.

Leere Listen dürfen niemals vollständig leer erscheinen.

---

# 12. Profil-Komponenten

## Profile Avatar

Zeigt:

- Bild oder Initialen,
- Profilfarbe,
- aktiven Status.

---

## Profile Switch

Ermöglicht den direkten Profilwechsel.

---

# 13. Messwert-Komponenten

Messwerte verwenden dieselbe Grundstruktur.

Bestandteile:

- Messwert
- Einheit
- Zeitpunkt
- Status
- Quelle

Die Quelle zeigt beispielsweise:

- manuell
- Smartwatch
- Waage
- Blutdruckmessgerät

---

# 14. Zustände

Alle interaktiven Komponenten unterstützen:

- Normal
- Hover (Desktop/Web)
- Focus
- Pressed
- Disabled
- Loading
- Error (falls relevant)

---

# 15. Barrierefreiheit

Alle Komponenten

- besitzen Semantik,
- unterstützen Screenreader,
- erfüllen Mindestgrößen,
- besitzen ausreichende Kontraste,
- funktionieren mit großer Schrift,
- besitzen sichtbare Fokuszustände.

---

# 16. Flutter-Regeln

Jede Komponente

- besitzt genau eine Verantwortung,
- verwendet ausschließlich Theme-Tokens,
- enthält keine Geschäftslogik,
- ist wiederverwendbar,
- besitzt Widget-Tests.

Neue Komponenten dürfen nur eingeführt werden, wenn keine bestehende Komponente denselben Zweck erfüllt.

---

# 17. Prüfliste

Vor Einführung einer neuen Komponente prüfen:

- Kann eine bestehende Komponente erweitert werden?
- Ist die Komponente fachlich unabhängig?
- Nutzt sie ausschließlich Design Tokens?
- Funktioniert sie responsiv?
- Unterstützt sie alle Erscheinungsbilder?
- Ist sie barrierefrei?
- Besitzt sie Widget-Tests?

Nur wenn alle Fragen mit **Ja** beantwortet werden, wird eine neue gemeinsame Komponente aufgenommen.