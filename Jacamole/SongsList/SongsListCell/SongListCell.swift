import UIKit

class SongListCell: UITableViewCell {
    
    var heartHendler: (() -> Void)!
    var songID: String! {
        didSet {
            setupHeartButton()
        }
    }
    
    lazy var songImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "guacamole-vectorportal")
        iv.layer.cornerRadius = 30.0
        iv.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            iv.heightAnchor.constraint(equalToConstant: 60.0),
            iv.widthAnchor.constraint(equalTo: iv.heightAnchor)
        
        ])
        
        return iv
    }()
    
    lazy var songLabel: UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "Abel-Regular", size: 15.0)
        
        return label
    } ()
    
    public lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "Abel-Regular", size: 12.0)
        
        return label
    } ()
    
    private lazy var textStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            songLabel,
            artistLabel
        ])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 1.0

        return sv
    }()
    
    private lazy var heartButton: UIButton = {
        let btn = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                 weight: .light,
                                                 scale: .default)
      
        btn.setImage( UIImage.init(systemName: "heart", withConfiguration: config), for: .normal)
        btn.setImage( UIImage.init(systemName: "heart.fill", withConfiguration: config), for: .selected)
        btn.tintColor = UIColor(named: "TextColor")
        btn.setTitleColor(.red, for: .selected)
        btn.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            songImage,
            textStackView,
            heartButton
        ])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.backgroundColor = UIColor(named: "BackgroungColor")
        sv.spacing = 6.26
        sv.translatesAutoresizingMaskIntoConstraints = false

        return sv
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(contentView)
        backgroundColor = UIColor(named: "BackgroungColor")
        contentView.backgroundColor = .clear
        contentView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupHeartButton() {
        if StorageManager.shared.isFavourite(songID: songID) {
            heartButton.isSelected = true
        } else {
            heartButton.isSelected = false
        }
        heartButton.tintColor = heartButton.isSelected ? .red : UIColor(named: "TextColor")
    }
    
    @objc func heartButtonPressed() {
        heartHendler()
        setupHeartButton()
    }
}
