
import UIKit


class RecordsViewController: UIViewController {
    
    let leaderLabel = UILabel()
    let backButton = GradienButton()
    // MARK: - IBOutlets
    @IBOutlet weak var backImageView: BackgroundImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addEveryting()
        for index in 0...9 {
            view.addSubview(playersArray[index].nameLabel)
            view.addSubview(playersArray[index].scoreLabel)
            view.addSubview(playersArray[index].numberLabel)
            
        }
    }
 
    // MARK: - Private methods
    @objc private func goBack(){
        dismiss(animated: false)
    }
    private func addEveryting(){
        backImageView.makeBlur()
        leaderLabel.text = "Bosses of the gym"
        leaderLabel.font = leaderLabel.font.withSize(40)
        leaderLabel.textAlignment = .center
        leaderLabel.textColor = .white
        leaderLabel.frame.size = CGSize(width: 350, height: 200)
        leaderLabel.center.x = view.center.x
        leaderLabel.center.y = 0.8*step
        view.addSubview(leaderLabel)
        
        let backString = NSMutableAttributedString(string: "Back", attributes: buttonAttribute as [NSAttributedString.Key : Any])
        backButton.frame.size = CGSize(width: 100, height: 45)
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = UIColor.black
        backButton.setAttributedTitle(backString, for: .normal)
        backButton.center.x = self.view.center.x
        backButton.center.y = self.view.frame.height - 50
        view.addSubview(backButton)
        
        backButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        let goBack = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(goBack)
    }
}
