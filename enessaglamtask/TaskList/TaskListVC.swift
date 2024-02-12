//
//  TaskListVC.swift
//  Task
//
//  Created by Enes Saglam on 10.02.2024.
//

import UIKit

class TaskListVC: UIViewController{
    @IBOutlet weak var isLoading: UIActivityIndicatorView!
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var receivedText = ""
    
    var viewModel : TaskListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    let refreshControl = UIRefreshControl()
    private var taskList : [TaskPresentations] = []
    private var filterList : [TaskPresentations] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.load()
        searchText.delegate = self
        searchText.text = receivedText
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        self.view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "qrcode"), style: .done, target: self, action: #selector(qrCodeRead))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshDataControl))
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchText.text = receivedText
    }


}
extension TaskListVC : TaskListViewModelDelegate {
    func handleViewModelOutput(_ output: TaskListViewModelOutput) {
        switch output {
        case .showMovieList(let array):
            self.taskList = array
            self.filterList = array
            self.tableView.reloadData()
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let loading):
            isLoading.startAnimating()
            self.isLoading.isHidden = loading
        }
    }
}

extension TaskListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
        let taskData = filterList[indexPath.row]
        
        cell.setup(task: taskData)
        
        return cell
    }
}

extension TaskListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    
}

extension TaskListVC {
    @objc func qrCodeRead() {
        let viewController = QrScannerBuilder.make()
        show(viewController, sender: nil)
        
    }
    
    @objc func refreshDataControl() {
        viewModel.load()
        self.tableView.reloadData()
    }
    
    @objc func refreshData() {
        viewModel.load()
        refreshControl.endRefreshing()
    }
}

extension TaskListVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterList = taskList
        } else {
            filterList = taskList.filter({ task in
                if task.name.range(of: searchText, options: .caseInsensitive) != nil {
                    return true
                } else if task.title.range(of: searchText, options: .caseInsensitive) != nil {
                    return true
                } else if task.description.range(of: searchText, options: .caseInsensitive) != nil {
                    return true
                } else if task.colorCode.range(of: searchText,options: .caseInsensitive) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
     
        tableView.reloadData()
    }
}



