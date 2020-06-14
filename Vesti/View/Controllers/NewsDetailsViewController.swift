//
//  NewsDetailsViewController.swift
//  Vesti
//
//  Created by Yuriy Balabin on 13.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class NewsDetailsViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupView()
       setupBinding()
        
       view.backgroundColor = .white
    }
    
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
    }
    
    func setupView() {
        
        navigationController?.navigationItem.backBarButtonItem?.title = ""
     
    view.addSubview(newsScrollView)
    newsScrollView.addSubview(newsImageView)
    newsScrollView.addSubview(newsTitle)
    newsScrollView.addSubview(newsText)
//
//     let stackView = UIStackView(arrangedSubviews: [newsImageView,newsTitle,newsText])
//        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(stackView)
    
    newsScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    newsScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    newsScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    newsScrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
//        scroll.isScrollEnabled = true
//        scroll.contentSize = CGSize(width: 600, height: 2000)
//
//        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
     
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
    //newsText.heightAnchor.constraint(equalToConstant: 2000).isActive = true
     newsText.bottomAnchor.constraint(equalTo: newsScrollView.bottomAnchor, constant: -80).isActive = true
   }
    
    init(viewModel: NewsDetailsViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//extension NewsDetailsViewController {
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        return cell
//    }
//
//}
