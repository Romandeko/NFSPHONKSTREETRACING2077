
import UIKit


class RecordsViewController: UIViewController {
    // MARK: - Private properties
    private let leaderLabel = UILabel()
    private let backButton = GradienButton()
    private let step : CGFloat = 100
    private var isFirstLoad = true
    
    // MARK: - IBOutlets
    @IBOutlet weak var backImageView: BackgroundImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addEveryting()
        if isFirstLoad == true{
            StorageManager.shared.createRecords()
            isFirstLoad = false
        }
        if StorageManager.shared.playersCount != 0{
            for index in 0...StorageManager.shared.playersCount-1{
                view.addSubview(StorageManager.shared.playersArray[index].nameLabel)
                view.addSubview(StorageManager.shared.playersArray[index].scoreLabel)
                view.addSubview(StorageManager.shared.playersArray[index].numberLabel)
                view.addSubview(StorageManager.shared.playersArray[index].dateLabel)
                
            }
            
            
        }
    }
        // MARK: - Private methods
        private func addEveryting(){
            backImageView.makeBlur()
           
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
        
        @objc private func goBack(){
            dismiss(animated: false)
        }
    }

