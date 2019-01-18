//
//  LoadingViewController.swift
//  iOS Demo App
//
//  Created by Stefan Renne on 09/04/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import UIKit
import RxSonosLib
import RxSwift

class LoadingViewController: UIViewController {

    internal var router: LoadingRouter!
    private let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllRoomsObservable()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func setupAllRoomsObservable() {
        SonosInteractor
            .getAllGroups()
            .filter({ $0.count > 0 })
            .take(1)
            .subscribe(onNext: { [weak self] (groups) in
                if groups.count > 0 {
                    self?.router.continueToMySonos()
                }
            })
            .disposed(by: disposebag)
    }

}
