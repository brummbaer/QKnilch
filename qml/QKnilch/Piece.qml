import "qrc:/qml/QKnilch"
import QtQuick 2.1

Rectangle {
    id: piece
    property int number
    property bool neverMoved

    Image {
        width: playground.listofpieces.children[number].initialwidth / 1024 * maincanvas.width
        height: playground.listofpieces.children[number].initialheight / 768 * maincanvas.height
        source: playground.listofpieces.children[number].svgSource
        x: playground.listofpieces.children[number].initialx / 1024 * maincanvas.width
        y: playground.listofpieces.children[number].initialy / 768 * maincanvas.height
        fillMode: Image.PreserveAspectFit
        sourceSize.width: playground.listofpieces.children[number].initialwidth / 1024 * maincanvas.width
        sourceSize.height: playground.listofpieces.children[number].initialheight / 768 * maincanvas.height
        scale: 1.0
        rotation: 0
        mirror: false

        MouseArea {
            anchors.fill: parent

            drag.target: piece

            onPressed: {
                piece.z = playground.lastz + 50
                playground.lastz = playground.lastz + 50
            }

            onReleased: {
                var dummy = mapToItem(playground, mouse.x, mouse.y)

                if (neverMoved == true) {
                    neverMoved = false
                    var anotherObject = Qt.createQmlObject(
                                'import QtQuick 2.1;Piece{number:' + number.toString(
                                    ) + ';neverMoved:true}', playground)

                }

                if (dummy.x < maincanvas.height/7) {
                    if (dummy.y < maincanvas.height/7) {
                        parent.visible = false
                        parent.destroy()
                    }
                    if ((dummy.y > maincanvas.height/7) && (dummy.y < 2*maincanvas.height/7) && (parent.scale<5)) {
                        parent.scale *= 1.2
                    }
                    if ((dummy.y > 2*maincanvas.height/7) && (dummy.y < 3*maincanvas.height/7) && (parent.scale>0.3)) {
                        parent.scale *= 0.8
                    }
                    if ((dummy.y > 3*maincanvas.height/7) && (dummy.y < 4*maincanvas.height/7)) {
                        parent.rotation += 22.5
                    }
                    if ((dummy.y > 4*maincanvas.height/7) && (dummy.y < 5*maincanvas.height/7)) {
                        parent.rotation -= 22.5
                    }
                    if ((dummy.y > 5*maincanvas.height/7) && (dummy.y < 6*maincanvas.height/7)) {
                        parent.mirror = !parent.mirror
                    }
                }
            }
        }
    }
}
