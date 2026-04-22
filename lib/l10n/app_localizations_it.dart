// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'Nessun contatto corrispondente';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'Impossibile caricare i biglietti da visita: $error';
  }

  @override
  String get contactPermissionRequired =>
      'È necessario l\'accesso ai contatti per mostrare i tuoi contatti.';

  @override
  String get noCardsYet =>
      'Ancora nessun biglietto.\nAggiungi il tuo primo biglietto da visita.';

  @override
  String get openSettings => 'Apri impostazioni';

  @override
  String get addBusinessCard => 'Aggiungi biglietto da visita';

  @override
  String get newBusinessCardTooltip => 'Nuovo biglietto da visita';

  @override
  String get searchHint => 'Cerca biglietti o contatti…';

  @override
  String get clearSearchTooltip => 'Cancella ricerca';

  @override
  String errorGeneric(Object error) {
    return 'Errore: $error';
  }

  @override
  String get settings => 'Impostazioni';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get sharing => 'Condivisione';

  @override
  String get defaultShareFields => 'Campi predefiniti per la condivisione';

  @override
  String get defaultShareFieldsSubtitle =>
      'Nome, telefoni, e-mail ecc. per la condivisione dei contatti';

  @override
  String get appearance => 'Aspetto';

  @override
  String get defaultQrCodeStyle => 'Stile QR predefinito';

  @override
  String get defaultQrCodeStyleSubtitle =>
      'Colori della scheda, carattere, aspetto del QR';

  @override
  String get application => 'Applicazione';

  @override
  String get language => 'Lingua';

  @override
  String get theme => 'Tema';

  @override
  String get themeAuto => 'Automatico';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get colorTheme => 'Tema colore';

  @override
  String get autoOpenCardOnLaunch => 'Apri scheda all\'avvio';

  @override
  String get none => 'Nessuna';

  @override
  String get cardNotFound => 'Scheda non trovata';

  @override
  String get contactNotFoundOrDeleted => 'Contatto non trovato o eliminato.';

  @override
  String get loading => 'Caricamento…';

  @override
  String get errorLoadingCards => 'Errore durante il caricamento delle schede';

  @override
  String get backup => 'Backup';

  @override
  String get export => 'Esporta';

  @override
  String get exportSubtitle =>
      'Salva impostazioni e schede in un file da condividere o conservare';

  @override
  String get import => 'Importa';

  @override
  String get importSubtitle =>
      'Ripristina da un file di backup salvato in precedenza';

  @override
  String get about => 'Informazioni';

  @override
  String get shareAppLink => 'Condividi link dell\'app';

  @override
  String get shareAppLinkSubtitle => 'Codice QR per scaricare l\'app';

  @override
  String get license => 'Licenza';

  @override
  String get licenseSubtitle =>
      'Copyright, licenze open source, codice sorgente';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get colorThemeDefault => 'Predefinito';

  @override
  String get colorThemeCustomLightDark => 'Personalizzato chiaro e scuro';

  @override
  String get colorThemeCustom => 'Colore personalizzato';

  @override
  String get themeFollowSystem => 'Segui il sistema';

  @override
  String get themeLightMode => 'Modalità chiara';

  @override
  String get themeDarkMode => 'Modalità scura';

  @override
  String get systemDefault => 'Predefinito di sistema';

  @override
  String get useDefault => 'Usa predefinito';

  @override
  String get useDefaultSubtitle => 'Segui i colori di sistema o dell\'app';

  @override
  String get useSameForBoth => 'Stesso per entrambe';

  @override
  String get useSameForBothSubtitle =>
      'Stesso colore per modalità chiara e scura';

  @override
  String get chooseColor => 'Scegli colore';

  @override
  String get chooseColorSubtitle =>
      'Scegli un colore personalizzato per il tema dell\'app';

  @override
  String get lightModeColor => 'Colore in modalità chiara';

  @override
  String get darkModeColor => 'Colore in modalità scura';

  @override
  String get exportBackup => 'Esporta backup';

  @override
  String get exportAppSettings => 'Esporta impostazioni app';

  @override
  String get exportContactCards => 'Esporta biglietti da visita';

  @override
  String get cancel => 'Annulla';

  @override
  String get exportReadyToShare => 'Esportazione pronta per la condivisione';

  @override
  String invalidBackupFile(Object error) {
    return 'File di backup non valido: $error';
  }

  @override
  String get backupFileEmpty => 'Il file di backup è vuoto';

  @override
  String get importFromBackup => 'Importa da backup';

  @override
  String get importSettings => 'Importa impostazioni';

  @override
  String get importContactCards => 'Importa biglietti da visita';

  @override
  String get importCompleted => 'Importazione completata';

  @override
  String get defaultShareFieldsIntro =>
      'Quando condividi un contatto del dispositivo, questi campi sono selezionati per impostazione predefinita. Puoi modificare la selezione per ogni contatto.';

  @override
  String get fieldName => 'Nome';

  @override
  String get fieldPhones => 'Telefoni';

  @override
  String get fieldEmails => 'E-mail';

  @override
  String get fieldOrganization => 'Organizzazione';

  @override
  String get fieldAddresses => 'Indirizzi';

  @override
  String get fieldWebsites => 'Siti web';

  @override
  String get fieldSocialMedia => 'Social media';

  @override
  String get fieldNotes => 'Note';

  @override
  String get previewYourName => 'Il tuo nome';

  @override
  String get previewYourInfo => 'Le tue informazioni';

  @override
  String get selectAtLeastOneField =>
      'Seleziona almeno un campo per visualizzare il codice QR.';

  @override
  String get shareContact => 'Condividi contatto';

  @override
  String get backTooltip => 'Indietro';

  @override
  String get noName => '(Senza nome)';

  @override
  String get done => 'Fatto';

  @override
  String get quickShare => 'Condivisione rapida';

  @override
  String get editContactCard => 'Modifica biglietto da visita';

  @override
  String get close => 'Chiudi';

  @override
  String get shareAsImage => 'Condividi come immagine';

  @override
  String get shareAsVCard => 'Condividi come vCard';

  @override
  String get viewQrDataAsText => 'Visualizza dati QR come testo';

  @override
  String get openLink => 'Apri link';

  @override
  String get qrCodeData => 'Dati del codice QR';

  @override
  String get copiedToClipboard => 'Copiato negli appunti';

  @override
  String get copy => 'Copia';

  @override
  String versionFormat(Object version) {
    return 'Versione $version';
  }

  @override
  String get sourceCode => 'Codice sorgente';

  @override
  String get viewOpenSourceLicenses => 'Visualizza licenze open source';

  @override
  String get licenseMplNotice =>
      'Questa applicazione è software open source concesso in licenza secondo la Mozilla Public License 2.0 (MPL 2.0).';

  @override
  String get readMplLicense => 'Leggi MPL 2.0';

  @override
  String get couldNotOpenLink => 'Impossibile aprire il link';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => 'Eliminare la scheda?';

  @override
  String deleteCardMessage(Object name) {
    return 'Eliminare «$name»? L\'azione non può essere annullata.';
  }

  @override
  String get delete => 'Elimina';

  @override
  String get pleaseSpecifyLabelForCustom =>
      'Specifica un\'etichetta per Personalizzato';

  @override
  String get cardNeedsData =>
      'La scheda deve avere almeno un campo con dati (ad es. nome, telefono, e-mail). Il nome della scheda da solo non è incluso nella vCard.';

  @override
  String saveFailed(Object error) {
    return 'Salvataggio non riuscito: $error';
  }

  @override
  String get details => 'Dettagli';

  @override
  String get discardChangesTitle => 'Ignorare le modifiche?';

  @override
  String get discardChangesMessage =>
      'Hai modifiche non salvate. Salvare questa scheda prima di chiudere?';

  @override
  String get discard => 'Ignora';

  @override
  String get saveChanges => 'Salva modifiche';

  @override
  String get data => 'Dati';

  @override
  String get save => 'Salva';

  @override
  String get error => 'Errore';

  @override
  String get editCard => 'Modifica scheda';

  @override
  String get ok => 'OK';

  @override
  String get preview => 'Anteprima';

  @override
  String get card => 'Scheda';

  @override
  String get qrCodeStyle => 'Stile codice QR';

  @override
  String get background => 'Sfondo';

  @override
  String get backgroundSubtitle => 'Riempimento dietro i moduli QR';

  @override
  String get quietZone => 'Zona silenziosa';

  @override
  String get quietZoneSubtitle => 'Bordo bianco intorno al codice QR';

  @override
  String get qrShapeSmooth => 'Morbido';

  @override
  String get qrShapeSquares => 'Quadrati';

  @override
  String get qrShapeDots => 'Punti';

  @override
  String get roundedCorners => 'Angoli arrotondati';

  @override
  String get roundedCornersSubtitle => 'Aspetto più morbido dei moduli QR';

  @override
  String get embedded => 'Incorporato';

  @override
  String get foreground => 'Primo piano';

  @override
  String get remove => 'Rimuovi';

  @override
  String get cardNameHint => 'Per ordinare e identificare rapidamente';

  @override
  String get company => 'Azienda';

  @override
  String get phoneNumbers => 'Numeri di telefono';

  @override
  String get emailAddresses => 'Indirizzi e-mail';

  @override
  String get urls => 'URL';

  @override
  String get socialMedia => 'Social media';

  @override
  String get addresses => 'Indirizzi';

  @override
  String get backgroundColor => 'Colore di sfondo';

  @override
  String get textColor => 'Colore del testo';

  @override
  String get imageOrLogo => 'Immagine o logo';

  @override
  String get color => 'Colore';

  @override
  String get style => 'Stile';

  @override
  String get logoPosition => 'Posizione logo';

  @override
  String get qrCenterImage => 'Immagine centrale QR';

  @override
  String get phoneLabelMobile => 'Cellulare';

  @override
  String get phoneLabelWork => 'Lavoro';

  @override
  String get phoneLabelHome => 'Casa';

  @override
  String get phoneLabelMain => 'Principale';

  @override
  String get phoneLabelOther => 'Altro';

  @override
  String get phoneLabelCustom => 'Personalizzato';

  @override
  String get emailLabelHome => 'Casa';

  @override
  String get emailLabelWork => 'Lavoro';

  @override
  String get emailLabelOther => 'Altro';

  @override
  String get emailLabelCustom => 'Personalizzato';

  @override
  String get addressLabelHome => 'Casa';

  @override
  String get addressLabelWork => 'Lavoro';

  @override
  String get addressLabelOther => 'Altro';

  @override
  String get addressLabelCustom => 'Personalizzato';

  @override
  String get socialLabelOther => 'Altro';

  @override
  String get socialLabelCustom => 'Personalizzato';

  @override
  String get unknownPlatformIndicatorTooltip => 'Supporto limitato';

  @override
  String get unknownPlatformDialogTitle => 'Piattaforma sconosciuta';

  @override
  String get unknownPlatformDialogMessage =>
      'Questa piattaforma non è nell\'elenco. Verrà salvata come proprietà personalizzata (X-SOCIALPROFILE) nel codice QR, non come link cliccabile. Le proprietà personalizzate non sono ben supportate da tutte le app e i dispositivi.';

  @override
  String get colorPickerPalette => 'Tavolozza';

  @override
  String get colorPickerPrimary => 'Primario';

  @override
  String get colorPickerAccent => 'Accento';

  @override
  String get colorPickerBW => 'B/N';

  @override
  String get colorPickerCustom => 'Personalizzato';

  @override
  String get colorPickerOptions => 'Opzioni';

  @override
  String get colorPickerWheel => 'Ruota';

  @override
  String get colorPickerColorShade => 'Tonalità';

  @override
  String get colorPickerTonalPalette => 'Tavolozza tonale Material 3';

  @override
  String get colorPickerSelectedColorShades => 'Colore selezionato e tonalità';

  @override
  String get colorPickerOpacity => 'Opacità';

  @override
  String get colorPickerRecentColors => 'Colori recenti';

  @override
  String get colorPickerDarkNavy => 'Blu navy scuro';

  @override
  String get colorPickerNavy => 'Blu navy';

  @override
  String get colorPickerBlueGrey => 'Blu grigio';

  @override
  String get colorPickerAccentRed => 'Rosso accento';

  @override
  String get colorPickerPurple => 'Viola';

  @override
  String get honorificPrefix => 'Prefisso onorifico';

  @override
  String get additionalNames => 'Nomi aggiuntivi';

  @override
  String get honorificSuffix => 'Suffisso onorifico';

  @override
  String get nickname => 'Soprannome';

  @override
  String get firstName => 'Nome';

  @override
  String get lastName => 'Cognome';

  @override
  String get organization => 'Organizzazione';

  @override
  String get jobTitle => 'Qualifica';

  @override
  String get companyUnit => 'Reparto aziendale';

  @override
  String get addJobTitle => 'Aggiungi qualifica';

  @override
  String get addCompanyUnit => 'Aggiungi reparto';

  @override
  String get label => 'Etichetta';

  @override
  String get phoneLabel => 'Etichetta telefono';

  @override
  String get emailLabel => 'Etichetta e-mail';

  @override
  String get addressLabel => 'Etichetta indirizzo';

  @override
  String get phone => 'Telefono';

  @override
  String get email => 'E-mail';

  @override
  String get addPhone => 'Aggiungi telefono';

  @override
  String get addEmail => 'Aggiungi e-mail';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'Aggiungi URL';

  @override
  String get platform => 'Piattaforma';

  @override
  String get customPlatform => 'Piattaforma personalizzata';

  @override
  String get platformName => 'Nome piattaforma';

  @override
  String get platformNameHint => 'es. Mastodon, Bluesky';

  @override
  String get username => 'Nome utente';

  @override
  String get addSocialMedia => 'Aggiungi social';

  @override
  String get addAddress => 'Aggiungi indirizzo';

  @override
  String get address => 'Indirizzo';

  @override
  String get removeTooltip => 'Rimuovi';

  @override
  String get cardName => 'Nome scheda';

  @override
  String get birthday => 'Compleanno';

  @override
  String get notes => 'Note';

  @override
  String get appearanceImageInputTooLarge =>
      'Questa immagine è troppo grande. Usa un file inferiore a 16 MB.';

  @override
  String get appearanceImageCouldNotProcess =>
      'Impossibile usare questa immagine. Prova un altro PNG o JPEG.';

  @override
  String get deleteCard => 'Elimina scheda';
}
