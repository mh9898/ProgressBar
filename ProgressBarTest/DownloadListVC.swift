//
//  DownloadListVC.swift
//  ProgressBarTest
//
//  Created by MiciH on 4/18/21.
//

import UIKit


class DownloadListVC: UIViewController {

    var tableView = UITableView()
    var button = PBButton(backgroundColor: .systemRed, title: "Play | Pause")
    var files: [File] = []
    var isButtonPressed = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        files = fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Files Downloader"
        view.backgroundColor = .systemBackground
        configureTableView()
        configureButton()
    }

    func configureButton(){
        view.addSubview(button)
        NSLayoutConstraint.activate([
           button.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
           button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           button.heightAnchor.constraint(equalToConstant: 50),
        ])

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton(){
        isButtonPressed.toggle()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func configureTableView(){
        view.addSubview(tableView)

        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FileCell.self, forCellReuseIdentifier: FileCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 190),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension DownloadListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileCell.reuseID) as! FileCell
        let file = files[indexPath.row]
        cell.set(file: file, isButtonPressed: isButtonPressed)
        return cell
    }
}

extension DownloadListVC{
    func fetchData() ->[File]{
        let file1 = File(title: "file1", subTitle: "file1", fileSize: 100.0)
        let file2 = File(title: "file2", subTitle: "file2", fileSize: 200.0)
        let file3 = File(title: "file3", subTitle: "file3", fileSize: 50.0)
        let file4 = File(title: "file4", subTitle: "file4", fileSize: 300.0)

        return [file1, file2, file3, file4]
    }
}


