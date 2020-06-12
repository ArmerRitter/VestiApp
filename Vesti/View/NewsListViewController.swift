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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        viewModel?.retrieveNewsFlag.bind(listener: { [unowned self] bool in
            self.tableView.reloadData()
        })
    }

    func setupView() {
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "cell")
        
        self.title = "ВЕСТИ RU"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.5843137255, blue: 0.8549019608, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let rightButton = UIBarButtonItem(title: "Филльтр", style: .plain, target: self, action: #selector(handleFilter))
        
        
        navigationItem.rightBarButtonItem = rightButton
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        tableView.addSubview(refreshControl!)
    }
    
    @objc func handleRefreshControl() {
        viewModel?.getNews()
        refreshControl?.endRefreshing()
    }
    
    @objc func handleFilter() {
//        let viewModel = NewsFilterViewModel()
//        let vc = NewsFilterViewController(viewModel: viewModel)
//        navigationController?.pushViewController(vc, animated: true)
        viewModel?.onSelectFilter?()
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
