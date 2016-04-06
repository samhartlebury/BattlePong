import QtQuick 2.5

Rectangle {

    property int xPos: 0
    property int yPos: 0
    readonly property int leftBound: xPos - (width / 2)
    readonly property int rightBound: xPos + (width / 2)

    x: xPos - (width / 2)
    y: yPos - (height / 2)

    width: 200
    height: 50
    radius: 5
    color: "blue"
}
