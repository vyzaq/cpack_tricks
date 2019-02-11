pragma Singleton
import QtQuick 2.9

QtObject
{
    property string defaultFont : _defaultFontLoader.name
    property string titleFont : _titleFontLoader.name
    property string listFont : _listFontLoader.name

    property var _defaultFontLoader :
    FontLoader {
        source: "../../fonts/Roboto-Light.ttf"
    }

    property var _titleFontLoader :
    FontLoader {
        source: "../../fonts/Roboto-Medium.ttf"
    }

    property var _listFontLoader :
    FontLoader {
        source: "../../fonts/Roboto-Regular.ttf"
    }
}

