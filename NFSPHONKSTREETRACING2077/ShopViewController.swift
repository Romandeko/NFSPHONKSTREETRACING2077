
import UIKit
import SnapKit
class ShopViewController: UIViewController {
    
    // MARK: - Override properties
    var coins = 0
    private  let coinsLabel = UILabel()
    private  let bugattiBorder = UIView()
    private  let yellowSportBorder = UIView()
    private  let bugattiImage = UIImage(named: "bugatti")
    private  let yellowSportImage = UIImage(named: "yellowSport")
    var mainCarImage = UIImage()
    
    private lazy var bugatti = UIImageView(image: bugattiImage)
    private lazy var yellowSport = UIImageView(image: yellowSportImage)
    
    private let backButton = UIButton()
    
    private let buyBugattiButton = UIButton()
    private  let yellowSportButton = UIButton()
    private  let bugattiCostLabel = UILabel()
    private  let yellowSportLabel = UILabel()
    
    private  var isBought = false
    private  var isBugattiBought = false
    private  var isYellowBought = false
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.frame.size = CGSize(width: 100, height: 40)
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = UIColor.black
        backButton.setTitle("Back", for: .normal)
        backButton.center.x = self.view.center.x
        backButton.center.y = self.view.frame.height - 50
        view.addSubview(backButton)
        
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
        
        
        buyBugattiButton.frame.size = CGSize(width: 100, height: 40)
        buyBugattiButton.layer.cornerRadius = 20
        buyBugattiButton.backgroundColor = UIColor.black
        buyBugattiButton.setTitle("Buy", for: .normal)
        buyBugattiButton.center.x = bugattiBorder.center.x
        buyBugattiButton.center.y = bugattiBorder.frame.maxY + 60
        view.addSubview(buyBugattiButton)
        
        bugattiCostLabel.text = "20"
        bugattiCostLabel.textAlignment = .center
        bugattiCostLabel.textColor = .black
        bugattiCostLabel.font = bugattiCostLabel.font.withSize(30)
        bugattiCostLabel.frame.size = CGSize(width: 350, height: 50)
        bugattiCostLabel.center.x = bugattiBorder.center.x
        bugattiCostLabel.center.y = buyBugattiButton.center.y - 40
        view.addSubview(bugattiCostLabel)
        
        
        yellowSportButton.frame.size = CGSize(width: 100, height: 40)
        yellowSportButton.layer.cornerRadius = 20
        yellowSportButton.backgroundColor = UIColor.black
        yellowSportButton.setTitle("Buy", for: .normal)
        yellowSportButton.center.x = yellowSportBorder.center.x
        yellowSportButton.center.y = yellowSportBorder.frame.maxY + 60
        view.addSubview(yellowSportButton)
        
        yellowSportLabel.text = "10"
        yellowSportLabel.textAlignment = .center
        yellowSportLabel.textColor = .black
        yellowSportLabel.font = yellowSportLabel.font.withSize(30)
        yellowSportLabel.frame.size = CGSize(width: 350, height: 50)
        yellowSportLabel.center.x = yellowSportBorder.center.x
        yellowSportLabel.center.y = yellowSportButton.center.y - 40
        view.addSubview(yellowSportLabel)
        
        let goBack = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(goBack)
        
        let buyBugatti = UITapGestureRecognizer(target: self, action: #selector(buyBugatti))
        buyBugattiButton.addGestureRecognizer(buyBugatti)
        
        let buyYellowSport = UITapGestureRecognizer(target: self, action: #selector(buyYellowSport))
        yellowSportButton.addGestureRecognizer(buyYellowSport)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        coinsLabel.text = "Coins:\(coins)"
        coinsLabel.textAlignment = .center
        coinsLabel.textColor = .black
        coinsLabel.frame.size = CGSize(width: 350, height: 50)
        coinsLabel.font = coinsLabel.font.withSize(50)
        coinsLabel.center.x = view.center.x
        coinsLabel.frame.origin.y = 50
        view.addSubview(coinsLabel)
        
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
        }
    }
}
