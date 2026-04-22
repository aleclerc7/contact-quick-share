// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Quick Share'**
  String get appTitle;

  /// No description provided for @noMatchingContacts.
  ///
  /// In en, this message translates to:
  /// **'No matching contacts'**
  String get noMatchingContacts;

  /// No description provided for @couldNotLoadBusinessCards.
  ///
  /// In en, this message translates to:
  /// **'Could not load business cards: {error}'**
  String couldNotLoadBusinessCards(Object error);

  /// No description provided for @contactPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Contact permission is required to display your contacts.'**
  String get contactPermissionRequired;

  /// No description provided for @noCardsYet.
  ///
  /// In en, this message translates to:
  /// **'No cards yet.\nAdd your first business card.'**
  String get noCardsYet;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @addBusinessCard.
  ///
  /// In en, this message translates to:
  /// **'Add business card'**
  String get addBusinessCard;

  /// No description provided for @newBusinessCardTooltip.
  ///
  /// In en, this message translates to:
  /// **'New Business Card'**
  String get newBusinessCardTooltip;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search cards or contacts…'**
  String get searchHint;

  /// No description provided for @clearSearchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearchTooltip;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(Object error);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @sharing.
  ///
  /// In en, this message translates to:
  /// **'Sharing'**
  String get sharing;

  /// No description provided for @defaultShareFields.
  ///
  /// In en, this message translates to:
  /// **'Default share fields'**
  String get defaultShareFields;

  /// No description provided for @defaultShareFieldsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, phones, emails, etc. for contact sharing'**
  String get defaultShareFieldsSubtitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @defaultQrCodeStyle.
  ///
  /// In en, this message translates to:
  /// **'Default QR code style'**
  String get defaultQrCodeStyle;

  /// No description provided for @defaultQrCodeStyleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Card colors, font, QR appearance'**
  String get defaultQrCodeStyleSubtitle;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get themeAuto;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @colorTheme.
  ///
  /// In en, this message translates to:
  /// **'Color theme'**
  String get colorTheme;

  /// No description provided for @autoOpenCardOnLaunch.
  ///
  /// In en, this message translates to:
  /// **'Auto-open card on launch'**
  String get autoOpenCardOnLaunch;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @cardNotFound.
  ///
  /// In en, this message translates to:
  /// **'Card not found'**
  String get cardNotFound;

  /// No description provided for @contactNotFoundOrDeleted.
  ///
  /// In en, this message translates to:
  /// **'Contact not found or was deleted.'**
  String get contactNotFoundOrDeleted;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @errorLoadingCards.
  ///
  /// In en, this message translates to:
  /// **'Error loading cards'**
  String get errorLoadingCards;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backup your settings and cards to a file you can share or save'**
  String get exportSubtitle;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @importSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore from a previously saved backup file'**
  String get importSubtitle;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @shareAppLink.
  ///
  /// In en, this message translates to:
  /// **'Share app link'**
  String get shareAppLink;

  /// No description provided for @shareAppLinkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'QR code to download the app'**
  String get shareAppLinkSubtitle;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// No description provided for @licenseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Copyrights, open-source licenses, source code'**
  String get licenseSubtitle;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @colorThemeDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get colorThemeDefault;

  /// No description provided for @colorThemeCustomLightDark.
  ///
  /// In en, this message translates to:
  /// **'Custom light & dark'**
  String get colorThemeCustomLightDark;

  /// No description provided for @colorThemeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom color'**
  String get colorThemeCustom;

  /// No description provided for @themeFollowSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get themeFollowSystem;

  /// No description provided for @themeLightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get themeLightMode;

  /// No description provided for @themeDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get themeDarkMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @useDefault.
  ///
  /// In en, this message translates to:
  /// **'Use default'**
  String get useDefault;

  /// No description provided for @useDefaultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Follow system or app default colors'**
  String get useDefaultSubtitle;

  /// No description provided for @useSameForBoth.
  ///
  /// In en, this message translates to:
  /// **'Use same for both'**
  String get useSameForBoth;

  /// No description provided for @useSameForBothSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Same color for light and dark mode'**
  String get useSameForBothSubtitle;

  /// No description provided for @chooseColor.
  ///
  /// In en, this message translates to:
  /// **'Choose color'**
  String get chooseColor;

  /// No description provided for @chooseColorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a custom color for the app theme'**
  String get chooseColorSubtitle;

  /// No description provided for @lightModeColor.
  ///
  /// In en, this message translates to:
  /// **'Light mode color'**
  String get lightModeColor;

  /// No description provided for @darkModeColor.
  ///
  /// In en, this message translates to:
  /// **'Dark mode color'**
  String get darkModeColor;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get exportBackup;

  /// No description provided for @exportAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Export app settings'**
  String get exportAppSettings;

  /// No description provided for @exportContactCards.
  ///
  /// In en, this message translates to:
  /// **'Export contact cards'**
  String get exportContactCards;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @exportReadyToShare.
  ///
  /// In en, this message translates to:
  /// **'Export ready to share'**
  String get exportReadyToShare;

  /// No description provided for @invalidBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Invalid backup file: {error}'**
  String invalidBackupFile(Object error);

  /// No description provided for @backupFileEmpty.
  ///
  /// In en, this message translates to:
  /// **'Backup file is empty'**
  String get backupFileEmpty;

  /// No description provided for @importFromBackup.
  ///
  /// In en, this message translates to:
  /// **'Import from backup'**
  String get importFromBackup;

  /// No description provided for @importSettings.
  ///
  /// In en, this message translates to:
  /// **'Import settings'**
  String get importSettings;

  /// No description provided for @importContactCards.
  ///
  /// In en, this message translates to:
  /// **'Import contact cards'**
  String get importContactCards;

  /// No description provided for @importCompleted.
  ///
  /// In en, this message translates to:
  /// **'Import completed'**
  String get importCompleted;

  /// No description provided for @defaultShareFieldsIntro.
  ///
  /// In en, this message translates to:
  /// **'When sharing a device contact, these fields are selected by default. You can change the selection per contact.'**
  String get defaultShareFieldsIntro;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldPhones.
  ///
  /// In en, this message translates to:
  /// **'Phones'**
  String get fieldPhones;

  /// No description provided for @fieldEmails.
  ///
  /// In en, this message translates to:
  /// **'Emails'**
  String get fieldEmails;

  /// No description provided for @fieldOrganization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get fieldOrganization;

  /// No description provided for @fieldAddresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get fieldAddresses;

  /// No description provided for @fieldWebsites.
  ///
  /// In en, this message translates to:
  /// **'Websites'**
  String get fieldWebsites;

  /// No description provided for @fieldSocialMedia.
  ///
  /// In en, this message translates to:
  /// **'Social media'**
  String get fieldSocialMedia;

  /// No description provided for @fieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get fieldNotes;

  /// No description provided for @previewYourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get previewYourName;

  /// No description provided for @previewYourInfo.
  ///
  /// In en, this message translates to:
  /// **'Your info'**
  String get previewYourInfo;

  /// No description provided for @selectAtLeastOneField.
  ///
  /// In en, this message translates to:
  /// **'Select at least one field to display the QR code.'**
  String get selectAtLeastOneField;

  /// No description provided for @shareContact.
  ///
  /// In en, this message translates to:
  /// **'Share contact'**
  String get shareContact;

  /// No description provided for @backTooltip.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backTooltip;

  /// No description provided for @noName.
  ///
  /// In en, this message translates to:
  /// **'(No name)'**
  String get noName;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @quickShare.
  ///
  /// In en, this message translates to:
  /// **'Quick Share'**
  String get quickShare;

  /// No description provided for @editContactCard.
  ///
  /// In en, this message translates to:
  /// **'Edit contact card'**
  String get editContactCard;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @shareAsImage.
  ///
  /// In en, this message translates to:
  /// **'Share as image'**
  String get shareAsImage;

  /// No description provided for @shareAsVCard.
  ///
  /// In en, this message translates to:
  /// **'Share as vCard'**
  String get shareAsVCard;

  /// No description provided for @viewQrDataAsText.
  ///
  /// In en, this message translates to:
  /// **'View QR code data as text'**
  String get viewQrDataAsText;

  /// No description provided for @openLink.
  ///
  /// In en, this message translates to:
  /// **'Open link'**
  String get openLink;

  /// No description provided for @qrCodeData.
  ///
  /// In en, this message translates to:
  /// **'QR code data'**
  String get qrCodeData;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @versionFormat.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionFormat(Object version);

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get sourceCode;

  /// No description provided for @viewOpenSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'View open-source licenses'**
  String get viewOpenSourceLicenses;

  /// No description provided for @licenseMplNotice.
  ///
  /// In en, this message translates to:
  /// **'This application is open-source software licensed under the Mozilla Public License 2.0 (MPL 2.0).'**
  String get licenseMplNotice;

  /// No description provided for @readMplLicense.
  ///
  /// In en, this message translates to:
  /// **'Read MPL 2.0'**
  String get readMplLicense;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link'**
  String get couldNotOpenLink;

  /// No description provided for @copyrightFormat.
  ///
  /// In en, this message translates to:
  /// **'© {year} {author}'**
  String copyrightFormat(Object year, Object author);

  /// No description provided for @deleteCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete card?'**
  String get deleteCardTitle;

  /// No description provided for @deleteCardMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? This cannot be undone.'**
  String deleteCardMessage(Object name);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @pleaseSpecifyLabelForCustom.
  ///
  /// In en, this message translates to:
  /// **'Please specify a label for Custom'**
  String get pleaseSpecifyLabelForCustom;

  /// No description provided for @cardNeedsData.
  ///
  /// In en, this message translates to:
  /// **'The card needs at least one field with data (e.g. name, phone, email). The card name alone is not included in the vCard.'**
  String get cardNeedsData;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String saveFailed(Object error);

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @discardChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardChangesTitle;

  /// No description provided for @discardChangesMessage.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Save this card before closing?'**
  String get discardChangesMessage;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @editCard.
  ///
  /// In en, this message translates to:
  /// **'Edit card'**
  String get editCard;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @qrCodeStyle.
  ///
  /// In en, this message translates to:
  /// **'QR code style'**
  String get qrCodeStyle;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @backgroundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill behind QR modules'**
  String get backgroundSubtitle;

  /// No description provided for @quietZone.
  ///
  /// In en, this message translates to:
  /// **'Quiet zone'**
  String get quietZone;

  /// No description provided for @quietZoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'White border around QR code'**
  String get quietZoneSubtitle;

  /// No description provided for @qrShapeSmooth.
  ///
  /// In en, this message translates to:
  /// **'Smooth'**
  String get qrShapeSmooth;

  /// No description provided for @qrShapeSquares.
  ///
  /// In en, this message translates to:
  /// **'Squares'**
  String get qrShapeSquares;

  /// No description provided for @qrShapeDots.
  ///
  /// In en, this message translates to:
  /// **'Dots'**
  String get qrShapeDots;

  /// No description provided for @roundedCorners.
  ///
  /// In en, this message translates to:
  /// **'Rounded corners'**
  String get roundedCorners;

  /// No description provided for @roundedCornersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Softer QR module appearance'**
  String get roundedCornersSubtitle;

  /// No description provided for @embedded.
  ///
  /// In en, this message translates to:
  /// **'Embedded'**
  String get embedded;

  /// No description provided for @foreground.
  ///
  /// In en, this message translates to:
  /// **'Foreground'**
  String get foreground;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @cardNameHint.
  ///
  /// In en, this message translates to:
  /// **'For sorting and quick identification'**
  String get cardNameHint;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @phoneNumbers.
  ///
  /// In en, this message translates to:
  /// **'Phone numbers'**
  String get phoneNumbers;

  /// No description provided for @emailAddresses.
  ///
  /// In en, this message translates to:
  /// **'Email addresses'**
  String get emailAddresses;

  /// No description provided for @urls.
  ///
  /// In en, this message translates to:
  /// **'URLs'**
  String get urls;

  /// No description provided for @socialMedia.
  ///
  /// In en, this message translates to:
  /// **'Social media'**
  String get socialMedia;

  /// No description provided for @addresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses;

  /// No description provided for @backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background color'**
  String get backgroundColor;

  /// No description provided for @textColor.
  ///
  /// In en, this message translates to:
  /// **'Text color'**
  String get textColor;

  /// No description provided for @imageOrLogo.
  ///
  /// In en, this message translates to:
  /// **'Image or logo'**
  String get imageOrLogo;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get style;

  /// No description provided for @logoPosition.
  ///
  /// In en, this message translates to:
  /// **'Logo position'**
  String get logoPosition;

  /// No description provided for @qrCenterImage.
  ///
  /// In en, this message translates to:
  /// **'QR Center Image'**
  String get qrCenterImage;

  /// No description provided for @phoneLabelMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get phoneLabelMobile;

  /// No description provided for @phoneLabelWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get phoneLabelWork;

  /// No description provided for @phoneLabelHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get phoneLabelHome;

  /// No description provided for @phoneLabelMain.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get phoneLabelMain;

  /// No description provided for @phoneLabelOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get phoneLabelOther;

  /// No description provided for @phoneLabelCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get phoneLabelCustom;

  /// No description provided for @emailLabelHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get emailLabelHome;

  /// No description provided for @emailLabelWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get emailLabelWork;

  /// No description provided for @emailLabelOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get emailLabelOther;

  /// No description provided for @emailLabelCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get emailLabelCustom;

  /// No description provided for @addressLabelHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get addressLabelHome;

  /// No description provided for @addressLabelWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get addressLabelWork;

  /// No description provided for @addressLabelOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get addressLabelOther;

  /// No description provided for @addressLabelCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get addressLabelCustom;

  /// No description provided for @socialLabelOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get socialLabelOther;

  /// No description provided for @socialLabelCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get socialLabelCustom;

  /// No description provided for @unknownPlatformIndicatorTooltip.
  ///
  /// In en, this message translates to:
  /// **'Limited support'**
  String get unknownPlatformIndicatorTooltip;

  /// No description provided for @unknownPlatformDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Unknown platform'**
  String get unknownPlatformDialogTitle;

  /// No description provided for @unknownPlatformDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This platform is not in our list. It will be saved as a custom property (X-SOCIALPROFILE) in the QR code, not as a clickable link. Custom properties are not well supported by all apps and devices.'**
  String get unknownPlatformDialogMessage;

  /// No description provided for @colorPickerPalette.
  ///
  /// In en, this message translates to:
  /// **'Palette'**
  String get colorPickerPalette;

  /// No description provided for @colorPickerPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get colorPickerPrimary;

  /// No description provided for @colorPickerAccent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get colorPickerAccent;

  /// No description provided for @colorPickerBW.
  ///
  /// In en, this message translates to:
  /// **'B & W'**
  String get colorPickerBW;

  /// No description provided for @colorPickerCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get colorPickerCustom;

  /// No description provided for @colorPickerOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get colorPickerOptions;

  /// No description provided for @colorPickerWheel.
  ///
  /// In en, this message translates to:
  /// **'Wheel'**
  String get colorPickerWheel;

  /// No description provided for @colorPickerColorShade.
  ///
  /// In en, this message translates to:
  /// **'Color shade'**
  String get colorPickerColorShade;

  /// No description provided for @colorPickerTonalPalette.
  ///
  /// In en, this message translates to:
  /// **'Material 3 tonal palette'**
  String get colorPickerTonalPalette;

  /// No description provided for @colorPickerSelectedColorShades.
  ///
  /// In en, this message translates to:
  /// **'Selected color and its shades'**
  String get colorPickerSelectedColorShades;

  /// No description provided for @colorPickerOpacity.
  ///
  /// In en, this message translates to:
  /// **'Opacity'**
  String get colorPickerOpacity;

  /// No description provided for @colorPickerRecentColors.
  ///
  /// In en, this message translates to:
  /// **'Recent colors'**
  String get colorPickerRecentColors;

  /// No description provided for @colorPickerDarkNavy.
  ///
  /// In en, this message translates to:
  /// **'Dark navy'**
  String get colorPickerDarkNavy;

  /// No description provided for @colorPickerNavy.
  ///
  /// In en, this message translates to:
  /// **'Navy'**
  String get colorPickerNavy;

  /// No description provided for @colorPickerBlueGrey.
  ///
  /// In en, this message translates to:
  /// **'Blue grey'**
  String get colorPickerBlueGrey;

  /// No description provided for @colorPickerAccentRed.
  ///
  /// In en, this message translates to:
  /// **'Accent red'**
  String get colorPickerAccentRed;

  /// No description provided for @colorPickerPurple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get colorPickerPurple;

  /// No description provided for @honorificPrefix.
  ///
  /// In en, this message translates to:
  /// **'Honorific prefix'**
  String get honorificPrefix;

  /// No description provided for @additionalNames.
  ///
  /// In en, this message translates to:
  /// **'Additional names'**
  String get additionalNames;

  /// No description provided for @honorificSuffix.
  ///
  /// In en, this message translates to:
  /// **'Honorific suffix'**
  String get honorificSuffix;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @jobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job title'**
  String get jobTitle;

  /// No description provided for @companyUnit.
  ///
  /// In en, this message translates to:
  /// **'Company unit'**
  String get companyUnit;

  /// No description provided for @addJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Add job title'**
  String get addJobTitle;

  /// No description provided for @addCompanyUnit.
  ///
  /// In en, this message translates to:
  /// **'Add company unit'**
  String get addCompanyUnit;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone label'**
  String get phoneLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email label'**
  String get emailLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address label'**
  String get addressLabel;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @addPhone.
  ///
  /// In en, this message translates to:
  /// **'Add phone'**
  String get addPhone;

  /// No description provided for @addEmail.
  ///
  /// In en, this message translates to:
  /// **'Add email'**
  String get addEmail;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @addUrl.
  ///
  /// In en, this message translates to:
  /// **'Add URL'**
  String get addUrl;

  /// No description provided for @platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get platform;

  /// No description provided for @customPlatform.
  ///
  /// In en, this message translates to:
  /// **'Custom platform'**
  String get customPlatform;

  /// No description provided for @platformName.
  ///
  /// In en, this message translates to:
  /// **'Platform name'**
  String get platformName;

  /// No description provided for @platformNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Mastodon, Bluesky'**
  String get platformNameHint;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @addSocialMedia.
  ///
  /// In en, this message translates to:
  /// **'Add social media'**
  String get addSocialMedia;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddress;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @removeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeTooltip;

  /// No description provided for @cardName.
  ///
  /// In en, this message translates to:
  /// **'Card name'**
  String get cardName;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @appearanceImageInputTooLarge.
  ///
  /// In en, this message translates to:
  /// **'This image is too large. Use a file under 16 MB.'**
  String get appearanceImageInputTooLarge;

  /// No description provided for @appearanceImageCouldNotProcess.
  ///
  /// In en, this message translates to:
  /// **'Could not use this image. Try another PNG or JPEG.'**
  String get appearanceImageCouldNotProcess;

  /// No description provided for @deleteCard.
  ///
  /// In en, this message translates to:
  /// **'Delete card'**
  String get deleteCard;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
    'pl',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
