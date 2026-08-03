# CHART_GUIDELINES.md

**Status:** Verbindliche UI-Spezifikation  
**Version:** 1.0 (Draft)  
**Stand:** 3. August 2026

---

# 1. Zweck

Diese Spezifikation definiert die verbindlichen Regeln für alle Diagramme, Datenvisualisierungen und grafischen Auswertungen des Health Trackers.

Sie ergänzt den `UI_GUIDE.md` sowie die `COMPONENT_LIBRARY.md` und stellt sicher, dass sämtliche Diagramme unabhängig vom Fachbereich einheitlich dargestellt und bedient werden.

Diagramme dienen ausschließlich dem besseren Verständnis von Gesundheitsdaten. Sie ersetzen niemals die zugrunde liegenden Messwerte.

---

# 2. Grundprinzipien

Diagramme sollen

- Entwicklungen verständlich darstellen,
- Trends schnell erkennbar machen,
- medizinische Zusammenhänge unterstützen,
- nicht überladen wirken,
- auch ohne Diagramm interpretierbar bleiben.

Die Darstellung orientiert sich stets an der Fragestellung des Benutzers und nicht an möglichst vielen grafischen Elementen.

---

# 3. Allgemeine Regeln

Alle Diagramme

- verwenden ausschließlich Theme-Tokens,
- funktionieren in allen Erscheinungsbildern,
- sind responsiv,
- unterstützen große Schrift,
- besitzen ausreichende Kontraste,
- sind mit Tastatur und Screenreader bedienbar.

---

# 4. Diagrammarten

Folgende Diagrammtypen sind zulässig.

## 4.1 Liniendiagramm

Verwendung:

- zeitliche Entwicklungen
- Messwertverläufe
- Trends

Beispiele:

- Gewicht
- Blutdruck
- Blutzucker
- Ruhepuls

---

## 4.2 Balkendiagramm

Verwendung:

- Vergleiche
- Häufigkeiten
- Zeiträume

Beispiele:

- Trainingseinheiten pro Woche
- Medikamenteneinnahmen
- Schritte pro Tag

---

## 4.3 Säulendiagramm

Verwendung:

- Monats- oder Jahresvergleiche
- Zielerreichung

---

## 4.4 Kreisdiagramm

Nur verwenden, wenn Anteile eines Ganzen dargestellt werden.

Beispiele:

- Makronährstoffverteilung
- Trainingsarten

Nicht geeignet für Zeitreihen.

---

## 4.5 Fortschrittsdiagramm

Darstellung eines Zieles.

Beispiele:

- Gewichtsziel
- Trainingsziel
- Trinkziel

---

# 5. Farben

Diagramme verwenden ausschließlich

- Bereichsfarben,
- neutrale Farben,
- Statusfarben.

Profilfarben dürfen niemals Datenreihen darstellen.

Bei mehreren Datenreihen bleibt jede Farbe innerhalb des gesamten Systems konsistent.

---

# 6. Achsen

Alle Achsen besitzen

- eindeutige Beschriftung,
- Einheiten,
- sinnvolle Skalierung.

Beispiele:

- kg
- cm
- mmHg
- mg/dl
- %

Achsen dürfen nicht irreführend abgeschnitten werden.

---

# 7. Zeitachsen

Zeitliche Diagramme unterstützen abhängig vom Datenbestand:

- Tag
- Woche
- Monat
- Quartal
- Jahr

Der Benutzer kann zwischen den verfügbaren Zeiträumen wechseln.

---

# 8. Datenpunkte

Messpunkte

- bleiben eindeutig erkennbar,
- können ausgewählt werden,
- zeigen Detailinformationen.

Bei sehr großen Datenmengen dürfen Punkte zusammengefasst werden.

---

# 9. Tooltips

Ein Tooltip zeigt mindestens

- Messwert,
- Einheit,
- Datum,
- Uhrzeit (falls relevant),
- Quelle.

Beispiel:

Gewicht

82,4 kg

03.08.2026

manuell erfasst

---

# 10. Legenden

Legenden

- erscheinen nur bei mehreren Datenreihen,
- verwenden dieselben Farben wie das Diagramm,
- dürfen einzelne Datenreihen ein- und ausblenden.

---

# 11. Zielwerte

Sollwerte werden

- als Referenzlinie,
- Referenzbereich oder
- Zielmarkierung

dargestellt.

Sie unterscheiden sich eindeutig von echten Messwerten.

---

# 12. Hinweise und Auffälligkeiten

Auffällige Werte dürfen hervorgehoben werden.

Beispiele:

- ungewöhnlicher Sprung
- fehlende Messungen
- inkonsistente Werte

Hinweise ersetzen niemals medizinische Bewertungen.

---

# 13. Fehlende Daten

Fehlende Messungen werden

- nicht interpoliert,
- klar kenntlich gemacht.

Der Benutzer erkennt jederzeit, ob tatsächlich keine Daten vorhanden sind.

---

# 14. Zoom und Navigation

Diagramme unterstützen bei Bedarf

- Zoomen,
- horizontales Scrollen,
- Zeitraumwechsel.

Die Standardansicht bleibt einfach verständlich.

---

# 15. Barrierefreiheit

Alle Diagramme besitzen zusätzlich

- eine textliche Zusammenfassung,
- semantische Beschreibung,
- ausreichende Kontraste.

Informationen dürfen niemals ausschließlich grafisch vermittelt werden.

---

# 16. Responsive Verhalten

## Smartphone

- vereinfachte Darstellung
- reduzierte Beschriftungen
- horizontales Scrollen bei Bedarf

---

## Tablet

- vollständige Darstellung
- größere Legenden
- komfortable Bedienung

---

## Desktop

- größere Diagrammflächen
- zusätzliche Vergleichsansichten möglich

---

# 17. Performance

Diagramme

- laden schrittweise,
- vermeiden unnötige Animationen,
- aktualisieren sich effizient.

Sehr große Datenmengen werden sinnvoll aggregiert.

---

# 18. Datenschutz

Diagramme beachten den aktiven Profilschutz.

Ausgeblendete Daten erscheinen weder

- im Diagramm,
- in Tooltips,
- noch in Zusammenfassungen.

---

# 19. Flutter-Regeln

Diagramme

- verwenden ausschließlich gemeinsame Diagrammkomponenten,
- enthalten keine Geschäftslogik,
- beziehen Daten ausschließlich über definierte ViewModels,
- verwenden Theme-Tokens,
- unterstützen alle Erscheinungsbilder.

---

# 20. Prüfliste

Vor Freigabe eines Diagramms prüfen:

- Ist die geeignete Diagrammart gewählt?
- Sind Achsen eindeutig beschriftet?
- Werden Einheiten angezeigt?
- Sind Zielwerte klar von Messwerten getrennt?
- Sind Auffälligkeiten nachvollziehbar dargestellt?
- Funktioniert das Diagramm responsiv?
- Unterstützt es Screenreader?
- Existiert eine textliche Zusammenfassung?
- Werden ausschließlich Theme-Tokens verwendet?
- Ist die Darstellung performant?

Nur wenn alle Punkte erfüllt sind, gilt ein Diagramm als freigegeben.