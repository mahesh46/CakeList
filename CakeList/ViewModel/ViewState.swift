//
//  ViewState.swift
//  CakeList
//
//  Created by mahesh lad on 11/09/2026.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case loaded([Cake])
    case error(String)
}

