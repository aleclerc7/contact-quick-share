// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'Aucun contact correspondant';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'Impossible de charger les cartes de visite : $error';
  }

  @override
  String get contactPermissionRequired =>
      'L\'autorisation de contacts est requise pour afficher vos contacts.';

  @override
  String get noCardsYet =>
      'Aucune carte pour l\'instant.\nAjoutez votre première carte de visite.';

  @override
  String get openSettings => 'Ouvrir les paramètres';

  @override
  String get addBusinessCard => 'Ajouter une carte de visite';

  @override
  String get newBusinessCardTooltip => 'Nouvelle carte de visite';

  @override
  String get searchHint => 'Rechercher des cartes ou contacts…';

  @override
  String get clearSearchTooltip => 'Effacer la recherche';

  @override
  String errorGeneric(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get sharing => 'Partage';

  @override
  String get defaultShareFields => 'Champs partagés par défaut';

  @override
  String get defaultShareFieldsSubtitle =>
      'Nom, téléphones, e-mails, etc. pour le partage de contacts';

  @override
  String get appearance => 'Apparence';

  @override
  String get defaultQrCodeStyle => 'Style QR par défaut';

  @override
  String get defaultQrCodeStyleSubtitle =>
      'Couleurs de carte, police, apparence du QR';

  @override
  String get application => 'Application';

  @override
  String get language => 'Langue';

  @override
  String get theme => 'Thème';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get colorTheme => 'Couleur du thème';

  @override
  String get autoOpenCardOnLaunch => 'Ouvrir une carte au lancement';

  @override
  String get none => 'Aucune';

  @override
  String get cardNotFound => 'Carte introuvable';

  @override
  String get contactNotFoundOrDeleted => 'Contact introuvable ou supprimé.';

  @override
  String get loading => 'Chargement…';

  @override
  String get errorLoadingCards => 'Erreur lors du chargement des cartes';

  @override
  String get backup => 'Sauvegarde';

  @override
  String get export => 'Exporter';

  @override
  String get exportSubtitle =>
      'Sauvegarder vos paramètres et cartes dans un fichier à partager ou conserver';

  @override
  String get import => 'Importer';

  @override
  String get importSubtitle =>
      'Restaurer à partir d\'une sauvegarde précédente';

  @override
  String get about => 'À propos';

  @override
  String get shareAppLink => 'Partager le lien de l\'app';

  @override
  String get shareAppLinkSubtitle => 'Code QR pour télécharger l\'application';

  @override
  String get license => 'Licence';

  @override
  String get licenseSubtitle =>
      'Droits d\'auteur, licences open-source, code source';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get colorThemeDefault => 'Par défaut';

  @override
  String get colorThemeCustomLightDark => 'Personnalisé clair et sombre';

  @override
  String get colorThemeCustom => 'Couleur personnalisée';

  @override
  String get themeFollowSystem => 'Suivre le système';

  @override
  String get themeLightMode => 'Mode clair';

  @override
  String get themeDarkMode => 'Mode sombre';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get useDefault => 'Utiliser par défaut';

  @override
  String get useDefaultSubtitle =>
      'Suivre les couleurs du système ou de l\'app';

  @override
  String get useSameForBoth => 'Même couleur pour les deux';

  @override
  String get useSameForBothSubtitle =>
      'Même couleur pour le mode clair et sombre';

  @override
  String get chooseColor => 'Choisir une couleur';

  @override
  String get chooseColorSubtitle =>
      'Choisir une couleur personnalisée pour le thème';

  @override
  String get lightModeColor => 'Couleur mode clair';

  @override
  String get darkModeColor => 'Couleur mode sombre';

  @override
  String get exportBackup => 'Exporter la sauvegarde';

  @override
  String get exportAppSettings => 'Exporter les paramètres';

  @override
  String get exportContactCards => 'Exporter les cartes de visite';

  @override
  String get cancel => 'Annuler';

  @override
  String get exportReadyToShare => 'Export prêt à partager';

  @override
  String invalidBackupFile(Object error) {
    return 'Fichier de sauvegarde invalide : $error';
  }

  @override
  String get backupFileEmpty => 'Le fichier de sauvegarde est vide';

  @override
  String get importFromBackup => 'Importer depuis une sauvegarde';

  @override
  String get importSettings => 'Importer les paramètres';

  @override
  String get importContactCards => 'Importer les cartes de visite';

  @override
  String get importCompleted => 'Importation terminée';

  @override
  String get defaultShareFieldsIntro =>
      'Lors du partage d\'un contact, ces champs sont sélectionnés par défaut. Vous pouvez modifier la sélection pour chaque contact.';

  @override
  String get fieldName => 'Nom';

  @override
  String get fieldPhones => 'Téléphones';

  @override
  String get fieldEmails => 'E-mails';

  @override
  String get fieldOrganization => 'Organisation';

  @override
  String get fieldAddresses => 'Adresses';

  @override
  String get fieldWebsites => 'Sites web';

  @override
  String get fieldSocialMedia => 'Réseaux sociaux';

  @override
  String get fieldNotes => 'Notes';

  @override
  String get previewYourName => 'Votre nom';

  @override
  String get previewYourInfo => 'Vos informations';

  @override
  String get selectAtLeastOneField =>
      'Sélectionnez au moins un champ pour afficher le code QR.';

  @override
  String get shareContact => 'Partager le contact';

  @override
  String get backTooltip => 'Retour';

  @override
  String get noName => '(Sans nom)';

  @override
  String get done => 'Terminé';

  @override
  String get quickShare => 'Partage rapide';

  @override
  String get editContactCard => 'Modifier la carte de visite';

  @override
  String get close => 'Fermer';

  @override
  String get shareAsImage => 'Partager en image';

  @override
  String get shareAsVCard => 'Partager en vCard';

  @override
  String get viewQrDataAsText => 'Voir les données du code QR en texte';

  @override
  String get openLink => 'Ouvrir le lien';

  @override
  String get qrCodeData => 'Données du code QR';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papiers';

  @override
  String get copy => 'Copier';

  @override
  String versionFormat(Object version) {
    return 'Version $version';
  }

  @override
  String get sourceCode => 'Code source';

  @override
  String get viewOpenSourceLicenses => 'Voir les licences open-source';

  @override
  String get licenseMplNotice =>
      'Cette application est un logiciel open-source sous licence Mozilla Public License 2.0 (MPL 2.0).';

  @override
  String get readMplLicense => 'Lire la MPL 2.0';

  @override
  String get couldNotOpenLink => 'Impossible d\'ouvrir le lien';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => 'Supprimer la carte ?';

  @override
  String deleteCardMessage(Object name) {
    return 'Supprimer « $name » ? Cette action est irréversible.';
  }

  @override
  String get delete => 'Supprimer';

  @override
  String get pleaseSpecifyLabelForCustom =>
      'Veuillez spécifier un libellé pour Personnalisé';

  @override
  String get cardNeedsData =>
      'La carte doit contenir au moins un champ avec des données (nom, téléphone, e-mail). Le nom de la carte seul n\'est pas inclus dans la vCard.';

  @override
  String saveFailed(Object error) {
    return 'Échec de l\'enregistrement : $error';
  }

  @override
  String get details => 'Détails';

  @override
  String get discardChangesTitle => 'Abandonner les modifications ?';

  @override
  String get discardChangesMessage =>
      'Vous avez des modifications non enregistrées. Enregistrer cette carte avant de fermer ?';

  @override
  String get discard => 'Abandonner';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get data => 'Données';

  @override
  String get save => 'Enregistrer';

  @override
  String get error => 'Erreur';

  @override
  String get editCard => 'Modifier la carte';

  @override
  String get ok => 'OK';

  @override
  String get preview => 'Aperçu';

  @override
  String get card => 'Carte';

  @override
  String get qrCodeStyle => 'Style du code QR';

  @override
  String get background => 'Arrière-plan';

  @override
  String get backgroundSubtitle => 'Remplissage derrière les modules QR';

  @override
  String get quietZone => 'Zone calme';

  @override
  String get quietZoneSubtitle => 'Bordure blanche autour du code QR';

  @override
  String get qrShapeSmooth => 'Lisse';

  @override
  String get qrShapeSquares => 'Carrés';

  @override
  String get qrShapeDots => 'Points';

  @override
  String get roundedCorners => 'Coins arrondis';

  @override
  String get roundedCornersSubtitle => 'Apparence plus douce des modules QR';

  @override
  String get embedded => 'Intégré';

  @override
  String get foreground => 'Premier plan';

  @override
  String get remove => 'Supprimer';

  @override
  String get cardNameHint => 'Pour le tri et l\'identification rapide';

  @override
  String get company => 'Entreprise';

  @override
  String get phoneNumbers => 'Numéros de téléphone';

  @override
  String get emailAddresses => 'Adresses e-mail';

  @override
  String get urls => 'URLs';

  @override
  String get socialMedia => 'Réseaux sociaux';

  @override
  String get addresses => 'Adresses';

  @override
  String get backgroundColor => 'Couleur d\'arrière-plan';

  @override
  String get textColor => 'Couleur du texte';

  @override
  String get imageOrLogo => 'Image ou logo';

  @override
  String get color => 'Couleur';

  @override
  String get style => 'Style';

  @override
  String get logoPosition => 'Position du logo';

  @override
  String get qrCenterImage => 'Image centrale du QR';

  @override
  String get phoneLabelMobile => 'Mobile';

  @override
  String get phoneLabelWork => 'Travail';

  @override
  String get phoneLabelHome => 'Domicile';

  @override
  String get phoneLabelMain => 'Principal';

  @override
  String get phoneLabelOther => 'Autre';

  @override
  String get phoneLabelCustom => 'Personnalisé';

  @override
  String get emailLabelHome => 'Domicile';

  @override
  String get emailLabelWork => 'Travail';

  @override
  String get emailLabelOther => 'Autre';

  @override
  String get emailLabelCustom => 'Personnalisé';

  @override
  String get addressLabelHome => 'Domicile';

  @override
  String get addressLabelWork => 'Travail';

  @override
  String get addressLabelOther => 'Autre';

  @override
  String get addressLabelCustom => 'Personnalisé';

  @override
  String get socialLabelOther => 'Autre';

  @override
  String get socialLabelCustom => 'Personnalisé';

  @override
  String get unknownPlatformIndicatorTooltip => 'Support limité';

  @override
  String get unknownPlatformDialogTitle => 'Plateforme inconnue';

  @override
  String get unknownPlatformDialogMessage =>
      'Cette plateforme n\'est pas dans notre liste. Elle sera enregistrée comme propriété personnalisée (X-SOCIALPROFILE) dans le code QR, et non comme lien cliquable. Les propriétés personnalisées ne sont pas bien prises en charge par toutes les applications et tous les appareils.';

  @override
  String get colorPickerPalette => 'Palette';

  @override
  String get colorPickerPrimary => 'Principal';

  @override
  String get colorPickerAccent => 'Accent';

  @override
  String get colorPickerBW => 'N & B';

  @override
  String get colorPickerCustom => 'Personnalisé';

  @override
  String get colorPickerOptions => 'Options';

  @override
  String get colorPickerWheel => 'Roulette';

  @override
  String get colorPickerColorShade => 'Nuance de couleur';

  @override
  String get colorPickerTonalPalette => 'Palette tonale Material 3';

  @override
  String get colorPickerSelectedColorShades =>
      'Couleur sélectionnée et ses nuances';

  @override
  String get colorPickerOpacity => 'Opacité';

  @override
  String get colorPickerRecentColors => 'Couleurs récentes';

  @override
  String get colorPickerDarkNavy => 'Bleu marine foncé';

  @override
  String get colorPickerNavy => 'Bleu marine';

  @override
  String get colorPickerBlueGrey => 'Bleu gris';

  @override
  String get colorPickerAccentRed => 'Rouge accent';

  @override
  String get colorPickerPurple => 'Violet';

  @override
  String get honorificPrefix => 'Préfixe honorifique';

  @override
  String get additionalNames => 'Noms supplémentaires';

  @override
  String get honorificSuffix => 'Suffixe honorifique';

  @override
  String get nickname => 'Surnom';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get organization => 'Organisation';

  @override
  String get jobTitle => 'Poste';

  @override
  String get companyUnit => 'Unité de l\'entreprise';

  @override
  String get addJobTitle => 'Ajouter un poste';

  @override
  String get addCompanyUnit => 'Ajouter une unité';

  @override
  String get label => 'Libellé';

  @override
  String get phoneLabel => 'Libellé du téléphone';

  @override
  String get emailLabel => 'Libellé de l\'e-mail';

  @override
  String get addressLabel => 'Libellé de l\'adresse';

  @override
  String get phone => 'Téléphone';

  @override
  String get email => 'E-mail';

  @override
  String get addPhone => 'Ajouter un téléphone';

  @override
  String get addEmail => 'Ajouter un e-mail';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'Ajouter une URL';

  @override
  String get platform => 'Plateforme';

  @override
  String get customPlatform => 'Plateforme personnalisée';

  @override
  String get platformName => 'Nom de la plateforme';

  @override
  String get platformNameHint => 'ex. Mastodon, Bluesky';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get addSocialMedia => 'Ajouter un réseau social';

  @override
  String get addAddress => 'Ajouter une adresse';

  @override
  String get address => 'Adresse';

  @override
  String get removeTooltip => 'Supprimer';

  @override
  String get cardName => 'Nom de la carte';

  @override
  String get birthday => 'Anniversaire';

  @override
  String get notes => 'Notes';

  @override
  String get appearanceImageInputTooLarge =>
      'Cette image est trop volumineuse. Utilisez un fichier de moins de 16 Mo.';

  @override
  String get appearanceImageCouldNotProcess =>
      'Impossible d\'utiliser cette image. Essayez une autre image PNG ou JPEG.';

  @override
  String get deleteCard => 'Supprimer la carte';
}
