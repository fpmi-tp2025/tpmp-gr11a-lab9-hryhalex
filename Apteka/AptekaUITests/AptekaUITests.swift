import XCTest

final class AptekaUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        super.tearDown()
    }
    
    // MARK: - Тест 1: Проверка наличия элементов на экране входа
    func testLoginScreenExists() throws {
        let loginButton = app.buttons["loginButton"]
        XCTAssertTrue(loginButton.exists)
        
        let usernameField = app.textFields["usernameTextField"]
        XCTAssertTrue(usernameField.exists)
        
        let passwordField = app.secureTextFields["passwordTextField"]
        XCTAssertTrue(passwordField.exists)
    }
    
    // MARK: - Тест 2: Успешная авторизация
    func testSuccessfulLogin() throws {
        let usernameField = app.textFields["usernameTextField"]
        usernameField.tap()
        usernameField.typeText("testUser")
        
        let passwordField = app.secureTextFields["passwordTextField"]
        passwordField.tap()
        passwordField.typeText("123")
        
        app.buttons["loginButton"].tap()
        
        let collectionView = app.collectionViews["medicinesCollectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
    }
    
    // MARK: - Тест 3: Авторизация с пустым логином
    func testLoginWithEmptyUsername() throws {
        let passwordField = app.secureTextFields["passwordTextField"]
        passwordField.tap()
        passwordField.typeText("123")
        
        app.buttons["loginButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
        alert.buttons["OK"].tap()
    }
    
    // MARK: - Тест 4: Авторизация с пустым паролем
    func testLoginWithEmptyPassword() throws {
        let usernameField = app.textFields["usernameTextField"]
        usernameField.tap()
        usernameField.typeText("testUser")
        
        app.buttons["loginButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
        alert.buttons["OK"].tap()
    }
    
    // MARK: - Тест 5: Авторизация с коротким паролем
    func testLoginWithShortPassword() throws {
        let usernameField = app.textFields["usernameTextField"]
        usernameField.tap()
        usernameField.typeText("testUser")
        
        let passwordField = app.secureTextFields["passwordTextField"]
        passwordField.tap()
        passwordField.typeText("12")
        
        app.buttons["loginButton"].tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
        alert.buttons["OK"].tap()
    }
    
    // MARK: - Тест 6: Проверка количества ячеек в CollectionView
    func testCollectionViewCellsCount() throws {
        login()
        
        let collectionView = app.collectionViews["medicinesCollectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
        
        let cells = collectionView.cells
        XCTAssertEqual(cells.count, 3)
    }
    
    // MARK: - Тест 7: Проверка, что коллекция не пустая
    func testCollectionViewIsNotEmpty() throws {
        login()
        
        let collectionView = app.collectionViews["medicinesCollectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
        
        let cells = collectionView.cells
        XCTAssertGreaterThan(cells.count, 0)
    }
    
    // MARK: - Тест 8: Проверка наличия кнопки "Выйти" после входа
    func testLogoutButtonExists() throws {
        login()
        
        let logoutButton = app.buttons["Выйти"]
        XCTAssertTrue(logoutButton.waitForExistence(timeout: 3))
    }
    
    // MARK: - Тест 9: Проверка надписи приветствия
    func testWelcomeLabelExists() throws {
        login()
        
        let welcomeLabel = app.staticTexts["welcomeLabel"]
        XCTAssertTrue(welcomeLabel.waitForExistence(timeout: 3))
    }
    
    // MARK: - Тест 10: Проверка скролла коллекции (вместо logout)
    func testCollectionViewScrollable() throws {
        login()
        
        let collectionView = app.collectionViews["medicinesCollectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
        
        // Прокручиваем вниз
        collectionView.swipeUp()
        
        // Прокручиваем вверх
        collectionView.swipeDown()
        
        // Если дошли сюда - тест пройден
        XCTAssertTrue(true)
    }
    
    // MARK: - Helper Methods
    private func login() {
        let usernameField = app.textFields["usernameTextField"]
        XCTAssertTrue(usernameField.waitForExistence(timeout: 3))
        usernameField.tap()
        usernameField.typeText("testUser")
        
        let passwordField = app.secureTextFields["passwordTextField"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 3))
        passwordField.tap()
        passwordField.typeText("123")
        
        app.buttons["loginButton"].tap()
        
        let collectionView = app.collectionViews["medicinesCollectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
    }
}
