//
//  ViewController.swift
//  timerrrr
//
//  Created by Admin on 23.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    let countdownLabel = UILabel()
    let startButton = UIButton(type: .system)
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.systemBackground
        
        startDatePicker.datePickerMode = .dateAndTime
        startDatePicker.preferredDatePickerStyle = .wheels
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startDatePicker)
        

        endDatePicker.datePickerMode = .dateAndTime
        endDatePicker.preferredDatePickerStyle = .wheels
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(endDatePicker)
 
        countdownLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        countdownLabel.textAlignment = .center
        countdownLabel.numberOfLines = 0
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countdownLabel)

        startButton.setTitle("Start Timer", for: .normal)
        startButton.backgroundColor = UIColor.systemBlue
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 10
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        startButton.addTarget(self, action: #selector(startCountdown), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)

        NSLayoutConstraint.activate([
            startDatePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            startDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
            endDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            endDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            countdownLabel.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 20),
            countdownLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countdownLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            startButton.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func startCountdown() {
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        
        if endDate > startDate {
            startTimer(from: startDate, to: endDate)
        } else {
            countdownLabel.text = "End date must be after start date"
            countdownLabel.textColor = UIColor.systemRed
        }
    }
    
    func startTimer(from startDate: Date, to endDate: Date) {
        timer?.invalidate()
        countdownLabel.textColor = UIColor.label
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            let now = Date()
            if now >= endDate {
                timer.invalidate()
                self?.countdownLabel.text = "Time's up!"
            } else {
                let timeInterval = endDate.timeIntervalSince(now)
                self?.updateCountdownLabel(with: timeInterval)
            }
        }
    }
    
    func updateCountdownLabel(with timeInterval: TimeInterval) {
        let days = Int(timeInterval) / 86400
        let hours = (Int(timeInterval) % 86400) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        
        countdownLabel.text = String(format: "%02d days\n%02d hours\n%02d minutes\n%02d seconds", days, hours, minutes, seconds)
    }
}


