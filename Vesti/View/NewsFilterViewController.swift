//
//  NewsFiltrViewController.swift
//  Vesti
//
//  Created by Yuriy Balabin on 11.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class NewsFilterViewController: UITableViewController {
    
    
    let headerTableView: UIView = {
       var view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
       return view
    }()
    
    
    
    
    var categories: [String]!
    var viewModel: NewsFilterViewModelType?
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = viewModel?.getCategories()
        
        self.title = "Фильтр"
        
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        
    }
    
  
    
    init(viewModel: NewsFilterViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category
        
        return cell
    }
    
}

