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
        viewModel?.getNews()
        viewModel?.filterdResultIsNullFlag = false
    }
    
    let footerTableView: UIView = {
       var view = UIView()
       return view
    }()
    
    let messageLabel: UILabel = {
    var label = UILabel(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 60))
        label.text = "Ничего не найдено\n выберите другую категорию"
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        viewModel?.updateNewsFlag.bind(listener: { [unowned self] bool in
            self.tableView.reloadData()
        })
    }

    func setupView() {
        
        self.title = "ВЕСТИ RU"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.5843137255, blue: 0.8549019608, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let rightButton = UIBarButtonItem(title: "Филльтр", style: .plain, target: self, action: #selector(handleFilter))
        
        navigationItem.rightBarButtonItem = rightButton
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "cell")
        footerTableView.addSubview(messageLabel)
        tableView.tableFooterView = footerTableView
        tableView.addSubview(refreshControl!)
    }
    
    @objc func handleRefreshControl() {
        viewModel?.getNews()
        refreshControl?.endRefreshing()
    }
    
    @objc func handleFilter() {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        
        if viewModel.filtredNewsList.isEmpty {
            let news = viewModel.newsList[indexPath.row]
            viewModel.onSelectNewsDetails?(news)
        } else {
            let news = viewModel.filtredNewsList[indexPath.row]
            viewModel.onSelectNewsDetails?(news)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfItems = viewModel?.numberOfItems() ?? 0
        
        if numberOfItems == 0 {
            messageLabel.isHidden = false
        } else {
            messageLabel.isHidden = true
        }
        
        return numberOfItems
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
