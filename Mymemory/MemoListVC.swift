//
//  MemoListVC.swift
//  Mymemory
//
//  Created by 한규철 on 4/4/R4.
//

import UIKit

class MemoListVC: UITableViewController {
    // 앱 델리게이트 객체의 참조 정보를 읽어온다.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //테이블 행의 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }
    //테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        //이미지 속성이 비어 있을 경우 memoCell, 아니면 memoCellWithImage
        let celled = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        //재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: celled) as! MemoCell
        
        //memoCell의 내용을 구성한다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        //Date 타입의 날짜를 yyyy-mm-dd HH:mm:ss  포맷에 맞게 변경한다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        cell.regDate?.text = formatter.string(from: row.regdata!)
        
        //6 cell 객체를 리턴한다.
        return cell
        
    }
    //테이블의 특정 행이 선택되었을 때 호출되는 메소드. 선택된 행의 정보는 indexPath에 담겨 전달된다.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //memolist배열에서 선택된 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        //상세 화면의 인스턴스를 생성한다.
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        //값을 전달한 다음, 상세화면으로 이동한다.
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //SWRevealViewController 라이브러리의 revealViewController객체를 읽어온다.
        if let revaelVC = self.revealViewController() {
            
            //바 버튼 아이템 객체를 정의한다.
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png") //이미지는  sidemenu.png로
            btn.target = revaelVC //버튼 클릭시 호출할 메소드가 정의된 객체를 지정
            btn.action = #selector(revaelVC.revealToggle(_:))
                // 버튼 클릭시 리빌 토클 호출
            //정의된 바 버튼을 내비게이션 바의 왼쪽 아이템으로 등록한다.
            self.navigationItem.leftBarButtonItem = btn
            
            //제스처 객체를 뷰에 추가한다.
            self.view.addGestureRecognizer(revaelVC.panGestureRecognizer())
        }
       
    }
    //디바이스 스크린에 뷰 컨트롤러가 나타날 때마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false)
            return
        }
        // 테이블 데이터를 다시 읽어들인다. 이에 따라 구성하는 로직이 다시 실행될 것이다.
        self.tableView.reloadData()
    }
   
    

   

}
