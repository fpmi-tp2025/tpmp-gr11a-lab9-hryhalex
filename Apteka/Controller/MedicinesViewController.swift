import UIKit

class MedicinesViewController: UIViewController {
    
    // Убираем @IBOutlet - создадим все программно
    var collectionView: UICollectionView!
    var welcomeLabel: UILabel!
    
    private var medicines: [Medicine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Аптека"
        
        setupWelcomeLabel()
        setupCollectionView()
        loadData()
        setupNavigationButtons()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        welcomeLabel.textColor = .darkGray
        
        if let username = DataManager.shared.getCurrentUser() {
            welcomeLabel.text = "Добро пожаловать, \(username)!"
        } else {
            welcomeLabel.text = "Добро пожаловать!"
        }
        
        view.addSubview(welcomeLabel)
        
        // Констрейнты
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: (screenWidth - 48) / 2, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Регистрируем ячейку
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MedicineCell")
        
        view.addSubview(collectionView)
        
        // Констрейнты
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationButtons() {
        // Кнопка "Выйти"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выйти",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        
        // Кнопка "Назад"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
    }
    
    private func loadData() {
        medicines = DataManager.shared.loadMedicinesFromPlist()
        print("✅ Загружено лекарств: \(medicines.count)")
        collectionView.reloadData()
    }
    
    @objc private func logoutTapped() {
        DataManager.shared.logout()
        dismiss(animated: true)
    }
    
    @objc private func backTapped() {
        dismiss(animated: true)
    }
}

extension MedicinesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicineCell", for: indexPath)
        let medicine = medicines[indexPath.row]
        
        // Очищаем ячейку от старых элементов
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Настраиваем внешний вид ячейки
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 4
        
        // Название лекарства
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = medicine.name
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        cell.contentView.addSubview(nameLabel)
        
        // Цена
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "\(medicine.price) ₽"
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        priceLabel.textAlignment = .center
        priceLabel.textColor = .systemGreen
        cell.contentView.addSubview(priceLabel)
        
        // Иконка (системная иконка таблетки)
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "pill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        
        // Констрейнты
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: cell.contentView.bottomAnchor, constant: -12)
        ])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let medicine = medicines[indexPath.row]
        
        let alert = UIAlertController(
            title: medicine.name,
            message: "Описание: \(medicine.description)\n\nСостав: \(medicine.composition)\n\nЦена: \(medicine.price) ₽",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        // Снимаем выделение
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
