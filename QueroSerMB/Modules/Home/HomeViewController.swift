//
//  HomeViewController.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit
import Foundation

enum HomeListState {
    case loading, loaded([ExchangeModel]), error
}

class HomeViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.registerCore(cellClass: HomeListCell.self)
        tableView.registerCore(cellClass: HomeLoadingCell.self)
        tableView.registerCore(cellClass: HomeErrorCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var viewModel: HomeViewModelProtocol
    
    var listState: HomeListState = .loading {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Exchange List"
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        
        
//        viewModel.fetchExchangesMap()
        viewModel.fetchExchanges()
    }
    
    func bindViewModel() {
        viewModel.state.bind { state in
            switch state {
            case .loading(let value):
                value ? self.showFullScreenLoading() : self.hideFullScreenLoading()
                
            case .loaded(let model):
                guard let model = model else { return }
                
                self.listState = .loaded(model)
                
            case .error:
                self.listState = .error
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch listState {
        case .loaded: return 112
        case .error: return 202
        case .loading: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch listState {
        case .loaded(let exchanges):
            return exchanges.count
        case .loading: return 0
        case .error: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch listState {
        case .loaded(let exchanges):
            return tableView.dequeueReusableCellCore(of: HomeListCell.self, for: indexPath) { cell in
                cell.setupInfo(model: exchanges[indexPath.row], index: indexPath.row)
            }
        case .loading:
            return tableView.dequeueReusableCellCore(of: HomeLoadingCell.self, for: indexPath)
        case .error:
            return tableView.dequeueReusableCellCore(of: HomeErrorCell.self, for: indexPath) { cell in
                cell.delegate = self
                cell.configure(with: "Error ao carregar os dados.")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.model[indexPath.item]
        viewModel.didOpenProductDetail(model: item)
    }
}

extension HomeViewController: CodeViewProtocol {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeErrorCellDelegate {
    func didTapRetryButton() {
        viewModel.fetchExchanges()
    }
}
