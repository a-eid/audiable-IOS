import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  let pages: [Page] = {
    let firstPage = Page(title: "Lorem ipsum dolor sit amet, ", description: "Lorem ipsum dolor sit amet, id qui sapientem suavitate, eam molestie scriptorem no. Ad fugit habemus mel, ", imageName: "page1")
    let secondPage = Page(title: "aeque diceret nam an. Pro", description: "rebum atqui partiendo ei, eu pri paulo postulant. Eum dicta consectetuer eu, id prima ", imageName: "page2")
    let thirdPage = Page(title: "Consul aliquip per no. Liber democritum ", description: "Et esse appareat conclusionemque duo. An per sonet tollit. Mollis facilis complectitur sed id", imageName: "page3")
    return [firstPage, secondPage, thirdPage]
  }()
  
  let highlightColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
  
  
  lazy var pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.translatesAutoresizingMaskIntoConstraints = false
    pc.numberOfPages = pages.count + 1 // later
    pc.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    pc.currentPageIndicatorTintColor = highlightColor
    return pc
  }()
  
  lazy var skipButton: UIButton =  {
    let button = UIButton(type: .system)
    button.setTitle("Skip", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(highlightColor, for: .normal)
    return button
  }()
  
  lazy var nextButton: UIButton =  {
    let button = UIButton(type: .system)
    button.setTitle("Next", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(highlightColor, for: .normal)
    return button
  }()

  // lazy var to be able to access self from within the closure
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0 
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    cv.isPagingEnabled = true
    cv.dataSource = self
    cv.delegate   = self
    return cv
  }()
  
  let splashCell = "SPLASH_CELL"
  let loginCell = "LOGIN_CELL"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(collectionView)
    
    collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    
    registerCells()
    view.addSubview(skipButton)
    addSkipButtonConstraints()
    view.addSubview(nextButton)
    addNextButtonConstraints()
    
    
    view.addSubview(pageControl)
    addPageControlConstraints()
  }
  
  fileprivate func registerCells(){
    // must register all cells here.
    collectionView.register(SplashCell.self, forCellWithReuseIdentifier: splashCell)
    collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCell)
  }
  

  //
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count + 1
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let active = Int(targetContentOffset.pointee.x / view.frame.width)
    pageControl.currentPage = active
  }

  func addPageControlConstraints(){
    pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  
  func addSkipButtonConstraints(){
    skipButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    skipButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    skipButton.contentEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 20)
    skipButton.heightAnchor.constraint(equalToConstant: 50)
    skipButton.widthAnchor.constraint(equalToConstant: 50)
  }
  
  func addNextButtonConstraints(){
    nextButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    nextButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    nextButton.contentEdgeInsets = UIEdgeInsets(top: 25, left: 20, bottom: 0, right: 0)
    nextButton.heightAnchor.constraint(equalToConstant: 50)
    nextButton.widthAnchor.constraint(equalToConstant: 50)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: splashCell, for: indexPath) as? SplashCell {
      
      if (indexPath.row == 3){
        let lc = collectionView.dequeueReusableCell(withReuseIdentifier: loginCell, for: indexPath) as! LoginCell
        return lc
      }
      
      cell.page = pages[indexPath.row]
      return cell
    }else{
      return UICollectionViewCell()
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
}


extension UIView{
  
  func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
    
    anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
  }
  
  func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
    }
    
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
    }
    
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
    }
    
  }
  
}

