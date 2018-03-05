import UIKit

class SplashCell: UICollectionViewCell {
  
  var page: Page?  {
    didSet {
      guard let page = page else { return }
      imageView.image = UIImage(named: page.imageName)
      let attributes = [
        
        NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium),
        NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        
      ] as [NSAttributedStringKey : Any]

      let attributedString = NSMutableAttributedString(
        string: page.title ,
        attributes: attributes
      )
      
      let messageAttributedString = NSAttributedString(string: "\n\n \(page.description)", attributes: [
        NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium),
        NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
      ])
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      

      attributedString.append(messageAttributedString)
      

      attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location:0 , length: attributedString.length))
      
      textView.attributedText = attributedString
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.image = #imageLiteral(resourceName: "page1")
    return iv
  }()
  
  let textView: UITextView = {
    let tv = UITextView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.text = "some sample text some sample text some sample text "
    tv.isEditable = false
    tv.contentInset = UIEdgeInsets(top: 24, left: 10, bottom: 0, right: 10)
    return tv
  }()
  
  let lineSeperator: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(white: 0.9, alpha: 1)
    return view
  }()
  
  func setupViews(){
    addSubview(textView)
    addTextViewConstraints()
    
    addSubview(imageView)
    addImageConstraints()

    addSubview(lineSeperator)
    addLineSeperatorConstraints()
  }

  func addImageConstraints(){
    imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
  }
  
  func addTextViewConstraints(){
    textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true

  }
  
  func addLineSeperatorConstraints(){
    lineSeperator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    lineSeperator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//    lineSeperator.topAnchor.constraint(equalTo: topAnchor).isActive = true
//    lineSeperator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    lineSeperator.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
    lineSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
