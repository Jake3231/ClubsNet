//
//  WebView.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/14/21.
//

import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
   var text: String
   
  func makeUIView(context: Context) -> WKWebView {
      let webview = WKWebView()
      webview.contentMode = .scaleToFill
      webview.isUserInteractionEnabled = false
    return webview
  }
   
  func updateUIView(_ uiView: WKWebView, context: Context) {
      
    uiView.loadHTMLString("<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'></header>" + text, baseURL: nil)
  }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(text: "www.apple.com")
    }
}
