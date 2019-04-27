//
//  NoteCell.swift
//  TestApp
//
//  Created by Raphael Souza on 2019-04-21.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    private(set) var note: Note!
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private methods

private extension NoteCell {
    func configureLayout() {
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self).inset(UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16))
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 16))
            make.height.equalTo(16)
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
        }
    }
}

// MARK: Public configurators

extension NoteCell {
    func configure(with note: RNote) {
        contentLabel.text = note.content
        dateLabel.text = "\(note.createdAt?.formated(as: .simple) ?? "")"
    }
}
