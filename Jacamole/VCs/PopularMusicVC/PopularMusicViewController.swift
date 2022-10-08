import UIKit

class PopularMusicViewController: SongsListViewController {
    
    init(navigationTitle: String, songsVM: [Song]) {
        super.init(navigationTitle: navigationTitle, iNeedSearchBar: false, iNeedCloseButton: true, songsVM: songsVM)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
