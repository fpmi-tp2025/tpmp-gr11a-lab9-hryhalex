import XCTest
@testable import Apteka

final class AptekaTests: XCTestCase {
    
    var dataManager: DataManager!
    
    override func setUpWithError() throws {
        super.setUp()
        dataManager = DataManager.shared
    }
    
    override func tearDownWithError() throws {
        dataManager = nil
        super.tearDown()
    }
    
    // Тест 1: Проверка работоспособности тестов
    func testExample() throws {
        XCTAssertTrue(true)
    }
    
    // Тест 2: Проверка существования DataManager
    func testDataManagerExists() throws {
        let manager = DataManager.shared
        XCTAssertNotNil(manager)
    }
    
    // Тест 3: Проверка сохранения логина в UserDefaults
    func testSaveLoginState() throws {
        dataManager.saveLoginState(isLoggedIn: true, username: "testUser")
        
        XCTAssertTrue(dataManager.isUserLoggedIn())
        XCTAssertEqual(dataManager.getCurrentUser(), "testUser")
    }
    
    // Тест 4: Проверка выхода из приложения
    func testLogout() throws {
        dataManager.saveLoginState(isLoggedIn: true, username: "user")
        dataManager.logout()
        
        XCTAssertFalse(dataManager.isUserLoggedIn())
        XCTAssertNil(dataManager.getCurrentUser())
    }
}
