//
//  delay.swift
//  app_project
//
//  Created by Abdulaziz  Almohsen on 11/24/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import Foundation



func delayWithSeconds(_ seconds: Double, completion:   @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}
