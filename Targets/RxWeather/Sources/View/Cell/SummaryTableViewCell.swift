//
//  SummaryTableViewCell.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SummaryTableViewCell"

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
    
    private let minMaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupViews() {
        self.addSubview(weatherImageView)
        self.addSubview(statusLabel)
        self.addSubview(minMaxLabel)
        self.addSubview(currentTemperatureLabel)
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),
            weatherImageView.widthAnchor.constraint(equalToConstant: 50),
            
            statusLabel.topAnchor.constraint(equalTo: weatherImageView.topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            statusLabel.heightAnchor.constraint(equalToConstant: 50),
            
            minMaxLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 10),
            minMaxLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            minMaxLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: minMaxLabel.bottomAnchor, constant: 10),
            currentTemperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            currentTemperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11)
        ])
    }

}
