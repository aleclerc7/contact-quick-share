// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'No hay contactos coincidentes';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'No se pudieron cargar las tarjetas: $error';
  }

  @override
  String get contactPermissionRequired =>
      'Se necesita permiso de contactos para mostrar tus contactos.';

  @override
  String get noCardsYet =>
      'Aún no hay tarjetas.\nAñade tu primera tarjeta de visita.';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get addBusinessCard => 'Añadir tarjeta de visita';

  @override
  String get newBusinessCardTooltip => 'Nueva tarjeta de visita';

  @override
  String get searchHint => 'Buscar tarjetas o contactos…';

  @override
  String get clearSearchTooltip => 'Borrar búsqueda';

  @override
  String errorGeneric(Object error) {
    return 'Error: $error';
  }

  @override
  String get settings => 'Ajustes';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get sharing => 'Compartir';

  @override
  String get defaultShareFields => 'Campos predeterminados al compartir';

  @override
  String get defaultShareFieldsSubtitle =>
      'Nombre, teléfonos, correos, etc. al compartir contactos';

  @override
  String get appearance => 'Apariencia';

  @override
  String get defaultQrCodeStyle => 'Estilo QR predeterminado';

  @override
  String get defaultQrCodeStyleSubtitle =>
      'Colores de la tarjeta, fuente y apariencia del QR';

  @override
  String get application => 'Aplicación';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get themeAuto => 'Automático';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get colorTheme => 'Color del tema';

  @override
  String get autoOpenCardOnLaunch => 'Abrir tarjeta al iniciar';

  @override
  String get none => 'Ninguna';

  @override
  String get cardNotFound => 'Tarjeta no encontrada';

  @override
  String get contactNotFoundOrDeleted => 'Contacto no encontrado o eliminado.';

  @override
  String get loading => 'Cargando…';

  @override
  String get errorLoadingCards => 'Error al cargar las tarjetas';

  @override
  String get backup => 'Copia de seguridad';

  @override
  String get export => 'Exportar';

  @override
  String get exportSubtitle =>
      'Respalda tus ajustes y tarjetas en un archivo para compartir o guardar';

  @override
  String get import => 'Importar';

  @override
  String get importSubtitle =>
      'Restaurar desde un archivo de copia de seguridad';

  @override
  String get about => 'Acerca de';

  @override
  String get shareAppLink => 'Compartir enlace de la app';

  @override
  String get shareAppLinkSubtitle => 'Código QR para descargar la aplicación';

  @override
  String get license => 'Licencia';

  @override
  String get licenseSubtitle =>
      'Derechos de autor, licencias de código abierto, código fuente';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get colorThemeDefault => 'Predeterminado';

  @override
  String get colorThemeCustomLightDark => 'Personalizado claro y oscuro';

  @override
  String get colorThemeCustom => 'Color personalizado';

  @override
  String get themeFollowSystem => 'Seguir el sistema';

  @override
  String get themeLightMode => 'Modo claro';

  @override
  String get themeDarkMode => 'Modo oscuro';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get useDefault => 'Usar predeterminado';

  @override
  String get useDefaultSubtitle => 'Seguir los colores del sistema o de la app';

  @override
  String get useSameForBoth => 'Mismo color en ambos';

  @override
  String get useSameForBothSubtitle => 'Mismo color para modo claro y oscuro';

  @override
  String get chooseColor => 'Elegir color';

  @override
  String get chooseColorSubtitle => 'Elige un color personalizado para el tema';

  @override
  String get lightModeColor => 'Color en modo claro';

  @override
  String get darkModeColor => 'Color en modo oscuro';

  @override
  String get exportBackup => 'Exportar copia de seguridad';

  @override
  String get exportAppSettings => 'Exportar ajustes';

  @override
  String get exportContactCards => 'Exportar tarjetas de visita';

  @override
  String get cancel => 'Cancelar';

  @override
  String get exportReadyToShare => 'Exportación lista para compartir';

  @override
  String invalidBackupFile(Object error) {
    return 'Archivo de copia no válido: $error';
  }

  @override
  String get backupFileEmpty => 'El archivo de copia está vacío';

  @override
  String get importFromBackup => 'Importar desde copia';

  @override
  String get importSettings => 'Importar ajustes';

  @override
  String get importContactCards => 'Importar tarjetas de visita';

  @override
  String get importCompleted => 'Importación completada';

  @override
  String get defaultShareFieldsIntro =>
      'Al compartir un contacto del dispositivo, estos campos están seleccionados por defecto. Puedes cambiar la selección por contacto.';

  @override
  String get fieldName => 'Nombre';

  @override
  String get fieldPhones => 'Teléfonos';

  @override
  String get fieldEmails => 'Correos';

  @override
  String get fieldOrganization => 'Organización';

  @override
  String get fieldAddresses => 'Direcciones';

  @override
  String get fieldWebsites => 'Sitios web';

  @override
  String get fieldSocialMedia => 'Redes sociales';

  @override
  String get fieldNotes => 'Notas';

  @override
  String get previewYourName => 'Tu nombre';

  @override
  String get previewYourInfo => 'Tu información';

  @override
  String get selectAtLeastOneField =>
      'Selecciona al menos un campo para mostrar el código QR.';

  @override
  String get shareContact => 'Compartir contacto';

  @override
  String get backTooltip => 'Atrás';

  @override
  String get noName => '(Sin nombre)';

  @override
  String get done => 'Hecho';

  @override
  String get quickShare => 'Compartir rápido';

  @override
  String get editContactCard => 'Editar tarjeta de visita';

  @override
  String get close => 'Cerrar';

  @override
  String get shareAsImage => 'Compartir como imagen';

  @override
  String get shareAsVCard => 'Compartir como vCard';

  @override
  String get viewQrDataAsText => 'Ver datos del QR como texto';

  @override
  String get openLink => 'Abrir enlace';

  @override
  String get qrCodeData => 'Datos del código QR';

  @override
  String get copiedToClipboard => 'Copiado al portapapeles';

  @override
  String get copy => 'Copiar';

  @override
  String versionFormat(Object version) {
    return 'Versión $version';
  }

  @override
  String get sourceCode => 'Código fuente';

  @override
  String get viewOpenSourceLicenses => 'Ver licencias de código abierto';

  @override
  String get licenseMplNotice =>
      'Esta aplicación es software de código abierto bajo la Mozilla Public License 2.0 (MPL 2.0).';

  @override
  String get readMplLicense => 'Leer MPL 2.0';

  @override
  String get couldNotOpenLink => 'No se pudo abrir el enlace';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => '¿Eliminar tarjeta?';

  @override
  String deleteCardMessage(Object name) {
    return '¿Eliminar «$name»? No se puede deshacer.';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get pleaseSpecifyLabelForCustom =>
      'Indica una etiqueta para Personalizado';

  @override
  String get cardNeedsData =>
      'La tarjeta necesita al menos un campo con datos (p. ej. nombre, teléfono, correo). El nombre de la tarjeta solo no se incluye en la vCard.';

  @override
  String saveFailed(Object error) {
    return 'Error al guardar: $error';
  }

  @override
  String get details => 'Detalles';

  @override
  String get discardChangesTitle => '¿Descartar cambios?';

  @override
  String get discardChangesMessage =>
      'Hay cambios sin guardar. ¿Guardar esta tarjeta antes de cerrar?';

  @override
  String get discard => 'Descartar';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get data => 'Datos';

  @override
  String get save => 'Guardar';

  @override
  String get error => 'Error';

  @override
  String get editCard => 'Editar tarjeta';

  @override
  String get ok => 'Aceptar';

  @override
  String get preview => 'Vista previa';

  @override
  String get card => 'Tarjeta';

  @override
  String get qrCodeStyle => 'Estilo del código QR';

  @override
  String get background => 'Fondo';

  @override
  String get backgroundSubtitle => 'Relleno detrás de los módulos del QR';

  @override
  String get quietZone => 'Zona silenciosa';

  @override
  String get quietZoneSubtitle => 'Borde blanco alrededor del código QR';

  @override
  String get qrShapeSmooth => 'Suave';

  @override
  String get qrShapeSquares => 'Cuadrados';

  @override
  String get qrShapeDots => 'Puntos';

  @override
  String get roundedCorners => 'Esquinas redondeadas';

  @override
  String get roundedCornersSubtitle =>
      'Apariencia más suave de los módulos del QR';

  @override
  String get embedded => 'Incrustado';

  @override
  String get foreground => 'Primer plano';

  @override
  String get remove => 'Quitar';

  @override
  String get cardNameHint => 'Para ordenar e identificar rápidamente';

  @override
  String get company => 'Empresa';

  @override
  String get phoneNumbers => 'Números de teléfono';

  @override
  String get emailAddresses => 'Direcciones de correo';

  @override
  String get urls => 'URLs';

  @override
  String get socialMedia => 'Redes sociales';

  @override
  String get addresses => 'Direcciones';

  @override
  String get backgroundColor => 'Color de fondo';

  @override
  String get textColor => 'Color del texto';

  @override
  String get imageOrLogo => 'Imagen o logotipo';

  @override
  String get color => 'Color';

  @override
  String get style => 'Estilo';

  @override
  String get logoPosition => 'Posición del logotipo';

  @override
  String get qrCenterImage => 'Imagen central del QR';

  @override
  String get phoneLabelMobile => 'Móvil';

  @override
  String get phoneLabelWork => 'Trabajo';

  @override
  String get phoneLabelHome => 'Casa';

  @override
  String get phoneLabelMain => 'Principal';

  @override
  String get phoneLabelOther => 'Otro';

  @override
  String get phoneLabelCustom => 'Personalizado';

  @override
  String get emailLabelHome => 'Casa';

  @override
  String get emailLabelWork => 'Trabajo';

  @override
  String get emailLabelOther => 'Otro';

  @override
  String get emailLabelCustom => 'Personalizado';

  @override
  String get addressLabelHome => 'Casa';

  @override
  String get addressLabelWork => 'Trabajo';

  @override
  String get addressLabelOther => 'Otro';

  @override
  String get addressLabelCustom => 'Personalizado';

  @override
  String get socialLabelOther => 'Otro';

  @override
  String get socialLabelCustom => 'Personalizado';

  @override
  String get unknownPlatformIndicatorTooltip => 'Compatibilidad limitada';

  @override
  String get unknownPlatformDialogTitle => 'Plataforma desconocida';

  @override
  String get unknownPlatformDialogMessage =>
      'Esta plataforma no está en nuestra lista. Se guardará como propiedad personalizada (X-SOCIALPROFILE) en el código QR, no como enlace. Las propiedades personalizadas no son bien compatibles con todas las apps y dispositivos.';

  @override
  String get colorPickerPalette => 'Paleta';

  @override
  String get colorPickerPrimary => 'Primario';

  @override
  String get colorPickerAccent => 'Acento';

  @override
  String get colorPickerBW => 'B y N';

  @override
  String get colorPickerCustom => 'Personalizado';

  @override
  String get colorPickerOptions => 'Opciones';

  @override
  String get colorPickerWheel => 'Rueda';

  @override
  String get colorPickerColorShade => 'Tono de color';

  @override
  String get colorPickerTonalPalette => 'Paleta tonal Material 3';

  @override
  String get colorPickerSelectedColorShades => 'Color seleccionado y sus tonos';

  @override
  String get colorPickerOpacity => 'Opacidad';

  @override
  String get colorPickerRecentColors => 'Colores recientes';

  @override
  String get colorPickerDarkNavy => 'Azul marino oscuro';

  @override
  String get colorPickerNavy => 'Azul marino';

  @override
  String get colorPickerBlueGrey => 'Azul grisáceo';

  @override
  String get colorPickerAccentRed => 'Rojo de acento';

  @override
  String get colorPickerPurple => 'Morado';

  @override
  String get honorificPrefix => 'Prefijo honorífico';

  @override
  String get additionalNames => 'Nombres adicionales';

  @override
  String get honorificSuffix => 'Sufijo honorífico';

  @override
  String get nickname => 'Apodo';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellidos';

  @override
  String get organization => 'Organización';

  @override
  String get jobTitle => 'Puesto';

  @override
  String get companyUnit => 'Unidad de la empresa';

  @override
  String get addJobTitle => 'Añadir puesto';

  @override
  String get addCompanyUnit => 'Añadir unidad';

  @override
  String get label => 'Etiqueta';

  @override
  String get phoneLabel => 'Etiqueta del teléfono';

  @override
  String get emailLabel => 'Etiqueta del correo';

  @override
  String get addressLabel => 'Etiqueta de la dirección';

  @override
  String get phone => 'Teléfono';

  @override
  String get email => 'Correo';

  @override
  String get addPhone => 'Añadir teléfono';

  @override
  String get addEmail => 'Añadir correo';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'Añadir URL';

  @override
  String get platform => 'Plataforma';

  @override
  String get customPlatform => 'Plataforma personalizada';

  @override
  String get platformName => 'Nombre de la plataforma';

  @override
  String get platformNameHint => 'p. ej. Mastodon, Bluesky';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get addSocialMedia => 'Añadir red social';

  @override
  String get addAddress => 'Añadir dirección';

  @override
  String get address => 'Dirección';

  @override
  String get removeTooltip => 'Quitar';

  @override
  String get cardName => 'Nombre de la tarjeta';

  @override
  String get birthday => 'Cumpleaños';

  @override
  String get notes => 'Notas';

  @override
  String get appearanceImageInputTooLarge =>
      'Esta imagen es demasiado grande. Usa un archivo de menos de 16 MB.';

  @override
  String get appearanceImageCouldNotProcess =>
      'No se pudo usar esta imagen. Prueba otro PNG o JPEG.';

  @override
  String get deleteCard => 'Eliminar tarjeta';
}
