//
//  RulesVCViewController.swift
//  CardWorkout-Programmatic
//
//  Created by Ege Kaygisizer on 5/12/24.
//

import UIKit

class RulesVC: UIViewController {

    let titleLabel = UILabel()
    let rulesLabel = UILabel()
    let excersiseLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTitleLabel()
        configureRulesLabel()
        configureExcersiseLabel()
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Rules"
        titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
        
    }
    
    func configureRulesLabel() {
        view.addSubview(rulesLabel)
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesLabel.text = "Each cards number represents a how many you should do excersises\n\nJ = 11, Q = 12, K = 13, A = 14"
        rulesLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        rulesLabel.textAlignment = .center
        rulesLabel.lineBreakMode = .byWordWrapping
        rulesLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            rulesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            rulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            rulesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func configureExcersiseLabel() {
        view.addSubview(excersiseLabel)
        excersiseLabel.translatesAutoresizingMaskIntoConstraints = false
        excersiseLabel.text = "♠️ = Push-up\n\n♥️ = Sit-up \n\n♦️ = Squat \n\n♣️ = Jump"
        excersiseLabel.font = .systemFont(ofSize: 20, weight: .regular)
        excersiseLabel.textAlignment = .center
        excersiseLabel.lineBreakMode = .byWordWrapping
        excersiseLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            excersiseLabel.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor,constant: 60),
            excersiseLabel.widthAnchor.constraint(equalToConstant: 200),
            excersiseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
}
