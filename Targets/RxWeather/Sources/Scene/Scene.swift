//
//  Scene.swift
//  RxWeather
//
//  Created by yoon on 2022/02/28.
//  Copyright © 2022 kr.co. All rights reserved.
//

import UIKit

enum Scene {
    case main(MainViewModel)
}

extension Scene {
    func instantiate() -> UIViewController {
//        let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
        switch self {
        case .main(let mainViewModel):
            var vc = MainViewController()
            DispatchQueue.main.async {
                vc.bind(viewModel: mainViewModel)
            }
            return vc
        }
    }
}

