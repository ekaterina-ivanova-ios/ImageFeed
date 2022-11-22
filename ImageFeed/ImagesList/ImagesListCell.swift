import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let reusedIdentifier = "ImagesListCell"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!

}
