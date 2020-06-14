//
//  Coordinator.swift
//  Vesti
//
//  Created by Yuriy Balabin on 12.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


final class Coordinator {
    
    
    private var navigationController: UINavigationController?
    
    func start() {
        showNewsListScreen()
        print("start")
    }
    
    func showNewsListScreen() {
        let viewModel = NewsListViewModel(networkService: NetworkService())
        
        viewModel.onSelectFilter = { [weak self] in
            self?.showNewsFilterScreen()
        }
        
        viewModel.onSelectNewsDetails = { [weak self] news in
            self?.shoeNewsDetailsScreen(news: news)
        }
        
        let controller = NewsListViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func showNewsFilterScreen() {
        let viewModel = NewsFilterViewModel()
        
        viewModel.onBackScreen = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let controller = NewsFilterViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func shoeNewsDetailsScreen(news: News) {
        let viewModel = NewsDetailsViewModel(news: news, networkService: NetworkService())
        
        viewModel.onBackScreen = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let controller = NewsDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
