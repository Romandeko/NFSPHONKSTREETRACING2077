
import UIKit

let okAction = UIAlertAction(title: "OK", style: .default)
let step : CGFloat = 100

class Menu: UIViewController {
    
    // MARK: - Override properties
    var destVC: ShopViewController? = nil
    var backMessage = ""
    var mainCarImage = UIImage(named: "maincar")
    
    
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

      createReacords()
        mainLabel.text = ""
        mainLabel.font = mainLabel.font.withSize(100)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .black
        mainLabel.frame.size = CGSize(width: 350, height: 200)
        mainLabel.center.x = view.center.x
        mainLabel.frame.origin.y = 20
        self.view.addSubview(mainLabel)
        
        backgroundImage.makeBlur()
        logoImageView.makeShadow()
        
        addButtons()
        addGestures()
        addEffects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if  backMessage == "Капец ты слабый..."
                || backMessage == "Так себе"
                || backMessage == "Можно и лучше"
                || backMessage == "КУДА ТЫ ТАК ГОНИШЬ"
        {
            showAlert(title: "Lose",message: backMessage,actions: [okAction])
        
            backMessage = ""
        }
        if  backMessage == "VICTORY"{
            showAlert(title: "Lose",message: "Поздравляю",actions: [okAction])
            backMessage = ""
        }
    }
    
    // MARK: - Private methods
    @objc private func toPlayLevel(sender : UIButton!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "GameLevel") as? GameLevel else { return }
        destinationViewController.modalPresentationStyle = .fullScreen
        guard let testImage = mainCarImage else { return }
        destinationViewController.mainCarImage = testImage
        present(destinationViewController, animated: false)
    }
    
    @objc private func toPlayTime(sender : UIButton!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "GameEndless") as? GameEndless else { return }
        destinationViewController.modalPresentationStyle = .fullScreen
        guard let testImage = mainCarImage else { return }
        destinationViewController.mainCarImage = testImage
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
            guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "RecordsViewController") as? RecordsViewController else { return }
            destinationViewController.modalPresentationStyle = .fullScreen
        present(destinationViewController, animated: false)
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
