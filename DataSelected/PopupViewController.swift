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
        let mainString = "There will be a party in "
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
        button.setTitle("Set", for: .normal)
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
        let components = calendar.dateComponents([.day], from: currentDate, to: chosenDate)
        guard let dayDifference = components.day else { return }
        var dateString = String()
        
        switch dayDifference {
        case 0:
            dateString = "today"
        case 1:
            dateString = "tomorrow"
        case 2:
            dateString = "day after tomorrow"
        case 3:
            dateString = "after three days"
        case 4:
            dateString = "after four days"
        case 5:
            dateString = "after five days"
        case 6:
            dateString = "after six days"
        case 7:
            dateString = "after seven days"
        default:
            dateString = "\(dayDifference) days"
        }

        onButtonTapped?(textView.text
            .replacingOccurrences(of: "{date}", with: dateString), selectedDateString)
        
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
