//
//  ViewController.swift
//  NFSPHONKSTREETRACING2077
//
//  Created by Роман Денисенко on 11.10.22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: - Override properties
    var audioPlayer = AVAudioPlayer()
    var loseMessage = ""
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playButton = UIButton()
        playButton.frame.size = CGSize(width: 100, height: 50)
        playButton.layer.cornerRadius = 20
        playButton.backgroundColor = UIColor.black
        playButton.setTitle("ПОГНАЛИ", for: .normal)
        playButton.center = self.view.center
        
        let musicButton = UIButton()
        musicButton.frame.size = CGSize(width: 100, height: 50)
        musicButton.layer.cornerRadius = 20
        musicButton.backgroundColor = UIColor.black
        musicButton.setTitle("PLAY", for: .normal)
        musicButton.center.x = self.view.center.x
        musicButton.center.y = playButton.center.y + 150
        
        let restartMusicButton = UIButton()
        restartMusicButton.frame.size = CGSize(width: 100, height: 50)
        restartMusicButton.layer.cornerRadius = 20
        restartMusicButton.backgroundColor = UIColor.black
        restartMusicButton.setTitle("RESTART", for: .normal)
        restartMusicButton.center.x = self.view.center.x
        restartMusicButton.center.y = musicButton.center.y + 60
        
        let stopMusicButton = UIButton()
        stopMusicButton.frame.size = CGSize(width: 100, height: 50)
        stopMusicButton.layer.cornerRadius = 20
        stopMusicButton.backgroundColor = UIColor.black
        stopMusicButton.setTitle("STOP", for: .normal)
        stopMusicButton.center.x = self.view.center.x
        stopMusicButton.center.y = restartMusicButton.center.y + 60
        
        let mainLabel = UILabel()
        mainLabel.text = "Давно тебя не было в уличных гонках"
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
        mainLabel.frame.size = CGSize(width: 350, height: 50)
        mainLabel.center.x = view.center.x
        mainLabel.frame.origin.y = 100
        
        let musicLabel = UILabel()
        musicLabel.text = "Music"
        musicLabel.textAlignment = .center
        musicLabel.font = musicLabel.font.withSize(40)
        musicLabel.textColor = .white
        musicLabel.frame.size = CGSize(width: 350, height: 50)
        musicLabel.center.x = view.center.x
        musicLabel.frame.origin.y = musicButton.center.y - 80
        
        self.view.addSubview(mainLabel)
        self.view.addSubview(playButton)
        self.view.addSubview(musicButton)
        self.view.addSubview(stopMusicButton)
        self.view.addSubview(restartMusicButton)
        self.view.addSubview(musicLabel)
        
        
        let playGesture = UITapGestureRecognizer(target: self, action: #selector(toPlay))
        playButton.addGestureRecognizer(playGesture)
        
        do{
            audioPlayer = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        
        let musicGesture = UITapGestureRecognizer(target: self, action: #selector(playMusic))
        musicButton.addGestureRecognizer(musicGesture)
        let stopMusicGesture = UITapGestureRecognizer(target: self, action: #selector(stopMusic))
        stopMusicButton.addGestureRecognizer(stopMusicGesture)
        let restartMusicGesture = UITapGestureRecognizer(target: self, action: #selector(restartMusic))
        restartMusicButton.addGestureRecognizer(restartMusicGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let loseMessageLabel = UILabel()
        loseMessageLabel.text = loseMessage
        loseMessageLabel.textAlignment = .center
        loseMessageLabel.font = loseMessageLabel.font.withSize(30)
        loseMessageLabel.textColor = .white
        loseMessageLabel.frame.size = CGSize(width: 350, height: 50)
        loseMessageLabel.center.x = view.center.x
        loseMessageLabel.frame.origin.y = 180
        self.view.addSubview(loseMessageLabel)
    }
    
    // MARK: - Private methods
    @objc func toPlay(sender : UIButton!){
        let destinationViewController = Game()
        destinationViewController.modalPresentationStyle = .fullScreen
        present(destinationViewController, animated: false)
    }
    
    @objc func playMusic(){
        audioPlayer.play()
    }
    
    @objc func restartMusic(){
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    @objc func stopMusic(){
        if audioPlayer.isPlaying{
            audioPlayer.stop()
        }
    }
}

