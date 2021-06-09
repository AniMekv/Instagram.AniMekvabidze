//
//  SettingsViewController.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 5/29/21.
//
import SafariServices
import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
    
}
// i made class below final so nobody can subclass it
/// ViewController to show user Settings
final class SettingsViewController: UIViewController {
    
    // i create tableview to show me different setting options on other page
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    // collection of collecion Settings model, as we are gonna have several sections
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        // [weak self] i write to be sure i won't cause a memory leak as i am referencing to "self"
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.onEditProfile()
            },
                SettingCellModel(title: "Invite Friends") { [weak self] in
                    self?.onInviteFriends()
            },
               SettingCellModel(title: "Save original posts") { [weak self] in
                self?.onSaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingCellModel(title: "Terms of service") { [weak self] in
                self?.openUrl(type: .terms)
            }
        ])
        data.append([
            SettingCellModel(title: "Privacy policy") { [weak self] in
                self?.openUrl(type: .privacy)
            }
        ])
        data.append([
            SettingCellModel(title: "Help Feedback") { [weak self] in
                self?.openUrl(type: .help)
            }
        ])
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.onLogOut()
            }
        ])
       // data.append(section)
    }
    enum SettingURLType {
        case terms, privacy, help
    }
    
    private func openUrl(type:  SettingURLType) {
        let urlString:  String

        switch type {
        case .terms: urlString = ""
        case .privacy: urlString = ""
        case.help: urlString = ""
        }
        
        guard let url = URL(string: urlString) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func onEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
    private func onInviteFriends() {
        // show share sheet to invite friends
    }
    
    private func onSaveOriginalPosts() {
        
    }
    
    private func onLogOut() {
        // creating actins sheet to ask user they want to log out or not
        
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sere you want to log out?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        // present login
                        let loginVC = LogInViewController()
                        // user won't be able to swipe away
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                    else {
                        // error
                        fatalError("Could not log out User")
                    }
                }
            })
        
        }))
        // to be sere it won't crash on Ipad i am gonna asign popoverPresentaionController
        // actionSheet doesn't know how to present itself on Ipad  so it might crash my app, therefore i asign it to Ipad
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        // generally present
        present(actionSheet, animated: true)

        
    }
    
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selection here
        let model = data[indexPath.section][indexPath.row]
        model.handler()
        // or instead of those two lines above i could have:  data[indexPath.section][indexPath.row].handler()
    }
    
    
    
    
    
}
