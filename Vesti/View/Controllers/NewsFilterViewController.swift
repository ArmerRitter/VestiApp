//
//  NewsFiltrViewController.swift
//  Vesti
//
//  Created by Yuriy Balabin on 11.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class NewsFilterViewController: UITableViewController {
 
//MARK: Properties
    var selectedCategories = [String]()
    var viewModel: NewsFilterViewModelType?
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
//MARK: Functions
    func setupView() {
        self.title = "Фильтр"
        
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(handleBackward))
        navigationItem.leftBarButtonItem = backButton
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.tableFooterView = UIView()
    }
    
    @objc func resetSellected() {
        selectedCategories = [String()]
        tableView.reloadData()
    }
    
    @objc func handleBackward() {
        let cells = tableView.visibleCells
        
        for cell in cells {
            if cell.accessoryType == .checkmark {
                selectedCategories.append((cell.textLabel?.text)!)
            }
        }
        UserDefaults.standard.set(selectedCategories, forKey: "selectedCategories")
        viewModel?.onBackScreen?()
    }
    
//MARK: Initialization
    init(viewModel: NewsFilterViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: TablewViewDelegate & DataSource
extension NewsFilterViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.numberOfItems())!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        let label = UILabel(frame: CGRect(x: 5, y: 10, width: headerView.frame.width - 5, height:  headerView.frame.height - 5))
        label.text = "Выберите категорию новостей"
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else {
            return UITableViewCell()
        }
        tableViewCell.selectionStyle = .none
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    
}

