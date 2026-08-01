# UI_GUIDE.md

> HealthTracker User Interface & User Experience Standard

---

# Dokumentinformationen

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-UI-001 |
| Dokumenttyp | Projektstandard |
| Kategorie | User Interface / User Experience |
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
| 1.0.0 | 2026-07-31 | Erste Version erstellt | Einführung eines projektweiten UI-/UX-Standards | HealthTracker Team |

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

Nach Abschluss aller vier Teile wird ein Qualitätsindex von mindestens **95 %** angestrebt.

---

# Zweck

Dieses Dokument definiert den verbindlichen UI-/UX-Standard des HealthTracker-Projekts.

Es beschreibt:

- Designsystem
- Komponenten
- Navigation
- Responsive Design
- Barrierefreiheit
- Datenvisualisierung
- Flutter-UI-Konventionen
- Dashboard-Regeln
- Design Tokens

Der Standard gewährleistet eine konsistente Benutzeroberfläche auf allen unterstützten Plattformen.

---

# Ziele

Die Benutzeroberfläche verfolgt folgende Ziele:

- einfache Bedienbarkeit
- hohe Wiedererkennbarkeit
- konsistente Gestaltung
- schnelle Orientierung
- geringe kognitive Belastung
- Barrierefreiheit
- Plattformunabhängigkeit
- Erweiterbarkeit

---

# Geltungsbereich

Dieser Standard gilt für sämtliche UI-Komponenten.

Insbesondere für

- Dashboard
- Profile
- Messwerte
- Ernährung
- Medikamente
- Analyse
- Einstellungen
- Dialoge
- Formulare
- Diagramme
- Navigation

---

# UI-Prinzipien

## Einfachheit

Die Benutzeroberfläche soll möglichst einfach sein.

Jede Ansicht besitzt einen klaren Schwerpunkt.

---

## Konsistenz

Gleiche Elemente verhalten sich überall identisch.

Beispiele

- Buttons
- Dialoge
- Karten
- Eingabefelder
- Navigation
- Fehlermeldungen

---

## Vorhersagbarkeit

Benutzer sollen jederzeit erkennen können,

- was möglich ist,
- was als Nächstes passiert,
- welche Auswirkungen eine Aktion besitzt.

---

## Lesbarkeit

Informationen besitzen eine klare visuelle Hierarchie.

Wichtige Informationen stehen im Vordergrund.

---

## Wenige Ablenkungen

Dekorative Elemente werden auf das notwendige Maß reduziert.

Gesundheitsdaten stehen im Mittelpunkt.

---

## Feedback

Jede Benutzeraktion erzeugt eine erkennbare Rückmeldung.

Beispiele

- Speichern erfolgreich
- Profil gelöscht
- Fehler aufgetreten
- Daten synchronisiert

---

# UX-Grundsätze

Die Benutzerführung orientiert sich an folgenden Prinzipien.

---

## Klarheit

Jede Seite beantwortet unmittelbar:

- Wo bin ich?
- Was kann ich tun?
- Was passiert als Nächstes?

---

## Effizienz

Häufig verwendete Funktionen sind mit möglichst wenigen Interaktionen erreichbar.

---

## Fehlertoleranz

Fehleingaben sollen möglichst verhindert werden.

Ist dies nicht möglich,

werden verständliche Hinweise angezeigt.

---

## Wiedererkennung

Benutzer sollen Informationen wiedererkennen,

anstatt sie auswendig lernen zu müssen.

---

## Kontrolle

Benutzer behalten jederzeit die Kontrolle.

Kritische Aktionen benötigen eine Bestätigung.

---

# Designsystem

Das HealthTracker-Designsystem definiert sämtliche visuellen Grundelemente.

Es besteht aus:

- Farben
- Typografie
- Icons
- Abständen
- Komponenten
- Animationen
- Design Tokens

Alle UI-Komponenten basieren ausschließlich auf diesem Designsystem.

---

# Design Tokens

Design Tokens definieren zentrale Gestaltungswerte.

Sie dienen als einzige Quelle für wiederverwendbare UI-Eigenschaften.

---

## Token-Kategorien

```text
Colors

Typography

Spacing

Border Radius

Elevation

Icons

Animations

Breakpoints
```

---

## Regeln

Design Tokens

- werden zentral definiert,
- werden nicht lokal überschrieben,
- besitzen eindeutige Namen,
- sind plattformunabhängig.

---

## Beispiel

```text
color.primary

spacing.medium

radius.large

font.body

animation.standard
```

---

# Farbkonzept

Farben besitzen eine eindeutige Bedeutung.

---

## Primärfarben

Dienen der Navigation und den Hauptaktionen.

---

## Sekundärfarben

Unterstützen Inhalte.

---

## Statusfarben

| Bedeutung | Verwendung |
|------------|------------|
| Grün | Ziel erreicht |
| Gelb | Aufmerksamkeit |
| Rot | Kritischer Wert |
| Blau | Information |
| Grau | Neutral |

---

## Profilfarben

Jedes Profil besitzt eine eigene Akzentfarbe.

Die Profilfarbe dient ausschließlich der Orientierung.

Sie ersetzt niemals Statusfarben.

---

## Regeln

Farben dürfen niemals die einzige Informationsquelle sein.

Statusinformationen werden zusätzlich dargestellt durch

- Symbole
- Texte
- Icons
- Hervorhebungen

---

# Typografie

Die Typografie folgt einer klaren Hierarchie.

---

## Ebenen

```text
Display

Headline

Title

Body

Caption

Label
```

---

## Regeln

- einheitliche Schriftfamilie
- ausreichender Kontrast
- ausreichender Zeilenabstand
- keine dekorativen Schriftarten

---

# Icons

Icons unterstützen die Benutzerführung.

---

## Regeln

Icons

- besitzen überall dieselbe Bedeutung,
- werden sparsam eingesetzt,
- besitzen ausreichende Größe,
- erhalten bei Bedarf Textbeschriftungen.

---

## Beispiele

```text
Profil

Dashboard

Messung

Ernährung

Medikamente

Analyse

Einstellungen

Backup
```

---

# Datenvisualisierung

Gesundheitsdaten werden nach einheitlichen Regeln dargestellt.

---

## Ziele

Diagramme sollen

- leicht verständlich,
- vergleichbar,
- barrierefrei,
- konsistent

sein.

---

## Darstellungsregeln

Alle Diagramme besitzen

- Titel
- Achsenbeschriftungen
- Einheiten
- Zeiträume
- Legenden (falls erforderlich)

---

## Farbregeln

Für Diagramme gelten dieselben Statusfarben wie im gesamten UI.

Zusätzlich dürfen Linien, Muster oder Symbole verwendet werden.

---

## Fehlende Daten

Fehlende Messwerte werden eindeutig gekennzeichnet.

Sie dürfen niemals als Nullwert dargestellt werden.

---

# Status dieses Teils

Mit Teil 1 sind definiert:

- Dokumentinformationen
- Dokumenthistorie
- Dokumentqualität
- Zweck
- Ziele
- Geltungsbereich
- UI-Prinzipien
- UX-Grundsätze
- Designsystem
- Design Tokens
- Farbkonzept
- Profilfarben
- Typografie
- Icons
- Datenvisualisierung

---

## Teil 2

Der nächste Abschnitt behandelt:

- Grid-System
- Responsive Design
- Seitenlayout
- Navigation
- Dashboard
- Cards
- Listen
- Dialoge
- Buttons
- Formulare
- Eingabefelder
- Validierung
- Diagramm-Komponenten

# Layout-System

HealthTracker verwendet ein einheitliches Layoutsystem für alle unterstützten Plattformen.

Das Layout basiert auf einem responsiven Grid-System.

---

# Grid-System

Alle Seiten orientieren sich an einem flexiblen Raster.

## Ziele

- konsistente Ausrichtung
- klare Struktur
- optimale Lesbarkeit
- einfache Erweiterbarkeit

---

## Grundregeln

Alle Inhalte werden an einem gemeinsamen Raster ausgerichtet.

Komponenten dürfen das Raster nicht eigenständig verlassen.

---

# Abstände (Spacing)

Alle Abstände werden ausschließlich über Design Tokens definiert.

---

## Standardwerte

| Token | Verwendung |
|--------|------------|
| spacing.xs | sehr kleine Abstände |
| spacing.sm | kleine Abstände |
| spacing.md | Standardabstand |
| spacing.lg | große Bereiche |
| spacing.xl | Abschnittsabstände |

---

## Regeln

Es werden keine festen Pixelwerte im Widget-Code verwendet.

Abstände erfolgen ausschließlich über zentrale Tokens.

---

# Seitenlayout

Jede Seite besitzt denselben strukturellen Aufbau.

```text
AppBar

↓

Seitenüberschrift

↓

Hauptinhalt

↓

Optionale Aktionsleiste

↓

Footer (falls erforderlich)
```

---

# Responsive Design

Die Benutzeroberfläche passt sich automatisch an unterschiedliche Bildschirmgrößen an.

---

## Unterstützte Plattformen

- Web
- Windows
- iPad
- zukünftige Smartphones

---

## Breakpoints

| Bereich | Darstellung |
|----------|-------------|
| Small | einspaltig |
| Medium | zwei Spalten |
| Large | mehrspaltig |
| Extra Large | Dashboard-Layout |

Die konkreten Schwellenwerte werden zentral als Design Tokens definiert.

---

# Navigation

Die Navigation muss auf allen Plattformen konsistent funktionieren.

---

## Grundprinzipien

- maximal drei Navigationsebenen
- eindeutige Seitenhierarchie
- jederzeit erkennbare Position
- Rücknavigation möglich

---

## Navigationsarten

Je nach Plattform werden verwendet:

- Navigation Rail
- Navigation Drawer
- Bottom Navigation
- Tab Navigation

Die Auswahl richtet sich nach Bildschirmgröße und Nutzungskontext.

---

# Dashboard

Das Dashboard ist der zentrale Einstiegspunkt.

---

## Anforderungen

Benutzer können:

- Widgets hinzufügen
- Widgets entfernen
- Reihenfolge ändern
- Größe anpassen (wenn unterstützt)
- Standardlayout wiederherstellen

---

## Dashboard-Komponenten

Beispiele:

```text
Profil

Gewicht

Bauchumfang

Blutdruck

Puls

Ernährung

Aktivität

Empfehlungen
```

---

## Dashboard-Regeln

Widgets

- besitzen ein einheitliches Layout,
- zeigen aktuelle Daten,
- reagieren auf Profilwechsel,
- unterstützen leere Zustände.

---

# Cards

Informationen werden bevorzugt in Cards dargestellt.

---

## Eigenschaften

Cards besitzen:

- Titel
- Inhalt
- optionale Aktionen
- optionale Statusanzeige

---

## Regeln

Cards

- besitzen einheitliche Radien,
- verwenden zentrale Elevation-Tokens,
- enthalten keine verschachtelten Cards.

---

# Listen

Listen dienen der Darstellung größerer Datenmengen.

---

## Beispiele

- Profile
- Medikamente
- Messwerte
- Backups

---

## Regeln

Listen unterstützen:

- Sortierung
- Filterung
- Suche
- leere Zustände

---

# Dialoge

Dialoge dienen ausschließlich kurzfristigen Interaktionen.

---

## Geeignete Anwendungsfälle

- Bestätigungen
- Warnungen
- Eingaben
- Informationen

---

## Regeln

Dialoge

- blockieren keine komplexen Arbeitsabläufe,
- besitzen eindeutige Aktionen,
- enthalten maximal eine Hauptaktion.

---

# Buttons

Buttons folgen einer einheitlichen Hierarchie.

---

## Button-Typen

| Typ | Verwendung |
|------|------------|
| Primary | wichtigste Aktion |
| Secondary | alternative Aktion |
| Tertiary | optionale Aktion |
| Icon | Symbolaktion |

---

## Regeln

Es existiert pro Ansicht höchstens ein Primary Button.

---

# Eingabefelder

Alle Eingabefelder besitzen ein einheitliches Erscheinungsbild.

---

## Bestandteile

- Label
- Eingabefeld
- Hilfetext
- Fehlermeldung
- Einheit (falls erforderlich)

---

## Beispiele

```text
Gewicht (kg)

Größe (cm)

Bauchumfang (cm)

Blutdruck (mmHg)
```

---

# Formulare

Formulare folgen einem konsistenten Aufbau.

---

## Reihenfolge

```text
Titel

↓

Beschreibung

↓

Eingabefelder

↓

Fehlermeldungen

↓

Aktionen
```

---

## Regeln

- sinnvolle Feldreihenfolge
- logische Gruppierung
- Pflichtfelder kennzeichnen
- automatische Validierung
- Fokussteuerung

---

# Validierung

Fehler werden unmittelbar am Eingabefeld angezeigt.

---

## Regeln

Fehlermeldungen

- sind verständlich,
- beschreiben das Problem,
- geben einen Lösungshinweis.

---

## Beispiele

Nicht

```text
Ungültige Eingabe
```

Sondern

```text
Bitte geben Sie eine Körpergröße zwischen 20 cm und 300 cm ein.
```

---

# Diagramm-Komponenten

Alle Diagramme verwenden dieselben Grundelemente.

---

## Bestandteile

- Titel
- Zeitraum
- Achsen
- Einheiten
- Legende
- Tooltip
- Statusanzeige

---

## Unterstützte Diagramme

```text
Liniendiagramm

Balkendiagramm

Kreisdiagramm

Trenddiagramm
```

---

# Vergleichsansichten

HealthTracker unterstützt den Vergleich von Messwerten.

---

## Beispiele

- Profil A ↔ Profil B
- aktueller Monat ↔ Vormonat
- Gewicht ↔ Bauchumfang
- Blutdruck ↔ Puls

---

## Regeln

Vergleichsdaten

- werden eindeutig beschriftet,
- verwenden konsistente Farben,
- bleiben auch ohne Farbe unterscheidbar.

---

# Leere Zustände

Jede Komponente unterstützt einen Empty State.

---

## Beispiele

```text
Noch keine Messwerte vorhanden.

Jetzt ersten Messwert erfassen.
```

---

# Status dieses Teils

Mit Teil 2 sind definiert:

- Layout-System
- Grid-System
- Design Tokens für Abstände
- Responsive Design
- Navigation
- Dashboard
- Dashboard-Regeln
- Cards
- Listen
- Dialoge
- Buttons
- Eingabefelder
- Formulare
- Validierung
- Diagramm-Komponenten
- Vergleichsansichten
- Empty States

---

## Teil 3

Der nächste Abschnitt behandelt:

- Loading States
- Error States
- Success States
- Animationen
- Mikrointeraktionen
- Barrierefreiheit (WCAG)
- Tastaturbedienung
- Screenreader
- Fokussteuerung
- Mehrsprachigkeit
- Plattformbesonderheiten

# Interaktionsprinzipien

Jede Benutzerinteraktion muss eindeutig, nachvollziehbar und konsistent sein.

Der Benutzer erhält jederzeit eine Rückmeldung über den aktuellen Zustand der Anwendung.

---

# Zustände (States)

Jede UI-Komponente unterstützt definierte Zustände.

---

## Loading State

Während einer laufenden Verarbeitung wird ein Ladezustand angezeigt.

Beispiele

- Daten werden geladen
- Backup wird erstellt
- Import läuft
- Synchronisation läuft

---

## Regeln

Loading-Anzeigen

- blockieren nur notwendige Bereiche,
- zeigen den Fortschritt an (falls möglich),
- vermeiden unnötige Wartezeiten.

---

## Empty State

Leere Datenbereiche erhalten eine erklärende Darstellung.

Beispiel

```text
Noch keine Messwerte vorhanden.

Jetzt ersten Messwert erfassen.
```

---

## Error State

Fehler werden verständlich dargestellt.

---

### Regeln

Fehlermeldungen

- beschreiben das Problem,
- enthalten eine mögliche Lösung,
- vermeiden technische Begriffe.

---

### Beispiel

Nicht

```text
Error 500
```

Sondern

```text
Die Messwerte konnten momentan nicht geladen werden.

Bitte versuchen Sie es erneut.
```

---

## Success State

Erfolgreiche Aktionen werden bestätigt.

Beispiele

- Profil gespeichert
- Backup erstellt
- Messwert übernommen

Die Rückmeldung erfolgt möglichst unaufdringlich.

---

# Benutzerfeedback

Jede Benutzeraktion erzeugt eine erkennbare Rückmeldung.

---

## Beispiele

- Button reagiert sofort
- Eingabe übernommen
- Speichern erfolgreich
- Warnung angezeigt

---

# Animationen

Animationen unterstützen die Orientierung.

Sie dienen niemals ausschließlich dekorativen Zwecken.

---

## Einsatzgebiete

- Seitenwechsel
- Einblenden
- Ausblenden
- Dialoge
- Dashboard-Änderungen
- Listenanimationen

---

## Regeln

Animationen

- sind kurz,
- flüssig,
- dezent,
- jederzeit nachvollziehbar.

---

## Verboten

Nicht zulässig:

- blinkende Elemente
- übermäßige Bewegungen
- lange Warteanimationen
- Animationen ohne funktionalen Nutzen

---

# Mikrointeraktionen

Kleine Animationen unterstützen die Bedienung.

Beispiele

- Button-Feedback
- Checkbox
- Umschalter
- Ladeindikator
- Pull-to-Refresh

---

# Barrierefreiheit

HealthTracker orientiert sich an den WCAG-Richtlinien.

---

## Ziele

Die Anwendung soll möglichst vielen Menschen zugänglich sein.

---

## Anforderungen

- ausreichender Farbkontrast
- skalierbare Schriftgrößen
- Tastaturbedienung
- Screenreader-Unterstützung
- ausreichende Touch-Ziele
- Fokussteuerung

---

# Farbunabhängigkeit

Informationen dürfen niemals ausschließlich durch Farben vermittelt werden.

Zusätzlich verwendet werden

- Symbole
- Texte
- Muster
- Hervorhebungen

---

# Tastaturbedienung

Alle wesentlichen Funktionen müssen vollständig per Tastatur bedienbar sein.

---

## Regeln

Benutzer können

- navigieren,
- Formulare ausfüllen,
- Dialoge bedienen,
- Aktionen ausführen,

ohne Maus.

---

# Fokussteuerung

Der Fokus folgt einer logischen Reihenfolge.

---

## Regeln

- sichtbarer Fokus
- nachvollziehbare Reihenfolge
- keine Fokusfallen
- Rückkehr nach Dialogen

---

# Screenreader

Alle interaktiven Komponenten erhalten verständliche Beschreibungen.

---

## Beispiele

Nicht

```text
Button
```

Sondern

```text
Profil speichern
```

---

# Schriftgrößen

Texte müssen skalierbar sein.

---

## Regeln

Die Benutzeroberfläche bleibt auch bei vergrößerter Schrift vollständig bedienbar.

---

# Touch-Bedienung

Touch-Ziele besitzen ausreichende Größe.

---

## Beispiele

Buttons

Icons

Checkboxen

Schalter

---

# Mehrsprachigkeit

Die Benutzeroberfläche unterstützt mehrere Sprachen.

---

## Regeln

Alle sichtbaren Texte

- werden lokalisiert,
- besitzen keine Hardcodierung,
- unterstützen unterschiedliche Textlängen.

---

# Datums- und Zahlenformate

Anzeigeformate orientieren sich an der eingestellten Sprache.

---

## Beispiele

Datum

```text
31.07.2026
```

Gewicht

```text
82,4 kg
```

Blutdruck

```text
120 / 80 mmHg
```

---

# Plattformbesonderheiten

Die Anwendung berücksichtigt Unterschiede zwischen den Plattformen.

---

## Web

- responsive Layouts
- Tastaturbedienung
- Browser-Kompatibilität

---

## Windows

- Fenstergrößen
- Mausbedienung
- Tastatursteuerung

---

## iPad

- Touch-Gesten
- Landscape
- Portrait
- Split View (zukünftig)

---

## Android (zukünftige Unterstützung)

- Material Design
- Gesten
- Berechtigungen
- unterschiedliche Displaygrößen

---

# Profilwechsel

Der Wechsel zwischen Profilen erfolgt jederzeit nachvollziehbar.

---

## Regeln

Nach einem Profilwechsel

- werden alle Daten aktualisiert,
- Dashboard neu aufgebaut,
- Filter zurückgesetzt (falls erforderlich),
- Profilfarbe übernommen.

---

# Dashboard-Anpassung

Anpassungen des Dashboards erfolgen unmittelbar.

---

## Beispiele

- Widget verschieben
- Widget entfernen
- Widget hinzufügen

Alle Änderungen werden automatisch gespeichert.

---

# Offline-Verhalten

Offline-Zustände werden klar dargestellt.

---

## Beispiele

```text
Keine Internetverbindung.

Alle Daten werden lokal gespeichert.
```

---

# Performance

Die Benutzeroberfläche reagiert flüssig.

---

## Ziele

- kurze Reaktionszeiten
- keine sichtbaren Ruckler
- schnelle Listen
- effiziente Diagramme

---

# Status dieses Teils

Mit Teil 3 sind definiert:

- Loading State
- Empty State
- Error State
- Success State
- Benutzerfeedback
- Animationen
- Mikrointeraktionen
- Barrierefreiheit
- Farbunabhängigkeit
- Tastaturbedienung
- Fokussteuerung
- Screenreader
- Schriftgrößen
- Touch-Bedienung
- Mehrsprachigkeit
- Datums- und Zahlenformate
- Plattformbesonderheiten
- Profilwechsel
- Dashboard-Anpassung
- Offline-Verhalten
- Performance

---

## Teil 4

Der letzte Abschnitt behandelt:

- Flutter-UI-Regeln
- Widget-Konventionen
- Design-System-Governance
- UI-Review
- Anti-Patterns
- Best Practices
- Qualitätsmetriken
- Referenzen
- Änderungsverlauf
- Freigabe
- Änderungsstopp

# Flutter-UI-Regeln

HealthTracker verwendet Flutter als plattformübergreifendes UI-Framework.

Alle Benutzeroberflächen orientieren sich an den offiziellen Flutter-Richtlinien und diesem Projektstandard.

---

# Widget-Konventionen

Widgets besitzen eine klar definierte Verantwortung.

---

## Regeln

Ein Widget

- erfüllt genau eine Aufgabe,
- ist möglichst wiederverwendbar,
- besitzt einen klaren Namen,
- ist leicht testbar.

---

## Widget-Aufbau

Widgets werden nach folgendem Prinzip aufgebaut:

```text
Page

↓

Section

↓

Card

↓

Widget

↓

Control
```

---

## Seiten (Pages)

Pages bilden eigenständige Anwendungsbereiche.

Beispiele

```text
DashboardPage

ProfilePage

MeasurementPage

NutritionPage

SettingsPage
```

---

## Sections

Sections strukturieren größere Seiten.

Beispiele

```text
DashboardSection

StatisticsSection

RecommendationSection
```

---

## Wiederverwendbare Widgets

Gemeinsame Komponenten werden zentral verwaltet.

Beispiele

```text
PrimaryButton

SecondaryButton

MeasurementCard

ProfileAvatar

SectionHeader

InfoCard

LoadingIndicator
```

---

# Design-System-Governance

Alle neuen UI-Komponenten müssen Bestandteil des Designsystems werden.

---

## Regeln

Neue Komponenten

- verwenden Design Tokens,
- dokumentieren ihre Eigenschaften,
- werden wiederverwendbar entwickelt,
- besitzen Widget-Tests.

---

# UI-Konsistenz

Neue Komponenten dürfen bestehende Muster nicht durchbrechen.

Vor Einführung neuer Komponenten ist zu prüfen,

ob bereits eine geeignete Lösung existiert.

---

# Widget-Namenskonventionen

Widget-Namen verwenden PascalCase.

---

## Beispiele

```text
DashboardCard

ProfileHeader

MeasurementTile

RecommendationCard

BackupDialog
```

---

## Dateinamen

Dateien verwenden snake_case.

```text
dashboard_card.dart

profile_header.dart

measurement_tile.dart

backup_dialog.dart
```

---

# Widget-Komposition

Große Widgets werden in kleinere Komponenten zerlegt.

---

## Ziel

- bessere Lesbarkeit
- höhere Wiederverwendbarkeit
- einfachere Tests

---

# State Management

UI-Komponenten enthalten möglichst wenig Geschäftslogik.

---

## Regeln

Business-Logik gehört ausschließlich in

- Use Cases
- Services
- Riverpod Notifier

Widgets stellen Daten dar und reagieren auf Zustandsänderungen.

---

# Designsystem-Erweiterungen

Neue Farben, Abstände oder Komponenten dürfen ausschließlich zentral ergänzt werden.

Lokale Sonderlösungen sind nicht zulässig.

---

# UI-Review

Vor der Freigabe werden Benutzeroberflächen geprüft.

---

## Prüfkriterien

- Konsistenz
- Lesbarkeit
- Barrierefreiheit
- Performance
- Responsivität
- Designsystem
- Navigation
- Benutzerführung

---

# UI-Review-Checkliste

## Layout

- [ ] Raster eingehalten
- [ ] Abstände korrekt
- [ ] Responsive Darstellung

---

## Komponenten

- [ ] Design Tokens verwendet
- [ ] Wiederverwendbare Widgets
- [ ] Keine Duplikate

---

## Formulare

- [ ] Validierung vorhanden
- [ ] Fehlermeldungen verständlich
- [ ] Einheiten korrekt

---

## Dashboard

- [ ] Widgets korrekt dargestellt
- [ ] Profilwechsel geprüft
- [ ] Leere Zustände vorhanden

---

## Diagramme

- [ ] Einheiten korrekt
- [ ] Legende vorhanden
- [ ] Fehlende Daten korrekt dargestellt
- [ ] Farben und Symbole konsistent

---

## Barrierefreiheit

- [ ] Kontrast ausreichend
- [ ] Screenreader unterstützt
- [ ] Tastaturbedienung möglich
- [ ] Fokus sichtbar

---

## Performance

- [ ] Keine unnötigen Rebuilds
- [ ] Listen optimiert
- [ ] Animationen flüssig

---

# Anti-Patterns

Folgende Vorgehensweisen sind projektweit unzulässig.

---

## UI-AP-001 – Hardcodierte Farben

Alle Farben werden ausschließlich über Design Tokens definiert.

---

## UI-AP-002 – Hardcodierte Abstände

Abstände dürfen nicht direkt im Widget definiert werden.

---

## UI-AP-003 – Business-Logik im Widget

Widgets enthalten keine fachliche Logik.

---

## UI-AP-004 – Verschachtelte Komponenten

Unnötig tiefe Widget-Hierarchien sind zu vermeiden.

---

## UI-AP-005 – Uneinheitliche Navigation

Neue Seiten müssen dem definierten Navigationskonzept folgen.

---

## UI-AP-006 – Farbabhängige Informationen

Informationen dürfen niemals ausschließlich durch Farben dargestellt werden.

---

## UI-AP-007 – Nicht lokalisierte Texte

Sichtbare Texte dürfen nicht hardcodiert werden.

---

## UI-AP-008 – Nicht getestete Widgets

Wiederverwendbare Widgets müssen Widget-Tests besitzen.

---

# Best Practices

Folgende Vorgehensweisen werden empfohlen.

---

## Mobile First

Layouts werden zunächst für kleine Bildschirme entworfen und anschließend erweitert.

---

## Konsistente Komponenten

Bestehende Komponenten werden bevorzugt wiederverwendet.

---

## Klare Hierarchie

Wichtige Informationen stehen im Vordergrund.

---

## Sofortiges Feedback

Jede Benutzeraktion erhält eine unmittelbare Rückmeldung.

---

## Zugänglichkeit

Barrierefreiheit wird bereits bei der Entwicklung berücksichtigt.

---

## Weniger ist mehr

Komplexität wird reduziert.

Gesundheitsdaten stehen im Mittelpunkt.

---

# UI-KPIs

Zur Bewertung der Benutzeroberfläche werden folgende Kennzahlen erhoben.

| Kennzahl | Ziel |
|-----------|------|
| Responsive Seiten | 100 % |
| Wiederverwendbare Komponenten | ≥ 90 % |
| Widget-Testabdeckung | ≥ 90 % |
| Hardcodierte Farben | 0 |
| Hardcodierte Abstände | 0 |
| Barrierefreie Seiten | 100 % |
| Lokalisierte Texte | 100 % |
| Kritische UI-Fehler | 0 |

---

# Kontinuierliche Verbesserung

Der UI-Standard wird regelmäßig überprüft.

Verbesserungen stammen aus:

- UX-Tests
- Benutzerfeedback
- UI-Reviews
- Accessibility-Reviews
- Performance-Analysen
- Release-Retrospektiven

Änderungen erfolgen ausschließlich über eine neue Dokumentversion.

---

# Referenzen

Dieser Standard baut auf folgenden Projektdokumenten auf:

- DOCUMENTATION_STANDARD.md
- STYLE_GUIDE.md
- NAMING_CONVENTIONS.md
- REVIEW_GUIDE.md
- ARCHITECTURE_GUIDE.md
- TESTING_GUIDE.md
- SECURITY_GUIDE.md
- GIT_GUIDE.md
- REQUIREMENTS_GUIDE.md

Zusätzlich gelten:

- Architecture Decision Records (ADR)
- Flutter Design System
- Moduldokumentationen

---

# Änderungsverlauf

| Version | Datum | Änderung | Grund |
|----------|-------|----------|-------|
| 1.0.0 | 2026-07-31 | Erste freigegebene Version | Projektstandard |

---

# Freigabe

| Feld | Wert |
|------|------|
| Dokument-ID | DOC-STD-UI-001 |
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
4. Erneutes UI-Review.
5. Dokumentation wesentlicher Änderungen über Traceability und ADR.

Direkte Änderungen an einer freigegebenen Version sind nicht zulässig.

---

# Status

**Dokument:** `docs/standards/UI_GUIDE.md`

**Version:** 1.0.0

**Status:** ✅ Approved