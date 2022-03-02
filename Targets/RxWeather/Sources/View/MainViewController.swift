//
//  HomeViewController.swift
//  RxWeather
//
//  Created by yoon on 2022/02/28.
//  Copyright © 2022 kr.co. All rights reserved.
//
import CoreLocation
import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx


class MainViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MainViewModel!
    var topInset: CGFloat = 0.0
    
    func bindViewModel() {
        viewModel.title
            .bind(to: navTitle.rx.text)
            .disposed(by: rx.disposeBag)
        print("bind")
        viewModel.weatherData
            .drive(tableView.rx.items(dataSource: viewModel.dataSources))
            .disposed(by: rx.disposeBag)
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(WeatherData.self))
            .withUnretained(self)
            .bind { (vc, data) in
                vc.tableView.deselectRow(at: data.0, animated: true)
            }
            .disposed(by: rx.disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    private let bgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background")
        return imageView
    }()

    private let navView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let navTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.reuseIdentifier)
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        return tableView
    }()


    func setupViews() {
        view.addSubview(bgView)
        view.addSubview(navView)
        navView.addSubview(navTitle)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 60),
            navTitle.centerXAnchor.constraint(equalTo: navView.centerXAnchor),
            navTitle.centerYAnchor.constraint(equalTo: navView.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if topInset == 0.0 {
            let first = IndexPath(row: 0, section: 0)
            if let cell = tableView.cellForRow(at: first) {
                topInset = tableView.frame.height - cell.frame.height
                tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            }
        }
    }
}
