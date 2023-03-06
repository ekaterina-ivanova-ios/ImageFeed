
import UIKit

extension UIViewController {
    func showAlert(_ completion: ((UIAlertAction) -> (Void))?) {
        let alert = UIAlertController(title: "Что-то пошло не так(", message: "Не удалось войти в систему", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: completion)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
