//
//  Helper.swift
//  ArchO
//
//  Created by Tixon Markin on 02.11.2023.
//

import Foundation

enum PersistentDataContainer {
    case sectionHeader(title: String)
    case header(number: String, 
                title: String,
                hint: String?)
    case text(placeholder: String?,
              placementOrder: Int? = nil)
    case date(annotation: String? = nil)
    case picker(annotation: String?, 
                options: [String],
                initialOption: String?,
                placementOrder: Int? = nil)
    case imageLoad, fileLoad
    case describedImageLoad(label: String, 
                            placeholder: String)
}

enum TypologicalAffilation: String, CaseIterable {
    case archeologyMonument = "Памятник археологии"
    case historyMonument = "Памятник истории"
    case architectureAndArtMonument = "Памятник гр-ства и архитектуры"
    case monumentalArtMonument = "Памятник монументального искусства"
}

enum ProtectedStatusOKN: String, CaseIterable {
    case federalSignificance = "Объект федерального значения"
    case regionalSignificance = "Объект регионального значения"
    case local = "Объект местного (муниципального)"
    case noProtectedStatus = "Объект не имеет охранного статуса"
    case dontKnow = "Не знаю"
}

enum TecnicalCondition: String, CaseIterable {
    case good = "Хорошее"
    case average = "Среднее"
    case bad = "Плохое"
    case emergency = "Аварийное"
    case ruined = "Руинированное"
}

enum StageOfWork: String, CaseIterable {
    case notExecuted = "Не выполнялась"
    case executing = "В процессе выполнения"
    case executed = "Выполнена"
}

enum PhotoFixationKind: String, CaseIterable {
    case protocolDocumentary = "Протокольно-документальная"
    case artictic = "Художестванная"
}

struct PersistentData {
    let sectionHeaders: [[PersistentDataContainer]] = [
        [],
        [
            .sectionHeader(title: "Общие данные по объекту")
        ],
        [
            .sectionHeader(title: "Перечень работ, выполненных по данному объекту")
        ],
        [
            .sectionHeader(title: "Краткая историческая справка"),
            .sectionHeader(title: "Инженерно-техническое описание ОКН")
        ],
        [
            .sectionHeader(title: "Дополнительная информация")
        ]
    ]
    
    lazy var sectionData: [[ItemID: [PersistentDataContainer]]] = [section0, section1, section2, section3, section4]
    
    private let section0: [ItemID: [PersistentDataContainer]] = [
        .item1: [
            .header(number: "1", 
                    title: "Укажите полное название объекта (комплекса)",
                    hint: nil),
            .text(placeholder: nil)
        ],
        .item2: [
            .header(number: "2", 
                    title: "Дата формирования Карты ОКН",
                    hint: nil),
            .date()
        ],
        .item3: [
            .header(number: "3", 
                    title: "Дата обновления/изменения Карты ОКН",
                    hint: nil),
            .date()
        ]
    ]
    
    private lazy var section1: [ItemID: [PersistentDataContainer]] = [
        .item4: [
            .header(number: "4", 
                    title: "Наименование объекта",
                    hint: nil),
            .text(placeholder: "Укажите название описываемого объекта")
        ],
        .item5: [
            .header(number: "5", 
                    title: "Состав дворцово-паркового ансамбля",
                    hint: nil)
        ],
        .item6: [
            .header(number: "6", 
                    title: "Адрес объекта",
                    hint: nil),
            .text(placeholder: "Укажите адрес объекта")
        ],
        .item7: [
            .header(number: "7", 
                    title: "Современный вид ОКН",
                    hint: nil),
            .imageLoad
        ],
        .item71: [
            .header(number: "7/1", 
                    title: "Первоначальный вид ОКН",
                    hint: nil),
            .imageLoad
        ],
        .item8: [
            .header(number: "8", 
                    title: "Координаты объекта",
                    hint: nil)
        ],
        .item9: [
            .header(number: "9", 
                    title: "Дата строительства",
                    hint: nil)
        ],
        .item10: [
            .header(number: "10", 
                    title: "Архитектор(ы)",
                    hint: nil)
        ],
        .item11: [
            .header(number: "11", 
                    title: "Сведения о владельцах",
                    hint: nil),
            .text(placeholder: "Укажите владельца и годы владения")
        ],
        .item12: [
            .header(number: "12", 
                    title: "Типологическая принадлежность",
                    hint: nil),
            .picker(annotation: nil,
                    options: TypologicalAffilation.allValues,
                    initialOption: ". . .")
        ],
        .item13: [
            .header(number: "13", 
                    title: "Охранный статус объекта ОКН",
                    hint: nil),
            .picker(annotation: nil, 
                    options: ProtectedStatusOKN.allValues,
                    initialOption: ". . .")
        ],
        .item14: [
            .header(number: "14", 
                    title: "Краткое архитектурное описание",
                    hint: nil),
            .text(placeholder: "Укажите материалы, форму и декор здания, характер фундамента, форму крыши и другие особенности")
        ],
        .item15: [
            .header(number: "15", 
                    title: "Характеристика технического состояния объекта",
                    hint: nil),
            .picker(annotation: nil,
                    options: TecnicalCondition.allValues,
                    initialOption: ". . .")
        ],
        .item16: [
            .header(number: "16", 
                    title: "Характер современного использования",
                    hint: nil),
            .text(placeholder: "Укажите современное назначение (использование) объекта")
        ],
        .item17: [
            .header(number: "17", 
                    title: "Необходимые первоочередные работы",
                    hint: nil),
            .text(placeholder: "Какие на ваш взгляд, необходимы первоочередные работы для сохранения данного объекта?")
        ]
    ]
    
    private lazy var section2: [ItemID: [PersistentDataContainer]] = [
        .item18(): [
            .header(number: "18", 
                    title: "Фотофиксация",
                    hint: nil),
            .picker(annotation: "Вид фотофиксации",
                    options: PhotoFixationKind.allValues,
                    initialOption: ". . .",
                    placementOrder: 0),
            .picker(annotation: "Стадия работ",
                    options: StageOfWork.allValues,
                    initialOption: ". . .",
                    placementOrder: 1),
            .date(annotation: "Дата фотофиксации"),
            .imageLoad
        ],
        .item19(): [
            .header(number: "19", 
                    title: "Историческая справка",
                    hint: nil),
            .picker(annotation: "Стадия работ",
                    options: StageOfWork.allValues,
                    initialOption: ". . ."),
            .date(annotation: "Дата составления"),
            .text(placeholder: "Ссылка на материал, выдается по предвврительному согласованию", 
                  placementOrder: 0),
            .text(placeholder: "Если у вас имеется комментарий к данному разделу, напишите его тут",
                  placementOrder: 1)
         ],
         .item20: [
            .header(number: "20", 
                    title: "Фотограмметрия",
                    hint: nil),
            .picker(annotation: "Стадия работ",
                    options: StageOfWork.allValues,
                    initialOption: ". . ."),
            .date(annotation: "Дата проведения"),
            .text(placeholder: "Ссылка на модель"),
            .imageLoad
         ],
         .item21: [
            .header(number: "21", 
                    title: "3D сканирование",
                    hint: nil),
            .picker(annotation: "Стадия работ",
                    options: StageOfWork.allValues,
                    initialOption: ". . ."),
            .date(annotation: "Дата сканирования"),
            .text(placeholder: "Ссылка на материал, выдается по предвврительному согласованию"),
            .imageLoad
         ],
         .item22: [
            .header(number: "22", 
                    title: "3D Реконструкция",
                    hint: nil),
            .picker(annotation: "Стадия работ",
                    options: StageOfWork.allValues,
                    initialOption: ". . ."),
            .date(annotation: "Дата реконструкции"),
            .text(placeholder: "Ссылка на материал"),
            .imageLoad
         ],
         .item23: [
            .header(number: "23", 
                    title: "Составление инженерно-технического описания ОКН",
                    hint: nil),
            .picker(annotation: "Стадия работ",
                    options: StageOfWork.allValues,
                    initialOption: ". . ."),
            .text(placeholder: "Если у вас имеется комментарий к данному разделу, напишите его тут"),
            .fileLoad
         ]
    ]
    
    private let section3: [ItemID: [PersistentDataContainer]] = [
        .item24: [
            .header(number: "24", 
                    title: "Краткая историческая справка",
                    hint: nil),
            .text(placeholder: "Опишите историю самого здания, а не его владельцев"),
            .describedImageLoad(label: "Иконография", 
                                placeholder: "Комментарий к фотографии")
        ],
        .item25: [
            .header(number: "25", 
                    title: "Используемая литература",
                    hint: nil),
            .text(placeholder: "Укажите использованную литературу")
        ],
        .item26: [
            .header(number: "26", 
                    title: "Инженерно-техническое описание ОКН",
                    hint: nil),
            .text(placeholder: "Опишите текущее состояние объекта, на что стоит обратить внимание, прогноз и выводы"),
            .describedImageLoad(label: "Иконография", 
                                placeholder: "Комментарий к фотографии")
        ]
    ]
    
    private let section4: [ItemID: [PersistentDataContainer]] = [
        .item27: [
            .header(number: "27", 
                    title: "Документы",
                    hint: nil),
            .fileLoad
        ],
        .item28: [
            .header(number: "28", 
                    title: "Предложения по сохранению данного объекта",
                    hint: nil),
            .text(placeholder: "Укажите первоочередные работы для сохранения данного объекта")
        ],
        .item29: [
            .header(number: "29", 
                    title: "Комментарии",
                    hint: nil)
        ]
    ]
    
    private var pickerOptions: [[String]] = [
        [
            ". . .",
            "Памятник археологии",
            "Памятник истории",
            "Памятник гр-ства и архитектуры",
            "Памятник монументального искусства"
        ],
        [
            ". . .",
            "Объект федерального значения",
            "Объект регионального значения",
            "Объект местного (муниципального)",
            "Объект не имеет охранного статуса",
            "Не знаю"
        ],
        [
            ". . .",
            "Хорошее",
            "Среднее",
            "Плохое",
            "Аварийное",
            "Руинированное"
        ],
        [
            ". . .",
            "Протокольно-документальная",
            "Художестванная"
        ],
        [
            ". . .",
            "Не выполнялась",
            "В процессе выполнения",
            "Выполнена"
        ]
    ]
}

