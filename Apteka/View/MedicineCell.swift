import UIKit

class MedicineCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
    }
    
    func configure(with medicine: Medicine) {
        nameLabel.text = medicine.name
        priceLabel.text = "\(medicine.price) ₽"
        // imageView.image = medicine.image (пока используем системную иконку)
        imageView.image = UIImage(systemName: "pill")
        imageView.tintColor = .systemBlue
    }
}
