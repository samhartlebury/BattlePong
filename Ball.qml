import QtQuick 2.5

Rectangle {

    property real xPos: 0
    property real yPos: 0
    property int size: 100

    property real direction: 20
    property real speed: 15
    property bool collision: false

    x: xPos - (width / 2)
    y: yPos - (height / 2)

    width: size
    height: size
    radius: size
    color: "black"


    function step()
    {
        xPos += speed * Math.cos(deg2rad(direction));
        yPos += speed * Math.sin(deg2rad(direction));
    }

    function xBounce()
    {
        direction = 180 - direction;
    }

    function yBounce()
    {
        direction = 360 - direction;
    }


    function deg2rad(degrees)
    {
        return (degrees * Math.PI) / 180;
    }
}
