import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1

ApplicationWindow {
    visible: true
    width: 400
    height: 200

    Rectangle {
        width: parent.width
        height: parent.height

        Column {
            anchors.centerIn: parent
            spacing: 10

            TextField {
                id: textInput
                width: parent.width - 20
                height: 40
                placeholderText: "Enter text here"
            }

            Button {
                text: "Save Text with Timestamp"
                onClicked: saveTextToFile()
            }
        }
    }

    function saveTextToFile() {
        var timestamp = new Date().toLocaleString().replace(/[-:.,\s]/g, "_");
        var fileDialog = fileDialogComponent.createObject();
        fileDialog.folder = shortcuts.documents; // Open in the Documents folder, you can change it to another path or remove this line to let the user choose the folder.
        fileDialog.accepted.connect(function() {
            var fileUrl = fileDialog.fileUrls[0];
            if (fileUrl !== "") {
                var file = fileUrl.toLocalFile();
                var fileText = textInput.text;
                var fileContents = timestamp + "\n" + fileText;
                Qt.createFile(file, fileContents);
            }
        });
        fileDialog.open();
    }

    FileDialog {
        id: fileDialogComponent
        title: "Save File"
        folder: shortcuts.documents // Set default folder when the dialog is opened.
        onAccepted: {
            fileDialogComponent.visible = false;
        }
    }

    FileDialogShortcut {
        id: shortcuts
    }
}
