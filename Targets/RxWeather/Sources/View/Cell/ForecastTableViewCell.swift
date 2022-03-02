//
//  ForecastTableViewCell.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews(){
        self.addSubview(dateLabel)
        self.addSubview(timeLabel)
        self.addSubview(weatherImageView)
        self.addSubview(statusLabel)
        self.addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -21),
            
            statusLabel.centerXAnchor.constraint(equalTo: temperatureLabel.centerXAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -10),
            statusLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 10),
            
            weatherImageView.centerXAnchor.constraint(equalTo: statusLabel.centerXAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40),
            weatherImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherImageView.leadingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor, constant: 10)
        
        ])
    }

}
