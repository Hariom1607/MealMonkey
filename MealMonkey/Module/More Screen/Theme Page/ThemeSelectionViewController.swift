import UIKit

class ThemeSelectionViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // Available themes
    private let themes: [Theme] = [
        MainTheme.themes.defaultApp,   // 👈 add this first
        MainTheme.themes.lavenderSand,
        MainTheme.themes.peachTeal,
        MainTheme.themes.mustardSlate,
        MainTheme.themes.mintSandstone,
        MainTheme.themes.plumLemon
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = Main.Labels.moreThemes
        
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
extension ThemeSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let theme = themes[indexPath.row]
        
        // Theme name label
        cell.textLabel?.text = theme.name
        
        // Show small color preview
        let colorView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        colorView.layer.cornerRadius = 4
        colorView.backgroundColor = theme.mainColor
        cell.accessoryView = colorView
        
        // ✅ Checkmark for currently selected theme
        if theme.name == ThemeManager.currentTheme.name {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTheme = themes[indexPath.row]
        
        // ✅ Apply theme
        ThemeManager.currentTheme = selectedTheme
        
        // ✅ Dismiss modal
        dismiss(animated: true)
    }
}
