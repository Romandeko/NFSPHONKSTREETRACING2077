
import UIKit
import AVFoundation

var name = ""
class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backImageView: BackgroundImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Private properties
    private var audioPlayer = AVAudioPlayer()
    let step : CGFloat = 100
   private  let okAction = UIAlertAction(title: "OK", style: .default)
    private var musicArray = ["phonk","serebro","lmfao"]
    private var currenMusic = "phonk"
    private let musicOnImage = UIImage(named: "turnOn")
    private let musicOffImage = UIImage(named: "turnOff")
    private let nextMusicImage = UIImage(named: "nextMusic")
    private let previousMusicImage = UIImage(named: "prevMusic")
    private let playMusicButton = UIButton()
    private let nextMusicButton = UIButton()
    private let previousMusicButton = UIButton()
    private let nameLabel = UILabel()
    private let newNameButton = GradienButton()
    private let backButton = GradienButton()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        backImageView.makeBlur()
        addLabelsAndButtons()
        do{
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currenMusic, ofType: "mp3") ?? musicArray[0]))
                audioPlayer.prepareToPlay()
            } catch {
                showAlert(title: "Ошибка",message: "Радио сломалось",actions: [okAction])
            }
        }
        
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
        
        nameLabel.text = "Your name is : \(StorageManager.shared.name)"
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.frame.size = CGSize(width: 350, height: 200)
        nameLabel.center.x = view.center.x
        nameLabel.center.y = nameTextField.frame.origin.y - 15
        self.view.addSubview(nameLabel)
        
        backButton.frame.size = CGSize(width: 100, height: 45)
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = UIColor.black
        backButton.setAttributedTitle(backString, for: .normal)
        backButton.center.x = self.view.center.x
        backButton.center.y = self.view.frame.height - 50
        self.backButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        
        newNameButton.frame.size = CGSize(width: 100, height: 45)
        newNameButton.layer.cornerRadius = 20
        newNameButton.backgroundColor = UIColor.black
        newNameButton.setAttributedTitle(addString, for: .normal)
        newNameButton.center.x = self.view.center.x
        newNameButton.center.y = nameTextField.center.y + 75
        self.newNameButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        
        
        playMusicButton.frame.size = CGSize(width: 50, height: 50)
        playMusicButton.setImage(musicOffImage, for: .normal)
        playMusicButton.center.x = self.view.center.x
        playMusicButton.center.y = self.view.frame.size.height - 1.5 * step
        
        nextMusicButton.frame.size = CGSize(width: 50, height: 50)
        nextMusicButton.setImage(nextMusicImage, for: .normal)
        nextMusicButton.center.x = self.view.center.x + 75
        nextMusicButton.center.y = playMusicButton.center.y
        
        previousMusicButton.frame.size = CGSize(width: 50, height: 50)
        previousMusicButton.setImage(previousMusicImage, for: .normal)
        previousMusicButton.center.x = self.view.center.x - 75
        previousMusicButton.center.y = playMusicButton.center.y
        
        self.view.addSubview(playMusicButton)
        self.view.addSubview(previousMusicButton)
        self.view.addSubview(nextMusicButton)
        self.view.addSubview(backButton)
        self.view.addSubview(newNameButton)
        
        let goBack = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(goBack)
        
        let musicGesture = UITapGestureRecognizer(target: self, action: #selector(playMusic))
        playMusicButton.addGestureRecognizer(musicGesture)
        
        let nextMusicGesture = UITapGestureRecognizer(target: self, action: #selector(playNextMusic))
        nextMusicButton.addGestureRecognizer(nextMusicGesture)
        
        let previousMusicGesture = UITapGestureRecognizer(target: self, action: #selector(playPreviousMusic))
        previousMusicButton.addGestureRecognizer(previousMusicGesture)
        
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
        StorageManager.shared.name = nameTextField.text ?? ""
        nameLabel.text = "Your name is : \(StorageManager.shared.name)"
    }
    
    //MARK: - Music
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
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currenMusic, ofType: "mp3") ?? musicArray[0]))
                audioPlayer.prepareToPlay()
            } catch {
                showAlert(title: "Ошибка",message: "Радио сломалось",actions: [okAction])
            }
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
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currenMusic, ofType: "mp3") ?? musicArray[0]))
                audioPlayer.prepareToPlay()
            } catch {
                showAlert(title: "Ошибка",message: "Радио сломалось",actions: [okAction])
            }
        }
        
        audioPlayer.play()
    }
    
}
