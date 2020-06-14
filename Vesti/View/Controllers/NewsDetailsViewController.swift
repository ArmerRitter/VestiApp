//
//  NewsDetailsViewController.swift
//  Vesti
//
//  Created by Yuriy Balabin on 13.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class NewsDetailsViewController: UIViewController {

//MARK: Properties
    var viewModel: NewsDetailsViewModelType?
    
    let newsScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let newsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newsText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupView()
       setupBinding()
        
       view.backgroundColor = .white
    }
    
//MARK: Functions
    func setupBinding() {
        viewModel?.newsImage.bind(listener: { [unowned self] image in
            self.newsImageView.image = image
        })
        
        viewModel?.newsTitle.bind(listener: { [unowned self] title in
            self.newsTitle.text = title
        })
        
        viewModel?.newsText.bind(listener: { [unowned self] text in
            self.newsText.text = text
        })
        
        viewModel?.newsCategory.bind(listener: { [unowned self] category in
            self.title = category
        })
    }
    
    func setupView() {
        
      let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(handleBackward))
      navigationItem.leftBarButtonItem = backButton
       
        
    view.addSubview(newsScrollView)
    newsScrollView.addSubview(newsImageView)
    newsScrollView.addSubview(newsTitle)
    newsScrollView.addSubview(newsText)

    
    newsScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    newsScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    newsScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    newsScrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
     
    newsImageView.topAnchor.constraint(equalTo: newsScrollView.topAnchor, constant: 20).isActive = true
    newsImageView.leftAnchor.constraint(equalTo: newsScrollView.leftAnchor, constant: 20).isActive = true
    newsImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant:  -40).isActive = true
    newsImageView.heightAnchor.constraint(equalToConstant: (view.bounds.width - 40) * 0.56).isActive = true
    

    newsTitle.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20).isActive = true
    newsTitle.leftAnchor.constraint(equalTo: newsScrollView.leftAnchor, constant: 20).isActive = true
    newsTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true

    newsText.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant:  20).isActive = true
    newsText.leftAnchor.constraint(equalTo: newsScrollView.leftAnchor, constant: 20).isActive = true
    newsText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
     newsText.bottomAnchor.constraint(equalTo: newsScrollView.bottomAnchor, constant: -80).isActive = true
   }
    
    @objc func handleBackward() {
        viewModel?.onBackScreen?()
    }
    
//MARK: Initialization
    init(viewModel: NewsDetailsViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

