# OSINT Template

## Instalacja maszyny wraz z narzędziami do pracy w OSINT

Ten skrypt automatyzuje konfigurację systemu operacyjnego do pracy w OSINT, instalując niezbędne narzędzia, rozszerzenia przeglądarki, konfigurując środowisko GNOME i zabezpieczając system.

### **Instalacja**
Aby uruchomić skrypt instalacyjny, wykonaj następujące polecenia w terminalu:

```bash
sudo apt install curl -y
curl https://raw.githubusercontent.com/p4b1o/osint-template/refs/heads/main/setup.sh | bash
```

### **Co robi skrypt?**

#### 1. **Aktualizacja i instalacja podstawowych narzędzi**
- Aktualizuje system (`apt update && apt upgrade -y`).
- Instalacja pakietów: `wget`, `curl`, `git`, `build-essential`, `python3-pip`, `pipx`, `flatpak`.

#### 2. **Konfiguracja Python**
- Usuwa ograniczenie `EXTERNALLY-MANAGED` dla Pythona.
- Instaluje `python3-venv`, `pipx`, `pipx ensurepath`.

#### 3. **Instalacja rozszerzeń GNOME i konfiguracja środowiska**
- Konfiguruje docka (dodaje ikony: Firefox, TorBrowser, Terminal, Pliki, VSCode, Kosz).
- Ustawia ciemny motyw terminala.
- Konfiguruje układ przycisków okien i inne ustawienia GNOME.
- Pobiera i ustawia domyślne tło pulpitu.

#### 4. **Instalacja narzędzi OSINT**
- `Sherlock` – narzędzie do wyszukiwania nazw użytkowników w sieci.
- `Ghunt` – analiza kont Google.
- `theHarvester` – zbieranie informacji o domenach.
- `Exiftool` – analiza metadanych plików.
- `Subfinder` – narzędzie do enumeracji subdomen.

#### 5. **Instalacja Tor Browser i OnionShare**
- Dodaje repozytorium Flathub.
- Instalacja i uruchomienie `Tor Browser`.
- Instalacja `OnionShare` do anonimowego udostępniania plików.

#### 6. **Instalacja Firefoxa i rozszerzeń**
- Usuwa Firefoxa w wersji `snap`.
- Dodaje repozytorium PPA Mozilli.
- Instalacja Firefoxa z PPA.
- Pobiera szablon konfiguracji Firefoxa i rozpakowuje go.

#### 7. **Instalacja Visual Studio Code**
- Dodaje klucz GPG Microsoftu.
- Dodaje repozytorium VSCode.
- Instaluje `code`.

### **Podsumowanie**
Po zakończeniu instalacji system jest gotowy do pracy w OSINT, wyposażony w niezbędne narzędzia oraz zoptymalizowany pod kątem prywatności i wygody użytkownika.

Aby przełączyć się na użytkownika `osint`, użyj:
```bash
su - osint
```

Jeśli masz pytania lub chcesz dostosować skrypt, skontaktuj się z autorem repozytorium.

