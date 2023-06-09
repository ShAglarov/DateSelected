//
//  PopupViewController.swift
//  DataSelected
//
//  Created by Shamil Aglarov on 09.06.2023.
//

import UIKit

class PopupViewController: UIViewController {
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.backgroundColor = .gray
        picker.tintColor = #colorLiteral(red: 0.8719834089, green: 0.8719834089, blue: 0.8719834089, alpha: 1)
        picker.layer.cornerRadius = 10
        picker.layer.masksToBounds = true
        picker.minimumDate = .now
        return picker
    }()
    
    var onButtonTapped: ((String, String) -> Void)?
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 5
        textView.backgroundColor = UIColor.darkGray
        // Добавляем начальный текст
        let mainString = "Будет вечеринка через "
        let highlightString = "{date}"
        
        let attributedMainString = NSMutableAttributedString(string: mainString)
        attributedMainString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: mainString.count))
        
        let attributedHighlightString = NSMutableAttributedString(string: highlightString)
        
        attributedHighlightString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: highlightString.count))
        
        attributedMainString.append(attributedHighlightString)
        textView.attributedText = attributedMainString
        
        return textView
    }()
    
    let setBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Установить", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        return button
    }()
    
    @objc func buttonTapped() {

        let chosenDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.MM"
        let selectedDateString = dateFormatter.string(from: chosenDate)

        let currentDate = Date()

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate, to: chosenDate)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        numberFormatter.locale = Locale(identifier: "ru_RU")

        var dateString = String()

        if let years = components.year, years > 0 {
            let yearsEnding = (years % 10 == 1 && years % 100 != 11) ? "год" : (years % 10 >= 2 && years % 10 <= 4 && (years % 100 < 10 || years % 100 >= 20) ? "года" : "лет")
            dateString += "\(numberFormatter.string(from: NSNumber(value: years))!) \(yearsEnding) "
        }

        if let months = components.month, months > 0 {
            let monthsEnding = (months % 10 == 1 && months % 100 != 11) ? "месяц" : (months % 10 >= 2 && months % 10 <= 4 && (months % 100 < 10 || months % 100 >= 20) ? "месяца" : "месяцев")
            dateString += "\(numberFormatter.string(from: NSNumber(value: months))!) \(monthsEnding) "
        }

        if let days = components.day, days > 0 {
            let daysEnding = (days % 10 == 1 && days % 100 != 11) ? "день" : (days % 10 >= 2 && days % 10 <= 4 && (days % 100 < 10 || days % 100 >= 20) ? "дня" : "дней")
            dateString += "\(numberFormatter.string(from: NSNumber(value: days))!) \(daysEnding) "
        }

        if dateString.isEmpty {
            dateString = "Сегодня"
        }

        onButtonTapped?(textView.text.replacingOccurrences(of: "{date}", with: dateString), selectedDateString)

        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfigureConstraint()
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        setBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

extension PopupViewController {
    
    func setupConfigureConstraint() {
        
        view.addSubview(datePicker)
        view.addSubview(textView)
        view.addSubview(setBtn)
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(40)
            make.left.right.equalTo(datePicker) // равен ширине datePicker
            make.height.equalTo(100)
        }
        
        setBtn.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(30)
            make.left.right.equalTo(datePicker) // равен ширине datePicker
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.height.equalTo(50)
        }
    }
}
