//
//  CardSelectionVC.swift
//  CardWorkout
//
//  Created by Ege Kaygisizer on 2/12/24.
//

import UIKit

class CardSelectionVC: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    
    var timer : Timer!
    var card : [UIImage] = Decks.AllCards
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        for button in buttons {
            button.layer.cornerRadius = 8
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) { // ekranı kapatırken veya minimalize ettiğinde yapılacak fonksiyon.
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector (updateCards), userInfo: nil, repeats: true)
    }
    
    @objc func updateCards() {
        cardImageView.image = card.randomElement() ?? UIImage(named: "AS")
        }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = nil
    }
    
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        startTimer()
    }
    
    
    @IBAction func rulesButtonTapped(_ sender: Any) {
    }
    @IBAction func rulesCloseButton(unwindSegue: UIStoryboardSegue){
        
    }
}
