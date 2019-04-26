//
//  ACNavigationBar.swift
//  MockNotes
//
//  Created by Raphael Souza on 2019-04-26.
//  Copyright © 2019 Raphael Inc. All rights reserved.
//

import UIKit

class ACNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearence() {
        titleTextAttributes = [.foregroundColor: UIColor.defaultGreen]
        
        if #available(iOS 11.0, *) {
            largeTitleTextAttributes = [.foregroundColor: UIColor.defaultGreen]
        }
    }
}
