Sentinel **0.4.1 Alpha 3** — Windows installer configuration compatibility and startup payload reduction, Windows 10/11 x64.

**Посмотреть дизайн без установки:** скачайте `Sentinel-0.4.1-Design-Preview.zip`, распакуйте и откройте `index.html`. Галерея содержит 35 настоящих снимков WPF с синтетическими данными: RU/UA, компактное окно, состояния Scanner и заполнение ромба. Это не результаты проверки вашего компьютера.

**UI:** единая графитово-лиловая палитра, встроенный Inter 4.1 (OFL), сгенерированные растровые иконки и иллюстрация, более ясная навигация и шаги установки, состояния кнопок, плавные переходы с поддержкой уменьшения движения. Технические идентификаторы и Risk Engine не изменены.

Installer and complete offline TestKit are included separately. The full kit also contains the gallery, safe diagnostic checker, authored fixtures, licenses and UPDATE-LOG.md. No SDK, separate .NET installation or GitHub login is required.

Windows CI passed actual EXE startup, MSI lifecycle/checker, synthetic upgrade/rollback and UI render checks. Genuine historical/user-machine migration, interactive Windows 10/11, per-monitor DPI/accessibility and hardware performance remain pending. Installer is unsigned; keep Defender, Firewall and UAC enabled. Detection/monitoring only; no quarantine, removal or automatic network update.

Переглянути дизайн без встановлення: завантажте `Sentinel-0.4.1-Design-Preview.zip`, розпакуйте та відкрийте `index.html`. Усі дані в галереї синтетичні. Установлення та перевірки на вашому ПК можна виконати пізніше.

Alpha 2 refined the design after actual Windows visual review: sharp high-resolution brand image, accurate Scanner/Overview subtitles, a responsive process table with readable names and matching RU/UA capture sizes.

Alpha 3 fixes MigrationPreflight code 30 for the reviewed default config.json with Windows CRLF line endings. Only the exact reviewed LF/CRLF hashes are accepted; the existing configuration is preserved byte-for-byte. Other settings and unregistered/manual service adoption remain outside automatic migration. The bootstrapper startup payload removes 30 service-side dependency files (16.5 MiB); actual client launch-time improvement is not measured.
