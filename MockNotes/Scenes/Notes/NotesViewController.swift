//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit
import SnapKit

protocol NotesView: class {
    func updateData()
}

class NotesViewController: UIViewController {
    
    // MARK: UI Components
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate   = self
        tv.refreshControl = refreshControl
        tv.registerCell(cellClass: NoteCell.self)
        return tv
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = .defaultGreen
        rc.addTarget(self, action: #selector(refreshNotes), for: .valueChanged)
        return rc
    }()
    
    // MARK: - Variables
    
    var presenter: INotesPresenter?
    
    // MARK: Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        presenter?.loadNotes() { }
    }
}

// MARK: Private methods

private extension NotesViewController {
    func configureNavBar() {
        navigationItem.title = Localizable.Home.notes
    }
    
    func configureLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaInsets)
            } else {
                make.edges.equalTo(view)
            }
        }
    }
}

// MARK: Private selectors

private extension NotesViewController {
    @objc func refreshNotes() {
        presenter?.loadNotes() { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}

// MARK: NotesView Implementation

extension NotesViewController: NotesView {
    func updateData() {
        tableView.reloadData()
    }
}

// MARK: TableView methods

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfNotes ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: NoteCell.self, indexPath: indexPath)
        presenter?.configure(cell: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelect(rowAt: indexPath)
    }
}
