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
    var boldButton = UIButton()
    var italicButton = UIButton()
    var fontSizeLabel = UILabel()
    var fontSizePlusButton = UIButton()
    var fontSizeDownButton = UIButton()
    let text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    //TODO: Allow user to switch between different fontsize and modification(bold, italic)
    var isBold: Bool = false {
        didSet {
            resetTextView()
        }
    }
    var isItalic: Bool = true {
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
    
    
    private func resetTextView() {
        
        if let font = font {
            textView.text = text
            textView.font = UIFont(name: font, size: fontSize)
            textView.textColor = isNightModeActive ? Metrics.white : Metrics.black
            
            if isBold {
                textView.font = textView.font?.makeBold()
            }
            if isItalic {
                textView.font = textView.font?.makeItalic()
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

//View setup
extension FontDetailsViewController {
    
    private func setupView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        view.addSubview(textView)
        
        [boldButton, italicButton, fontSizePlusButton, fontSizeDownButton].forEach { (btn) in
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.backgroundColor = isNightModeActive ? Metrics.black : Metrics.white
            btn.titleLabel?.textColor = isNightModeActive ? Metrics.white : Metrics.black
            view.addSubview(btn)
        }
        
        boldButton.setAttributedTitle(NSAttributedString(string: "B", attributes: [.font: UIFont.boldSystemFont(ofSize: 17)]), for: .normal)
        italicButton.setAttributedTitle(NSAttributedString(string: "I", attributes: [.font: UIFont.italicSystemFont(ofSize: 17)]), for: .normal)
        fontSizePlusButton.setAttributedTitle(NSAttributedString(string: "+", attributes: [.font: UIFont.boldSystemFont(ofSize: 17)]), for: .normal)
        fontSizeDownButton.setAttributedTitle(NSAttributedString(string: "-", attributes: [.font: UIFont.boldSystemFont(ofSize: 17)]), for: .normal)
        
        fontSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        fontSizeLabel.backgroundColor = isNightModeActive ? Metrics.black : Metrics.white
        fontSizeLabel.textColor = isNightModeActive ? Metrics.white : Metrics.black
        view.addSubview(fontSizeLabel)
        
        NSLayoutConstraint.activate([
            
            boldButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            boldButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            boldButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/6),
            boldButton.heightAnchor.constraint(equalToConstant: 50),
            
            italicButton.leadingAnchor.constraint(equalTo: boldButton.trailingAnchor),
            italicButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            italicButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/6),
            italicButton.heightAnchor.constraint(equalToConstant: 50),
            
            fontSizeDownButton.leadingAnchor.constraint(equalTo: italicButton.trailingAnchor),
            fontSizeDownButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            fontSizeDownButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/6),
            fontSizeDownButton.heightAnchor.constraint(equalToConstant: 50),
            
            fontSizeLabel.leadingAnchor.constraint(equalTo: fontSizeDownButton.trailingAnchor),
            fontSizeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            fontSizeLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 2/6),
            fontSizeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            fontSizePlusButton.leadingAnchor.constraint(equalTo: fontSizeLabel.trailingAnchor),
            fontSizePlusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            fontSizePlusButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/6),
            fontSizePlusButton.heightAnchor.constraint(equalToConstant: 50),
            
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: boldButton.topAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        
        resetTextView()
    }
}
