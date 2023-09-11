// Pegasus Frontend - Flixnet theme
// Copyright (C) 2017  Mátyás Mustoha
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


import QtQuick 2.7

Item {
    property real percent
    property int size

    FontLoader {
        id: customFont
        source: "font/NetflixSansBold.ttf"
    }

    height: size
    width: height * 5

    Text {
        anchors.centerIn: parent
        text: Math.round(percent * 100) + " % rating"
        font.pixelSize: height * 1.5
        font.family: customFont.name // Asigna la fuente cargada al Text
        color: "#4ae170" // Color verde en formato hexadecimal
    }
}
