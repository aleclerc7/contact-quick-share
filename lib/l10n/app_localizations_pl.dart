// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'Brak pasujących kontaktów';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'Nie udało się wczytać wizytówek: $error';
  }

  @override
  String get contactPermissionRequired =>
      'Potrzebne jest uprawnienie do kontaktów, aby wyświetlić Twoje kontakty.';

  @override
  String get noCardsYet =>
      'Nie ma jeszcze wizytówek.\nDodaj pierwszą wizytówkę.';

  @override
  String get openSettings => 'Otwórz ustawienia';

  @override
  String get addBusinessCard => 'Dodaj wizytówkę';

  @override
  String get newBusinessCardTooltip => 'Nowa wizytówka';

  @override
  String get searchHint => 'Szukaj wizytówek lub kontaktów…';

  @override
  String get clearSearchTooltip => 'Wyczyść wyszukiwanie';

  @override
  String errorGeneric(Object error) {
    return 'Błąd: $error';
  }

  @override
  String get settings => 'Ustawienia';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get sharing => 'Udostępnianie';

  @override
  String get defaultShareFields => 'Domyślne pola przy udostępnianiu';

  @override
  String get defaultShareFieldsSubtitle =>
      'Imię i nazwisko, telefony, e-maile itd. przy udostępnianiu kontaktu';

  @override
  String get appearance => 'Wygląd';

  @override
  String get defaultQrCodeStyle => 'Domyślny styl kodu QR';

  @override
  String get defaultQrCodeStyleSubtitle => 'Kolory karty, czcionka, wygląd QR';

  @override
  String get application => 'Aplikacja';

  @override
  String get language => 'Język';

  @override
  String get theme => 'Motyw';

  @override
  String get themeAuto => 'Automatyczny';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get colorTheme => 'Motyw kolorystyczny';

  @override
  String get autoOpenCardOnLaunch => 'Otwórz kartę przy starcie';

  @override
  String get none => 'Brak';

  @override
  String get cardNotFound => 'Nie znaleziono karty';

  @override
  String get contactNotFoundOrDeleted =>
      'Nie znaleziono kontaktu lub został usunięty.';

  @override
  String get loading => 'Wczytywanie…';

  @override
  String get errorLoadingCards => 'Błąd wczytywania kart';

  @override
  String get backup => 'Kopia zapasowa';

  @override
  String get export => 'Eksportuj';

  @override
  String get exportSubtitle =>
      'Zapisz ustawienia i karty w pliku do udostępnienia lub archiwizacji';

  @override
  String get import => 'Importuj';

  @override
  String get importSubtitle => 'Przywróć z wcześniej zapisanego pliku kopii';

  @override
  String get about => 'O aplikacji';

  @override
  String get shareAppLink => 'Udostępnij link do aplikacji';

  @override
  String get shareAppLinkSubtitle => 'Kod QR do pobrania aplikacji';

  @override
  String get license => 'Licencja';

  @override
  String get licenseSubtitle =>
      'Prawa autorskie, licencje open source, kod źródłowy';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get colorThemeDefault => 'Domyślny';

  @override
  String get colorThemeCustomLightDark => 'Niestandardowy jasny i ciemny';

  @override
  String get colorThemeCustom => 'Niestandardowy kolor';

  @override
  String get themeFollowSystem => 'Zgodnie z systemem';

  @override
  String get themeLightMode => 'Tryb jasny';

  @override
  String get themeDarkMode => 'Tryb ciemny';

  @override
  String get systemDefault => 'Domyślne ustawienia systemu';

  @override
  String get useDefault => 'Użyj domyślnych';

  @override
  String get useDefaultSubtitle => 'Kolory systemu lub aplikacji';

  @override
  String get useSameForBoth => 'Ten sam w obu trybach';

  @override
  String get useSameForBothSubtitle =>
      'Ten sam kolor w trybie jasnym i ciemnym';

  @override
  String get chooseColor => 'Wybierz kolor';

  @override
  String get chooseColorSubtitle =>
      'Wybierz niestandardowy kolor motywu aplikacji';

  @override
  String get lightModeColor => 'Kolor w trybie jasnym';

  @override
  String get darkModeColor => 'Kolor w trybie ciemnym';

  @override
  String get exportBackup => 'Eksportuj kopię zapasową';

  @override
  String get exportAppSettings => 'Eksportuj ustawienia aplikacji';

  @override
  String get exportContactCards => 'Eksportuj wizytówki';

  @override
  String get cancel => 'Anuluj';

  @override
  String get exportReadyToShare => 'Eksport gotowy do udostępnienia';

  @override
  String invalidBackupFile(Object error) {
    return 'Nieprawidłowy plik kopii: $error';
  }

  @override
  String get backupFileEmpty => 'Plik kopii jest pusty';

  @override
  String get importFromBackup => 'Importuj z kopii';

  @override
  String get importSettings => 'Importuj ustawienia';

  @override
  String get importContactCards => 'Importuj wizytówki';

  @override
  String get importCompleted => 'Import zakończony';

  @override
  String get defaultShareFieldsIntro =>
      'Przy udostępnianiu kontaktu z urządzenia te pola są domyślnie zaznaczone. Możesz zmienić wybór dla każdego kontaktu.';

  @override
  String get fieldName => 'Imię i nazwisko';

  @override
  String get fieldPhones => 'Telefony';

  @override
  String get fieldEmails => 'E-maile';

  @override
  String get fieldOrganization => 'Organizacja';

  @override
  String get fieldAddresses => 'Adresy';

  @override
  String get fieldWebsites => 'Strony WWW';

  @override
  String get fieldSocialMedia => 'Media społecznościowe';

  @override
  String get fieldNotes => 'Notatki';

  @override
  String get previewYourName => 'Twoje imię i nazwisko';

  @override
  String get previewYourInfo => 'Twoje dane';

  @override
  String get selectAtLeastOneField =>
      'Zaznacz co najmniej jedno pole, aby wyświetlić kod QR.';

  @override
  String get shareContact => 'Udostępnij kontakt';

  @override
  String get backTooltip => 'Wstecz';

  @override
  String get noName => '(Brak nazwy)';

  @override
  String get done => 'Gotowe';

  @override
  String get quickShare => 'Szybkie udostępnianie';

  @override
  String get editContactCard => 'Edytuj wizytówkę';

  @override
  String get close => 'Zamknij';

  @override
  String get shareAsImage => 'Udostępnij jako obraz';

  @override
  String get shareAsVCard => 'Udostępnij jako vCard';

  @override
  String get viewQrDataAsText => 'Zobacz dane QR jako tekst';

  @override
  String get openLink => 'Otwórz link';

  @override
  String get qrCodeData => 'Dane kodu QR';

  @override
  String get copiedToClipboard => 'Skopiowano do schowka';

  @override
  String get copy => 'Kopiuj';

  @override
  String versionFormat(Object version) {
    return 'Wersja $version';
  }

  @override
  String get sourceCode => 'Kod źródłowy';

  @override
  String get viewOpenSourceLicenses => 'Zobacz licencje open source';

  @override
  String get licenseMplNotice =>
      'Ta aplikacja jest oprogramowaniem open source na licencji Mozilla Public License 2.0 (MPL 2.0).';

  @override
  String get readMplLicense => 'Przeczytaj MPL 2.0';

  @override
  String get couldNotOpenLink => 'Nie można otworzyć linku';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => 'Usunąć kartę?';

  @override
  String deleteCardMessage(Object name) {
    return 'Usunąć „$name”? Tej operacji nie można cofnąć.';
  }

  @override
  String get delete => 'Usuń';

  @override
  String get pleaseSpecifyLabelForCustom =>
      'Podaj etykietę dla opcji Niestandardowa';

  @override
  String get cardNeedsData =>
      'Karta musi zawierać co najmniej jedno pole z danymi (np. imię, telefon, e-mail). Sama nazwa karty nie trafia do vCard.';

  @override
  String saveFailed(Object error) {
    return 'Zapis nie powiódł się: $error';
  }

  @override
  String get details => 'Szczegóły';

  @override
  String get discardChangesTitle => 'Odrzucić zmiany?';

  @override
  String get discardChangesMessage =>
      'Masz niezapisane zmiany. Zapisać tę kartę przed zamknięciem?';

  @override
  String get discard => 'Odrzuć';

  @override
  String get saveChanges => 'Zapisz zmiany';

  @override
  String get data => 'Dane';

  @override
  String get save => 'Zapisz';

  @override
  String get error => 'Błąd';

  @override
  String get editCard => 'Edytuj kartę';

  @override
  String get ok => 'OK';

  @override
  String get preview => 'Podgląd';

  @override
  String get card => 'Karta';

  @override
  String get qrCodeStyle => 'Styl kodu QR';

  @override
  String get background => 'Tło';

  @override
  String get backgroundSubtitle => 'Wypełnienie za modułami QR';

  @override
  String get quietZone => 'Strefa ciszy';

  @override
  String get quietZoneSubtitle => 'Biała obwódka wokół kodu QR';

  @override
  String get qrShapeSmooth => 'Gładki';

  @override
  String get qrShapeSquares => 'Kwadraty';

  @override
  String get qrShapeDots => 'Kropki';

  @override
  String get roundedCorners => 'Zaokrąglone rogi';

  @override
  String get roundedCornersSubtitle => 'Łagodniejszy wygląd modułów QR';

  @override
  String get embedded => 'Osadzony';

  @override
  String get foreground => 'Pierwszy plan';

  @override
  String get remove => 'Usuń';

  @override
  String get cardNameHint => 'Do sortowania i szybkiej identyfikacji';

  @override
  String get company => 'Firma';

  @override
  String get phoneNumbers => 'Numery telefonów';

  @override
  String get emailAddresses => 'Adresy e-mail';

  @override
  String get urls => 'Adresy URL';

  @override
  String get socialMedia => 'Media społecznościowe';

  @override
  String get addresses => 'Adresy';

  @override
  String get backgroundColor => 'Kolor tła';

  @override
  String get textColor => 'Kolor tekstu';

  @override
  String get imageOrLogo => 'Obraz lub logo';

  @override
  String get color => 'Kolor';

  @override
  String get style => 'Styl';

  @override
  String get logoPosition => 'Położenie logo';

  @override
  String get qrCenterImage => 'Obraz środkowy QR';

  @override
  String get phoneLabelMobile => 'Komórka';

  @override
  String get phoneLabelWork => 'Praca';

  @override
  String get phoneLabelHome => 'Dom';

  @override
  String get phoneLabelMain => 'Główny';

  @override
  String get phoneLabelOther => 'Inny';

  @override
  String get phoneLabelCustom => 'Niestandardowy';

  @override
  String get emailLabelHome => 'Dom';

  @override
  String get emailLabelWork => 'Praca';

  @override
  String get emailLabelOther => 'Inny';

  @override
  String get emailLabelCustom => 'Niestandardowy';

  @override
  String get addressLabelHome => 'Dom';

  @override
  String get addressLabelWork => 'Praca';

  @override
  String get addressLabelOther => 'Inny';

  @override
  String get addressLabelCustom => 'Niestandardowy';

  @override
  String get socialLabelOther => 'Inny';

  @override
  String get socialLabelCustom => 'Niestandardowy';

  @override
  String get unknownPlatformIndicatorTooltip => 'Ograniczone wsparcie';

  @override
  String get unknownPlatformDialogTitle => 'Nieznana platforma';

  @override
  String get unknownPlatformDialogMessage =>
      'Tej platformy nie ma na naszej liście. Zostanie zapisana jako niestandardowa właściwość (X-SOCIALPROFILE) w kodzie QR, a nie jako klikalny link. Niestandardowe właściwości nie są dobrze obsługiwane we wszystkich aplikacjach i urządzeniach.';

  @override
  String get colorPickerPalette => 'Paleta';

  @override
  String get colorPickerPrimary => 'Podstawowy';

  @override
  String get colorPickerAccent => 'Akcent';

  @override
  String get colorPickerBW => 'Cz/B';

  @override
  String get colorPickerCustom => 'Niestandardowy';

  @override
  String get colorPickerOptions => 'Opcje';

  @override
  String get colorPickerWheel => 'Koło barw';

  @override
  String get colorPickerColorShade => 'Odcień';

  @override
  String get colorPickerTonalPalette => 'Paleta tonalna Material 3';

  @override
  String get colorPickerSelectedColorShades => 'Wybrany kolor i odcienie';

  @override
  String get colorPickerOpacity => 'Krycie';

  @override
  String get colorPickerRecentColors => 'Ostatnie kolory';

  @override
  String get colorPickerDarkNavy => 'Ciemny granat';

  @override
  String get colorPickerNavy => 'Granat';

  @override
  String get colorPickerBlueGrey => 'Niebieskoszary';

  @override
  String get colorPickerAccentRed => 'Czerwony akcent';

  @override
  String get colorPickerPurple => 'Fiolet';

  @override
  String get honorificPrefix => 'Prefiks tytułu';

  @override
  String get additionalNames => 'Dodatkowe imiona';

  @override
  String get honorificSuffix => 'Sufiks tytułu';

  @override
  String get nickname => 'Pseudonim';

  @override
  String get firstName => 'Imię';

  @override
  String get lastName => 'Nazwisko';

  @override
  String get organization => 'Organizacja';

  @override
  String get jobTitle => 'Stanowisko';

  @override
  String get companyUnit => 'Dział firmy';

  @override
  String get addJobTitle => 'Dodaj stanowisko';

  @override
  String get addCompanyUnit => 'Dodaj dział';

  @override
  String get label => 'Etykieta';

  @override
  String get phoneLabel => 'Etykieta telefonu';

  @override
  String get emailLabel => 'Etykieta e-mail';

  @override
  String get addressLabel => 'Etykieta adresu';

  @override
  String get phone => 'Telefon';

  @override
  String get email => 'E-mail';

  @override
  String get addPhone => 'Dodaj telefon';

  @override
  String get addEmail => 'Dodaj e-mail';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'Dodaj URL';

  @override
  String get platform => 'Platforma';

  @override
  String get customPlatform => 'Niestandardowa platforma';

  @override
  String get platformName => 'Nazwa platformy';

  @override
  String get platformNameHint => 'np. Mastodon, Bluesky';

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String get addSocialMedia => 'Dodaj media społecznościowe';

  @override
  String get addAddress => 'Dodaj adres';

  @override
  String get address => 'Adres';

  @override
  String get removeTooltip => 'Usuń';

  @override
  String get cardName => 'Nazwa karty';

  @override
  String get birthday => 'Urodziny';

  @override
  String get notes => 'Notatki';

  @override
  String get appearanceImageInputTooLarge =>
      'Ten obraz jest za duży. Użyj pliku mniejszego niż 16 MB.';

  @override
  String get appearanceImageCouldNotProcess =>
      'Nie można użyć tego obrazu. Spróbuj innego PNG lub JPEG.';

  @override
  String get deleteCard => 'Usuń kartę';
}
