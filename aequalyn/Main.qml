import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: config.backgroundColor

    TextConstants { id: textConstants }

    // Font loader for the bundled Aequalyn font
    FontLoader { id: aequalynFont; source: "Aequalyn-Regular.ttf" }

    property string fontFamily: config.fontFamily || "Aequalyn"

    // User & session state
    property int userIndex: 0
    property int sessionIndex: 0
    Component.onCompleted: {
        if (typeof userModel !== "undefined" && userModel.lastIndex >= 0) userIndex = userModel.lastIndex
        if (typeof sessionModel !== "undefined" && sessionModel.lastIndex >= 0) sessionIndex = sessionModel.lastIndex
    }
    property bool isLoggingIn: false

    // Background
    Rectangle {
        anchors.fill: parent
        color: config.backgroundColor
    }

    // Centered content
    Column {
        anchors.centerIn: parent
        spacing: 32
        width: 360

        // Logo
        Image {
            source: "aequalyn-mark.svg"
            width: 96
            height: 96
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Image {
            source: "aequalyn-wordmark.svg"
            width: 220
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // Clock
        Text {
            id: clockText
            anchors.horizontalCenter: parent.horizontalCenter
            color: config.textColor
            font.family: root.fontFamily
            font.pixelSize: 48
            font.weight: Font.Light
            text: Qt.formatTime(new Date(), config.use24HourClock ? "HH:mm" : "hh:mm AP")
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clockText.text = Qt.formatTime(new Date(), config.use24HourClock ? "HH:mm" : "hh:mm AP")
            }
        }

        // Login card
        Rectangle {
            width: parent.width
            height: loginColumn.implicitHeight + 40
            radius: 16
            color: Qt.rgba(1, 1, 1, 0.04)
            border.color: Qt.rgba(1, 1, 1, 0.08)
            border.width: 1

            Column {
                id: loginColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 20
                spacing: 12

                // User
                ComboBox {
                    id: userCombo
                    width: parent.width
                    model: userModel
                    textRole: "name"
                    currentIndex: root.userIndex
                    onCurrentIndexChanged: { if (currentIndex >= 0) root.userIndex = currentIndex }
                }

                // Password
                TextField {
                    id: passwordField
                    width: parent.width
                    placeholderText: textConstants.password
                    echoMode: TextInput.Password
                    onAccepted: doLogin()
                }

                // Login button
                Button {
                    width: parent.width
                    text: textConstants.login
                    enabled: !root.isLoggingIn
                    onClicked: doLogin()
                }

                // Session
                ComboBox {
                    id: sessionCombo
                    width: parent.width
                    model: sessionModel
                    textRole: "name"
                    currentIndex: root.sessionIndex
                    onCurrentIndexChanged: { if (currentIndex >= 0) root.sessionIndex = currentIndex }
                }
            }
        }
    }

    // Power buttons (bottom right)
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

    function doLogin() {
        root.isLoggingIn = true
        sddm.login(userCombo.currentText, passwordField.text, root.sessionIndex)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            root.isLoggingIn = false
            passwordField.text = ""
            passwordField.forceActiveFocus()
        }
    }
}
