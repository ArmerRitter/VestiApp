//
//  ViewController.swift
//  Vesti
//
//  Created by Yuriy Balabin on 09.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class NewsListViewController: UITableViewController {

    var viewModel: NewsListViewModelType?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel?.update.bind(listener: { [unowned self] bool in
            self.tableView.reloadData()
        })
        
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "cell")
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc func add() {
        
        
    }
    
    init(viewModel: NewsListViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewsListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    
}
