import UIKit

class LanguageSelectionViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // Available languages (code, display name)
    private let languages: [(code: String, name: String)] = [
        ("en", "English"),
        ("hi", "हिन्दी"),
        ("ar", "العربية")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = NSLocalizedString("label_more_languages_title", comment: "Languages")
        
        // Setup table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Table View Delegate / DataSource
extension LanguageSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let lang = languages[indexPath.row]
        cell.textLabel?.text = lang.name
        
        // ✅ Checkmark for current language
        if lang.code == LocalizationManager.shared.currentLanguage {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lang = languages[indexPath.row]
        
        // ✅ Set language
        LocalizationManager.shared.setLanguage(lang.code)
        
        // ✅ Reset UI with new language
        LocalizationManager.shared.resetRootControllerToInitial()
        
        // ✅ Dismiss modal
        dismiss(animated: true)
    }
}
