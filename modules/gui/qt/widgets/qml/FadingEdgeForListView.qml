/*****************************************************************************
 * Copyright (C) 2022 VLC authors and VideoLAN
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * ( at your option ) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/
import QtQuick

import VLC.Style
import VLC.Util

FadingEdge {
    id: root

    required property ListView listView

    sourceItem: listView.contentItem

    beginningMargin: listView.displayMarginBeginning
    endMargin: listView.displayMarginEnd
    orientation: (listView.orientation === ListView.Vertical) ? Qt.Vertical : Qt.Horizontal

    sourceX: listView.contentX
    sourceY: listView.contentY

    fadeSize: delegateItem ? (orientation === Qt.Vertical ? delegateItem.height
                                                          : delegateItem.width) / 2
                           : (VLCStyle.margin_large * 2)

    readonly property bool transitionsRunning: (listView.add?.running ||
                                                listView.addDisplaced?.running ||
                                                listView.displaced?.running ||
                                                listView.move?.running ||
                                                listView.moveDisplaced?.running ||
                                                listView.populate?.running ||
                                                listView.remove?.running ||
                                                listView.removeDisplaced?.running) ?? false

    // FIXME: Delegate with variable size
    readonly property Item delegateItem: (listView.count > 0) ? listView.itemAtIndex(0) : null

    readonly property Item firstVisibleItem: {
        if (transitionsRunning || !delegateItem)
            return null

        let margin = 0 // -root.beginningMargin
        if (orientation === Qt.Vertical) {
            // if (headerItem && headerItem.visible && headerPositioning === ListView.OverlayHeader)
            //    margin += headerItem.height

            return listView.itemAt(sourceX + (delegateItem.x + delegateItem.width / 2),
                                   sourceY + margin - beginningMargin + listView.spacing)
        } else {
            // if (headerItem && headerItem.visible && headerPositioning === ListView.OverlayHeader)
            //    margin += headerItem.width

            return listView.itemAt(sourceX + margin - beginningMargin + listView.spacing,
                                   sourceY + (delegateItem.y + delegateItem.height / 2))
        }
    }

    readonly property Item lastVisibleItem: {
        if (transitionsRunning || !delegateItem)
            return null

        let margin = 0 // -root.endMargin
        if (orientation === Qt.Vertical) {
            // if (footerItem && footerItem.visible && footerPositioning === ListView.OverlayFooter)
            //    margin += footerItem.height

            return listView.itemAt(sourceX + (delegateItem.x + delegateItem.width / 2),
                                   sourceY + listView.height - margin + endMargin - listView.spacing - 1)
        } else {
            // if (footerItem && footerItem.visible && footerPositioning === ListView.OverlayFooter)
            //    margin += footerItem.width

            return listView.itemAt(sourceX + listView.width - margin + endMargin - listView.spacing - 1,
                                   sourceY + (delegateItem.y + delegateItem.height / 2))
        }
    }

    readonly property bool _fadeRectEnoughSize: (orientation === Qt.Vertical ? listView.height
                                                                             : listView.width) > (fadeSize * 2 + VLCStyle.dp(25))

    enableBeginningFade: _fadeRectEnoughSize &&
                         (orientation === Qt.Vertical ? !listView.atYBeginning
                                                      : !listView.atXBeginning) &&
                         (!firstVisibleItem ||
                         (!firstVisibleItem.activeFocus &&
                          !(firstVisibleItem?.hovered ?? true)))

    enableEndFade: _fadeRectEnoughSize &&
                   (orientation === Qt.Vertical ? !listView.atYEnd
                                                : !listView.atXEnd) &&
                   (!lastVisibleItem ||
                   (!lastVisibleItem.activeFocus &&
                    !(lastVisibleItem?.hovered ?? true)))

    Binding on enableBeginningFade {
        when: !!listView.headerItem && (listView.headerPositioning !== ListView.InlineHeader)
        value: false
    }

    Binding on enableEndFade {
        when: !!listView.footerItem && (listView.footerPositioning !== ListView.InlineFooter)
        value: false
    }
}
