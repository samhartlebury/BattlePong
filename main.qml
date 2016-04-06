import QtQuick 2.5
import QtQml 2.2
import QtQuick.Controls 1.4
import Sam.Multiplayer 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("BattlePong")

    property int enemyScore: 0
    property int meScore: 0

    Label {
        x: 0
        y: parent.height / 2
        text: meScore
        color: "blue"
    }

    Label {
        x: parent.width - width;
        y: parent.height / 2
        text: enemyScore
        color: "red"
    }

    Multiplayer {
        id: network

        property string userName: "dhgf"

        Component.onCompleted: {
            login(userName);
        }

        onPositionReceived: {
            enemy.xPos = position;
        }
    }

    Timer {
        id: repainter
        interval: 20
        repeat: true
        running: true

        onTriggered: {
            checkCollisions();
            ball.step();
            me.xPos = touch.mouseX;
        }

        function checkCollisions()
        {
            if ((ball.xPos >= parent.width || ball.xPos <=0) && !ball.collision) { // Hoz collision
                ball.collision = true;
                ball.xBounce();
            }
            if ((ball.yPos >= parent.height || ball.yPos <= 0) && !ball.collision) { // Ver collision
                ball.collision = true;
                ball.yBounce();

                if (ball.yPos >= parent.height) // enemy scores
                    enemyScore++;
                if (ball.yPos <= 0) // me scores
                    meScore++;
            }
            if ((ball.yPos >= me.y && ball.xPos >= me.leftBound && ball.xPos <= me.rightBound && !ball.collision)) { // Me collision
                ball.collision = true;
                ball.yBounce();
                ball.direction += ball.xPos - me.xPos;
            }
            if ((ball.yPos <= (enemy.y + enemy.height) && ball.xPos >= enemy.leftBound && ball.xPos <= enemy.rightBound && !ball.collision)) { // Enemy collision
                ball.collision = true;
                ball.yBounce();
                ball.direction += ball.xPos - enemy.xPos;
            }

            if (ball.xPos < parent.width && ball.xPos > 0)
                ball.collision = false;
        }
    }

    MouseArea {
        id: touch
        anchors.fill: parent
    }

    Ball {
        id: ball
        xPos: parent.width / 2
        yPos: 1
    }

    Player {
        id: me
        xPos: parent.width / 2
        yPos: parent.height - height

        onXPosChanged: network.say(xPos);
    }

    Player {
        id: enemy
        xPos: parent.width / 2
        yPos: height
        color: "red"
    }
}
