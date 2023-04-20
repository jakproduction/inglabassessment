//
//  ListingVC.swift
//  inglab_assessment
//
//  Created by Chia Chi on 20/04/2023.
//

import UIKit
import AlamofireImage

class ListingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_search")
        imageView.contentMode = .center
        return imageView
    }()
    
    let searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2.0
        
        return view
    }()
    
    let searchTextField: UITextField = {
        let imageView = UIImageView()
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.clear
        textField.textColor = .darkText
        textField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    let containerView = UIView()
    var tableView = UITableView()
    
    var oriData:[User] = []
    var data:[User] = []
    var sortedData:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "background")
        view.backgroundColor = UIColor(patternImage: backgroundImage!)
        self.navigationItem.title = "Inglab Assessment "
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        }
        
        configureTableView()
        initAPI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    //MARK: API
    func initAPI(){
        
        guard let url = URL(string: "https://my-json-server.typicode.com/jakproduction/inglabassessment/db") else { return }
        
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    let dataArray = parseJSON["data"] as! NSArray
                    
                    for itemDic in dataArray {
                        let item = itemDic as! NSDictionary
                        self.processJsonData(item: item)
                    }
                    self.sortData()
                    
                }
                
                
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    func processJsonData(item: NSDictionary){
        print("process")
        print(item.object(forKey: "email"))
        self.oriData.append(User(
            name: item.object(forKey: "name") as! String,
            phone: item.object(forKey: "phone") as! String,
            isActive: item.object(forKey: "isActive") as! Bool,
            avatar: item.object(forKey: "avatar") as! String,
            index: item.object(forKey: "index") as! Int,
            email: item.object(forKey: "email") as! String
        ))
        
    }
    
    //MARK: Configure View
    private func configureTableView(){
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 2
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        tableView.register(UserListingCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        containerView.addSubview(tableView)
        view.addSubview(containerView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ])
        
        configureSubviews()
    }
    
    private func configureSubviews() {
        
        
        
        searchView.addSubview(searchIcon)
        searchView.addSubview(searchTextField)
        view.addSubview(searchView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            searchView.heightAnchor.constraint(equalToConstant: 50),
            
            searchIcon.trailingAnchor.constraint(equalTo: searchView.trailingAnchor),
            searchIcon.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 40),
            searchIcon.heightAnchor.constraint(equalTo: searchView.heightAnchor),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -8),
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
        ])
        
    }
    
    //MARK: TABLE VIEW
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserListingCell
        
        let item:User = sortedData[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.nameLabel.text = item.name
        cell.contactLabel.text = item.phone
        
        cell.selectionStyle = .none
        
        let url = URL(string: item.avatar!)
        
        
        cell.activityIndicator.startAnimating()
        cell.userImageView.af_setImage(withURL: url!) { result in
            cell.activityIndicator.stopAnimating()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = sortedData[indexPath.row]
        let detailsVC = DetailsVC()
        detailsVC.data = selectedItem
        detailsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    //MARK: textField Delegate
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Get the text entered in the UITextField
        guard let searchText = textField.text else { return }
        
        // Filter the data based on the text entered in the UITextField
        if !textField.text!.isEmpty {
            sortedData = data.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }else{
            sortedData = data
        }
        // Reload the table view to display the filtered data
        tableView.reloadData()
    }
    
    
    //MARK: Function
    func sortData(){
        
        data = self.oriData.filter { $0.isActive == true }.sorted { $0.index! < $1.index! }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.sortedData = self.data
            self.tableView.reloadData()
        })
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
