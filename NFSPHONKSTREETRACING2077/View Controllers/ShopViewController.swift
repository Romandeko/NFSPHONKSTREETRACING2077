
import UIKit
import SnapKit

 let labelAttribute = [ NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 50)
                               ,NSAttributedString.Key.foregroundColor:UIColor.white]
 let buttonAttribute = [ NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 20)
                                ,NSAttributedString.Key.foregroundColor:UIColor.white]
let buyString = NSMutableAttributedString(string: "Buy", attributes: buttonAttribute as [NSAttributedString.Key : Any] )
let chooseString = NSMutableAttributedString(string: "Choose", attributes: buttonAttribute as [NSAttributedString.Key : Any])

 let buyLamboButton = GradienButton()
 let yellowSportButton = GradienButton()
 let redSportButton = GradienButton()
 let blueSportButton = GradienButton()

class ShopViewController: UIViewController {
    
    // MARK: - Override properties
    var mainCarImage = UIImage()
    
    // MARK: - Private properties
    private let lamboBorder = UIView()
    private let yellowSportBorder = UIView()
    private let redSportBorder = UIView()
    private let blueSportBorder = UIView()
    private let lamboImage = UIImage(named: "lambo")
    private let yellowSportImage = UIImage(named: "yellowSport")
    private let redSportImage = UIImage(named: "redSport")
    private let blueSportImage = UIImage(named: "blueSport")
    
    private lazy var lambo = UIImageView(image: lamboImage)
    private lazy var yellowSport = UIImageView(image: yellowSportImage)
    private lazy var blueSport = UIImageView(image: blueSportImage)
    private lazy var redSport = UIImageView(image: redSportImage)
    

    private let backButton = GradienButton()
    
    private let lamboCostLabel = UILabel()
    private let yellowSportLabel = UILabel()
    private let redSportLabel = UILabel()
    private let blueSportLabel = UILabel()
    private let moneyLabel = UILabel()
    
    private var stepFromButton : CGFloat = 40
    private var stepFromBorder : CGFloat = 60
  
    
    // MARK: - IBOutlets
    @IBOutlet weak var backImageView: BackgroundImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = String(StorageManager.shared.coins)
        backImageView.makeBlur()
        let backString = NSMutableAttributedString(string: "Back", attributes: buttonAttribute as [NSAttributedString.Key : Any])
        backButton.frame.size = CGSize(width: 100, height: 45)
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = UIColor.black
        backButton.setAttributedTitle(backString, for: .normal)
        backButton.center.x = self.view.center.x
        backButton.center.y = self.view.frame.height - 50
        view.addSubview(backButton)
        
        addCarBorders()
        addCarButtons()
        addCarLabels()
        addGradient()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let coinsString = NSMutableAttributedString(string: "Coins:", attributes: buttonAttribute as [NSAttributedString.Key : Any])
        let coinsValueString = NSMutableAttributedString(string: String(StorageManager.shared.coins),attributes: buttonAttribute as [NSAttributedString.Key : Any])
        coinsString.append(coinsValueString)
        
        moneyLabel.attributedText = coinsString
        moneyLabel.textAlignment = .center
        moneyLabel.textColor = .white
        moneyLabel.frame.size = CGSize(width: 350, height: 50)
        moneyLabel.font = moneyLabel.font.withSize(50)
        moneyLabel.center.x = view.center.x
        moneyLabel.frame.origin.y = 50
        view.addSubview(moneyLabel)
        
        addConstraints()
    }
    
    // MARK: - Private methods
    @objc private func goBack(){
        guard let parentViewController = self.presentingViewController as?
                Menu else { return }
            parentViewController.mainCarImage = mainCarImage
            dismiss(animated: false)
    }
    
    @objc private func buyLambo(){
        if StorageManager.shared.isLamboBought == false{
            guard let stringCost = lamboCostLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if StorageManager.shared.coins - cost >= 0 {
                StorageManager.shared.coins -= cost
            } else {
                showAlert(title: "Ошибка",message: "Ну ты и нищеброд",actions: [okAction])
                return }
            moneyLabel.text = "Coins:\(StorageManager.shared.coins)"
            guard let testImage = lamboImage else { return }
            mainCarImage = testImage
            StorageManager.shared.isLamboBought = true
            buyLamboButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = lamboImage else { return }
            mainCarImage = testImage
        }
    }
    
    @objc private func buyYellowSport(){
        if StorageManager.shared.isYellowBought == false{
            guard let stringCost = yellowSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if StorageManager.shared.coins - cost >= 0 {
                StorageManager.shared.coins -= cost
            } else {
                showAlert(title: "Ошибка",message: "Ну ты и нищеброд",actions: [okAction])
                return }
            moneyLabel.text = "Coins:\(StorageManager.shared.coins)"
            guard let testImage = yellowSportImage else { return }
            mainCarImage = testImage
            StorageManager.shared.isYellowBought = true
            yellowSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = yellowSportImage else { return }
            mainCarImage = testImage
          
        }
    }
    
    @objc private func buyRedSport(){
        if StorageManager.shared.isRedBought == false{
            guard let stringCost = redSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if StorageManager.shared.coins - cost >= 0 {
                StorageManager.shared.coins -= cost
            } else {
                showAlert(title: "Ошибка",message: "Ну ты и нищеброд",actions: [okAction])
                return }
            moneyLabel.text = "Coins:\(StorageManager.shared.coins)"
            guard let testImage = redSportImage else { return }
            mainCarImage = testImage
            StorageManager.shared.isRedBought = true
            redSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = redSportImage else { return }
            mainCarImage = testImage

        }
    }
    
    @objc private func buyBlueSport(){
        if StorageManager.shared.isBlueBought == false{
            guard let stringCost = blueSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if StorageManager.shared.coins - cost >= 0 {
                StorageManager.shared.coins -= cost
            } else {
                showAlert(title: "Ошибка",message: "Ну ты и нищеброд",actions: [okAction])
                return }
            moneyLabel.text = "Coins:\(StorageManager.shared.coins)"
            guard let testImage = blueSportImage else { return }
            mainCarImage = testImage
            StorageManager.shared.isBlueBought  = true
            blueSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = blueSportImage else { return }
            mainCarImage = testImage
        }
    }
    
    private func addGestures(){
        let goBack = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(goBack)
        
        let buyBugatti = UITapGestureRecognizer(target: self, action: #selector(buyLambo))
        buyLamboButton.addGestureRecognizer(buyBugatti)
        
        let buyYellowSport = UITapGestureRecognizer(target: self, action: #selector(buyYellowSport))
        yellowSportButton.addGestureRecognizer(buyYellowSport)
        
        let buyRedSport = UITapGestureRecognizer(target: self, action: #selector(buyRedSport))
        redSportButton.addGestureRecognizer(buyRedSport)
        
        let buyBlueSport = UITapGestureRecognizer(target: self, action: #selector(buyBlueSport))
        blueSportButton.addGestureRecognizer(buyBlueSport)
    }
    
    private func addGradient(){
        buyLamboButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        yellowSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
      redSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        blueSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        backButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
    }
    
    private func addConstraints(){
       
        lambo.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(0)
        }
        
        yellowSport.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        redSport.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        blueSport.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    private func addCarLabels(){
        let carAttribute = [ NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 14.0)!
                             ,NSAttributedString.Key.foregroundColor:UIColor.white]
        let blueCostString = NSMutableAttributedString(string: "5", attributes: carAttribute )
        let redCostString = NSMutableAttributedString(string: "10", attributes: carAttribute )
        let yellowCostString = NSMutableAttributedString(string: "20", attributes: carAttribute )
        let lamboCostString = NSMutableAttributedString(string: "25", attributes: carAttribute )
        blueSportLabel.attributedText = blueCostString
        blueSportLabel.textAlignment = .center
        blueSportLabel.textColor = .white
        blueSportLabel.font = blueSportLabel.font.withSize(30)
        blueSportLabel.frame.size = CGSize(width: 350, height: 50)
        blueSportLabel.center.x = blueSportBorder.center.x
        blueSportLabel.center.y = blueSportButton.center.y - stepFromButton
        view.addSubview(blueSportLabel)
        
        yellowSportLabel.attributedText = yellowCostString
        yellowSportLabel.textAlignment = .center
        yellowSportLabel.textColor = .white
        yellowSportLabel.font = yellowSportLabel.font.withSize(30)
        yellowSportLabel.frame.size = CGSize(width: 350, height: 50)
        yellowSportLabel.center.x = yellowSportBorder.center.x
        yellowSportLabel.center.y = yellowSportButton.center.y - stepFromButton
        view.addSubview(yellowSportLabel)
        
        redSportLabel.attributedText = redCostString
        redSportLabel.textAlignment = .center
        redSportLabel.textColor = .white
        redSportLabel.font = redSportLabel.font.withSize(30)
        redSportLabel.frame.size = CGSize(width: 350, height: 50)
        redSportLabel.center.x = redSportBorder.center.x
        redSportLabel.center.y = redSportButton.center.y - stepFromButton
        view.addSubview(redSportLabel)
        
        lamboCostLabel.attributedText = lamboCostString
        lamboCostLabel.textAlignment = .center
        lamboCostLabel.textColor = .white
        lamboCostLabel.font = lamboCostLabel.font.withSize(30)
        lamboCostLabel.frame.size = CGSize(width: 350, height: 50)
        lamboCostLabel.center.x = lamboBorder.center.x
        lamboCostLabel.center.y = buyLamboButton.center.y - stepFromButton
        view.addSubview(lamboCostLabel)
    }
    
    private func addCarButtons(){
        
        
        buyLamboButton.frame.size = CGSize(width: 100, height: 45)
        buyLamboButton.layer.cornerRadius = 20
        buyLamboButton.backgroundColor = UIColor.black
        buyLamboButton.center.x = lamboBorder.center.x
        buyLamboButton.center.y = lamboBorder.frame.maxY + stepFromBorder
        if StorageManager.shared.isLamboBought == true{
            buyLamboButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            buyLamboButton.setAttributedTitle(buyString, for: .normal)
        }
        view.addSubview(buyLamboButton)
        
        redSportButton.frame.size = CGSize(width: 100, height: 45)
        redSportButton.layer.cornerRadius = 20
        redSportButton.backgroundColor = UIColor.black
        redSportButton.center.x = redSportBorder.center.x
        redSportButton.center.y = redSportBorder.frame.maxY + stepFromBorder
        if StorageManager.shared.isRedBought == true{
            redSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            redSportButton.setAttributedTitle(buyString, for: .normal)
        }
        view.addSubview(redSportButton)
        
        yellowSportButton.frame.size = CGSize(width: 100, height: 45)
        yellowSportButton.layer.cornerRadius = 20
        yellowSportButton.backgroundColor = UIColor.black
        yellowSportButton.center.x = yellowSportBorder.center.x
        yellowSportButton.center.y = yellowSportBorder.frame.maxY + stepFromBorder
        if StorageManager.shared.isYellowBought == true{
            yellowSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            yellowSportButton.setAttributedTitle(buyString, for: .normal)
        }
        view.addSubview(yellowSportButton)
        
        blueSportButton.frame.size = CGSize(width: 100, height: 45)
        blueSportButton.layer.cornerRadius = 20
        blueSportButton.backgroundColor = UIColor.black
        blueSportButton.center.x = blueSportBorder.center.x
        blueSportButton.center.y = blueSportBorder.frame.maxY + stepFromBorder
        if StorageManager.shared.isBlueBought == true{
            blueSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            blueSportButton.setAttributedTitle(buyString, for: .normal)
        }
        view.addSubview(blueSportButton)
    }
    
    private func addCarBorders(){
        lamboBorder.backgroundColor = .white
        lamboBorder.frame.size = CGSize(width: 100, height: 150)
        lamboBorder.center.y = 200
        lamboBorder.center.x = 100
        lamboBorder.layer.cornerRadius = 20
        lamboBorder.layer.borderColor = UIColor.black.cgColor
        lamboBorder.layer.borderWidth = 5
        view.addSubview(lamboBorder)
        lamboBorder.addSubview(lambo)
        
        yellowSportBorder.backgroundColor = .white
        yellowSportBorder.frame.size = CGSize(width: 100, height: 150)
        yellowSportBorder.center.y = 200
        yellowSportBorder.center.x = self.view.frame.width - 100
        yellowSportBorder.layer.cornerRadius = 20
        yellowSportBorder.layer.borderColor = UIColor.black.cgColor
        yellowSportBorder.layer.borderWidth = 5
        view.addSubview(yellowSportBorder)
        yellowSportBorder.addSubview(yellowSport)
        
        redSportBorder.backgroundColor = .white
        redSportBorder.frame.size = CGSize(width: 100, height: 150)
        redSportBorder.center.y = lamboBorder.center.y + 250
        redSportBorder.center.x = lamboBorder.center.x
        redSportBorder.layer.cornerRadius = 20
        redSportBorder.layer.borderColor = UIColor.black.cgColor
        redSportBorder.layer.borderWidth = 5
        view.addSubview(redSportBorder)
        redSportBorder.addSubview(redSport)
        
        blueSportBorder.backgroundColor = .white
        blueSportBorder.frame.size = CGSize(width: 100, height: 150)
        blueSportBorder.center.y = yellowSportBorder.center.y + 250
        blueSportBorder.center.x = yellowSportBorder.center.x
        blueSportBorder.layer.cornerRadius = 20
        blueSportBorder.layer.borderColor = UIColor.black.cgColor
        blueSportBorder.layer.borderWidth = 5
        view.addSubview(blueSportBorder)
        blueSportBorder.addSubview(blueSport)
    }
}
