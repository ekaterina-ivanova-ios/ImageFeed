
import UIKit

extension UIViewController {
    func showSingleAlert(title: String, message: String, _ completion: ((UIAlertAction) -> (Void))?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: completion)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showDoubleAlert(title: String, message: String, firstAction: String, secondAction: String, _ firstCompletion: ((UIAlertAction) -> (Void))?, _ secondCompletion: ((UIAlertAction) -> (Void))?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let first = UIAlertAction(title: firstAction, style: .default, handler: firstCompletion)
        let second = UIAlertAction(title: secondAction, style: .default, handler: secondCompletion)
        
        alert.addAction(first)
        alert.addAction(second)
        
        present(alert, animated: true)
    }
}
