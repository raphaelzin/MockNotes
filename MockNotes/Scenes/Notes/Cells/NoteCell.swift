//
//  NoteCell.swift
//  TestApp
//
//  Created by Raphael Souza on 2019-04-21.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    private(set) var note: RNote!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .lightGray
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self).inset(UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
            make.height.equalTo(22)
        }
        
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(self).inset(UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
}

// MARK: Public configurators

extension NoteCell {
    func configure(with note: RNote) {
        titleLabel.text   = note.title
        contentLabel.text = note.content
    }
}
