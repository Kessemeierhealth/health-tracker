# Health Tracker – Home Page Specification

**Status:** Verbindliche Seitenspezifikation  
**Version:** 1.0  
**Stand:** 3. August 2026  
**Übergeordnete Grundlagen:** `../UI_GUIDE.md`, `../navigation/NAVIGATION_SPEC.md`

## 1. Zweck und Geltungsbereich

Dieses Dokument beschreibt Aufbau, Inhalt, Verhalten und Zustände der Startseite des Health Trackers. Es ist die verbindliche Grundlage für UX, Architektur, Flutter-Implementierung und Tests dieser Seite.

Der `../UI_GUIDE.md` definiert die systemweiten Gestaltungs- und Bedienregeln. Die `../navigation/NAVIGATION_SPEC.md` definiert Navigation und fachliche Bereichsgrenzen. Diese Spezifikation konkretisiert beide Dokumente für die Startseite.

## 2. Ziel der Startseite

Die Startseite beantwortet auf einen Blick:

1. Welches Profil ist aktiv?
2. Was ist jetzt oder heute relevant?
3. Gibt es einen neuen Erfolg?
4. Welche häufige Information kann schnell erfasst werden?

Die Startseite ist **kein Dashboard** und keine vollständige Gesundheitsübersicht. Sie bleibt ruhig, persönlich und handlungsorientiert.

## 3. Verbindliche Inhalte und Reihenfolge

Die Startseite enthält:

1. Kopfbereich mit Begrüßung und Tagesbezug,
2. Profilwechsel und Einstellungen,
3. einen dynamischen Eyecatcher,
4. den Bereich **Heute** mit relevanten Aufgaben und Erinnerungen,
5. die globale Aktion **Schnellerfassen**,
6. die einheitliche Hauptnavigation.

Nicht Bestandteil der Startseite sind:

- dauerhafte Messwertkarten,
- Dashboards, Diagramme und vollständige Verläufe,
- allgemeine Statistiken ohne aktuellen Handlungsbezug,
- vollständige Listen anderer Bereiche,
- ein Menüpunkt **Mehr**,
- ein Hauptbereich **Erfassen**.

## 4. Kopfbereich

Der Kopfbereich zeigt:

- eine kurze, tageszeitabhängige Begrüßung,
- optional Datum oder verständlichen Tagesbezug,
- oben rechts das aktive Profil,
- neben der Profilauswahl den Einstellungsbutton mit Zahnrad-Symbol.

Die Profilfarbe kennzeichnet ausschließlich das aktive Profil und niemals einen Gesundheitsstatus.

Aktionen:

- Die Profilauswahl öffnet den Profilwechsel.
- Das Zahnrad öffnet die Einstellungen.
- Profile werden ausschließlich unter **Einstellungen → Profile** angelegt, bearbeitet und gelöscht.
- Ein Profilwechsel aktualisiert alle Inhalte der Startseite gemeinsam und ohne Vermischung verschiedener Profile.

## 5. Dynamischer Eyecatcher

Der Eyecatcher ist das visuelle Leitelement der Startseite. Es gibt höchstens einen prominenten Eyecatcher. Er besitzt vier fachliche Zustände:

1. akuter sicherheitsrelevanter Hinweis,
2. neuer Meilenstein,
3. nächste wichtige Aufgabe oder nächster Termin,
4. ruhiger Leerzustand.

Er darf nicht zu einer Sammlung kleiner Dashboard-Karten werden.

### 5.1 Prioritätslogik

| Priorität | Inhalt | Bedingung |
|---:|---|---|
| 1 | akuter sicherheitsrelevanter Hinweis | unmittelbare Aufmerksamkeit ist erforderlich |
| 2 | neuer, ungesehener Meilenstein | Erfolg wurde erreicht und noch nicht gesehen |
| 3 | überfällige wichtige Aufgabe | Aufgabe ist fällig und als wichtig eingestuft |
| 4 | nächste wichtige Aufgabe oder nächster Termin | heute relevant und zeitlich am nächsten |
| 5 | ruhiger Leerzustand | kein vorrangiger Inhalt vorhanden |

Bei gleicher Priorität entscheidet zuerst die Dringlichkeit und danach der früheste Zeitpunkt. Inhalte des Eyecatchers werden nicht zusätzlich in **Heute** wiederholt.

### 5.2 Meilensteinzustand

Ein neuer Meilenstein zeigt:

- eine große zentrale Medaille oder Kreisform,
- die Erfolgszahl groß, kontrastreich und exakt mittig,
- Titel, kurze Bedeutung und Erreichungsdatum,
- die Zuordnung zu **Meine Gesundheit**, **Ernährung**, **Training** oder **Meine Entwicklung**,
- eine Aktion zu den Details,
- eine Aktion zum Schließen beziehungsweise als gesehen Markieren.

Der Zustand darf farbenfroher als die übrige Startseite sein. Er verwendet die Palette des zugehörigen Bereichs. Bereichsübergreifend dürfen mehrere helle Bereichsfarben kombiniert werden. Animationen sind kurz, optional und bei reduzierter Bewegung deaktiviert.

Meilensteine bleiben dauerhaft unter **Meine Entwicklung → Meilensteine** gespeichert. Schließen entfernt nur die Präsentation auf der Startseite. Sensible oder ausgeblendete Erfolge werden nicht offen angezeigt.

### 5.3 Aufgaben- oder Terminzustand

Dieser Zustand enthält:

- Bereichssymbol,
- kurze Überschrift,
- verständlichen Zeitpunkt oder Fälligkeit,
- knappe Einordnung,
- höchstens eine primäre kontextbezogene Aktion.

Die Gestaltung bleibt hell, freundlich und ruhig. Die Aktion führt direkt zur zuständigen Aufgabe oder zum zuständigen Bereich.

### 5.4 Ruhiger Leerzustand

Wenn nichts Relevantes ansteht, erscheint eine sachlich positive Botschaft, beispielsweise: **Für heute ist nichts Dringendes offen.** Der Zustand erzeugt keine künstlichen Aufgaben oder unbegründeten Gesundheitsbewertungen. **Schnellerfassen** bleibt erreichbar.

### 5.5 Sicherheitsrelevante Hinweise

Sicherheitsrelevante Hinweise verwenden sachliche Warnkommunikation und nennen die nächste sinnvolle Handlung. Sie werden nie allein durch Farbe vermittelt und nicht feierlich gestaltet.

Für Schließen und Zurückstellen gelten die systemweiten Regeln des `../UI_GUIDE.md`. Akute Sicherheitshinweise dürfen geschlossen, aber nicht für eine oder zwei Wochen beziehungsweise bis zu einem Datum unterdrückt werden. Bei erneut kritischen Daten dürfen sie wieder erscheinen.

## 6. Bereich „Heute“

### 6.1 Zulässige Inhalte

Der Bereich zeigt ausschließlich aktuell relevante Tagespunkte, beispielsweise:

- fällige Medikamenteneinnahme,
- Vorsorge- oder Gesundheitstermin,
- geplante Messung,
- Ernährungsaufgabe oder Erinnerung,
- geplantes Training,
- fehlende Daten, sofern sie für eine aktuelle Auswertung erforderlich sind.

### 6.2 Darstellung

- gemeinsame helle Listenfläche statt vieler bunter Karten,
- dezente Trennlinien,
- kleines Symbol oder schmaler Farbakzent der fachlichen Herkunft,
- Titel, Zeitpunkt, Status und klare Aktion,
- Status zusätzlich zu Farbe immer als Text oder Symbol,
- erledigte Aufgaben visuell zurücknehmen, aber eindeutig erkennbar lassen.

### 6.3 Sortierung und Umfang

Die Sortierung lautet:

1. überfällige wichtige Aufgaben,
2. zeitgebundene Aufgaben und Termine,
3. übrige relevante Tagespunkte.

Die sichtbare Anzahl bleibt kompakt. Weitere Einträge werden über eine klar beschriftete Aktion im zuständigen Bereich geöffnet. Die Startseite enthält keine endlose Aufgabenliste.

### 6.4 Zulässige Aktionen

Je nach fachlicher Regel darf ein Eintrag:

- geöffnet,
- als erledigt bestätigt,
- als Einnahme oder Durchführung erfasst,
- einmalig verschoben,
- im zuständigen Bereich weiterbearbeitet werden.

Destruktive oder medizinisch relevante Änderungen dürfen nicht durch unbeabsichtigte Wischgesten ausgelöst werden.

Für allgemeine Hinweismeldungen gelten systemweit **Schließen** und **Später erinnern**. **Später erinnern** bietet eine Woche, zwei Wochen oder ein gewähltes Datum. Die Aktionen verändern keine zugrunde liegenden Daten und gelten nur für das aktive Profil.

## 7. Schnellerfassen

### 7.1 Rolle

**Schnellerfassen** ist eine globale Aktion, aber kein sechster Navigationspunkt und kein eigener fachlicher Bereich. Die Startseite besitzt keine parallele Validierungs- oder Speicherlogik.

### 7.2 Öffnen

- Bei geringer Breite öffnet bevorzugt ein Bottom Sheet.
- Bei ausreichender Breite öffnet ein kompakter Dialog oder ein verankertes Auswahlfenster.

### 7.3 Erfassungsoptionen für Version 1.0

- Messwert,
- Medikamenteneinnahme,
- Gesundheitsnotiz,
- Training.

Ernährungsdaten werden zunächst unter **Ernährung** erfasst. Eine spätere Aufnahme muss ausdrücklich spezifiziert werden.

### 7.4 Delegation und Rückkehr

Nach der Auswahl öffnet die fachlich zuständige Eingabe. Beispielsweise verwendet **Messwert** dasselbe Formular wie die Messwertübersicht und die Aktion **Neuer Wert** auf einer Messwertkarte.

Nach erfolgreicher Speicherung:

- erscheint eine kurze unaufdringliche Bestätigung,
- kehrt die Person sinnvoll zum Ausgangskontext zurück,
- aktualisieren sich betroffene Startseiteninhalte,
- entstehen durch wiederholtes Antippen keine Duplikate.

## 8. Hauptnavigation

Die Navigation enthält in unveränderlicher Reihenfolge:

1. **Start**
2. **Meine Gesundheit**
3. **Ernährung**
4. **Training**
5. **Meine Entwicklung**

**Start** ist aktiv markiert. Reihenfolge, Icons, Ziele und Bedienverhalten sind auf allen Seiten identisch.

- Bei geringer verfügbarer Breite werden nur die fünf Icons angezeigt.
- Bei ausreichender Breite erscheinen dieselben Icons mit vollständigen Bezeichnungen.
- Die Umschaltung richtet sich nach verfügbarer Breite, nicht nach dem Gerätetyp.
- Bezeichnungen werden nicht gekürzt oder abgeschnitten.
- In der Icon-Darstellung gibt es vollständige Screenreader-Bezeichnungen und bei Mausbedienung Tooltips.
- Profil und Einstellungen bleiben unabhängig davon oben rechts.

## 9. Zielzuordnung

| Inhalt oder Aktion | Kanonisches Ziel |
|---|---|
| Messung, Medikament, Erkrankung, Gesundheitsnotiz, Vorsorge | Meine Gesundheit |
| Mahlzeit, Getränk, Ernährungsplanung, Rezept | Ernährung |
| Trainingsplan, Übung, Einheit, Trainingsziel | Training |
| Dashboard, Trend, Empfehlung, Profilvergleich | Meine Entwicklung |
| Meilenstein-Details, Timeline, Sammlung | Meine Entwicklung → Meilensteine |
| Profile, Geräte, Datenschutz, Backup, Darstellung | Einstellungen |

Die Zurück-Navigation erhält den vorherigen Zustand der Startseite, sofern dessen Datengrundlage noch gültig ist.

## 10. Farben und visuelle Hierarchie

| Herkunft | Hauptfarbe | Helle Fläche |
|---|---:|---:|
| Meine Gesundheit | `#2F8F8B` | `#DDF3F1` |
| Ernährung | `#C9784A` | `#FBE8DC` |
| Training | `#4F7FBF` | `#E3EEFA` |
| Meine Entwicklung | `#7A68B3` | `#ECE8F7` |

Bereichsfarben zeigen die fachliche Herkunft. Profilfarben zeigen ausschließlich das aktive Profil. Statusfarben zeigen Bewertung oder Dringlichkeit. Diese drei Ebenen dürfen weder visuell noch technisch vermischt werden.

## 11. Responsive Verhalten

Breakpoints richten sich ausschließlich nach der verfügbaren Breite.

### 11.1 Geringe Breite

- einspaltiger Inhalt,
- Hauptnavigation nur mit Icons,
- Profil und Einstellungen im Kopfbereich,
- Eyecatcher über die Inhaltsbreite,
- gut erreichbares Schnellerfassen,
- keine Hauptfunktion hinter **Mehr**.

### 11.2 Mittlere Breite

- ein- oder zweispaltiger Aufbau bei eindeutiger Lesereihenfolge,
- Navigation je nach Breite als Leiste oder Rail,
- Icons mit vollständigen Bezeichnungen nur bei ausreichendem Platz,
- Eyecatcher bleibt das dominante erste Inhaltselement.

### 11.3 Große Breite

- Navigation Rail oder Seitenleiste mit Icons und vollständigen Bezeichnungen,
- begrenzte Inhaltsbreite für gute Lesbarkeit,
- zusätzliche Breite verbessert Gruppierung und Abstände, erzeugt aber keine weiteren Dashboard-Karten.

## 12. Lade-, Fehler- und Offline-Zustände

### Laden

Die Grundstruktur bleibt stabil. Platzhalter dürfen keinen falschen Gesundheitsstatus vermitteln.

### Fehler

- verständliche Meldung ohne technische Details,
- sicher verfügbare Inhalte bleiben sichtbar,
- erneutes Laden wird angeboten,
- unbekannte Zustände werden nicht als erledigt oder nicht vorhanden interpretiert.

### Offline

Lokal verfügbare Inhalte bleiben sichtbar. Möglicherweise veraltete synchronisierte Daten werden gekennzeichnet. Lokale Erfassungen bleiben, sofern technisch möglich, verfügbar und werden für spätere Synchronisation vorgemerkt.

## 13. Datenschutz und Profilbezug

- Sämtliche Inhalte gehören ausschließlich zum aktiven Profil.
- Ein Profilwechsel aktualisiert Eyecatcher, Heute-Liste und Schnellerfassungsbezug gemeinsam.
- Während des Wechsels werden keine Daten verschiedener Profile vermischt.
- Geschützte Profile müssen vor Anzeige sensibler Inhalte entsperrt werden.
- Sensible Aufgaben und Meilensteine verwenden bei aktivierter Privatsphäre eine neutrale Vorschau.
- Unterdrückte oder geschlossene Hinweise werden profilbezogen verwaltet.

## 14. Barrierefreiheit

- Touch-Ziele sind mindestens ungefähr 44 × 44 logische Pixel groß.
- Texte und interaktive Elemente besitzen ausreichenden Kontrast.
- Große Systemschrift schneidet keine Inhalte oder Aktionen ab.
- Fokus- und Lesereihenfolge folgen dem Seitenaufbau.
- Alle Aktionen sind per Tastatur erreichbar und besitzen sichtbare Fokuszustände.
- Symbole erhalten verständliche semantische Bezeichnungen.
- Herkunft, Status und Dringlichkeit werden nie ausschließlich über Farbe vermittelt.
- Animationen respektieren reduzierte Bewegung.
- Neue Meilensteine werden für Screenreader informativ, aber nicht wiederholt störend angekündigt.

## 15. Sprache und Ton

- freundlich, ruhig und direkt in der Du-Form,
- kurze Überschriften und konkrete Verben,
- keine beschämenden Aussagen bei versäumten Aufgaben,
- keine unbegründeten Diagnosen oder medizinischen Bewertungen,
- Warnungen nennen Situation und nächste sinnvolle Handlung,
- Erfolge werden positiv, aber nicht übertrieben gewürdigt,
- Datum und Uhrzeit folgen der Geräteeinstellung und bleiben eindeutig.

## 16. Fachliche und technische Verantwortlichkeiten

Die Startseite ist eine lesende und koordinierende Komposition. Sie darf freigegebene, profilbezogene Darstellungsmodelle zusammenführen, priorisieren und zu fachlichen Funktionen navigieren.

Sie darf nicht:

- fachliche Regeln eines anderen Bereichs duplizieren,
- Quelldaten eigenständig interpretieren oder verändern,
- persistente Kopien fachlicher Datensätze anlegen,
- Daten verschiedener Profile vermischen.

Verbindlich gilt:

- Die Fachbereiche bleiben Eigentümer ihrer Daten, Regeln und Schreiboperationen.
- **Meine Entwicklung** erzeugt und verwaltet Meilensteine.
- Schnellerfassen delegiert an öffentliche Anwendungsfälle der Eigentümerbereiche.
- Profilwechsel, Navigation und Einstellungen sind globale App-Funktionen.
- Farben stammen ausschließlich aus zentralen Design-Tokens.
- Beispieldaten sind eindeutig gekennzeichnet.

## 17. Aktualisierungsereignisse

Die Startseite aktualisiert sich mindestens nach:

- App-Start oder Rückkehr in den Vordergrund,
- Profilwechsel,
- erfolgreicher Erfassung,
- Erledigen, Verschieben oder Ändern einer Aufgabe,
- Erreichen oder Schließen eines Meilensteins,
- Änderung von Termin-, Medikamenten-, Ernährungs- oder Trainingsdaten,
- erfolgreicher Synchronisation,
- neuem oder wesentlich verändertem Hinweis.

Aktualisierungen dürfen eine laufende Interaktion nicht verfälschen. Mehrfach ausgelöste Ereignisse werden idempotent verarbeitet.

## 18. Akzeptanzkriterien

Die Startseite ist spezifikationskonform, wenn:

- [ ] das aktive Profil und die Einstellungen oben rechts erreichbar sind,
- [ ] genau fünf Hauptbereiche in der festgelegten Reihenfolge navigierbar sind,
- [ ] die Navigation abhängig von der Breite nur Icons oder Icons mit vollständigen Bezeichnungen zeigt,
- [ ] kein Menüpunkt **Mehr** oder **Erfassen** erscheint,
- [ ] kein Dashboard, Diagramm oder dauerhafter Messwertblock vorhanden ist,
- [ ] höchstens ein dynamischer Eyecatcher sichtbar ist,
- [ ] die Prioritätslogik einschließlich Sicherheitsfall eingehalten wird,
- [ ] ein ungesehener Meilenstein prominent und barrierefrei erscheint,
- [ ] die Erfolgszahl groß, kontrastreich und mittig dargestellt wird,
- [ ] das Schließen eines Meilensteins ihn nicht aus Timeline oder Sammlung löscht,
- [ ] normale Aufgaben ruhiger als Meilensteine gestaltet sind,
- [ ] Bereichs-, Profil- und Statusfarben getrennt verwendet werden,
- [ ] kein Inhalt gleichzeitig im Eyecatcher und in **Heute** erscheint,
- [ ] **Heute** nur kompakte, aktuell relevante Inhalte zeigt,
- [ ] Schnellerfassen dieselben fachlichen Eingaben wie die Eigentümerbereiche verwendet,
- [ ] Schließen und Zurückstellen von Hinweisen den Regeln des `../UI_GUIDE.md` folgen,
- [ ] akute Sicherheitshinweise nicht längerfristig unterdrückt werden können,
- [ ] alle sichtbaren Inhalte zum aktiven Profil gehören,
- [ ] Lade-, Leer-, Fehler- und Offline-Zustände verständlich behandelt werden,
- [ ] geringe, mittlere und große Breiten ohne Informationsverlust unterstützt werden,
- [ ] große Schrift, Tastatur, Screenreader und reduzierte Bewegung berücksichtigt sind.

## 19. Bewusst offene Detailentscheidungen

Folgende Punkte werden im Komponentenentwurf oder in der Implementierungsplanung konkretisiert:

- exakte Breakpoint-Werte,
- endgültige Typografiegrößen und Abstände,
- konkrete Icons und Illustration des Eyecatchers,
- maximale Zahl sichtbarer Heute-Einträge je Breite,
- Dauer und Gestaltung optionaler Meilensteinanimationen,
- spätere zusätzliche Schnellerfassungsoptionen.

Diese Entscheidungen dürfen die Grundprinzipien und Akzeptanzkriterien nicht verändern. Fachlich relevante Änderungen werden versioniert in diesem Dokument nachgeführt.
