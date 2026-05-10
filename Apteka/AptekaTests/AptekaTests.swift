import XCTest
@testable import Apteka

final class AptekaTests: XCTestCase {
    
    var dataManager: DataManager!
    
    override func setUpWithError() throws {
        super.setUp()
        dataManager = DataManager.shared
        // Очищаем UserDefaults перед каждым тестом
        dataManager.logout()
    }
    
    override func tearDownWithError() throws {
        dataManager = nil
        super.tearDown()
    }
    
    // MARK: - Тест 1: Проверка работоспособности тестов
    func testExample() throws {
        XCTAssertTrue(true)
    }
    
    // MARK: - Тест 2: Проверка существования DataManager
    func testDataManagerExists() throws {
        XCTAssertNotNil(dataManager)
    }
    
    // MARK: - Тест 3: Проверка сохранения логина в UserDefaults
    func testSaveLoginState() throws {
        dataManager.saveLoginState(isLoggedIn: true, username: "testUser")
        
        XCTAssertTrue(dataManager.isUserLoggedIn())
        XCTAssertEqual(dataManager.getCurrentUser(), "testUser")
    }
    
    // MARK: - Тест 4: Проверка выхода из приложения
    func testLogout() throws {
        dataManager.saveLoginState(isLoggedIn: true, username: "user")
        dataManager.logout()
        
        XCTAssertFalse(dataManager.isUserLoggedIn())
        XCTAssertNil(dataManager.getCurrentUser())
    }
    
    // MARK: - Тест 5: Проверка загрузки лекарств из .plist
    func testLoadMedicinesFromPlist() throws {
        let medicines = dataManager.loadMedicinesFromPlist()
        
        XCTAssertNotNil(medicines)
        XCTAssertEqual(medicines.count, 3)
    }
    
    // MARK: - Тест 6: Проверка названий лекарств
    func testMedicineNames() throws {
        let medicines = dataManager.loadMedicinesFromPlist()
        
        let expectedNames = ["Ибупрофен", "Парацетамол", "Аспирин"]
        for (index, medicine) in medicines.enumerated() {
            XCTAssertEqual(medicine.name, expectedNames[index])
        }
    }
    
    // MARK: - Тест 7: Проверка цен лекарств
    func testMedicinePrices() throws {
        let medicines = dataManager.loadMedicinesFromPlist()
        
        XCTAssertEqual(medicines[0].price, 150.0)
        XCTAssertEqual(medicines[1].price, 120.0)
        XCTAssertEqual(medicines[2].price, 80.0)
    }
    
    // MARK: - Тест 8: Проверка наличия изображений
    func testMedicineImagesExist() throws {
        let medicines = dataManager.loadMedicinesFromPlist()
        
        for medicine in medicines {
            XCTAssertNotNil(medicine.image, "Изображение для \(medicine.name) не найдено")
        }
    }
    
    // MARK: - Тест 9: Проверка модели Medicine
    func testMedicineModel() throws {
        let medicine = Medicine(
            id: 1,
            name: "Тестовое лекарство",
            description: "Тестовое описание",
            composition: "Тестовый состав",
            imageName: "medicine1",
            price: 99.99
        )
        
        XCTAssertEqual(medicine.id, 1)
        XCTAssertEqual(medicine.name, "Тестовое лекарство")
        XCTAssertEqual(medicine.price, 99.99)
    }
    
    // MARK: - Тест 10: Проверка повторного сохранения (перезапись)
    func testOverwriteLoginState() throws {
        // Первый пользователь
        dataManager.saveLoginState(isLoggedIn: true, username: "user1")
        XCTAssertEqual(dataManager.getCurrentUser(), "user1")
        
        // Второй пользователь (перезапись)
        dataManager.saveLoginState(isLoggedIn: true, username: "user2")
        XCTAssertEqual(dataManager.getCurrentUser(), "user2")
    }
}
