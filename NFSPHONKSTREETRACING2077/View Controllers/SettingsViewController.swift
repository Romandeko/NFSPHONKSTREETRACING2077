
import UIKit
import MessageUI
class SettingsViewController: UIViewController,GameDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backImageView: BackgroundImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    // MARK: - Private properties
    let step : CGFloat = 100
    private  let okAction = UIAlertAction(title: "OK", style: .default)
    private let newNameButton = GradienButton()
    private let backButton = GradienButton()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Your name is:\(StorageManager.shared.name)"
        backImageView.makeBlur()
        addLabelsAndButtons()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Private methods
    
    @objc private func hideKeyBoard(){
        view.endEditing(true)
    }
    
    private func addLabelsAndButtons(){
        let backString = NSMutableAttributedString(string: "Back", attributes: buttonAttribute as [NSAttributedString.Key : Any])
        let addString = NSMutableAttributedString(string: "Add", attributes: buttonAttribute as [NSAttributedString.Key : Any])
        
        backButton.frame.size = CGSize(width: 100, height: 45)
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = UIColor.black
        backButton.setAttributedTitle(backString, for: .normal)
        backButton.center.x = view.center.x
        backButton.center.y = view.frame.height - 150
        backButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        
        newNameButton.frame.size = CGSize(width: 100, height: 45)
        newNameButton.layer.cornerRadius = 20
        newNameButton.backgroundColor = UIColor.black
        newNameButton.setAttributedTitle(addString, for: .normal)
        newNameButton.center.x = view.center.x
        newNameButton.center.y = nameTextField.center.y + 75
        newNameButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        
        view.addSubview(backButton)
        view.addSubview(newNameButton)
        
        let goBack = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(goBack)
        
        let addNewNameGesture = UITapGestureRecognizer(target: self, action: #selector(addNewName))
        newNameButton.addGestureRecognizer(addNewNameGesture)
    }
    
    @objc private func goBack(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "Menu") as? Menu else {return}
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC,animated: false)
    }
    
    @objc private func addNewName(){
        guard nameTextField.text != "" else { return }
        StorageManager.shared.name = nameTextField.text ?? ""
        nameLabel.text = "Your name is : \(StorageManager.shared.name)"
    }
    //MARK: - IBActions
    @IBAction func phoneCall(_ sender: UIButton) {
        guard let number = URL(string: "tel://+375336997401") else { return }
        UIApplication.shared.open(number)
    }
    @IBAction func sendMail(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["sir.roma-denisenko@yandex.ru"])
            mail.setSubject("Жалоба")
            mail.setMessageBody("<h>Hola amigo!</h>", isHTML: true)
            mail.setCcRecipients(["sir.roma-denisenko@yandex.ru"])
            present(mail,animated: true)
        }
    }
    @IBAction func toTelegram(_ sender: UIButton) {
        guard let telegramLink = URL(string: "https://t.me/nexta_live") else { return }
        UIApplication.shared.open(telegramLink)
    }
}
extension UIViewController : MFMailComposeViewControllerDelegate{
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
