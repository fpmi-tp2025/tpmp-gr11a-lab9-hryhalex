# Лабораторная работа №9 — Тестирование iOS приложений

## Студент
Григорьева Александра, группа 11А

## Приложение
**"Аптека"** — iOS приложение для просмотра лекарств с авторизацией.

## Тестирование

### Фреймворк
**XCTest** — выбран для UIKit-приложения

### Результаты тестов

| Тип тестов | Кол-во | Пройдено | Результат |
|------------|--------|----------|-----------|
| Unit Tests | 10 | 10 | ✅ 100% |
| UI Tests | 10 | 10 | ✅ 100% |
| **Итого** | **20** | **20** | **✅ 100%** |

### Unit Tests (10 тестов)
- testExample ✅
- testDataManagerExists ✅
- testSaveLoginState ✅
- testLogout ✅
- testLoadMedicinesFromPlist ✅
- testMedicineNames ✅
- testMedicinePrices ✅
- testMedicineImagesExist ✅
- testMedicineModel ✅
- testOverwriteLoginState ✅

### UI Tests (10 тестов)
- testLoginScreenExists ✅
- testSuccessfulLogin ✅
- testLoginWithEmptyUsername ✅
- testLoginWithEmptyPassword ✅
- testLoginWithShortPassword ✅
- testCollectionViewCellsCount ✅
- testCollectionViewIsNotEmpty ✅
- testLogoutButtonExists ✅
- testWelcomeLabelExists ✅
- testCollectionViewScrollable ✅

## Запуск тестов
```bash
# В Xcode
Cmd + U

# В терминале
xcodebuild test -project Apteka.xcodeproj -scheme Apteka -destination 'platform=iOS Simulator,name=iPhone 15 Pro'Структура
text
├── Apteka/              # Исходный код приложения
│   ├── Model/          # Модели данных
│   ├── Controller/     # Контроллеры
│   ├── View/           # View и Storyboard
│   ├── AptekaTests/    # Unit-тесты (10)
│   └── AptekaUITests/  # UI-тесты (10)
├── docs/               # Документация
├── screenshots/        # Скриншоты
└── README.md
Ссылка на отчет
Отчет
