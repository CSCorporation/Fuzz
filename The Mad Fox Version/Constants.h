/*
 *  Strings.h
 *  duudleJump
 *
 *  Created by Viktor Todorov on 24.03.14.
 *  Copyright 2014 Viktor Todorov. All rights reserved.
 *
 */


#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IS_IPHONE5 (fabs ( (double) [ [UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

int stars;
int chapterNumber;
int temp_level;
int shopItemIndex;
BOOL isAlertViewVisible;
int shopLevel;
BOOL isFirstRunPassed;

static double SceneTransitionTime = 0.3f;
static NSString* RATE_URL = @"https://itunes.apple.com/us/app/bubble-math/id874794787?mt=8";
static int timeToReloadBonuses = 60;
static int getVideoTime = 30;
static NSString* fontInTheGame = @"Cartwheel";

// ****************** FONTS ****************** //
// ******************************************* //

//BACK BUTTON ALL VIEWS
static NSString* BackButtonTitle = @"Back";
static int BackButtonFontSize = 30;

//Shop View
static NSString* RestoreTitleName = @"Restore";
static int RestoreFontSize = 20;

static NSString* BuyTitleName = @"Buy";
static int BuyFontSize = 20;

static NSString* ShopItemLabel = @"50 Bubbles";
static int ShopLabelFontSize = 25;

//Menu View
static NSString* PlayTitleName = @"Play";
static int PlayFontSize = 60;

static NSString* OptionsTitleName = @"Options";
static int OptionsFontSize = 60;

static NSString* ShopTitleName = @"Shop";
static int ShopFontSize = 60;

static NSString* BonusTitleName = @"Bonus";
static int BonusFontSize = 60;

static NSString* AchievementsTitleName = @"Achievements";
static int AchievementsFontSize = 30;

//Play View
//Weapons Counters
static int FreezeFoxCounterFontSize = 30;
static int FreezeFoxCounterX = 150;
static int FreezeFoxCounterY = 250;

static int CutAdjacentWeaponCounterFontSize = 30;
static int CutAdjacentWeaponCounterX = 150;
static int CutAdjacentWeaponCounterY = 350;

static int DummyChickenCounterFontSize = 30;
static int DummyChickenCounterX = 150;
static int DummyChickenCounterY = 300;

//ACHIEVEMENTS
static int achievements_fontSize = 30;

static NSString* achiev_label_1 = @"Noobie";
static NSString* achiev_label_2 = @"Good";
static NSString* achiev_label_3 = @"Great";
static NSString* achiev_label_4 = @"Awesome";
static NSString* achiev_label_5 = @"Master";
static NSString* achiev_label_6 = @"Insane";
static NSString* achiev_label_7 = @"Social";

static NSString* achiev_share_label = @"Share";

//Share Messages
static NSString* achiev_share_1 = @"I became a noobie! Can you become a noobie?";
static NSString* achiev_share_2 = @"I achieve goodness! ";
static NSString* achiev_share_3 = @"I achieve godlike! ";
static NSString* achiev_share_4 = @"I became a master! Can you become a master?";
static NSString* achiev_share_5 = @"I became a godlike! Can you become a godlike?";
static NSString* achiev_share_6 = @"I became a unstopabble! Can you become a unstopabble?";
static NSString* achiev_share_7 = @"I became a socialist! Can you become a socialist?";

//CHAPTERS
static NSString* chapter_1_label_string = @"Chapter 1";
static NSString* chapter_2_label_string = @"Chapter 2";
static NSString* chapter_3_label_string = @"Chapter 3";
static int chapter_font_size = 30;

// ****************** SPRITES ****************** //
// ********************************************* //

//****************** PLAY VIEW ******************//
//Containers & Background
static NSString* PlayBackground = @"background4.png";
static NSString* PathContainerSprite = @"pathContainer.png";
static NSString* WeaponContainerSprite = @"weaponContainer.png";
static NSString* Arrow_Weapon_ContainerSprite = @"arrow.png";

//Weapons & Hint
static NSString* DefaultWeaponSprite = @"defaultButton.png";
static NSString* DefaultWeaponHighlightedSprite = @"defaultButtonHover.png";

static NSString* CutAdjacentWeaponSprite = @"cutAdjacentButton.png";
static NSString* CutAdjacentHighlightedWeaponSprite = @"cutAdjacentButtonHover.png";

static NSString* DummyChickenSprite = @"dummyButton.png";
static NSString* DummyChickenHighlightedSprite = @"dummyButtonHover.png";

static NSString* FreezeFoxSprite = @"freezeButton.png";
static NSString* FreezeFoxHighlightedSprite = @"freezeButtonHover.png";

static NSString* HintSprite = @"hint.png";
static NSString* HintHighlightedSprite = @"hint.png";

//When Hint is pressed titles checks
static NSString* DefaultWeaponTitle = @"DefaultWeapon";
static NSString* CutAdjacentWeaponTitle = @"Cut";
static NSString* DummyWeaponTitle = @"FakeChickenWeapon";
static NSString* FreezeWeaponTitle = @"FreezyFox";

//Fox Character
static NSString* FoxPlist = @"foxSprite.plist";
static NSString* FoxSpriteSheet = @"foxSprite.png";
static NSString* FoxFrames = @"fox%d.png";
static NSString* FoxFirstFrame = @"fox1.png";

//Path Sprite
static NSString* StartPointSprite = @"test.png";
static NSString* EndPointSprite = @"test.png";
static NSString* PathSprite = @"line.png";

//Chicken Character
static NSString* ChickenPlist = @"sprites.plist";
static NSString* ChickenSpriteSheet = @"sprites.png";
static NSString* ChickenFrames = @"%d.png";
static NSString* ChickenFirstFrame = @"1.png";

//******************GAME OVER VIEW******************//
static NSString* GameOverBackground = @"wall.png";
static NSString* GameOverContainer = @"stain.png";
static NSString* GameOverStarsSprite = @"bistar.png";
static NSString* GameOverFailed = @"failed.png";
static NSString* GameOverGood = @"good.png";
static NSString* GameOverGreat = @"great.png";
static NSString* GameOverAwesome = @"awesome.png";

//******************SHOP VIEW******************//
static NSString* ShopBackground = @"background4.png";
static NSString* leftArrowSprite = @"arrow.png";
static NSString* leftArrowHighlighted = @"arrow.png";
static NSString* rightArrowSprite = @"arrowright.png";
static NSString* rightArrowHighlighted = @"arrowright.png";

static NSString* ShopItem1 = @"square2.png";
static NSString* ShopItem2 = @"square2.png";
static NSString* ShopItem3 = @"square2.png";

static NSString* ChapterItem1 = @"star.png";
static NSString* ChapterItem2 = @"star.png";
static NSString* ChapterItem3 = @"star.png";

//******************MENU VIEW******************//
static NSString* MenuBackground = @"menuwall.png";
static NSString* MenuLogo = @"foxMM.png";

//******************LEVEL VIEW******************//n
static NSString* LevelBackground = @"wall.png";
static NSString* LevelButtonSprite = @"level.png";
static NSString* LevelStar = @"star.png";

//******************OPTIONS VIEW******************//
static NSString* OptionsBackground = @"background4.png";

//******************ACHIEVEMENTS VIEW******************//
static NSString* achiev_image_1 = @"star.png";
static NSString* achiev_image_2 = @"star.png";
static NSString* achiev_image_3 = @"star.png";
static NSString* achiev_image_4 = @"star.png";
static NSString* achiev_image_5 = @"star.png";
static NSString* achiev_image_6 = @"star.png";
static NSString* achiev_image_7 = @"star.png";

//******************CHAPTER VIEW******************//
static NSString* chapter_1_image = @"chapter1.jpg";
static NSString* chapter_2_image = @"chapter2.jpg";
static NSString* chapter_3_image = @"chapter3.jpg";

//******************BONUS VIEW********************//
static NSString* BonusBackground = @"wall.png";

static NSString* facebookBonus = @"rate.png";
static NSString* twitterBonus = @"rate.png";
static NSString* likeUsBonus = @"rate.png";

static NSString* rateUsBonus = @"rate.png";

