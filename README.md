### **OSINT Template – Automatyczna Konfiguracja Środowiska**  

Ten skrypt automatyzuje konfigurację systemu operacyjnego do pracy w OSINT, instalując niezbędne narzędzia, optymalizując środowisko GNOME oraz poprawiając bezpieczeństwo systemu.  

---

## **📌 Instalacja**  

Aby zainstalować i uruchomić skrypt, wykonaj następujące polecenia w terminalu:  

```bash
sudo apt install curl -y
curl -O https://raw.githubusercontent.com/p4b1o/osint-template/refs/heads/main/setup.sh
chmod +x setup.sh
./setup.sh
```

---

## **🔧 Co robi skrypt?**  

### **1. Aktualizacja i instalacja podstawowych narzędzi**  

- Czyści pamięć podręczną i aktualizuje system (`apt update && apt upgrade -y`).  
- Instaluje niezbędne pakiety: `wget`, `curl`, `git`, `build-essential`, `python3-pip`, `flatpak`, `unzip`.  

### **2. Konfiguracja Pythona**  

- Usuwa ograniczenie `EXTERNALLY-MANAGED` w Pythonie 3.11.  
- Instaluje `python3-venv` oraz `pipx` do zarządzania pakietami.  

### **3. Instalacja i konfiguracja GNOME**  

- **Instaluje GNOME Extensions CLI** i dodaje niezbędne rozszerzenia:  
  - `Dash to Dock` – umożliwia dostosowanie docka GNOME.  
  - `Rozszerzenie 2087` – dodatkowe funkcjonalności dla GNOME.  

- **Konfiguruje środowisko GNOME**:  
  - Dock zostaje umieszczony na dole ekranu i dostosowany pod kątem użytkownika.  
  - Wyłączona zostaje automatyczna ukrywanie docka.  
  - Maksymalny rozmiar ikon w docku ustawiony na 64 px.  
  - Ustawiony ciemny motyw terminala.  
  - Zmodyfikowane ustawienia powiadomień i blokady ekranu.  

### **4. Ustawienie tła pulpitu**  

- Pobiera domyślne tło pulpitu i ustawia je jako tapetę systemową.  

### **5. Wyłączenie zawieszania systemu (suspend)**  

- Wyłącza automatyczne przechodzenie systemu w tryb uśpienia.  

### **6. Instalacja narzędzi OSINT (przez pipx)**  

Instaluje kluczowe narzędzia do OSINT:  

- **`Sherlock`** – wyszukiwanie nazw użytkowników w różnych serwisach.  
- **`Ghunt`** – analiza kont Google.  
- **`theHarvester`** – zbieranie informacji o domenach.  
- **`Exiftool`** – analiza metadanych plików.  
- **`H8mail`** – sprawdzanie wycieków haseł i adresów e-mail.  
- **`Search-That-Hash` & `Name-That-Hash`** – identyfikacja i analiza skrótów hash.  

### **7. Instalacja Subfinder**  

- Pobiera i instaluje **Subfinder**, narzędzie do enumeracji subdomen.  

### **8. Instalacja Tor Browser i OnionShare**  

- Dodaje repozytorium Flathub i instaluje **Tor Browser**.
- Uruchamia konfigurator Tor Browser.  

### **9. Instalacja i konfiguracja Firefoxa**  

- Usuwa domyślną wersję Firefoxa.  
- Instaluje Firefox ESR z repozytorium **Debian Backports**.  
- Pobiera i rozpakowuje predefiniowany szablon konfiguracji przeglądarki zgodny z **Mistrzostwo w białym wywiadzie: Firefox**.  
- **Instaluje następujące rozszerzenia:**  
  - **uBlock Origin** – blokowanie reklam i trackerów.  
  - **Firefox Containers** – separacja danych między witrynami.  
  - **Wappalyzer** – identyfikacja technologii używanych na stronach.  
  - **Fireshot** – tworzenie zrzutów ekranu całych stron internetowych.  
  - **User-Agent Switcher** – zmiana agenta użytkownika w przeglądarce.  
  - **Exif Viewer** – analiza danych EXIF w obrazach.  
  - **OneTab** – zarządzanie zakładkami i oszczędzanie pamięci.  
  - **DownThemAll** – pobieranie wszystkich zasobów ze strony jednym kliknięciem.  
  - **Bulk Media Downloader** – pobieranie dużej ilości plików multimedialnych z witryn internetowych.  
  - **Copy Selected Links** – kopiowanie wszystkich wybranych linków w treści strony.  
  - **Image Search Options** – ułatwia wyszukiwanie obrazów w różnych wyszukiwarkach.  
  - **Search By Image** – narzędzie do wyszukiwania odwrotnego obrazów w popularnych serwisach.  
- **Dostosowuje ustawienia prywatności**, m.in.:  
  - Włącza ścisłą ochronę przed śledzeniem.  
  - Włącza blokowanie fingerprintingu.  
  - Modyfikuje ustawienia WebRTC, by zapobiec wyciekom IP.  
  - Ogranicza dostęp do sensorów i API geolokalizacji.  
  - Dezaktywuje telemetrię Mozilli i zbieranie danych diagnostycznych.  

### **10. Instalacja narzędzia WhatsMyName-Python**  

- Pobiera narzędzie **WhatsMyName-Python**, tworzy środowisko `venv` i instaluje zależności.  

### **11. Instalacja Visual Studio Code**  

- Pobiera i instaluje **Visual Studio Code** z oficjalnego repozytorium Microsoft.  

### **12. Konfiguracja ulubionych aplikacji w GNOME-Shell**  

- Dodaje do ulubionych aplikacji:  
  - `Firefox ESR`  
  - `GNOME Terminal`  
  - `VS Code`  
  - `Tor Browser`  

---

## **📺 Szkolenie o skrypcie**  

Dowiedz się więcej o konfiguracji i zastosowaniach tego skryptu w OSINT, ogląd...

