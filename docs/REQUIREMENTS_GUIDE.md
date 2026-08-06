# Requirements Guide

Version: 1.0.0

---

# Zweck

Dieser Guide definiert die projektweiten Regeln für die Erstellung,
Pflege, Änderung und Qualität fachlicher Anforderungen.

Er gilt für sämtliche Module der Gesundheitsplattform.

Dazu gehören insbesondere:

- Profile
- Gesundheit
- Messwerte
- Medikamente
- Ernährung
- Training
- Analyse
- Geräteintegration
- Benachrichtigungen
- zukünftige Module

Dieser Guide beschreibt keine fachlichen Anforderungen.

Er beschreibt ausschließlich den Umgang mit Anforderungen.

---

# Ziele

Die Anforderungen sollen

- eindeutig,
- vollständig,
- nachvollziehbar,
- testbar,
- wartbar,
- versionierbar

sein.

Jede Anforderung muss eindeutig aus der Dokumentation hervorgehen.

---

# Verbindliche Dokumentationsreihenfolge

Fachliche Anforderungen werden grundsätzlich in folgender Reihenfolge
beschrieben.

1. Requirements
2. Use Cases
3. Business Rules
4. Domain Model
5. Validation Rules
6. Error Handling
7. Traceability
8. Implementierung
9. Tests

Nachgelagerte Dokumente konkretisieren frühere Entscheidungen.

Sie dürfen ihnen nicht widersprechen.

---

# Führendes Dokument

Für jede fachliche Änderung wird zunächst bestimmt, welches Dokument die
führende fachliche Quelle darstellt.

Die neue Entscheidung wird ausschließlich dort erstmals beschrieben.

Alle weiteren Dokumente werden anschließend daraus abgeleitet.

Nachgelagerte Dokumente dürfen keine zusätzlichen fachlichen Regeln
einführen.

---

# Anforderungen an Requirements

Jede fachliche Anforderung muss

- eindeutig formuliert sein,
- fachlich begründet sein,
- testbar sein,
- unabhängig von der technischen Umsetzung beschrieben sein,
- widerspruchsfrei sein.

Requirements beschreiben niemals

- UI-Implementierungen,
- Datenbankstrukturen,
- Frameworks,
- Programmiersprachen,
- Bibliotheken,
- technische Architektur.

---

# Evolvierende Fachdomäne

Die Fachdomäne entwickelt sich während des Projekts kontinuierlich weiter.

Neue Erkenntnisse, geänderte Prioritäten und zusätzliche Anforderungen
sind ausdrücklich Bestandteil des Entwicklungsprozesses.

Eine Änderung bestehender Anforderungen stellt keinen Fehler dar.

Sie ist Bestandteil der fachlichen Weiterentwicklung.

---

# Dokumentation als Single Source of Truth

Die Dokumentation bildet die verbindliche fachliche Grundlage des Projekts.

Implementierungen dürfen keine fachlichen Regeln enthalten, die nicht aus
der aktuellen Dokumentation ableitbar sind.

Die Dokumentation besitzt Vorrang vor der Implementierung.

---

# Vorgehen bei Anforderungsänderungen

Vor jeder Implementierungsänderung wird geprüft,

- welche fachliche Entscheidung geändert wurde,
- welches Dokument führend ist,
- welche weiteren Dokumente tatsächlich betroffen sind.

Nur betroffene Dokumente werden angepasst.

Nicht betroffene Dokumente bleiben unverändert.

---

# Umgang mit Implementierungsblockern

Kann eine fachliche Anforderung aufgrund fehlender Spezifikation nicht
implementiert werden,

muss die Implementierung unterbrochen werden.

Der Blocker muss enthalten:

- betroffener Domänentyp,
- betroffene Operation,
- konkrete Fundstellen,
- Begründung,
- fehlende fachliche Entscheidung.

Es dürfen keine fachlichen Regeln erfunden werden.

---

# Dokumentationsänderungen

Dokumentationsänderungen erfolgen ausschließlich aufgrund

- neuer Anforderungen,
- geänderter fachlicher Entscheidungen,
- nachgewiesener Widersprüche,
- konkreter Implementierungsblocker.

Hypothetische zukünftige Anforderungen werden nicht vorab dokumentiert.

---

# Konsistenz

Eine fachliche Änderung gilt erst als abgeschlossen, wenn

- alle betroffenen Dokumente aktualisiert wurden,
- Implementierung und Dokumentation übereinstimmen,
- automatisierte Tests angepasst wurden,
- Qualitätsprüfungen erfolgreich sind.

---

# Rückwärtskompatibilität

Bei jeder fachlichen Änderung ist zu prüfen,

- ob bestehende Requirements betroffen sind,
- ob bestehende Business Rules betroffen sind,
- ob bestehende Error Codes betroffen sind,
- ob bestehende Message Keys betroffen sind,
- ob bestehende Schnittstellen betroffen sind,
- ob bestehende Daten migriert werden müssen.

Bereits veröffentlichte Error Codes dürfen ihre fachliche Bedeutung nicht
ändern.

---

# Qualitätskriterien

Eine Anforderung ist vollständig, wenn sie

- fachlich eindeutig,
- testbar,
- widerspruchsfrei,
- nachvollziehbar,
- implementierbar

ist.

---

# Review

Vor der Implementierung wird geprüft,

- ob die Anforderung vollständig spezifiziert ist,
- ob alle notwendigen Dokumente vorhanden sind,
- ob Widersprüche bestehen,
- ob fehlende Entscheidungen existieren.

Erst danach beginnt die Implementierung.

---

# Änderungsprinzip

Änderungen erfolgen grundsätzlich

- klein,
- fachlich abgeschlossen,
- nachvollziehbar,
- versionierbar.

Große zusammenhängende Änderungen werden in fachlich abgeschlossene
Teilblöcke zerlegt.

---

# Ziel

Das Projekt verfolgt das Ziel,

eine dauerhaft konsistente,
vollständig dokumentierte,
testbare und wartbare Fachdomäne aufzubauen.

Die Dokumentation entwickelt sich gemeinsam mit der Domäne weiter und
bildet jederzeit den aktuellen fachlichen Stand der Gesundheitsplattform.