import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Для UI-тестов
        usernameTextField.accessibilityIdentifier = "usernameTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
        
        // Проверяем, не авторизован ли уже пользователь
        if DataManager.shared.isUserLoggedIn() {
            navigateToMedicines()
        }
    }
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 10
        usernameTextField.placeholder = "Имя пользователя"
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        titleLabel.text = "Добро пожаловать в Аптеку"
        loginButton.setTitle("Войти", for: .normal)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Заполните все поля")
            return
        }
        
        if password.count >= 3 {
            DataManager.shared.saveLoginState(isLoggedIn: true, username: username)
            navigateToMedicines()
        } else {
            showAlert(message: "Неверный пароль (минимум 3 символа)")
        }
    }
    
    private func navigateToMedicines() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let medicinesVC = MedicinesViewController()
        let navigationController = UINavigationController(rootViewController: medicinesVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
