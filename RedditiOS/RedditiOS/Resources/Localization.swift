//
//  Localization.swift
//  RedditiOS
//
//  Created by orpan on 30.04.2021.
//

import Foundation

struct Localization {
    
    internal enum Alert {
        
        internal enum Button {
            /// Cкасувати
            internal static let cancel = "Скасувати"
            /// Зрозуміло
            internal static let ok = "Зрозуміло"
            ///Завантажити
            internal static let save = "Завантажити"
            ///Перезавантажити
            internal static let reload = "Переавантажити"
            
        }
        
        internal enum Title {
            /// Зображення
            internal static let save = "Зображення"
            /// Упс
            internal static let network = "Упс!"
        }
        
        internal enum Message {
            /// Зберігти до галереї
            internal static let save = "Зберігти до галереї"
            /// Нема зв'язку
            internal static let network = "Нема зв'язку"
        }
    }
}
