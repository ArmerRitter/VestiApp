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
        let controller = NewsListViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func showNewsFilterScreen() {
        let viewModel = NewsFilterViewModel()
        let controller = NewsFilterViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
