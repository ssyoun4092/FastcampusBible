import UIKit

class BenefitListViewController: UIViewController {
    // 사용자는 포인트를 볼 수 있다.
    // 사용자는 오늘의 혜택을 볼 수 있다.
    // 사용자는 나머지 헤택 리스트를 볼 수 있다.

    // 사용자는 포인트 셀을 눌렀을 때, 포인트 상세 뷰로 넘어간다.
    // 사용자는 혜택 관련 셀을 눌렀을 때, 혜택 상세뷰로 넘어간다.

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "혜택"
    }
}
