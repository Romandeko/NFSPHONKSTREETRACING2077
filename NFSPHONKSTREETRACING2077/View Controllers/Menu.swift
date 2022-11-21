
import UIKit
import AVFoundation
class Menu: UIViewController{
    
    // MARK: - Override properties
    var destVC: ShopViewController? = nil
    var backMessage = ""
    var mainCarImage = UIImage(named: "maincar")
    let okAction = UIAlertAction(title: "OK", style: .default)
    let step : CGFloat = 100
    weak var delegate : GameDelegate?
    
    // MARK: - Private properties
    private let scoreImage = UIImage(named: "kubokk")
    private let settingsImage = UIImage(named: "settings")
    private let settingsButton = UIButton()
    private let scoreButton = UIButton()
    private let mainLabel = UILabel()
    private let shopButton = GradienButton()
    private let playLevelButton = GradienButton()
    private let playEndlessButton = GradienButton()
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: ShadowImageView!
    @IBOutlet weak var backgroundImage: BackgroundImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.makeBlur()
        logoImageView.makeShadow()
        
        addButtons()
        addGestures()
        addEffects()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if StorageManager.shared.playersArray.count == 0{
            scoreButton.isHidden = true
        }
        checkUsername() { isConfirmed in
            if !isConfirmed {
                self.rickRoll()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Private methods
    private func checkUsername(handler : ((_ isConfirmed : Bool) -> ())? = nil){
        guard StorageManager.shared.name.count == 0 else {return}
        let nameAlert = UIAlertController(title: "Enter your name", message: "Type your name for saving scores", preferredStyle: .alert)
        nameAlert.addTextField { textField in
            textField.placeholder = "Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default){_ in
            let name = nameAlert.textFields?.first?.text ?? ""
            if name == "" {
                handler?(false)
            } else{
                StorageManager.shared.name = name
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){_ in
            handler?(false)
            
        }
        nameAlert.addAction(saveAction)
        nameAlert.addAction(cancelAction)
        present(nameAlert,animated: true)
    }
    
    private func rickRoll(){
        guard let url = URL(string: "https://www.youtube.com/watch?v=9PUSwdStJdQ") else { return }
        UIApplication.shared.open(url, options: [:])
        
    }
    @objc private func toPlayLevel(sender : UIButton!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "GameLevel") as? GameLevel else { return }
        destinationViewController.modalPresentationStyle = .fullScreen
        guard let testImage = mainCarImage else { return }
        destinationViewController.mainCarImage = testImage
        destinationViewController.delegate = self
        present(destinationViewController, animated: false)
    }
    
    @objc private func toPlayTime(sender : UIButton!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "GameEndless") as? GameEndless else { return }
        destinationViewController.modalPresentationStyle = .fullScreen
        guard let testImage = mainCarImage else { return }
        destinationViewController.mainCarImage = testImage
        destinationViewController.delegate = self
        present(destinationViewController, animated: false)
    }
    
    @objc private func toShop(sender : UIButton!){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as? ShopViewController else { return }
        destinationViewController.modalPresentationStyle = .fullScreen
        guard let testImage = mainCarImage else { return }
        destinationViewController.mainCarImage = testImage
        
        destVC = destinationViewController
        
        guard let destVC = destVC else { return }
        present(destVC, animated: false)
    }
    @objc private func toSettings(sender : UIButton!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        destinationViewController.modalPresentationStyle = .fullScreen
        present(destinationViewController, animated: false)
    }
    
    @objc private func toLeaderBoard(sender : UIButton!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ScoresViewController") as? ScoresViewController else { return }
        present(destinationViewController, animated: true)
    }
    
    
    private func addGestures(){
        let playLevelGesture = UITapGestureRecognizer(target: self, action: #selector(toPlayLevel))
        playLevelButton.addGestureRecognizer(playLevelGesture)
        
        let playTimeGesture = UITapGestureRecognizer(target: self, action: #selector(toPlayTime))
        playEndlessButton.addGestureRecognizer(playTimeGesture)
        
        let shopGesture = UITapGestureRecognizer(target: self, action: #selector(toShop))
        shopButton.addGestureRecognizer(shopGesture)
        
        let toSettingsGestture = UITapGestureRecognizer(target: self, action: #selector(toSettings))
        settingsButton.addGestureRecognizer(toSettingsGestture)
        
        let toLeaderBoard = UITapGestureRecognizer(target: self, action: #selector(toLeaderBoard))
        scoreButton.addGestureRecognizer(toLeaderBoard)
    }
    private func addButtons(){
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 18.0)
                            ,NSAttributedString.Key.foregroundColor:UIColor.white]
        let levelString = NSMutableAttributedString(string: "Level", attributes: myAttribute as [NSAttributedString.Key : Any] )
        let endlessString = NSMutableAttributedString(string: "Endless", attributes: myAttribute as [NSAttributedString.Key : Any] )
        let shopString = NSMutableAttributedString(string: "Shop", attributes: myAttribute as [NSAttributedString.Key : Any] )
        
        playLevelButton.frame.size = CGSize(width: 100, height: 50)
        playLevelButton.setAttributedTitle(levelString, for: .normal)
        playLevelButton.center.y = self.view.center.y
        playLevelButton.center.x = step
        
        playEndlessButton.frame.size = CGSize(width: 100, height: 50)
        playEndlessButton.setAttributedTitle(endlessString, for: .normal)
        playEndlessButton.center.x = self.view.frame.width - step
        playEndlessButton.center.y = self.view.center.y
        
        shopButton.frame.size = CGSize(width: 100, height: 50)
        shopButton.setAttributedTitle(shopString, for: .normal)
        shopButton.center.x = self.view.center.x
        shopButton.center.y = self.view.frame.height - 2 * step
        
        settingsButton.frame.size = CGSize(width: 75, height: 75)
        settingsButton.setImage(settingsImage, for: .normal)
        settingsButton.center.x = self.view.center.x
        settingsButton.center.y = self.view.frame.size.height - step
        
        scoreButton.frame.size = CGSize(width: 50, height: 50)
        scoreButton.setImage(scoreImage, for: .normal)
        scoreButton.center = view.center
        
        self.view.addSubview(playLevelButton)
        self.view.addSubview(playEndlessButton)
        self.view.addSubview(shopButton)
        self.view.addSubview(scoreButton)
        self.view.addSubview(settingsButton)
    }
    
    private func addEffects(){
        self.shopButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.playEndlessButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.playLevelButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        
        playEndlessButton.alpha = 0
        playLevelButton.alpha = 0
        scoreButton.alpha = 0
        mainLabel.alpha = 0
        shopButton.alpha = 0
        logoImageView.alpha = 0
        settingsButton.alpha = 0
        
        UIView.animate(withDuration: 1.5, delay:1.5,options: .curveEaseInOut, animations: {
            self.playEndlessButton.alpha = 1
            self.playLevelButton.alpha = 1
            self.scoreButton.alpha = 1
            self.mainLabel.alpha = 1
            self.logoImageView.alpha = 1
            self.shopButton.alpha = 1
            self.settingsButton.alpha = 1
        })
        
    }
    
    
}

extension Menu : GameDelegate {
    func gameEnded(withScore score: Int) {
        var message : String
        switch score {
        case 0...50:
            message = "Капец ты слабый..."
        case 51...100:
            message = "Так себе"
        case 101...200:
            message = "Можно и лучше"
        default:
            message = "КУДА ТЫ ТАК ГОНИШЬ"
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2){[self] in
            showAlert(title: "Game over", message: message,actions: [okAction])
        }
    }

    func finishPassed() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2){ [self] in
            showAlert(title: "VICTORY",message: "Поздравляю",actions: [okAction])
        }
    }
    func newRecordSet(withScore score: Int) {
        let date = Date()
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dataFormatter.string(from: date)
        let newPlayer = Player(name: StorageManager.shared.name, score: score, date: dateString)
        StorageManager.shared.playersArray.append(newPlayer)
        StorageManager.shared.playersArray.sort{ $0.score > $1.score }

    }
}
