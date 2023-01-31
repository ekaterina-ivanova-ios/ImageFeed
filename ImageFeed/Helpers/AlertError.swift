import UIKit

extension UIAlertController {

    func createSimpleAlert(withTitle alertTitle: String,
                           message alertMessage: String,
                           andButtonTitle alertButtonTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertButtonAction = UIAlertAction(title: alertButtonTitle, style: .default)
        alertController.addAction(alertButtonAction)
        return alertController
    }
}
