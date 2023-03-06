
import UIKit

extension UILabel {
    func config(for label: UILabel, text: String, fontSize: CGFloat, textColor: UIColor) {
        label.text = text
        label.font = UIFont(name: "YS Display", size: fontSize)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}
