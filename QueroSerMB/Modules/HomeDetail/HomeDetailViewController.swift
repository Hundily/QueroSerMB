//
//  HomeDetailViewController.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit

final class HomeDetailViewController: UIViewController {
    
    private var viewModel: HomeDetailViewModelProtocol
    var innerView = HomeDetailView()
    
    init(viewModel: HomeDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = innerView
        innerView.configure(model: viewModel.getDetail())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCoins()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.state.bind { state in
            switch state {
            case .loading(let value):
                value ? self.showFullScreenLoading() : self.hideFullScreenLoading()
                
            case .loaded(let model):
                guard let model = model else { return }
                self.innerView.configureCoins(coins: model)
                
            case .error:
//                self.listState = .error
                print("loading")
            }
        }
    }
}
