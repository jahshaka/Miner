import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "subclass"


BasePage {

    padding: 10
    background: Rectangle {
        color: Literals.darkBackgroundColor
    }

    ScrollView {
        id: scrollview
        width: parent.width
        height: parent.height
        Layout.fillWidth: true
        Layout.fillHeight: true

        clip: true
        padding: 10

        background: Rectangle {
            color: Literals.darkBackgroundColor
        }


        ColumnLayout {

            id: col
            spacing:5
            width: scrollview.width- scrollview.padding * 2

            ParagraphLink{
                id: createAccount
                explanation: "click the button above to create an account on xmr stak"
                labelText: "Create Account"
                linkText: "Register"
            }

            ParagraphLink{
                id: onlineHelp
                explanation: "click the button to get help online from jahfx"
                labelText: "Online Assistance"
                linkText: "Help"
            }

            ParagraphLink{
                id: config
                explanation: "click the button to build the configurations"
                labelText: "Build Configuration"
                linkText: "Configure"
            }

            ParagraphLink{
                id: support
                explanation: "click the button to support Jahshaka by visiting www.jahshaka.com"
                labelText: "Support Jahshaka"
                linkText: "Visit"
            }

        }
    }

}
