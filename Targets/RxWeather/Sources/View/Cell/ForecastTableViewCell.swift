//
//  ForecastTableViewCell.swift
//  RxWeather
//
//  Created by yoon on 2022/03/02.
//  Copyright © 2022 kr.co. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ForecastTableViewCell"

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
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
        imageView.tintColor = .white
        return imageView
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {
        self.backgroundColor = .clear
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
            
            statusLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -10),
            statusLabel.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
        
            weatherImageView.trailingAnchor.constraint(equalTo: statusLabel.leadingAnchor, constant: -10),
            weatherImageView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40),
            weatherImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherImageView.leadingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor, constant: 10)

        ])
    }

    func configure(from data: WeatherDataType, dateFormatter: DateFormatter, tempFormatter: NumberFormatter) {
        dateFormatter.dateFormat = "M.d (E)"
        dateLabel.text = dateFormatter.string(for: data.date)

        dateFormatter.dateFormat = "HH:00"
        timeLabel.text = dateFormatter.string(for: data.date)

        weatherImageView.image = UIImage.from(name: data.icon)

        statusLabel.text = data.description

        let tempStr = tempFormatter.string(for: data.temperature) ?? "-"
        temperatureLabel.text = "\(tempStr)º"
    }
}
