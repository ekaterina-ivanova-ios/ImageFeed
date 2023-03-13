import UIKit
import Kingfisher

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    
    static let reuseIdentifier = "ImagesListCell"
    
    private let gradient = CAGradientLayer()
    
    private let imageListService = ImagesListService.shared
    weak var delegate: ImagesListCellDelegate?
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCell.kf.cancelDownloadTask()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.ypBlack.withAlphaComponent(0).cgColor,
                           UIColor.ypBlack.withAlphaComponent(0.2).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 1)
    }
    
    //MARK: - Helpers
    @IBAction private func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
    
    func configCell(for cell: ImagesListCell, from photos: [Photo], with indexPath: IndexPath) {
        let imageUrl = photos[indexPath.row].thumbImageURL
        let url = URL(string: imageUrl)
        
        showGradientAnimation(for: cell)
        
        cell.imageCell.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder_list_photos")) { [weak self] _ in
                self?.imageCell.layer.sublayers?.removeAll()
            }
        
        if photos[indexPath.row].createdAt != nil {
            let photo = photos[indexPath.row]
            cell.dateLabel.text = photo.createdAt?.dateTimeString
        } else {
            cell.dateLabel.text = ""
        }
        
        cell.setIsLiked(photos[indexPath.row].isLiked)
    }
    
    func setIsLiked(_ state: Bool) {
        let likeImage = state ? UIImage(named: "active") : UIImage(named: "noActive")
        likeButton.setImage(likeImage, for: .normal)
    }
    
    private func showGradientAnimation(for cell: ImagesListCell) {
        let gradientAnimation = CAGradientLayer().createLoadingGradient(
            width: UIScreen.main.bounds.width - 32,
            height: UIImage(named: "placeholder_list_photos")?.size.height ?? 252,
            radius: 16
        )
        cell.imageCell.layer.addSublayer(gradientAnimation)
    }
}
