# App-Konzept: BorrowBack

Ein rein lokaler, visueller Micro-Tracker für iOS, der das Vergessen von verliehenen Gegenständen und Geldbeträgen verhindert – ohne Registrierung, ohne Tracking, ohne Abo.

---

## 1. Problemstellung & Zielgruppe

* **Problem:** Dinge an Freunde, Kollegen oder Nachbarn zu verleihen führt oft zu Verlusten, weil Standard-Notizen unübersichtlich sind und typische Inventar-Apps mit Features überladen sind.
* **Zielgruppe:** Minimalisten, WG-Bewohner, Hobby-Handwerker, Buchliebhaber und alle Nutzer, die eine fokussierte Lösung ohne Kontozwang suchen.

---

## 2. Kernfunktionalitäten (MVP)

### 2.1 Schnellerfassungs-Flow (unter 10 Sekunden)
1. **Foto aufnehmen/wählen:** Visueller Fokus steht im Vordergrund.
2. **Titel eingeben:** Kurzbeschreibung (z. B. *„Akku-Bohrschrauber“* oder *„20 € Bar“*).
3. **Person zuweisen:** Schnellzugriff auf Adressbuchkontakte oder einfache Freitexteingabe.
4. **Frist festlegen:** Schnellwahl-Buttons (*7 Tage*, *14 Tage*, *1 Monat*) oder individuelles Datum.

### 2.2 Visuelles Dashboard
* **Kachel-Raster:** Bildbasierte Übersicht aller aktiven Verleihvorgänge.
* **Status-Indikatoren:** Farbcodierung nach Dringlichkeit (z. B. Neutral = im Zeitplan, Gelb = bald fällig, Rot = überfällig).
* **Filter/Sortierung:** Schnellansichten für *„Aktiv“*, *„Überfällig“* und *„Historie/Zurückgegeben“*.

### 2.3 Benachrichtigung & Ein-Klick-Rückfrage
* **Lokale Push-Mitteilungen:** Automatische Erinnerung bei Ablauf der gesetzten Frist.
* **Share-Sheet-Integration:** Vordefinierte, freundliche Textnachricht inkl. Foto für Messenger (WhatsApp, iMessage etc.):
  > *„Hi [Name], kurze Erinnerung an meinen Gegenstand [Titel]. Brauchst du ihn aktuell noch?“*

### 2.4 Abschluss & Archiv
* **Geste:** Wischgeste (Swipe-to-Complete) mit haptischem Feedback markiert den Gegenstand als zurückgegeben.
* **Archiv:** Historie der vergangenen Verleihvorgänge zur Übersicht.

---

## 3. Technische Architektur

* **Plattform:** iOS (Swift & SwiftUI)
* **Persistenz:** SwiftData / CoreData (Ausschließlich lokale Speicherung auf dem Gerät)
* **Dateisystem:** Komprimierte JPG/HEIC-Bilder im lokalen Sandbox-Verzeichnis
* **Benachrichtigungen:** `UserNotifications`-Framework (rein lokal, kein Backend-Server erforderlich)
* **Datenschutz & Betrieb:** Keine Analytics-Tracker, kein Benutzer-Login, keine Cloud-Infrastrukturkosten (Zero Maintenance).

---

## 4. Monetarisierung & Positionierung

| Parameter | Details |
| :--- | :--- |
| **Preismodell** | Einmalkauf: **2,49 €** (Paid Upfront) |
| **Hauptargumente** | Keine Abofalle, 100 % Datenschutz (lokal), werbefrei |
| **Primäre Kategorie** | Dienstprogramme (Utilities) |
| **Sekundäre Kategorie** | Produktivität |
| **Keywords (ASO)** | Verleih Tracker, Sachen verliehen, Rückgabe Erinnerung, Borrow Manager, Minimal Tracker |

---

## 5. Zukünftige Ausbaustufen (Post-MVP)
* Optionaler iCloud-Sync (CloudKit) für Backups über mehrere eigene Apple-Geräte.
* Home-Screen- und Lock-Screen-Widgets.
* Export-Funktion (CSV/PDF) für die Verleih-Historie.
