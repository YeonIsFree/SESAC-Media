//
//  ViewController.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let dummyData: [[String]] = [
        ["lasso", "figure.walk", "figure.fall", "figure.run", "figure.core.training"],
        ["trash", "light.min"],
        ["paperplane.fill", "person.line.dotted.person", "person.3.sequence"],
    ]
    
/*
     
     data 구조 : [
        1) [TV Trend],
     
        2) [TV Top Rated],
     
        3) [TV Popular]
     ]

*/
    
     // MARK: - UI Properties
    
    let tvTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray
        return tableView
    }()

     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        render()
    }
}

 // MARK: - UITableView Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tvTableView.dequeueReusableCell(withIdentifier: TvTableViewCell.identifier, for: indexPath) as? TvTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

 // MARK: - UITableView Configuration Method

extension ViewController {
    func configureTableView() {
        tvTableView.dataSource = self
        tvTableView.delegate = self
        tvTableView.register(TvTableViewCell.self, forCellReuseIdentifier: TvTableViewCell.identifier)
    }
}

 // MARK: - UI Configuration Method

extension ViewController {
    func render() {
        view.addSubview(tvTableView)
        tvTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
