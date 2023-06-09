//
//  ViewController.swift
//  DataSelected
//
//  Created by Shamil Aglarov on 08.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let todayDateLbl: UILabel = {
        let label = UILabel()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d:MM"
        label.textColor = .gray
        label.text = dateFormatter.string(from: currentDate)
        return label
    }()
    
    private let textTodayLbl: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    let selectedBtn: UIButton = {
        let button = UIButton()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "d.MM"
        
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitle(dateFormatter.string(from: date), for: .normal)
        button.addTarget(self,
                         action: #selector(buttonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    let textLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        label.text = "Start in three days"
        return label
    }()
    
    @objc func buttonTapped() {
        let popUpVC = PopupViewController()
        popUpVC.modalPresentationStyle = .pageSheet
        popUpVC.modalTransitionStyle = .coverVertical
        
        popUpVC.onButtonTapped = { [weak self] selectedDate, currentDate in
            self?.textLbl.text = selectedDate
            self?.selectedBtn.setTitle(currentDate, for: .normal)
        }
        
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        setupConstraint()
    }
}

extension ViewController {
    
    func setupConstraint() {
        view.addSubview(textTodayLbl)
        view.addSubview(todayDateLbl)
        view.addSubview(arrowImageView)
        view.addSubview(selectedBtn)
        view.addSubview(textLbl)
        
        textTodayLbl.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        todayDateLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(textTodayLbl.snp.leading)
            make.bottom.equalTo(textTodayLbl.snp.top).offset(2)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(textTodayLbl.snp.trailing).offset(20)
            make.centerY.equalTo(textTodayLbl.snp.centerY).offset(2)
            make.width.height.equalTo(30)
        }
        selectedBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(arrowImageView.snp.trailing).offset(15)
            make.centerY.equalTo(arrowImageView.snp.centerY).offset(2)
            make.width.width.equalTo(150)
        }
        textLbl.snp.makeConstraints { (make) in
            textLbl.numberOfLines = 0
            textLbl.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(selectedBtn.snp.bottom).offset(100)
                make.left.right.equalToSuperview().inset(20)
            }
        }
    }
}
