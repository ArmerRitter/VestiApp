//
//  ViewController.swift
//  Vesti
//
//  Created by Yuriy Balabin on 09.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class NewsListViewController: UITableViewController {

//MARK: Properties
    var viewModel: NewsListViewModelType?
    
    let footerTableView: UIView = {
       var view = UIView()
       return view
    }()
    
    let filterMessageLabel: UILabel = {
    var label = UILabel(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 60))
        label.text = "Ничего не найдено\n выберите другую категорию"
        label.textColor = .gray
        label.isHidden = true
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

//MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let viewModel = viewModel else { return }
        
        viewModel.filterNews()
        
        if viewModel.filterdResultIsNullFlag {
            filterMessageLabel.isHidden = false
        } else {
            filterMessageLabel.isHidden = true
        }
    }
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        viewModel?.updateNewsFlag.bind(listener: { [unowned self] bool in
            self.tableView.reloadData()
        })
    }

//MARK: Functions
    func setupView() {
        
        self.title = "ВЕСТИ RU"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.5843137255, blue: 0.8549019608, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let rightButton = UIBarButtonItem(title: "Филльтр", style: .plain, target: self, action: #selector(handleFilter))
        
        navigationItem.rightBarButtonItem = rightButton
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        footerTableView.addSubview(filterMessageLabel)
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
    
//MARK: Initialization
    init(viewModel: NewsListViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: TablewViewDelegate & DataSource
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
        return viewModel?.numberOfItems() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    
}
