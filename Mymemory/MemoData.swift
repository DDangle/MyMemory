//
//  MemoData.swift
//  Mymemory
//
//  Created by 한규철 on 4/4/R4.
//

import UIKit

//사용자가 메모작성 화면애서 입력한 값을 저장햇다가, 목록화면이나 상세화면에 제공하는 역할을 한다 앱의 핵심데이터를 정의하는객체를 도메인 모델 이라고한다.
class MemoData {
    var memoIdx: Int?   //데이터 식별값
    var title: String?      //메모 제목
    var contents: String?   //메모 내용
    var image : UIImage?    //이미지
    var regdata: Date?      //작성일
}

