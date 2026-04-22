// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'Keine passenden Kontakte';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'Visitenkarten konnten nicht geladen werden: $error';
  }

  @override
  String get contactPermissionRequired =>
      'Kontakte-Berechtigung ist erforderlich, um deine Kontakte anzuzeigen.';

  @override
  String get noCardsYet =>
      'Noch keine Karten.\nFüge deine erste Visitenkarte hinzu.';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get addBusinessCard => 'Visitenkarte hinzufügen';

  @override
  String get newBusinessCardTooltip => 'Neue Visitenkarte';

  @override
  String get searchHint => 'Karten oder Kontakte suchen…';

  @override
  String get clearSearchTooltip => 'Suche löschen';

  @override
  String errorGeneric(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get settings => 'Einstellungen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get sharing => 'Teilen';

  @override
  String get defaultShareFields => 'Standardfelder beim Teilen';

  @override
  String get defaultShareFieldsSubtitle =>
      'Name, Telefonnummern, E-Mails usw. beim Kontakt-Teilen';

  @override
  String get appearance => 'Darstellung';

  @override
  String get defaultQrCodeStyle => 'Standard-QR-Code-Stil';

  @override
  String get defaultQrCodeStyleSubtitle =>
      'Kartenfarben, Schrift, QR-Erscheinungsbild';

  @override
  String get application => 'Anwendung';

  @override
  String get language => 'Sprache';

  @override
  String get theme => 'Design';

  @override
  String get themeAuto => 'Automatisch';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get colorTheme => 'Farbschema';

  @override
  String get autoOpenCardOnLaunch => 'Karte beim Start öffnen';

  @override
  String get none => 'Keine';

  @override
  String get cardNotFound => 'Karte nicht gefunden';

  @override
  String get contactNotFoundOrDeleted =>
      'Kontakt nicht gefunden oder gelöscht.';

  @override
  String get loading => 'Wird geladen…';

  @override
  String get errorLoadingCards => 'Fehler beim Laden der Karten';

  @override
  String get backup => 'Sicherung';

  @override
  String get export => 'Exportieren';

  @override
  String get exportSubtitle =>
      'Einstellungen und Karten in einer Datei sichern, die du teilen oder speichern kannst';

  @override
  String get import => 'Importieren';

  @override
  String get importSubtitle =>
      'Aus einer zuvor gespeicherten Sicherungsdatei wiederherstellen';

  @override
  String get about => 'Info';

  @override
  String get shareAppLink => 'App-Link teilen';

  @override
  String get shareAppLinkSubtitle => 'QR-Code zum Herunterladen der App';

  @override
  String get license => 'Lizenz';

  @override
  String get licenseSubtitle =>
      'Urheberrechte, Open-Source-Lizenzen, Quellcode';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get colorThemeDefault => 'Standard';

  @override
  String get colorThemeCustomLightDark => 'Benutzerdefiniert hell und dunkel';

  @override
  String get colorThemeCustom => 'Benutzerdefinierte Farbe';

  @override
  String get themeFollowSystem => 'System folgen';

  @override
  String get themeLightMode => 'Heller Modus';

  @override
  String get themeDarkMode => 'Dunkler Modus';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get useDefault => 'Standard verwenden';

  @override
  String get useDefaultSubtitle => 'System- oder App-Standardfarben verwenden';

  @override
  String get useSameForBoth => 'Gleiche für beide';

  @override
  String get useSameForBothSubtitle =>
      'Gleiche Farbe für hellen und dunklen Modus';

  @override
  String get chooseColor => 'Farbe wählen';

  @override
  String get chooseColorSubtitle =>
      'Eine benutzerdefinierte Farbe für das App-Design wählen';

  @override
  String get lightModeColor => 'Farbe im hellen Modus';

  @override
  String get darkModeColor => 'Farbe im dunklen Modus';

  @override
  String get exportBackup => 'Sicherung exportieren';

  @override
  String get exportAppSettings => 'App-Einstellungen exportieren';

  @override
  String get exportContactCards => 'Visitenkarten exportieren';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get exportReadyToShare => 'Export zum Teilen bereit';

  @override
  String invalidBackupFile(Object error) {
    return 'Ungültige Sicherungsdatei: $error';
  }

  @override
  String get backupFileEmpty => 'Sicherungsdatei ist leer';

  @override
  String get importFromBackup => 'Aus Sicherung importieren';

  @override
  String get importSettings => 'Einstellungen importieren';

  @override
  String get importContactCards => 'Visitenkarten importieren';

  @override
  String get importCompleted => 'Import abgeschlossen';

  @override
  String get defaultShareFieldsIntro =>
      'Beim Teilen eines Gerätekontakts sind diese Felder standardmäßig ausgewählt. Du kannst die Auswahl pro Kontakt ändern.';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldPhones => 'Telefone';

  @override
  String get fieldEmails => 'E-Mails';

  @override
  String get fieldOrganization => 'Organisation';

  @override
  String get fieldAddresses => 'Adressen';

  @override
  String get fieldWebsites => 'Websites';

  @override
  String get fieldSocialMedia => 'Soziale Medien';

  @override
  String get fieldNotes => 'Notizen';

  @override
  String get previewYourName => 'Dein Name';

  @override
  String get previewYourInfo => 'Deine Infos';

  @override
  String get selectAtLeastOneField =>
      'Wähle mindestens ein Feld, um den QR-Code anzuzeigen.';

  @override
  String get shareContact => 'Kontakt teilen';

  @override
  String get backTooltip => 'Zurück';

  @override
  String get noName => '(Ohne Namen)';

  @override
  String get done => 'Fertig';

  @override
  String get quickShare => 'Schnell teilen';

  @override
  String get editContactCard => 'Visitenkarte bearbeiten';

  @override
  String get close => 'Schließen';

  @override
  String get shareAsImage => 'Als Bild teilen';

  @override
  String get shareAsVCard => 'Als vCard teilen';

  @override
  String get viewQrDataAsText => 'QR-Code-Daten als Text anzeigen';

  @override
  String get openLink => 'Link öffnen';

  @override
  String get qrCodeData => 'QR-Code-Daten';

  @override
  String get copiedToClipboard => 'In die Zwischenablage kopiert';

  @override
  String get copy => 'Kopieren';

  @override
  String versionFormat(Object version) {
    return 'Version $version';
  }

  @override
  String get sourceCode => 'Quellcode';

  @override
  String get viewOpenSourceLicenses => 'Open-Source-Lizenzen anzeigen';

  @override
  String get licenseMplNotice =>
      'Diese Anwendung ist Open-Source-Software unter der Mozilla Public License 2.0 (MPL 2.0) lizenziert.';

  @override
  String get readMplLicense => 'MPL 2.0 lesen';

  @override
  String get couldNotOpenLink => 'Link konnte nicht geöffnet werden';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => 'Karte löschen?';

  @override
  String deleteCardMessage(Object name) {
    return '„$name“ löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get delete => 'Löschen';

  @override
  String get pleaseSpecifyLabelForCustom =>
      'Bitte eine Bezeichnung für „Benutzerdefiniert“ angeben';

  @override
  String get cardNeedsData =>
      'Die Karte braucht mindestens ein Feld mit Daten (z. B. Name, Telefon, E-Mail). Der Kartenname allein wird nicht in die vCard übernommen.';

  @override
  String saveFailed(Object error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get details => 'Details';

  @override
  String get discardChangesTitle => 'Änderungen verwerfen?';

  @override
  String get discardChangesMessage =>
      'Du hast ungespeicherte Änderungen. Diese Karte vor dem Schließen speichern?';

  @override
  String get discard => 'Verwerfen';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get data => 'Daten';

  @override
  String get save => 'Speichern';

  @override
  String get error => 'Fehler';

  @override
  String get editCard => 'Karte bearbeiten';

  @override
  String get ok => 'OK';

  @override
  String get preview => 'Vorschau';

  @override
  String get card => 'Karte';

  @override
  String get qrCodeStyle => 'QR-Code-Stil';

  @override
  String get background => 'Hintergrund';

  @override
  String get backgroundSubtitle => 'Fläche hinter den QR-Modulen';

  @override
  String get quietZone => 'Ruhezone';

  @override
  String get quietZoneSubtitle => 'Weißer Rand um den QR-Code';

  @override
  String get qrShapeSmooth => 'Weich';

  @override
  String get qrShapeSquares => 'Quadrate';

  @override
  String get qrShapeDots => 'Punkte';

  @override
  String get roundedCorners => 'Abgerundete Ecken';

  @override
  String get roundedCornersSubtitle =>
      'Weicheres Erscheinungsbild der QR-Module';

  @override
  String get embedded => 'Eingebettet';

  @override
  String get foreground => 'Vordergrund';

  @override
  String get remove => 'Entfernen';

  @override
  String get cardNameHint => 'Zum Sortieren und schnellen Erkennen';

  @override
  String get company => 'Firma';

  @override
  String get phoneNumbers => 'Telefonnummern';

  @override
  String get emailAddresses => 'E-Mail-Adressen';

  @override
  String get urls => 'URLs';

  @override
  String get socialMedia => 'Soziale Medien';

  @override
  String get addresses => 'Adressen';

  @override
  String get backgroundColor => 'Hintergrundfarbe';

  @override
  String get textColor => 'Textfarbe';

  @override
  String get imageOrLogo => 'Bild oder Logo';

  @override
  String get color => 'Farbe';

  @override
  String get style => 'Stil';

  @override
  String get logoPosition => 'Logo-Position';

  @override
  String get qrCenterImage => 'QR-Mittelbild';

  @override
  String get phoneLabelMobile => 'Mobil';

  @override
  String get phoneLabelWork => 'Arbeit';

  @override
  String get phoneLabelHome => 'Privat';

  @override
  String get phoneLabelMain => 'Haupt';

  @override
  String get phoneLabelOther => 'Sonstige';

  @override
  String get phoneLabelCustom => 'Benutzerdefiniert';

  @override
  String get emailLabelHome => 'Privat';

  @override
  String get emailLabelWork => 'Arbeit';

  @override
  String get emailLabelOther => 'Sonstige';

  @override
  String get emailLabelCustom => 'Benutzerdefiniert';

  @override
  String get addressLabelHome => 'Privat';

  @override
  String get addressLabelWork => 'Arbeit';

  @override
  String get addressLabelOther => 'Sonstige';

  @override
  String get addressLabelCustom => 'Benutzerdefiniert';

  @override
  String get socialLabelOther => 'Sonstige';

  @override
  String get socialLabelCustom => 'Benutzerdefiniert';

  @override
  String get unknownPlatformIndicatorTooltip => 'Eingeschränkte Unterstützung';

  @override
  String get unknownPlatformDialogTitle => 'Unbekannte Plattform';

  @override
  String get unknownPlatformDialogMessage =>
      'Diese Plattform steht nicht auf unserer Liste. Sie wird als benutzerdefinierte Eigenschaft (X-SOCIALPROFILE) im QR-Code gespeichert, nicht als anklickbarer Link. Benutzerdefinierte Eigenschaften werden nicht von allen Apps und Geräten gut unterstützt.';

  @override
  String get colorPickerPalette => 'Palette';

  @override
  String get colorPickerPrimary => 'Primär';

  @override
  String get colorPickerAccent => 'Akzent';

  @override
  String get colorPickerBW => 'S/W';

  @override
  String get colorPickerCustom => 'Benutzerdefiniert';

  @override
  String get colorPickerOptions => 'Optionen';

  @override
  String get colorPickerWheel => 'Farbkreis';

  @override
  String get colorPickerColorShade => 'Farbton';

  @override
  String get colorPickerTonalPalette => 'Material-3-Tonpalette';

  @override
  String get colorPickerSelectedColorShades => 'Gewählte Farbe und Abstufungen';

  @override
  String get colorPickerOpacity => 'Deckkraft';

  @override
  String get colorPickerRecentColors => 'Zuletzt verwendet';

  @override
  String get colorPickerDarkNavy => 'Dunkles Marineblau';

  @override
  String get colorPickerNavy => 'Marineblau';

  @override
  String get colorPickerBlueGrey => 'Blaugrau';

  @override
  String get colorPickerAccentRed => 'Akzentrot';

  @override
  String get colorPickerPurple => 'Violett';

  @override
  String get honorificPrefix => 'Namenspräfix';

  @override
  String get additionalNames => 'Weitere Namen';

  @override
  String get honorificSuffix => 'Namenszusatz';

  @override
  String get nickname => 'Spitzname';

  @override
  String get firstName => 'Vorname';

  @override
  String get lastName => 'Nachname';

  @override
  String get organization => 'Organisation';

  @override
  String get jobTitle => 'Berufsbezeichnung';

  @override
  String get companyUnit => 'Unternehmensbereich';

  @override
  String get addJobTitle => 'Berufsbezeichnung hinzufügen';

  @override
  String get addCompanyUnit => 'Bereich hinzufügen';

  @override
  String get label => 'Bezeichnung';

  @override
  String get phoneLabel => 'Telefon-Bezeichnung';

  @override
  String get emailLabel => 'E-Mail-Bezeichnung';

  @override
  String get addressLabel => 'Adress-Bezeichnung';

  @override
  String get phone => 'Telefon';

  @override
  String get email => 'E-Mail';

  @override
  String get addPhone => 'Telefon hinzufügen';

  @override
  String get addEmail => 'E-Mail hinzufügen';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'URL hinzufügen';

  @override
  String get platform => 'Plattform';

  @override
  String get customPlatform => 'Eigene Plattform';

  @override
  String get platformName => 'Plattformname';

  @override
  String get platformNameHint => 'z. B. Mastodon, Bluesky';

  @override
  String get username => 'Benutzername';

  @override
  String get addSocialMedia => 'Soziales Netzwerk hinzufügen';

  @override
  String get addAddress => 'Adresse hinzufügen';

  @override
  String get address => 'Adresse';

  @override
  String get removeTooltip => 'Entfernen';

  @override
  String get cardName => 'Kartenname';

  @override
  String get birthday => 'Geburtstag';

  @override
  String get notes => 'Notizen';

  @override
  String get appearanceImageInputTooLarge =>
      'Dieses Bild ist zu groß. Verwende eine Datei unter 16 MB.';

  @override
  String get appearanceImageCouldNotProcess =>
      'Dieses Bild konnte nicht verwendet werden. Versuche eine andere PNG- oder JPEG-Datei.';

  @override
  String get deleteCard => 'Karte löschen';
}
