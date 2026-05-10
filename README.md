# Лабораторная работа №9 — Тестирование iOS приложений

## Студент
Григорьева Александра, группа 12А

## Отчет
https://disk.yandex.ru/edit/disk/disk%2Ftpmp%2FГригорьева_Александра_ПИ_Лаб9.docx?sk=y9f68223113cdb05c217a2efc4f4fb419
## Приложение
**"Аптека"** — iOS приложение для просмотра лекарств с авторизацией.

## Результаты тестов

| Тип тестов | Кол-во | Пройдено | Результат |
|------------|--------|----------|-----------|
| Unit Tests | 10 | 10 | ✅ 100% |
| UI Tests | 10 | 10 | ✅ 100% |

## Запуск тестов
\`\`\`bash
xcodebuild test -project Apteka.xcodeproj -scheme Apteka -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
\`\`\`
