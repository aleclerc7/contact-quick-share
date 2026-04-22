// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'No matching contacts';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'Could not load business cards: $error';
  }

  @override
  String get contactPermissionRequired =>
      'Contact permission is required to display your contacts.';

  @override
  String get noCardsYet => 'No cards yet.\nAdd your first business card.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get addBusinessCard => 'Add business card';

  @override
  String get newBusinessCardTooltip => 'New Business Card';

  @override
  String get searchHint => 'Search cards or contacts…';

  @override
  String get clearSearchTooltip => 'Clear search';

  @override
  String errorGeneric(Object error) {
    return 'Error: $error';
  }

  @override
  String get settings => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sharing => 'Sharing';

  @override
  String get defaultShareFields => 'Default share fields';

  @override
  String get defaultShareFieldsSubtitle =>
      'Name, phones, emails, etc. for contact sharing';

  @override
  String get appearance => 'Appearance';

  @override
  String get defaultQrCodeStyle => 'Default QR code style';

  @override
  String get defaultQrCodeStyleSubtitle => 'Card colors, font, QR appearance';

  @override
  String get application => 'Application';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get colorTheme => 'Color theme';

  @override
  String get autoOpenCardOnLaunch => 'Auto-open card on launch';

  @override
  String get none => 'None';

  @override
  String get cardNotFound => 'Card not found';

  @override
  String get contactNotFoundOrDeleted => 'Contact not found or was deleted.';

  @override
  String get loading => 'Loading…';

  @override
  String get errorLoadingCards => 'Error loading cards';

  @override
  String get backup => 'Backup';

  @override
  String get export => 'Export';

  @override
  String get exportSubtitle =>
      'Backup your settings and cards to a file you can share or save';

  @override
  String get import => 'Import';

  @override
  String get importSubtitle => 'Restore from a previously saved backup file';

  @override
  String get about => 'About';

  @override
  String get shareAppLink => 'Share app link';

  @override
  String get shareAppLinkSubtitle => 'QR code to download the app';

  @override
  String get license => 'License';

  @override
  String get licenseSubtitle => 'Copyrights, open-source licenses, source code';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get colorThemeDefault => 'Default';

  @override
  String get colorThemeCustomLightDark => 'Custom light & dark';

  @override
  String get colorThemeCustom => 'Custom color';

  @override
  String get themeFollowSystem => 'Follow system';

  @override
  String get themeLightMode => 'Light mode';

  @override
  String get themeDarkMode => 'Dark mode';

  @override
  String get systemDefault => 'System default';

  @override
  String get useDefault => 'Use default';

  @override
  String get useDefaultSubtitle => 'Follow system or app default colors';

  @override
  String get useSameForBoth => 'Use same for both';

  @override
  String get useSameForBothSubtitle => 'Same color for light and dark mode';

  @override
  String get chooseColor => 'Choose color';

  @override
  String get chooseColorSubtitle => 'Pick a custom color for the app theme';

  @override
  String get lightModeColor => 'Light mode color';

  @override
  String get darkModeColor => 'Dark mode color';

  @override
  String get exportBackup => 'Export backup';

  @override
  String get exportAppSettings => 'Export app settings';

  @override
  String get exportContactCards => 'Export contact cards';

  @override
  String get cancel => 'Cancel';

  @override
  String get exportReadyToShare => 'Export ready to share';

  @override
  String invalidBackupFile(Object error) {
    return 'Invalid backup file: $error';
  }

  @override
  String get backupFileEmpty => 'Backup file is empty';

  @override
  String get importFromBackup => 'Import from backup';

  @override
  String get importSettings => 'Import settings';

  @override
  String get importContactCards => 'Import contact cards';

  @override
  String get importCompleted => 'Import completed';

  @override
  String get defaultShareFieldsIntro =>
      'When sharing a device contact, these fields are selected by default. You can change the selection per contact.';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldPhones => 'Phones';

  @override
  String get fieldEmails => 'Emails';

  @override
  String get fieldOrganization => 'Organization';

  @override
  String get fieldAddresses => 'Addresses';

  @override
  String get fieldWebsites => 'Websites';

  @override
  String get fieldSocialMedia => 'Social media';

  @override
  String get fieldNotes => 'Notes';

  @override
  String get previewYourName => 'Your Name';

  @override
  String get previewYourInfo => 'Your info';

  @override
  String get selectAtLeastOneField =>
      'Select at least one field to display the QR code.';

  @override
  String get shareContact => 'Share contact';

  @override
  String get backTooltip => 'Back';

  @override
  String get noName => '(No name)';

  @override
  String get done => 'Done';

  @override
  String get quickShare => 'Quick Share';

  @override
  String get editContactCard => 'Edit contact card';

  @override
  String get close => 'Close';

  @override
  String get shareAsImage => 'Share as image';

  @override
  String get shareAsVCard => 'Share as vCard';

  @override
  String get viewQrDataAsText => 'View QR code data as text';

  @override
  String get openLink => 'Open link';

  @override
  String get qrCodeData => 'QR code data';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get copy => 'Copy';

  @override
  String versionFormat(Object version) {
    return 'Version $version';
  }

  @override
  String get sourceCode => 'Source code';

  @override
  String get viewOpenSourceLicenses => 'View open-source licenses';

  @override
  String get licenseMplNotice =>
      'This application is open-source software licensed under the Mozilla Public License 2.0 (MPL 2.0).';

  @override
  String get readMplLicense => 'Read MPL 2.0';

  @override
  String get couldNotOpenLink => 'Could not open link';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => 'Delete card?';

  @override
  String deleteCardMessage(Object name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get pleaseSpecifyLabelForCustom => 'Please specify a label for Custom';

  @override
  String get cardNeedsData =>
      'The card needs at least one field with data (e.g. name, phone, email). The card name alone is not included in the vCard.';

  @override
  String saveFailed(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get details => 'Details';

  @override
  String get discardChangesTitle => 'Discard changes?';

  @override
  String get discardChangesMessage =>
      'You have unsaved changes. Save this card before closing?';

  @override
  String get discard => 'Discard';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get data => 'Data';

  @override
  String get save => 'Save';

  @override
  String get error => 'Error';

  @override
  String get editCard => 'Edit card';

  @override
  String get ok => 'OK';

  @override
  String get preview => 'Preview';

  @override
  String get card => 'Card';

  @override
  String get qrCodeStyle => 'QR code style';

  @override
  String get background => 'Background';

  @override
  String get backgroundSubtitle => 'Fill behind QR modules';

  @override
  String get quietZone => 'Quiet zone';

  @override
  String get quietZoneSubtitle => 'White border around QR code';

  @override
  String get qrShapeSmooth => 'Smooth';

  @override
  String get qrShapeSquares => 'Squares';

  @override
  String get qrShapeDots => 'Dots';

  @override
  String get roundedCorners => 'Rounded corners';

  @override
  String get roundedCornersSubtitle => 'Softer QR module appearance';

  @override
  String get embedded => 'Embedded';

  @override
  String get foreground => 'Foreground';

  @override
  String get remove => 'Remove';

  @override
  String get cardNameHint => 'For sorting and quick identification';

  @override
  String get company => 'Company';

  @override
  String get phoneNumbers => 'Phone numbers';

  @override
  String get emailAddresses => 'Email addresses';

  @override
  String get urls => 'URLs';

  @override
  String get socialMedia => 'Social media';

  @override
  String get addresses => 'Addresses';

  @override
  String get backgroundColor => 'Background color';

  @override
  String get textColor => 'Text color';

  @override
  String get imageOrLogo => 'Image or logo';

  @override
  String get color => 'Color';

  @override
  String get style => 'Style';

  @override
  String get logoPosition => 'Logo position';

  @override
  String get qrCenterImage => 'QR Center Image';

  @override
  String get phoneLabelMobile => 'Mobile';

  @override
  String get phoneLabelWork => 'Work';

  @override
  String get phoneLabelHome => 'Home';

  @override
  String get phoneLabelMain => 'Main';

  @override
  String get phoneLabelOther => 'Other';

  @override
  String get phoneLabelCustom => 'Custom';

  @override
  String get emailLabelHome => 'Home';

  @override
  String get emailLabelWork => 'Work';

  @override
  String get emailLabelOther => 'Other';

  @override
  String get emailLabelCustom => 'Custom';

  @override
  String get addressLabelHome => 'Home';

  @override
  String get addressLabelWork => 'Work';

  @override
  String get addressLabelOther => 'Other';

  @override
  String get addressLabelCustom => 'Custom';

  @override
  String get socialLabelOther => 'Other';

  @override
  String get socialLabelCustom => 'Custom';

  @override
  String get unknownPlatformIndicatorTooltip => 'Limited support';

  @override
  String get unknownPlatformDialogTitle => 'Unknown platform';

  @override
  String get unknownPlatformDialogMessage =>
      'This platform is not in our list. It will be saved as a custom property (X-SOCIALPROFILE) in the QR code, not as a clickable link. Custom properties are not well supported by all apps and devices.';

  @override
  String get colorPickerPalette => 'Palette';

  @override
  String get colorPickerPrimary => 'Primary';

  @override
  String get colorPickerAccent => 'Accent';

  @override
  String get colorPickerBW => 'B & W';

  @override
  String get colorPickerCustom => 'Custom';

  @override
  String get colorPickerOptions => 'Options';

  @override
  String get colorPickerWheel => 'Wheel';

  @override
  String get colorPickerColorShade => 'Color shade';

  @override
  String get colorPickerTonalPalette => 'Material 3 tonal palette';

  @override
  String get colorPickerSelectedColorShades => 'Selected color and its shades';

  @override
  String get colorPickerOpacity => 'Opacity';

  @override
  String get colorPickerRecentColors => 'Recent colors';

  @override
  String get colorPickerDarkNavy => 'Dark navy';

  @override
  String get colorPickerNavy => 'Navy';

  @override
  String get colorPickerBlueGrey => 'Blue grey';

  @override
  String get colorPickerAccentRed => 'Accent red';

  @override
  String get colorPickerPurple => 'Purple';

  @override
  String get honorificPrefix => 'Honorific prefix';

  @override
  String get additionalNames => 'Additional names';

  @override
  String get honorificSuffix => 'Honorific suffix';

  @override
  String get nickname => 'Nickname';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get organization => 'Organization';

  @override
  String get jobTitle => 'Job title';

  @override
  String get companyUnit => 'Company unit';

  @override
  String get addJobTitle => 'Add job title';

  @override
  String get addCompanyUnit => 'Add company unit';

  @override
  String get label => 'Label';

  @override
  String get phoneLabel => 'Phone label';

  @override
  String get emailLabel => 'Email label';

  @override
  String get addressLabel => 'Address label';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get addPhone => 'Add phone';

  @override
  String get addEmail => 'Add email';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'Add URL';

  @override
  String get platform => 'Platform';

  @override
  String get customPlatform => 'Custom platform';

  @override
  String get platformName => 'Platform name';

  @override
  String get platformNameHint => 'e.g. Mastodon, Bluesky';

  @override
  String get username => 'Username';

  @override
  String get addSocialMedia => 'Add social media';

  @override
  String get addAddress => 'Add address';

  @override
  String get address => 'Address';

  @override
  String get removeTooltip => 'Remove';

  @override
  String get cardName => 'Card name';

  @override
  String get birthday => 'Birthday';

  @override
  String get notes => 'Notes';

  @override
  String get appearanceImageInputTooLarge =>
      'This image is too large. Use a file under 16 MB.';

  @override
  String get appearanceImageCouldNotProcess =>
      'Could not use this image. Try another PNG or JPEG.';

  @override
  String get deleteCard => 'Delete card';
}
