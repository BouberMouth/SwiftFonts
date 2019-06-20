//
//  ViewController.swift
//  SwiftFonts
//
//  Created by Antoine on 20/06/2019.
//  Copyright © 2019 BOUBERBOUCHE Antoine. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var isNightModeActive = false {
        didSet {
            reverseColorScheme()
        }
    }
    
    let fonts = UIFont.familyNames

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        title = "Swift fonts"
        //TODO: Fix the button's icon size
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "moonBlack@1"), style: .plain, target: self, action: #selector(nightModeButtonTapped))
    }
}

//TableView methods
extension MainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let font = fonts[indexPath.row]
        cell.textLabel?.text = font
        cell.textLabel?.font = UIFont(name: font, size: 17)
        cell.backgroundColor = isNightModeActive ? Metrics.black : Metrics.white
        cell.textLabel?.textColor = isNightModeActive ? Metrics.white : Metrics.black
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = FontDetailsViewController()
        nextVC.font = fonts[indexPath.row]
        nextVC.delegate = self
        nextVC.isNightModeActive = isNightModeActive
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

//Night Mode methods
extension MainTableViewController {
    
    func reverseColorScheme() {
        if isNightModeActive {
            tableView.backgroundColor = Metrics.black
            navigationController?.navigationBar.backgroundColor = Metrics.black
            navigationController?.navigationBar.tintColor = Metrics.white
            navigationController?.navigationBar.barTintColor = Metrics.black
        } else {
            tableView.backgroundColor = Metrics.white
            navigationController?.navigationBar.backgroundColor = Metrics.white
            navigationController?.navigationBar.tintColor = Metrics.black
            navigationController?.navigationBar.barTintColor = Metrics.white
        }
        tableView.reloadData()
    }
    
    @objc private func nightModeButtonTapped() {
        isNightModeActive = !isNightModeActive
    }
}

