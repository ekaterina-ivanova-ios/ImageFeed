import UIKit

final class ImagesListCell: UITableViewCell {
    
    //MARK: - Properties
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    static let reuseIdentifier = "ImagesListCell"
    
    private let gradient = CAGradientLayer()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    //MARK: - LifeCycle
    override func layoutSublayers(of layer: CALayer) {
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.ypBlack.withAlphaComponent(0).cgColor,
                           UIColor.ypBlack.withAlphaComponent(0.2).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 1)
    }
    
    //MARK: - Helpers
    func configCell(for cell: ImagesListCell, from photosName: [String], with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }

        cell.imageCell.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())

        let isLiked = indexPath.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "buttonNoActive") : UIImage(named: "buttonActive")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}
