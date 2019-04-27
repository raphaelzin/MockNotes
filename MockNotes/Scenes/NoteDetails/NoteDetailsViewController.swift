//
//  NoteDetailsViewController.swift
//  TestApp
//
//  Created by Raphael Souza on 2019-04-21.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol NoteDetailsView: class {
    func bindData(content: BehaviorRelay<String?>)
    func display(_ error: Error)
}

class NoteDetailsViewController: UIViewController {
    
    // MARK: UI Components
    
    private lazy var contentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 8
        tv.clipsToBounds = false
        return tv
    }()
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopEditing))
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    // MARK: - Variables
    
    var presenter: NoteDetailsPresenter?
    
    let disposeBag = DisposeBag()
    
    // MARK: Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureLayout()
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let shadowPath = UIBezierPath(roundedRect: contentTextView.bounds, cornerRadius: contentTextView.layer.cornerRadius)
        contentTextView.layer.shadowPath = shadowPath.cgPath
        contentTextView.layer.shadowColor = UIColor.black.cgColor
        contentTextView.layer.shadowRadius = 10
        contentTextView.layer.shadowOpacity = 0.16
        contentTextView.layer.shadowOffset = CGSize(width: 0.0, height: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
}

// MARK: Private selectors

private extension NoteDetailsViewController {
    @objc func stopEditing() {
        view.endEditing(true)
    }
    
    @objc func saveChanges() {
        presenter?.saveChanges()
    }
}

// MARK: Private configuration methods

private extension NoteDetailsViewController {
    func configureView() {
        view.backgroundColor = .white
        view.addGestureRecognizer(tap)
        
        // Avoids view beign extended and beign hiden behind nav bar.
        edgesForExtendedLayout = []
    }
    
    func configureNavBar() {
        navigationItem.title = Localizable.Details.note
        
        let save = UIBarButtonItem(title: Localizable.General.save, style: .done, target: self, action: #selector(saveChanges))
        navigationItem.rightBarButtonItem = save
    }
    
    func configureLayout() {
        
        view.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view).inset(UIEdgeInsets(top: 16, left: 24, bottom: 0, right: 24))
            make.height.equalTo(200)
        }
    }
}

// MARK: NoteDetailsView implementation

extension NoteDetailsViewController: NoteDetailsView {
    func display(_ error: Error) {
        let alert = UIAlertController(title: Localizable.Details.weHaveAProblem,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Localizable.General.ok, style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    func bindData(content: BehaviorRelay<String?>) {
        // Set the value from relay, then bind the text data back to the relay.
        contentTextView.text = content.value ?? ""
        contentTextView.rx.text.asDriver().drive(content).disposed(by: disposeBag)
    }
}
