//
//  FontDetailsViewController.swift
//  SwiftFonts
//
//  Created by Antoine on 20/06/2019.
//  Copyright © 2019 BOUBERBOUCHE Antoine. All rights reserved.
//

import UIKit

class FontDetailsViewController: UIViewController {
    
    var isNightModeActive = false {
        didSet {
            reverseColorScheme()
        }
    }
    var delegate: MainTableViewController?
    
    
    var font: String?
    var textView = UITextView()
    let text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    //TODO: Allow user to switch between different fontsize and modification(bold, italic)
    var isBold: Bool = false {
        didSet {
            resetTextView()
        }
    }
    var isItalic: Bool = false {
        didSet {
            resetTextView()
        }
    }
    var fontSize: CGFloat = 17 {
        didSet {
            resetTextView()
        }
    }
    
    
    override func viewDidLoad() {
        setupView()
        title = font
        
        //TODO: Fix the button's icon
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(nightModeButtonTapped))
    }
    
    private func setupView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        
        resetTextView()
    }
    
    
    private func resetTextView() {
        
        if let font = font {
            textView.text = text
            textView.font = UIFont(name: font, size: fontSize)
            textView.textColor = isNightModeActive ? Metrics.white : Metrics.black
            
            if isBold {
                textView.font = textView.font?.bold()
            }
            if isItalic {
                textView.font = textView.font?.italic()
            }
        }
    }
}

//Night Mode methods
extension FontDetailsViewController {
    private func reverseColorScheme() {
        if isNightModeActive {
            view.backgroundColor = Metrics.black
            textView.backgroundColor = Metrics.black
            navigationController?.navigationBar.backgroundColor = Metrics.black
            navigationController?.navigationBar.tintColor = Metrics.white
            navigationController?.navigationBar.barTintColor = Metrics.black
        } else {
            view.backgroundColor = Metrics.white
            textView.backgroundColor = Metrics.white
            navigationController?.navigationBar.backgroundColor = Metrics.white
            navigationController?.navigationBar.tintColor = Metrics.black
            navigationController?.navigationBar.barTintColor = Metrics.white
        }
        resetTextView()
    }
    
    //Bar button action
    @objc private func nightModeButtonTapped() {
        isNightModeActive = !isNightModeActive
        delegate!.isNightModeActive = isNightModeActive
    }
}
