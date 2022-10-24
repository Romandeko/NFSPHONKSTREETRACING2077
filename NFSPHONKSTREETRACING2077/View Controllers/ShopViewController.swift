
import UIKit
import SnapKit

private let labelAttribute = [ NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 50)
                               ,NSAttributedString.Key.foregroundColor:UIColor.white]
private let buttonAttribute = [ NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 20)
                                ,NSAttributedString.Key.foregroundColor:UIColor.white]

class ShopViewController: UIViewController {
    
    // MARK: - Override properties
    var mainCarImage = UIImage()
    var coins = 0
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
    
    private let buyLamboButton = GradienButton()
    private let yellowSportButton = GradienButton()
    private let redSportButton = GradienButton()
    private let blueSportButton = GradienButton()
    private let backButton = GradienButton()
    
    private let lamboCostLabel = UILabel()
    private let yellowSportLabel = UILabel()
    private let redSportLabel = UILabel()
    private let blueSportLabel = UILabel()
    private let coinsLabel = UILabel()
    
    private var isBought = false
    private var isLamboBought = false
    private var isYellowBought = false
    private var isRedBought = false
    private var isBlueBought = false
    
    private var stepFromButton : CGFloat = 40
    private var stepFromBorder : CGFloat = 60
    
    private let noMoneyString = NSMutableAttributedString(string: "NO MONEY", attributes: labelAttribute as [NSAttributedString.Key : Any])
    private let chooseString = NSMutableAttributedString(string: "Choose", attributes: buttonAttribute as [NSAttributedString.Key : Any])
    private let againString = NSMutableAttributedString(string: "AGAIN?", attributes: labelAttribute as [NSAttributedString.Key : Any])
    
    // MARK: - IBOutlets
    @IBOutlet weak var backImageView: BackgroundImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let coinsValueString = NSMutableAttributedString(string: String(coins),attributes: buttonAttribute as [NSAttributedString.Key : Any])
        coinsString.append(coinsValueString)
        coinsLabel.attributedText = coinsString
        coinsLabel.textAlignment = .center
        coinsLabel.textColor = .white
        coinsLabel.frame.size = CGSize(width: 350, height: 50)
        coinsLabel.font = coinsLabel.font.withSize(50)
        coinsLabel.center.x = view.center.x
        coinsLabel.frame.origin.y = 50
        view.addSubview(coinsLabel)
        
        addConstraints()
    }
    
    // MARK: - Private methods
    @objc private func goBack(){
        guard let parentViewController = self.presentingViewController as?
                Menu else { return }
        parentViewController.coins = coins
        if isBought == false{
            dismiss(animated: false)
        }else{
            parentViewController.mainCarImage = mainCarImage
            dismiss(animated: false)}
    }
    
    @objc private func buyBugatti(){
        if isLamboBought == false{
            guard let stringCost = lamboCostLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.attributedText = noMoneyString
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = lamboImage else { return }
            mainCarImage = testImage
            isBought = true
            isLamboBought = true
            buyLamboButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = lamboImage else { return }
            mainCarImage = testImage
            coinsLabel.attributedText = againString
        }
    }
    
    @objc private func buyYellowSport(){
        if isYellowBought == false{
            guard let stringCost = yellowSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.attributedText = noMoneyString
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = yellowSportImage else { return }
            mainCarImage = testImage
            isBought = true
            isYellowBought = true
            yellowSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = yellowSportImage else { return }
            mainCarImage = testImage
            coinsLabel.attributedText = againString
        }
    }
    
    @objc private func buyRedSport(){
        if isRedBought == false{
            guard let stringCost = redSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.attributedText = noMoneyString
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = redSportImage else { return }
            mainCarImage = testImage
            isBought = true
            isRedBought = true
            redSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = redSportImage else { return }
            mainCarImage = testImage
            coinsLabel.attributedText = againString
        }
    }
    
    @objc private func buyBlueSport(){
        if isBlueBought == false{
            guard let stringCost = blueSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.attributedText = noMoneyString
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = blueSportImage else { return }
            mainCarImage = testImage
            isBought = true
            isBlueBought = true
            blueSportButton.setAttributedTitle(chooseString, for: .normal)
        } else{
            guard let testImage = blueSportImage else { return }
            mainCarImage = testImage
            coinsLabel.attributedText = againString
        }
    }
    
    private func addGestures(){
        let goBack = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(goBack)
        
        let buyBugatti = UITapGestureRecognizer(target: self, action: #selector(buyBugatti))
        buyLamboButton.addGestureRecognizer(buyBugatti)
        
        let buyYellowSport = UITapGestureRecognizer(target: self, action: #selector(buyYellowSport))
        yellowSportButton.addGestureRecognizer(buyYellowSport)
        
        let buyRedSport = UITapGestureRecognizer(target: self, action: #selector(buyRedSport))
        redSportButton.addGestureRecognizer(buyRedSport)
        
        let buyBlueSport = UITapGestureRecognizer(target: self, action: #selector(buyBlueSport))
        blueSportButton.addGestureRecognizer(buyBlueSport)
    }
    
    private func addGradient(){
        self.buyLamboButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.yellowSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.redSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.blueSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.backButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
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
        
        let buyString = NSMutableAttributedString(string: "Buy", attributes: buttonAttribute as [NSAttributedString.Key : Any] )
        buyLamboButton.frame.size = CGSize(width: 100, height: 45)
        buyLamboButton.layer.cornerRadius = 20
        buyLamboButton.backgroundColor = UIColor.black
        buyLamboButton.setAttributedTitle(buyString, for: .normal)
        buyLamboButton.center.x = lamboBorder.center.x
        buyLamboButton.center.y = lamboBorder.frame.maxY + stepFromBorder
        view.addSubview(buyLamboButton)
        
        redSportButton.frame.size = CGSize(width: 100, height: 45)
        redSportButton.layer.cornerRadius = 20
        redSportButton.backgroundColor = UIColor.black
        redSportButton.setAttributedTitle(buyString, for: .normal)
        redSportButton.center.x = redSportBorder.center.x
        redSportButton.center.y = redSportBorder.frame.maxY + stepFromBorder
        view.addSubview(redSportButton)
        
        yellowSportButton.frame.size = CGSize(width: 100, height: 45)
        yellowSportButton.layer.cornerRadius = 20
        yellowSportButton.backgroundColor = UIColor.black
        yellowSportButton.setAttributedTitle(buyString, for: .normal)
        yellowSportButton.center.x = yellowSportBorder.center.x
        yellowSportButton.center.y = yellowSportBorder.frame.maxY + stepFromBorder
        view.addSubview(yellowSportButton)
        
        blueSportButton.frame.size = CGSize(width: 100, height: 45)
        blueSportButton.layer.cornerRadius = 20
        blueSportButton.backgroundColor = UIColor.black
        blueSportButton.setAttributedTitle(buyString, for: .normal)
        blueSportButton.center.x = blueSportBorder.center.x
        blueSportButton.center.y = blueSportBorder.frame.maxY + stepFromBorder
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
