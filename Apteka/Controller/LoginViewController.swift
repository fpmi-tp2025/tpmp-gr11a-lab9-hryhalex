import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Проверяем, не авторизован ли уже пользователь
        if DataManager.shared.isUserLoggedIn() {
            navigateToMedicines()
        }
    }
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 10
        usernameTextField.placeholder = NSLocalizedString("login.username", comment: "")
        passwordTextField.placeholder = NSLocalizedString("login.password", comment: "")
        titleLabel.text = NSLocalizedString("login.title", comment: "")
        loginButton.setTitle(NSLocalizedString("login.button", comment: ""), for: .normal)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("login.error", comment: ""),
                                     message: message,
                                     preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Заполните все поля")
            return
        }
        
        // Простая валидация (пароль минимум 3 символа)
        if password.count >= 3 {
            DataManager.shared.saveLoginState(isLoggedIn: true, username: username)
            navigateToMedicines()
        } else {
            showAlert(message: "Неверный пароль (минимум 3 символа)")
        }
    }
    
    private func navigateToMedicines() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let medicinesVC = storyboard.instantiateViewController(withIdentifier: "MedicinesViewController")
        medicinesVC.modalPresentationStyle = .fullScreen
        present(medicinesVC, animated: true)
    }
    
}
