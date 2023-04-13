//
//  Weather_WidgetBundle.swift
//  Weather Widget
//
//  Created by Sorfian on 13/04/23.
//

import WidgetKit
import SwiftUI

@main
struct Weather_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Weather_Widget()
        Weather_WidgetLiveActivity()
    }
}
