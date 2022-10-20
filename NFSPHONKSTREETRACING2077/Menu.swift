
import UIKit
import AVFoundation

class Menu: UIViewController {
    
    // MARK: - Override properties
    var destVC: ShopViewController? = nil
    var coins = 0
    var backMessage = ""
    var mainCarImage = UIImage(named: "maincar")
    
    // MARK: - Private properties
    private var audioPlayer = AVAudioPlayer()
    private let step : CGFloat = 100
    private var musicArray = ["phonk","serebro","lmfao"]
    private var currenMusic = "phonk"
    private let musicOnImage = UIImage(named: "turnOn")
    private let musicOffImage = UIImage(named: "turnOff")
    private let nextMusicImage = UIImage(named: "nextMusic")
    private let previousMusicImage = UIImage(named: "prevMusic")
    
    private let playMusicButton = UIButton()
    private let nextMusicButton = UIButton()
    private let previousMusicButton = UIButton()
    private let shopButton = UIButton()
    private let playLevelButton = UIButton()
    private let playEndlessButton = UIButton()
    private let mainLabel = UILabel()
   
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: ShadowImageView!
    @IBOutlet weak var backgroundImage: BackgroundImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            showAlert(withMessage: backMessage, withTitle: "LOSE")
            backMessage = ""
        }
        if  backMessage == "VICTORY"{
            showAlert(withMessage: backMessage, withTitle: "Поздравляю!")
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
    
    @objc private func toShop(sende : UIButton!){
        if destVC == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as? ShopViewController else { return }
            destinationViewController.modalPresentationStyle = .fullScreen
            guard let testImage = mainCarImage else { return }
            destinationViewController.mainCarImage = testImage
            destinationViewController.coins = coins
            destVC = destinationViewController
        }
        guard let destVC = destVC else { return }
        present(destVC, animated: false)
    }
    
    @objc private func playMusic(){
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            playMusicButton.setImage(musicOffImage, for: .normal)
        } else {
            audioPlayer.play()
            playMusicButton.setImage(musicOnImage, for: .normal)
        }
    }
    
    @objc private func playNextMusic(){
        for musicIndex in 0...musicArray.count-1{
            if currenMusic == musicArray[musicIndex]{
                if musicIndex != musicArray.count - 1{
                    currenMusic = musicArray[musicIndex+1]
                } else{
                    currenMusic = musicArray[0]
                }
                break
            }
        }
        playMusicButton.setImage(musicOnImage, for: .normal)
        do{
            audioPlayer = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currenMusic, ofType: "mp3") ?? musicArray[0]))
            audioPlayer.prepareToPlay()
        }
        audioPlayer.play()
    }
    
    @objc private func playPreviousMusic(){
        for musicIndex in 0...musicArray.count-1{
            if currenMusic == musicArray[musicIndex]{
                if musicIndex != 0 {
                    currenMusic = musicArray[musicIndex - 1]
                } else{
                    currenMusic = musicArray[musicArray.count-1]
                }
                break
            }
        }
        playMusicButton.setImage(musicOnImage, for: .normal)
        do{
            audioPlayer = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currenMusic, ofType: "mp3") ?? musicArray[0]))
            audioPlayer.prepareToPlay()
        }
        audioPlayer.play()
    }
    
    private func addGestures(){
        let playLevelGesture = UITapGestureRecognizer(target: self, action: #selector(toPlayLevel))
        playLevelButton.addGestureRecognizer(playLevelGesture)
        
        let playTimeGesture = UITapGestureRecognizer(target: self, action: #selector(toPlayTime))
        playEndlessButton.addGestureRecognizer(playTimeGesture)
        
        let shopGesture = UITapGestureRecognizer(target: self, action: #selector(toShop))
        shopButton.addGestureRecognizer(shopGesture)
        
        let musicGesture = UITapGestureRecognizer(target: self, action: #selector(playMusic))
        playMusicButton.addGestureRecognizer(musicGesture)
        
        let nextMusicGesture = UITapGestureRecognizer(target: self, action: #selector(playNextMusic))
        nextMusicButton.addGestureRecognizer(nextMusicGesture)
        
        let previousMusicGesture = UITapGestureRecognizer(target: self, action: #selector(playPreviousMusic))
        previousMusicButton.addGestureRecognizer(previousMusicGesture)
    }
    private func addButtons(){
        playLevelButton.frame.size = CGSize(width: 100, height: 50)
        playLevelButton.setTitle("Level", for: .normal)
        playLevelButton.center.y = self.view.center.y
        playLevelButton.center.x = step
        
        playEndlessButton.frame.size = CGSize(width: 100, height: 50)
        playEndlessButton.setTitle("Endless", for: .normal)
        playEndlessButton.center.x = self.view.frame.width - step
        playEndlessButton.center.y = self.view.center.y
        
        shopButton.frame.size = CGSize(width: 100, height: 50)
        shopButton.setTitle("Shop", for: .normal)
        shopButton.center.x = self.view.center.x
        shopButton.center.y = self.view.frame.height - 2 * step
        
        playMusicButton.frame.size = CGSize(width: 50, height: 50)
        playMusicButton.setImage(musicOffImage, for: .normal)
        playMusicButton.center.x = self.view.center.x
        playMusicButton.center.y = self.view.frame.size.height - step
      
        nextMusicButton.frame.size = CGSize(width: 50, height: 50)
        nextMusicButton.setImage(nextMusicImage, for: .normal)
        nextMusicButton.center.x = self.view.center.x + 75
        nextMusicButton.center.y = self.view.frame.size.height - step
 
        previousMusicButton.frame.size = CGSize(width: 50, height: 50)
        previousMusicButton.setImage(previousMusicImage, for: .normal)
        previousMusicButton.center.x = self.view.center.x - 75
        previousMusicButton.center.y = self.view.frame.size.height - step
        
        self.view.addSubview(playLevelButton)
        self.view.addSubview(playEndlessButton)
        self.view.addSubview(playMusicButton)
        self.view.addSubview(shopButton)
        self.view.addSubview(previousMusicButton)
        self.view.addSubview(nextMusicButton)
        
    }
    
    private func addEffects(){
        self.shopButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.playEndlessButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.playLevelButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
   
        playMusicButton.alpha = 0
        playEndlessButton.alpha = 0
        playLevelButton.alpha = 0
        nextMusicButton.alpha = 0
        previousMusicButton.alpha = 0
        mainLabel.alpha = 0
        shopButton.alpha = 0
        logoImageView.alpha = 0
  
        UIView.animate(withDuration: 1.5, delay:1.5,options: .curveEaseInOut, animations: {
            self.playMusicButton.alpha = 1
            self.nextMusicButton.alpha = 1
            self.previousMusicButton.alpha = 1
            self.playEndlessButton.alpha = 1
            self.playLevelButton.alpha = 1
            self.mainLabel.alpha = 1
            self.logoImageView.alpha = 1
            self.shopButton.alpha = 1
        })

        do{
            
            audioPlayer = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currenMusic, ofType: "mp3") ?? musicArray[0]))
            audioPlayer.prepareToPlay()
        }
    }
    
    private func showAlert(withMessage message: String,withTitle title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Перекур", style: .default, handler: {(action:UIAlertAction!) in
        }))
        
        self.present(alert,animated: true)
    }
}
