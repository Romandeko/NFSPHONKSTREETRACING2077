

import UIKit
extension UIViewController{
    func showAlert(title : String? = "",
                   message : String? = "",
                   style : UIAlertController.Style = .alert,
                   actions : [UIAlertAction] = [],
                   hasCancel: Bool = false
    ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach{
            alert.addAction($0)
        }
        if hasCancel {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
        }
        present(alert,animated: true)
    }
}

