import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080

    // Safe config access
    readonly property color bgColor: (typeof config !== "undefined" && config !== null && config.backgroundColor) ? config.backgroundColor : "#0f1115"
    readonly property color accentColor: (typeof config !== "undefined" && config !== null && config.accentColor) ? config.accentColor : "#1793d1"
    readonly property color textColor: (typeof config !== "undefined" && config !== null && config.textColor) ? config.textColor : "#e8e8e8"
    readonly property string fontFamily: (typeof config !== "undefined" && config !== null && config.fontFamily) ? config.fontFamily : "Aequalyn"
    readonly property bool use24h: (typeof config !== "undefined" && config !== null && config.use24HourClock !== undefined) ? config.use24HourClock : true

    color: bgColor

    // Background image
    Image {
        anchors.fill: parent
        source: "aequalyn-horizon.svg"
        fillMode: Image.PreserveAspectCrop
        smooth: true
        opacity: 0.35
    }

    TextConstants { id: textConstants }

    FontLoader { id: aequalynFont; source: "Aequalyn-Regular.ttf" }

    property int sessionIndex: 0
    Component.onCompleted: {
        console.log("Aequalyn SDDM: component completed")
        if (typeof userModel !== "undefined" && userModel !== null) {
            console.log("Aequalyn SDDM: userModel.count=" + userModel.count + " lastUser=[" + userModel.lastUser + "]")
        }
        if (typeof sessionModel !== "undefined" && sessionModel !== null && sessionModel.lastIndex >= 0) sessionIndex = sessionModel.lastIndex
        console.log("Aequalyn SDDM: sessionIndex=" + sessionIndex)
    }

    // Background
    Rectangle { anchors.fill: parent; color: bgColor }

    // Centered content
    Column {
        anchors.centerIn: parent
        spacing: 32
        width: 360

        // Logo
        Image {
            source: "aequalyn-mark.svg"
            width: 96; height: 96
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Image {
            source: "aequalyn-wordmark.svg"
            width: 200; height: 36
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // Clock
        Text {
            id: clockText
            anchors.horizontalCenter: parent.horizontalCenter
            color: textColor
            font.family: root.fontFamily
            font.pixelSize: 44
            font.weight: Font.Light
            text: Qt.formatTime(new Date(), root.use24h ? "HH:mm" : "hh:mm AP")
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clockText.text = Qt.formatTime(new Date(), root.use24h ? "HH:mm" : "hh:mm AP")
            }
        }

        // Login card
        Rectangle {
            width: parent.width
            height: loginCol.implicitHeight + 40
            radius: 16
            color: Qt.rgba(1, 1, 1, 0.04)
            border.color: Qt.rgba(1, 1, 1, 0.08)
            border.width: 1

            Column {
                id: loginCol
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 20
                spacing: 12

                TextBox {
                    id: userEntry
                    width: parent.width
                    font.pixelSize: 14
                    text: {
                        if (typeof userModel === "undefined" || userModel === null) return ""
                        if (userModel.lastUser && String(userModel.lastUser).length > 0) return userModel.lastUser
                        if (userModel.count > 0) {
                            var idx = userModel.index(0, 0)
                            var n = userModel.data(idx, Qt.UserRole + 1)
                            if (n && String(n).length > 0) return n
                        }
                        return ""
                    }
                    KeyNavigation.tab: pwEntry
                }

                PasswordBox {
                    id: pwEntry
                    width: parent.width
                    KeyNavigation.backtab: userEntry
                    KeyNavigation.tab: loginBtn
                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(userEntry.text, pwEntry.text, sessionIndex)
                            event.accepted = true
                        }
                    }
                }

                Button {
                    id: loginBtn
                    width: parent.width
                    text: textConstants.login
                    onClicked: sddm.login(userEntry.text, pwEntry.text, sessionIndex)
                    KeyNavigation.backtab: pwEntry
                }

                ComboBox {
                    id: sessionCombo
                    width: parent.width
                    model: (typeof sessionModel !== "undefined") ? sessionModel : null
                    index: root.sessionIndex
                    visible: (typeof sessionModel !== "undefined" && sessionModel !== null) && sessionModel.count > 1
                    onIndexChanged: { if (index >= 0) root.sessionIndex = index }
                }
            }
        }
    }

    // Power buttons
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 24
        spacing: 12
        Button {
            text: textConstants.shutdown
            onClicked: sddm.powerOff()
        }
        Button {
            text: textConstants.reboot
            onClicked: sddm.reboot()
        }
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            pwEntry.text = ""
            pwEntry.forceActiveFocus()
        }
    }

    // Populate the username when the user model becomes available (handles the
    // case where userModel is populated after the theme loads).
    Connections {
        target: (typeof userModel !== "undefined" && userModel !== null) ? userModel : null
        function onCountChanged() {
            if (userEntry.text.length === 0 && userModel.count > 0) {
                var idx = userModel.index(0, 0)
                var n = userModel.data(idx, Qt.UserRole + 1)
                if (n && String(n).length > 0) userEntry.text = n
            }
        }
    }
}
