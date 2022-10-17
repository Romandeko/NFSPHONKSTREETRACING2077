//
//  ViewController.swift
//  NFSPHONKSTREETRACING2077
//
//  Created by Роман Денисенко on 11.10.22.
//

import UIKit
import AVFoundation

class Menu: UIViewController {
    
    // MARK: - Override properties
    var coins = 0
    var mainCarImage = UIImage(named: "maincar")
    
    private var audioPlayer = AVAudioPlayer()

    var backMessage = ""
    
    private let step : CGFloat = 100
    
    private let musicOnImage = UIImage(named: "musicOn")
    private let musicOffImage = UIImage(named: "musicOff")
    private let musicButton = UIButton()
    private let shopButton = UIButton()
    private let playLevelButton = UIButton()
    private let playTimeButton = UIButton()
    private let mainLabel = UILabel()

    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        playLevelButton.frame.size = CGSize(width: 100, height: 50)
        playLevelButton.layer.cornerRadius = 20
        playLevelButton.backgroundColor = UIColor.black
        playLevelButton.setTitle("Level", for: .normal)
        playLevelButton.center.y = self.view.center.y
        playLevelButton.center.x = step
        
        playTimeButton.frame.size = CGSize(width: 100, height: 50)
        playTimeButton.layer.cornerRadius = 20
        playTimeButton.backgroundColor = UIColor.black
        playTimeButton.setTitle("Endless", for: .normal)
        playTimeButton.center.x = self.view.frame.width - step
        playTimeButton.center.y = self.view.center.y
        
        shopButton.frame.size = CGSize(width: 100, height: 50)
        shopButton.layer.cornerRadius = 20
        shopButton.backgroundColor = UIColor.black
        shopButton.setTitle("Shop", for: .normal)
        shopButton.center.x = self.view.center.x
        shopButton.center.y = self.view.frame.height - 2 * step
        
        musicButton.frame.size = CGSize(width: 50, height: 50)
        musicButton.layer.cornerRadius = 20
        musicButton.setImage(musicOffImage, for: .normal)
        musicButton.center.x = self.view.center.x
        musicButton.center.y = self.view.frame.size.height - step
        musicButton.layer.cornerRadius = 25
    
        mainLabel.text = "Давно тебя не было в уличных гонках"
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
        mainLabel.frame.size = CGSize(width: 350, height: 50)
        mainLabel.center.x = view.center.x
        mainLabel.frame.origin.y = 40
        
        let playLevelGesture = UITapGestureRecognizer(target: self, action: #selector(toPlayLevel))
        playLevelButton.addGestureRecognizer(playLevelGesture)
        
        let playTimeGesture = UITapGestureRecognizer(target: self, action: #selector(toPlayTime))
        playTimeButton.addGestureRecognizer(playTimeGesture)
        
        let shopGesture = UITapGestureRecognizer(target: self, action: #selector(toShop))
        shopButton.addGestureRecognizer(shopGesture)
        
        do{
            audioPlayer = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
        }
        
        let musicGesture = UITapGestureRecognizer(target: self, action: #selector(playMusic))
        musicButton.addGestureRecognizer(musicGesture)
        
        musicButton.alpha = 0
        playTimeButton.alpha = 0
        playLevelButton.alpha = 0
        mainLabel.alpha = 0
        shopButton.alpha = 0
        
        
        self.view.addSubview(mainLabel)
        self.view.addSubview(playLevelButton)
        self.view.addSubview(playTimeButton)
        self.view.addSubview(musicButton)
        self.view.addSubview(shopButton)
        
        UIView.animate(withDuration: 1, delay: 1,options: .curveEaseInOut, animations: {
            self.musicButton.alpha = 1
            self.playTimeButton.alpha = 1
            self.playLevelButton.alpha = 1
            self.mainLabel.alpha = 1
            self.shopButton.alpha = 1        })
        
        
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
    @objc func toPlayLevel(sender : UIButton!){
        let destinationViewController = GameLevel()
        destinationViewController.modalPresentationStyle = .fullScreen
        guard let testImage = mainCarImage else { return }
        destinationViewController.mainCarImage = testImage
        present(destinationViewController, animated: false)
    }
    
    @objc func toPlayTime(sender : UIButton!){
        let destinationViewController = GameEndless()
        destinationViewController.modalPresentationStyle = .fullScreen
        guard let testImage = mainCarImage else { return }
        destinationViewController.mainCarImage = testImage
        present(destinationViewController, animated: false)
    }
    
    @objc func toShop(sende : UIButton!){
        let destinationViewController = ShopViewController()
        destinationViewController.modalPresentationStyle = .fullScreen
        destinationViewController.view.backgroundColor = .white
        destinationViewController.coins = coins
        present(destinationViewController,animated: false)
    }
    
    @objc func playMusic(){
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            musicButton.setImage(musicOffImage, for: .normal)
        } else {
            audioPlayer.play()
            musicButton.setImage(musicOnImage, for: .normal)
        }
    }
    
    func showAlert(withMessage message: String,withTitle title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Перекур", style: .default, handler: {(action:UIAlertAction!) in
        }))
     
        self.present(alert,animated: true)
    }
}

