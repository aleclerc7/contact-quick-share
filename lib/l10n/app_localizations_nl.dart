// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'Geen overeenkomende contacten';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'Visitekaartjes konden niet worden geladen: $error';
  }

  @override
  String get contactPermissionRequired =>
      'Contacttoestemming is nodig om je contacten te tonen.';

  @override
  String get noCardsYet =>
      'Nog geen kaarten.\nVoeg je eerste visitekaartje toe.';

  @override
  String get openSettings => 'Instellingen openen';

  @override
  String get addBusinessCard => 'Visitekaartje toevoegen';

  @override
  String get newBusinessCardTooltip => 'Nieuw visitekaartje';

  @override
  String get searchHint => 'Zoek kaarten of contacten…';

  @override
  String get clearSearchTooltip => 'Zoekopdracht wissen';

  @override
  String errorGeneric(Object error) {
    return 'Fout: $error';
  }

  @override
  String get settings => 'Instellingen';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get sharing => 'Delen';

  @override
  String get defaultShareFields => 'Standaardvelden bij delen';

  @override
  String get defaultShareFieldsSubtitle =>
      'Naam, telefoons, e-mail enz. bij contact delen';

  @override
  String get appearance => 'Uiterlijk';

  @override
  String get defaultQrCodeStyle => 'Standaard QR-stijl';

  @override
  String get defaultQrCodeStyleSubtitle =>
      'Kaartkleuren, lettertype, QR-weergave';

  @override
  String get application => 'Applicatie';

  @override
  String get language => 'Taal';

  @override
  String get theme => 'Thema';

  @override
  String get themeAuto => 'Automatisch';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get colorTheme => 'Kleurthema';

  @override
  String get autoOpenCardOnLaunch => 'Kaart openen bij start';

  @override
  String get none => 'Geen';

  @override
  String get cardNotFound => 'Kaart niet gevonden';

  @override
  String get contactNotFoundOrDeleted => 'Contact niet gevonden of verwijderd.';

  @override
  String get loading => 'Laden…';

  @override
  String get errorLoadingCards => 'Fout bij laden van kaarten';

  @override
  String get backup => 'Back-up';

  @override
  String get export => 'Exporteren';

  @override
  String get exportSubtitle =>
      'Back-up van je instellingen en kaarten naar een bestand om te delen of op te slaan';

  @override
  String get import => 'Importeren';

  @override
  String get importSubtitle =>
      'Herstellen vanuit een eerder opgeslagen back-upbestand';

  @override
  String get about => 'Over';

  @override
  String get shareAppLink => 'App-link delen';

  @override
  String get shareAppLinkSubtitle => 'QR-code om de app te downloaden';

  @override
  String get license => 'Licentie';

  @override
  String get licenseSubtitle =>
      'Auteursrechten, open-sourcelicenties, broncode';

  @override
  String get privacyPolicy => 'Privacybeleid';

  @override
  String get colorThemeDefault => 'Standaard';

  @override
  String get colorThemeCustomLightDark => 'Aangepast licht en donker';

  @override
  String get colorThemeCustom => 'Aangepaste kleur';

  @override
  String get themeFollowSystem => 'Systeem volgen';

  @override
  String get themeLightMode => 'Lichte modus';

  @override
  String get themeDarkMode => 'Donkere modus';

  @override
  String get systemDefault => 'Systeemstandaard';

  @override
  String get useDefault => 'Standaard gebruiken';

  @override
  String get useDefaultSubtitle => 'Systeem- of app-standaardkleuren volgen';

  @override
  String get useSameForBoth => 'Hetzelfde voor beide';

  @override
  String get useSameForBothSubtitle =>
      'Zelfde kleur voor lichte en donkere modus';

  @override
  String get chooseColor => 'Kleur kiezen';

  @override
  String get chooseColorSubtitle =>
      'Kies een aangepaste kleur voor het app-thema';

  @override
  String get lightModeColor => 'Kleur in lichte modus';

  @override
  String get darkModeColor => 'Kleur in donkere modus';

  @override
  String get exportBackup => 'Back-up exporteren';

  @override
  String get exportAppSettings => 'App-instellingen exporteren';

  @override
  String get exportContactCards => 'Visitekaartjes exporteren';

  @override
  String get cancel => 'Annuleren';

  @override
  String get exportReadyToShare => 'Export klaar om te delen';

  @override
  String invalidBackupFile(Object error) {
    return 'Ongeldig back-upbestand: $error';
  }

  @override
  String get backupFileEmpty => 'Back-upbestand is leeg';

  @override
  String get importFromBackup => 'Importeren vanuit back-up';

  @override
  String get importSettings => 'Instellingen importeren';

  @override
  String get importContactCards => 'Visitekaartjes importeren';

  @override
  String get importCompleted => 'Importeren voltooid';

  @override
  String get defaultShareFieldsIntro =>
      'Bij het delen van een contact op je apparaat zijn deze velden standaard geselecteerd. Je kunt de selectie per contact wijzigen.';

  @override
  String get fieldName => 'Naam';

  @override
  String get fieldPhones => 'Telefoons';

  @override
  String get fieldEmails => 'E-mail';

  @override
  String get fieldOrganization => 'Organisatie';

  @override
  String get fieldAddresses => 'Adressen';

  @override
  String get fieldWebsites => 'Websites';

  @override
  String get fieldSocialMedia => 'Social media';

  @override
  String get fieldNotes => 'Notities';

  @override
  String get previewYourName => 'Jouw naam';

  @override
  String get previewYourInfo => 'Jouw gegevens';

  @override
  String get selectAtLeastOneField =>
      'Selecteer minstens één veld om de QR-code te tonen.';

  @override
  String get shareContact => 'Contact delen';

  @override
  String get backTooltip => 'Terug';

  @override
  String get noName => '(Geen naam)';

  @override
  String get done => 'Gereed';

  @override
  String get quickShare => 'Snel delen';

  @override
  String get editContactCard => 'Visitekaartje bewerken';

  @override
  String get close => 'Sluiten';

  @override
  String get shareAsImage => 'Delen als afbeelding';

  @override
  String get shareAsVCard => 'Delen als vCard';

  @override
  String get viewQrDataAsText => 'QR-gegevens als tekst bekijken';

  @override
  String get openLink => 'Link openen';

  @override
  String get qrCodeData => 'QR-codegegevens';

  @override
  String get copiedToClipboard => 'Gekopieerd naar klembord';

  @override
  String get copy => 'Kopiëren';

  @override
  String versionFormat(Object version) {
    return 'Versie $version';
  }

  @override
  String get sourceCode => 'Broncode';

  @override
  String get viewOpenSourceLicenses => 'Open-sourcelicenties bekijken';

  @override
  String get licenseMplNotice =>
      'Deze applicatie is open-sourcesoftware onder de Mozilla Public License 2.0 (MPL 2.0).';

  @override
  String get readMplLicense => 'MPL 2.0 lezen';

  @override
  String get couldNotOpenLink => 'Kon link niet openen';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => 'Kaart verwijderen?';

  @override
  String deleteCardMessage(Object name) {
    return '„$name“ verwijderen? Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String get delete => 'Verwijderen';

  @override
  String get pleaseSpecifyLabelForCustom => 'Geef een label op voor Aangepast';

  @override
  String get cardNeedsData =>
      'De kaart heeft minstens één veld met gegevens (bijv. naam, telefoon, e-mail). Alleen de kaartnaam wordt niet in de vCard opgenomen.';

  @override
  String saveFailed(Object error) {
    return 'Opslaan mislukt: $error';
  }

  @override
  String get details => 'Details';

  @override
  String get discardChangesTitle => 'Wijzigingen negeren?';

  @override
  String get discardChangesMessage =>
      'Je hebt niet-opgeslagen wijzigingen. Deze kaart opslaan voordat je sluit?';

  @override
  String get discard => 'Negeren';

  @override
  String get saveChanges => 'Wijzigingen opslaan';

  @override
  String get data => 'Gegevens';

  @override
  String get save => 'Opslaan';

  @override
  String get error => 'Fout';

  @override
  String get editCard => 'Kaart bewerken';

  @override
  String get ok => 'OK';

  @override
  String get preview => 'Voorbeeld';

  @override
  String get card => 'Kaart';

  @override
  String get qrCodeStyle => 'QR-codestijl';

  @override
  String get background => 'Achtergrond';

  @override
  String get backgroundSubtitle => 'Vulling achter QR-modules';

  @override
  String get quietZone => 'Rustzone';

  @override
  String get quietZoneSubtitle => 'Witte rand rond de QR-code';

  @override
  String get qrShapeSmooth => 'Vloeiend';

  @override
  String get qrShapeSquares => 'Vierkanten';

  @override
  String get qrShapeDots => 'Stippen';

  @override
  String get roundedCorners => 'Afgeronde hoeken';

  @override
  String get roundedCornersSubtitle => 'Zachtere weergave van QR-modules';

  @override
  String get embedded => 'Ingesloten';

  @override
  String get foreground => 'Voorgrond';

  @override
  String get remove => 'Verwijderen';

  @override
  String get cardNameHint => 'Voor sorteren en snel herkennen';

  @override
  String get company => 'Bedrijf';

  @override
  String get phoneNumbers => 'Telefoonnummers';

  @override
  String get emailAddresses => 'E-mailadressen';

  @override
  String get urls => 'URL\'s';

  @override
  String get socialMedia => 'Social media';

  @override
  String get addresses => 'Adressen';

  @override
  String get backgroundColor => 'Achtergrondkleur';

  @override
  String get textColor => 'Tekstkleur';

  @override
  String get imageOrLogo => 'Afbeelding of logo';

  @override
  String get color => 'Kleur';

  @override
  String get style => 'Stijl';

  @override
  String get logoPosition => 'Logopositie';

  @override
  String get qrCenterImage => 'QR-centrumafbeelding';

  @override
  String get phoneLabelMobile => 'Mobiel';

  @override
  String get phoneLabelWork => 'Werk';

  @override
  String get phoneLabelHome => 'Thuis';

  @override
  String get phoneLabelMain => 'Hoofd';

  @override
  String get phoneLabelOther => 'Overig';

  @override
  String get phoneLabelCustom => 'Aangepast';

  @override
  String get emailLabelHome => 'Thuis';

  @override
  String get emailLabelWork => 'Werk';

  @override
  String get emailLabelOther => 'Overig';

  @override
  String get emailLabelCustom => 'Aangepast';

  @override
  String get addressLabelHome => 'Thuis';

  @override
  String get addressLabelWork => 'Werk';

  @override
  String get addressLabelOther => 'Overig';

  @override
  String get addressLabelCustom => 'Aangepast';

  @override
  String get socialLabelOther => 'Overig';

  @override
  String get socialLabelCustom => 'Aangepast';

  @override
  String get unknownPlatformIndicatorTooltip => 'Beperkte ondersteuning';

  @override
  String get unknownPlatformDialogTitle => 'Onbekend platform';

  @override
  String get unknownPlatformDialogMessage =>
      'Dit platform staat niet op onze lijst. Het wordt opgeslagen als aangepaste eigenschap (X-SOCIALPROFILE) in de QR-code, niet als klikbare link. Aangepaste eigenschappen worden niet door alle apps en apparaten goed ondersteund.';

  @override
  String get colorPickerPalette => 'Palet';

  @override
  String get colorPickerPrimary => 'Primair';

  @override
  String get colorPickerAccent => 'Accent';

  @override
  String get colorPickerBW => 'Z/W';

  @override
  String get colorPickerCustom => 'Aangepast';

  @override
  String get colorPickerOptions => 'Opties';

  @override
  String get colorPickerWheel => 'Wiel';

  @override
  String get colorPickerColorShade => 'Kleurtint';

  @override
  String get colorPickerTonalPalette => 'Material 3-tonaal palet';

  @override
  String get colorPickerSelectedColorShades => 'Geselecteerde kleur en tinten';

  @override
  String get colorPickerOpacity => 'Dekking';

  @override
  String get colorPickerRecentColors => 'Recente kleuren';

  @override
  String get colorPickerDarkNavy => 'Donker marineblauw';

  @override
  String get colorPickerNavy => 'Marineblauw';

  @override
  String get colorPickerBlueGrey => 'Blauwgrijs';

  @override
  String get colorPickerAccentRed => 'Accentrood';

  @override
  String get colorPickerPurple => 'Paars';

  @override
  String get honorificPrefix => 'Voorvoegsel';

  @override
  String get additionalNames => 'Extra namen';

  @override
  String get honorificSuffix => 'Achtervoegsel';

  @override
  String get nickname => 'Bijnaam';

  @override
  String get firstName => 'Voornaam';

  @override
  String get lastName => 'Achternaam';

  @override
  String get organization => 'Organisatie';

  @override
  String get jobTitle => 'Functie';

  @override
  String get companyUnit => 'Afdeling';

  @override
  String get addJobTitle => 'Functie toevoegen';

  @override
  String get addCompanyUnit => 'Afdeling toevoegen';

  @override
  String get label => 'Label';

  @override
  String get phoneLabel => 'Telefoonlabel';

  @override
  String get emailLabel => 'E-maillabel';

  @override
  String get addressLabel => 'Adreslabel';

  @override
  String get phone => 'Telefoon';

  @override
  String get email => 'E-mail';

  @override
  String get addPhone => 'Telefoon toevoegen';

  @override
  String get addEmail => 'E-mail toevoegen';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'URL toevoegen';

  @override
  String get platform => 'Platform';

  @override
  String get customPlatform => 'Aangepast platform';

  @override
  String get platformName => 'Platformnaam';

  @override
  String get platformNameHint => 'bijv. Mastodon, Bluesky';

  @override
  String get username => 'Gebruikersnaam';

  @override
  String get addSocialMedia => 'Social media toevoegen';

  @override
  String get addAddress => 'Adres toevoegen';

  @override
  String get address => 'Adres';

  @override
  String get removeTooltip => 'Verwijderen';

  @override
  String get cardName => 'Kaartnaam';

  @override
  String get birthday => 'Verjaardag';

  @override
  String get notes => 'Notities';

  @override
  String get appearanceImageInputTooLarge =>
      'Deze afbeelding is te groot. Gebruik een bestand kleiner dan 16 MB.';

  @override
  String get appearanceImageCouldNotProcess =>
      'Deze afbeelding kon niet worden gebruikt. Probeer een andere PNG of JPEG.';

  @override
  String get deleteCard => 'Kaart verwijderen';
}
