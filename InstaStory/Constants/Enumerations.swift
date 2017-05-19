//
//  Enumerations.swift
//  InstaStory
//
//  Created by Sierra 4 on 13/05/17.
//  Copyright © 2017 code.brew. All rights reserved.
//

import Foundation
enum StoryBoardIdentifier:String
{
    case CameraVC = "CameraVC"
    case MainVC = "MainVC"
    case StoryVC = "StoryVC"
}

enum MediaTypesPermission:String
{
    case Image = "public.image"
    case video = "public.movie"
}

enum AlertMessage:String
{
    case Title = "Alert "
    case Text = "Do you want to add a cool stuff to your story ?"
    case CancelButtonText = "Cancel"
    case ButtonText = "Ok"
}

enum Font :String
{
    case TitleFont = "ClearSans-Bold"
    case TextFont = "ClearSans"
    case ButtonFont = "ClearSans-Light"
}

enum NoStoryAlertMessage:String
{
    case Title = "Attention"
    case Text = "There is no Story !!"
    case ButtonText = "Ok"
}

enum OtherUtility:String
{
    case Nil = "nil"
    case main = "Main"
}

enum CellIdentifier:String
{
    case MyCollectionViewCell = "cell"
    case StoryCollectionViewCell = "story"
}
