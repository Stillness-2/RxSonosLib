//
//  MoreCoordinator.swift
//  iOS Demo App
//
//  Created by Stefan Renne on 10/04/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import UIKit
import RxSonosLib

protocol MoreRouter {
    func didSelect(type: MoreType)
}

class MoreCoordinator: Coordinator {
    
    private let masterRouter: MasterRouter
    private weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController?, masterRouter: MasterRouter) {
        self.navigationController = navigationController
        self.masterRouter = masterRouter
    }
    
    private let viewController = MoreViewController()
    func setup() -> UIViewController {
        viewController.router = self
        return viewController
    }
    
    func start() {
        let viewController = self.setup()
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
}

extension MoreCoordinator: MoreRouter {
    
    func didSelect(type: MoreType) {
        switch type {
        case .musicproviders:
            MusicProvidersCoordinator(masterRouter: masterRouter).start()
        }
    }
    
}
