
import UIKit
import SnapKit
class ShopViewController: UIViewController {
    // MARK: - Override properties
    var mainCarImage = UIImage()
    var coins = 0
    // MARK: - Private properties
    private let coinsLabel = UILabel()
    private let bugattiBorder = UIView()
    private let yellowSportBorder = UIView()
    private let redSportBorder = UIView()
    private let blueSportBorder = UIView()
    private let bugattiImage = UIImage(named: "bugatti")
    private let yellowSportImage = UIImage(named: "yellowSport")
    private let redSportImage = UIImage(named: "redSport")
    private let blueSportImage = UIImage(named: "blueSport")
    
    private lazy var bugatti = UIImageView(image: bugattiImage)
    private lazy var yellowSport = UIImageView(image: yellowSportImage)
    private lazy var blueSport = UIImageView(image: blueSportImage)
    private lazy var redSport = UIImageView(image: redSportImage)
    
    private let backButton = UIButton()
    
    private let buyBugattiButton = UIButton()
    private let yellowSportButton = UIButton()
    private let redSportButton = UIButton()
    private let blueSportButton = UIButton()
    private let bugattiCostLabel = UILabel()
    private let yellowSportLabel = UILabel()
    private let redSportLabel = UILabel()
    private let blueSportLabel = UILabel()
    
    private var isBought = false
    private var isBugattiBought = false
    private var isYellowBought = false
    private var isRedBought = false
    private var isBlueBought = false
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var backImageView: BackgroundImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImageView.makeBlur()
        
        backButton.frame.size = CGSize(width: 100, height: 40)
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = UIColor.black
        backButton.setTitle("Back", for: .normal)
        backButton.center.x = self.view.center.x
        backButton.center.y = self.view.frame.height - 50
        view.addSubview(backButton)
        
      addCarBorders()
      addCarButtons()
      addCarLabels()
      addGradient()
      addGestures()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        coinsLabel.text = "Coins:\(coins)"
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
        if isBugattiBought == false{
            guard let stringCost = bugattiCostLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.text = "NO MONEY"
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = bugattiImage else { return }
            mainCarImage = testImage
            isBought = true
            isBugattiBought = true
            buyBugattiButton.setTitle("Choose", for: .normal)
        } else{
            guard let testImage = bugattiImage else { return }
            mainCarImage = testImage
            coinsLabel.text = "AGAIN?"
        }
    }
    
    
    @objc private func buyYellowSport(){
        if isYellowBought == false{
            guard let stringCost = yellowSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.text = "NO MONEY"
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = yellowSportImage else { return }
            mainCarImage = testImage
            isBought = true
            isYellowBought = true
            yellowSportButton.setTitle("Choose", for: .normal)
        } else{
            guard let testImage = yellowSportImage else { return }
            mainCarImage = testImage
            coinsLabel.text = "AGAIN?"
        }
    }
    
    @objc private func buyRedSport(){
        if isRedBought == false{
            guard let stringCost = redSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.text = "NO MONEY"
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = redSportImage else { return }
            mainCarImage = testImage
            isBought = true
            isRedBought = true
            redSportButton.setTitle("Choose", for: .normal)
        } else{
            guard let testImage = redSportImage else { return }
            mainCarImage = testImage
            coinsLabel.text = "AGAIN?"
        }
    }
    @objc private func buyBlueSport(){
        if isBlueBought == false{
            guard let stringCost = blueSportLabel.text else { return }
            guard let cost = Int(stringCost) else { return }
            if coins - cost > 0 {
                coins -= cost
            } else {
                coinsLabel.text = "NO MONEY"
                return }
            coinsLabel.text = "Coins:\(coins)"
            guard let testImage = blueSportImage else { return }
            mainCarImage = testImage
            isBought = true
            isBlueBought = true
            blueSportButton.setTitle("Choose", for: .normal)
        } else{
            guard let testImage = blueSportImage else { return }
            mainCarImage = testImage
            coinsLabel.text = "AGAIN?"
        }
    }
    private func addGestures(){
        let goBack = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(goBack)
        
        let buyBugatti = UITapGestureRecognizer(target: self, action: #selector(buyBugatti))
        buyBugattiButton.addGestureRecognizer(buyBugatti)
        
        let buyYellowSport = UITapGestureRecognizer(target: self, action: #selector(buyYellowSport))
        yellowSportButton.addGestureRecognizer(buyYellowSport)
        
        let buyRedSport = UITapGestureRecognizer(target: self, action: #selector(buyRedSport))
        redSportButton.addGestureRecognizer(buyRedSport)

        let buyBlueSport = UITapGestureRecognizer(target: self, action: #selector(buyBlueSport))
        blueSportButton.addGestureRecognizer(buyBlueSport)
    }
    private func addGradient(){
        self.buyBugattiButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.yellowSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.redSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.blueSportButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        self.backButton.applyGradient(colours: [.blue, .purple], cornerRadius: 20, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
    }
    private func addConstraints(){
        bugatti.snp.makeConstraints{ make in
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
        
        blueSportLabel.text = "7"
        blueSportLabel.textAlignment = .center
        blueSportLabel.textColor = .white
        blueSportLabel.font = blueSportLabel.font.withSize(30)
        blueSportLabel.frame.size = CGSize(width: 350, height: 50)
        blueSportLabel.center.x = blueSportBorder.center.x
        blueSportLabel.center.y = blueSportButton.center.y - 40
        view.addSubview(blueSportLabel)
        
        yellowSportLabel.text = "10"
        yellowSportLabel.textAlignment = .center
        yellowSportLabel.textColor = .white
        yellowSportLabel.font = yellowSportLabel.font.withSize(30)
        yellowSportLabel.frame.size = CGSize(width: 350, height: 50)
        yellowSportLabel.center.x = yellowSportBorder.center.x
        yellowSportLabel.center.y = yellowSportButton.center.y - 40
        view.addSubview(yellowSportLabel)
        
        redSportLabel.text = "5"
        redSportLabel.textAlignment = .center
        redSportLabel.textColor = .white
        redSportLabel.font = redSportLabel.font.withSize(30)
        redSportLabel.frame.size = CGSize(width: 350, height: 50)
        redSportLabel.center.x = redSportBorder.center.x
        redSportLabel.center.y = redSportButton.center.y - 40
        view.addSubview(redSportLabel)
        
        bugattiCostLabel.text = "20"
        bugattiCostLabel.textAlignment = .center
        bugattiCostLabel.textColor = .white
        bugattiCostLabel.font = bugattiCostLabel.font.withSize(30)
        bugattiCostLabel.frame.size = CGSize(width: 350, height: 50)
        bugattiCostLabel.center.x = bugattiBorder.center.x
        bugattiCostLabel.center.y = buyBugattiButton.center.y - 40
        view.addSubview(bugattiCostLabel)
        
    }
    private func addCarButtons(){
        
        buyBugattiButton.frame.size = CGSize(width: 100, height: 40)
        buyBugattiButton.layer.cornerRadius = 20
        buyBugattiButton.backgroundColor = UIColor.black
        buyBugattiButton.setTitle("Buy", for: .normal)
        buyBugattiButton.center.x = bugattiBorder.center.x
        buyBugattiButton.center.y = bugattiBorder.frame.maxY + 60
        view.addSubview(buyBugattiButton)
    
        redSportButton.frame.size = CGSize(width: 100, height: 40)
        redSportButton.layer.cornerRadius = 20
        redSportButton.backgroundColor = UIColor.black
        redSportButton.setTitle("Buy", for: .normal)
        redSportButton.center.x = redSportBorder.center.x
        redSportButton.center.y = redSportBorder.frame.maxY + 60
        view.addSubview(redSportButton)
        
        
        yellowSportButton.frame.size = CGSize(width: 100, height: 40)
        yellowSportButton.layer.cornerRadius = 20
        yellowSportButton.backgroundColor = UIColor.black
        yellowSportButton.setTitle("Buy", for: .normal)
        yellowSportButton.center.x = yellowSportBorder.center.x
        yellowSportButton.center.y = yellowSportBorder.frame.maxY + 60
        view.addSubview(yellowSportButton)
        
        blueSportButton.frame.size = CGSize(width: 100, height: 40)
        blueSportButton.layer.cornerRadius = 20
        blueSportButton.backgroundColor = UIColor.black
        blueSportButton.setTitle("Buy", for: .normal)
        blueSportButton.center.x = blueSportBorder.center.x
        blueSportButton.center.y = blueSportBorder.frame.maxY + 60
        view.addSubview(blueSportButton)
    }
    private func addCarBorders(){
        bugattiBorder.backgroundColor = .white
        bugattiBorder.frame.size = CGSize(width: 100, height: 150)
        bugattiBorder.center.y = 200
        bugattiBorder.center.x = 100
        bugattiBorder.layer.cornerRadius = 20
        bugattiBorder.layer.borderColor = UIColor.black.cgColor
        bugattiBorder.layer.borderWidth = 5
        view.addSubview(bugattiBorder)
        bugattiBorder.addSubview(bugatti)
        
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
        redSportBorder.center.y = bugattiBorder.center.y + 250
        redSportBorder.center.x = bugattiBorder.center.x
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
