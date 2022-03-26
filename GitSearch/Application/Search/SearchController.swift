//
//  SearchController.swift
//  GitSearch
//
//  Created by Vldmr on 7/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

final class SearchController: UIViewController, UITextFieldDelegate, SearchControllerViewDelegate {
    
    private lazy var _childView: SearchControllerView = {
        let view = SearchControllerView(frame: self.view.bounds)
        view.delegate = self
        return view
    }()

    private let _alertFactory: AlertControllerFactory

    init(alertFactory: AlertControllerFactory) {
        _alertFactory = AlertControllerFactory()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainTint

        self.view.addSubview(_childView)
        _childView.setNeedsUpdateConstraints()

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        _childView.setNeedsUpdateConstraints()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        _childView.setNeedsUpdateConstraints()
    }

    // MARK: - SearchControllerViewDelegate
    func processInputKeywords(keysSequence: String?) {
        guard let keysSequence = keysSequence else {
            _presentAlert(alert: .noKeyword)
            return
        }

        self.addSpinner()
        SearchServices.shared.getRepositories(keysSequence: keysSequence) { res in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.removeSpinner()
                switch res {
                    case let .success(gitRep):
                        guard gitRep.total_count != 0 else {
                            self._presentAlert(alert: .noDataFound)
                            return
                        }
                        let newVC = SearchResultViewController(data: gitRep)
                        self.navigationController?.pushViewController(newVC, animated: true)
                    case .failure:
                        self._presentAlert(alert: .errorFound)
                }
            }
        }
    }

    private func _presentAlert(alert: SearchUserAlerts) {
        let alert = _alertFactory.makeAlertController(alert: alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
