/*****************************************************************************
 * VLCLibraryCollectionViewMediaItemSupplementaryDetailView.h: MacOS X interface module
 *****************************************************************************
 * Copyright (C) 2022 VLC authors and VideoLAN
 *
 * Authors: Claudio Cambra <claudio.cambra@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/

#import <Cocoa/Cocoa.h>
#import "VLCLibraryCollectionViewSupplementaryDetailView.h"

NS_ASSUME_NONNULL_BEGIN

@class VLCImageView;

extern NSString *const VLCLibraryCollectionViewMediaItemSupplementaryDetailViewIdentifier;
extern NSCollectionViewSupplementaryElementKind const VLCLibraryCollectionViewMediaItemSupplementaryDetailViewKind;

@interface VLCLibraryCollectionViewMediaItemSupplementaryDetailView : VLCLibraryCollectionViewSupplementaryDetailView

@property (readwrite, weak) IBOutlet NSTextField *mediaItemTitleTextField;
@property (readwrite, weak) IBOutlet NSButton *mediaItemPrimaryDetailButton;
@property (readwrite, weak) IBOutlet NSButton *mediaItemSecondaryDetailButton;
@property (readwrite, weak) IBOutlet NSButton *mediaItemFavoriteButton;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemYearAndDurationTextField;
@property (readwrite, weak) IBOutlet NSLevelIndicator *mediaItemRatingIndicator;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemFileNameTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemPathTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemLabelsTitleTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemLabelsTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemLastPlayedTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemLastPlayedTitleTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemCopyrightTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemCopyrightTitleTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemContentDescriptionTextField;
@property (readwrite, weak) IBOutlet NSTextField *mediaItemContentDescriptionTitleTextField;
@property (readwrite, weak) IBOutlet VLCImageView *mediaItemArtworkImageView;
@property (readwrite, weak) IBOutlet NSButton *playMediaItemButton;

- (IBAction)playAction:(id)sender;
- (IBAction)enqueueAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
