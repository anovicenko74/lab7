import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: "Интерфейс с ползунками и синхронизацией"

    // Переменные для управления цветом и прозрачностью
    property int redValue: 128
    property int greenValue: 128
    property int blueValue: 128
    property real opacityValue: 1.0
    property int randomClicks: 0
    property int maxRandomClicks: 5
    property color currentColor: Qt.rgba(redValue / 255, greenValue / 255, blueValue / 255, opacityValue)
    property color reversedColor: Qt.rgba(255 - redValue, 255 - greenValue, 255 - blueValue, 1)

    // Центральный макет
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        // Верхняя часть: квадрат и ползунок прозрачности
        RowLayout {
            spacing: 20

            // Левая часть: прямоугольник и метка
            ColumnLayout {
                spacing: 10

                // Прямоугольник с изменяемым цветом и прозрачностью
                Rectangle {
                    id: coloredRect
                    width: 200
                    height: 200
                    color: root.currentColor

                    // Метка за прямоугольником
                    Label {
                        id: labelBehindRect
                        text: "Прозрачность прямоугольника"
                        color: root.reversedColor
                        visible: root.opacityValue > 0.25
                        anchors.centerIn: parent
                    }
                }
            }

            // Правая часть: кастомный слайдер с кнопками
            GroupBox {
                title: "Прозрачность"
                Layout.alignment: Qt.AlignVCenter
                ColumnLayout {
                    spacing: 10

                    // Кастомный слайдер с кнопками
                    RowLayout {
                        spacing: 10

                        // Кнопка "-"
                        Button {
                            text: "<"
                            onClicked: {
                                root.opacityValue = Math.max(root.opacityValue - 0.05, 0.0)
                            }
                        }

                        // Ползунок прозрачности
                        Slider {
                            id: customSlider
                            from: 0
                            to: 1
                            stepSize: 0.01
                            value: root.opacityValue
                            orientation: Qt.Horizontal
                            onValueChanged: root.opacityValue = value
                        }

                        // Кнопка "+"
                        Button {
                            text: ">"
                            onClicked: {
                                root.opacityValue = Math.min(root.opacityValue + 0.05, 1.0)
                            }
                        }
                    }
                }
            }
        }

        // Нижняя часть: ползунки RGB
        GroupBox {
            // Layout.alignment: Qt.AlignHCenter
            RowLayout {
                spacing: 20

                // Красный
                ColumnLayout {
                    spacing: 10
                    Label {
                        text: "Красный"
                        color: "#aa0000"
                    }
                    Slider {
                        id: redSlider
                        from: 0
                        to: 255
                        stepSize: 1
                        value: root.redValue
                        orientation: Qt.Vertical
                        onValueChanged: root.redValue = value
                    }
                    TextField {
                        id: redInput
                        text: root.redValue.toString()
                        validator: IntValidator { bottom: 0; top: 255 }
                        onEditingFinished: {
                            const newValue = parseInt(text)
                            if (!isNaN(newValue)) {
                                root.redValue = newValue
                            } else {
                                text = root.redValue.toString()
                            }
                        }
                    }
                }

                // Зеленый
                ColumnLayout {
                    spacing: 10
                    Label {
                        text: "Зеленый"
                        color: "#00aa00"
                    }
                    Slider {
                        id: greenSlider
                        from: 0
                        to: 255
                        stepSize: 1
                        value: root.greenValue
                        orientation: Qt.Vertical
                        onValueChanged: root.greenValue = value
                    }
                    TextField {
                        id: greenInput
                        text: root.greenValue.toString()
                        validator: IntValidator { bottom: 0; top: 255 }
                        onEditingFinished: {
                            const newValue = parseInt(text)
                            if (!isNaN(newValue)) {
                                root.greenValue = newValue
                            } else {
                                text = root.greenValue.toString()
                            }
                        }
                    }
                }

                // Синий
                ColumnLayout {
                    spacing: 10
                    Label {
                        text: "Синий"
                        color: "#0000aa"
                    }
                    Slider {
                        id: blueSlider
                        from: 0
                        to: 255
                        stepSize: 1
                        value: root.blueValue
                        orientation: Qt.Vertical
                        onValueChanged: root.blueValue = value
                    }
                    TextField {
                        id: blueInput
                        text: root.blueValue.toString()
                        validator: IntValidator { bottom: 0; top: 255 }
                        onEditingFinished: {
                            const newValue = parseInt(text)
                            if (!isNaN(newValue)) {
                                root.blueValue = newValue
                            } else {
                                text = root.blueValue.toString()
                            }
                        }
                    }
                }
            }
        }

        // Кнопка "Рандом"
        Button {
            id: randomButton
            text: "Рандом"
            enabled: root.randomClicks < root.maxRandomClicks && root.opacityValue >= 0.25
            onClicked: {
                root.redValue = Math.floor(Math.random() * 256)
                root.greenValue = Math.floor(Math.random() * 256)
                root.blueValue = Math.floor(Math.random() * 256)
                root.randomClicks++
            }
        }
    }
}
