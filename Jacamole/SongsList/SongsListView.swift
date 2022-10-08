import UIKit

class SongsListView: UIView {
    var songsLoadedAction: (() -> Void)?
    var tapOnTabelCell: (() -> Void)?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SongListCell.self, forCellReuseIdentifier: "SongCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    let viewModel: SongsListViewModel
    
    init(viewModel: SongsListViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        backgroundColor = .clear
    
        self.setupUI()
        
        self.viewModel.viewModelChanged = {
            [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
            self.songsLoadedAction?()
        }
        
        print("self.viewModel.songsVM.count: \(self.viewModel.songsVM.count)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        overrideUserInterfaceStyle = .light
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }

}

extension SongsListView: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        makeSongCell(for: indexPath, tableView: tableView)
    }
    
    func makeSongCell(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongListCell
        let vm = self.viewModel.songsVM[indexPath.row]

//        cell.songLabel.text = vm.songName
//        cell.artistLabel.text = vm.songArtist
//        cell.songImage.load(urlAdress: vm.imageAdress)
//        cell.heartHendler = vm.heartHandler
//        cell.songID = vm.songID

        cell.songLabel.text = vm.name
        cell.artistLabel.text = vm.artistName
        cell.songImage.load(urlAdress: vm.image)
//        cell.heartHendler = vm.heartHandler

        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.songsVM.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.songsVM[indexPath.row]
        
        tapOnTabelCell?()
        print("I tap on this cell")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = viewModel.songsVM.count - 1
        if indexPath.row == lastIndex {
            // api call and get next page
        }
    }
}
