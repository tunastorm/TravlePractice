//
//  AdImage.swift
//  TravlePractice
//
//  Created by 유철원 on 5/30/24.
//

import UIKit

struct AdImageUrl{
    var yogi1 = URL(string: "https://image.zdnet.co.kr/2023/06/05/63e8536160ec0e2ffd8d2bbd52969cbe.jpg")!
    var yogi2 = URL(string:"https://image.zdnet.co.kr/2022/09/08/dca8228e11f5a8b27c9ea142e6325441.jpg")!
    
    var getRandom: URL {
        let list = [yogi1]
        return list.randomElement() ?? yogi1
    }
}
