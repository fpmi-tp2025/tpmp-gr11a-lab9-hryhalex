import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    private let userDefaults = UserDefaults.standard
    
    // MARK: - UserDefaults Keys
    private let isLoggedInKey = "isLoggedIn"
    private let currentUserKey = "currentUser"
    
    // MARK: - Authentication Methods
    func saveLoginState(isLoggedIn: Bool, username: String? = nil) {
        userDefaults.set(isLoggedIn, forKey: isLoggedInKey)
        if let username = username {
            userDefaults.set(username, forKey: currentUserKey)
        }
        userDefaults.synchronize() // Принудительное сохранение
    }
    
    func isUserLoggedIn() -> Bool {
        return userDefaults.bool(forKey: isLoggedInKey)
    }
    
    func getCurrentUser() -> String? {
        return userDefaults.string(forKey: currentUserKey)
    }
    
    func logout() {
        userDefaults.removeObject(forKey: isLoggedInKey)
        userDefaults.removeObject(forKey: currentUserKey)
        userDefaults.synchronize()
    }
    
    // MARK: - Load Data from .plist
    func loadMedicinesFromPlist() -> [Medicine] {
        // Сначала пробуем загрузить из файла
        if let url = Bundle.main.url(forResource: "Medicines", withExtension: "plist"),
           let data = try? Data(contentsOf: url) {
            do {
                let decoder = PropertyListDecoder()
                let medicinesData = try decoder.decode([MedicineData].self, from: data)
                
                return medicinesData.map { medicineData in
                    Medicine(
                        id: medicineData.id,
                        name: medicineData.name,
                        description: medicineData.description,
                        composition: medicineData.composition,
                        imageName: medicineData.imageName,
                        price: medicineData.price
                    )
                }
            } catch {
                print("Ошибка загрузки plist: \(error)")
            }
        }
        
        // Если файла нет, возвращаем тестовые данные
        return getDefaultMedicines()
    }
    
    private func getDefaultMedicines() -> [Medicine] {
        return [
            Medicine(id: 1, name: "Ибупрофен", description: "Противовоспалительное средство", composition: "Ибупрофен 200 мг", imageName: "medicine1", price: 150.0),
            Medicine(id: 2, name: "Парацетамол", description: "Жаропонижающее средство", composition: "Парацетамол 500 мг", imageName: "medicine2", price: 120.0),
            Medicine(id: 3, name: "Аспирин", description: "Разжижает кровь", composition: "Ацетилсалициловая кислота 100 мг", imageName: "medicine3", price: 80.0)
        ]
    }
}

// Вспомогательная структура для декодирования из plist
struct MedicineData: Codable {
    let id: Int
    let name: String
    let description: String
    let composition: String
    let imageName: String
    let price: Double
}
