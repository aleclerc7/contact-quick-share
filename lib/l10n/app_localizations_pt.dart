// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Contact Quick Share';

  @override
  String get noMatchingContacts => 'Nenhum contato correspondente';

  @override
  String couldNotLoadBusinessCards(Object error) {
    return 'Não foi possível carregar os cartões: $error';
  }

  @override
  String get contactPermissionRequired =>
      'A permissão de contatos é necessária para exibir seus contatos.';

  @override
  String get noCardsYet =>
      'Ainda não há cartões.\nAdicione seu primeiro cartão de visita.';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get addBusinessCard => 'Adicionar cartão de visita';

  @override
  String get newBusinessCardTooltip => 'Novo cartão de visita';

  @override
  String get searchHint => 'Buscar cartões ou contatos…';

  @override
  String get clearSearchTooltip => 'Limpar busca';

  @override
  String errorGeneric(Object error) {
    return 'Erro: $error';
  }

  @override
  String get settings => 'Configurações';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get sharing => 'Compartilhamento';

  @override
  String get defaultShareFields => 'Campos padrão ao compartilhar';

  @override
  String get defaultShareFieldsSubtitle =>
      'Nome, telefones, e-mails etc. ao compartilhar contatos';

  @override
  String get appearance => 'Aparência';

  @override
  String get defaultQrCodeStyle => 'Estilo padrão do QR';

  @override
  String get defaultQrCodeStyleSubtitle =>
      'Cores do cartão, fonte e aparência do QR';

  @override
  String get application => 'Aplicativo';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get themeAuto => 'Automático';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get colorTheme => 'Cor do tema';

  @override
  String get autoOpenCardOnLaunch => 'Abrir cartão ao iniciar';

  @override
  String get none => 'Nenhum';

  @override
  String get cardNotFound => 'Cartão não encontrado';

  @override
  String get contactNotFoundOrDeleted =>
      'Contato não encontrado ou foi excluído.';

  @override
  String get loading => 'Carregando…';

  @override
  String get errorLoadingCards => 'Erro ao carregar cartões';

  @override
  String get backup => 'Backup';

  @override
  String get export => 'Exportar';

  @override
  String get exportSubtitle =>
      'Faça backup das configurações e cartões em um arquivo para compartilhar ou guardar';

  @override
  String get import => 'Importar';

  @override
  String get importSubtitle =>
      'Restaurar a partir de um arquivo de backup salvo';

  @override
  String get about => 'Sobre';

  @override
  String get shareAppLink => 'Compartilhar link do app';

  @override
  String get shareAppLinkSubtitle => 'QR code para baixar o aplicativo';

  @override
  String get license => 'Licença';

  @override
  String get licenseSubtitle =>
      'Direitos autorais, licenças de código aberto, código-fonte';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get colorThemeDefault => 'Padrão';

  @override
  String get colorThemeCustomLightDark => 'Personalizado claro e escuro';

  @override
  String get colorThemeCustom => 'Cor personalizada';

  @override
  String get themeFollowSystem => 'Seguir o sistema';

  @override
  String get themeLightMode => 'Modo claro';

  @override
  String get themeDarkMode => 'Modo escuro';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get useDefault => 'Usar padrão';

  @override
  String get useDefaultSubtitle => 'Seguir as cores do sistema ou do app';

  @override
  String get useSameForBoth => 'Mesma cor nos dois';

  @override
  String get useSameForBothSubtitle => 'Mesma cor para modo claro e escuro';

  @override
  String get chooseColor => 'Escolher cor';

  @override
  String get chooseColorSubtitle => 'Escolha uma cor personalizada para o tema';

  @override
  String get lightModeColor => 'Cor no modo claro';

  @override
  String get darkModeColor => 'Cor no modo escuro';

  @override
  String get exportBackup => 'Exportar backup';

  @override
  String get exportAppSettings => 'Exportar configurações';

  @override
  String get exportContactCards => 'Exportar cartões de visita';

  @override
  String get cancel => 'Cancelar';

  @override
  String get exportReadyToShare => 'Exportação pronta para compartilhar';

  @override
  String invalidBackupFile(Object error) {
    return 'Arquivo de backup inválido: $error';
  }

  @override
  String get backupFileEmpty => 'O arquivo de backup está vazio';

  @override
  String get importFromBackup => 'Importar do backup';

  @override
  String get importSettings => 'Importar configurações';

  @override
  String get importContactCards => 'Importar cartões de visita';

  @override
  String get importCompleted => 'Importação concluída';

  @override
  String get defaultShareFieldsIntro =>
      'Ao compartilhar um contato do dispositivo, estes campos são selecionados por padrão. Você pode alterar a seleção por contato.';

  @override
  String get fieldName => 'Nome';

  @override
  String get fieldPhones => 'Telefones';

  @override
  String get fieldEmails => 'E-mails';

  @override
  String get fieldOrganization => 'Organização';

  @override
  String get fieldAddresses => 'Endereços';

  @override
  String get fieldWebsites => 'Sites';

  @override
  String get fieldSocialMedia => 'Redes sociais';

  @override
  String get fieldNotes => 'Notas';

  @override
  String get previewYourName => 'Seu nome';

  @override
  String get previewYourInfo => 'Suas informações';

  @override
  String get selectAtLeastOneField =>
      'Selecione pelo menos um campo para exibir o QR code.';

  @override
  String get shareContact => 'Compartilhar contato';

  @override
  String get backTooltip => 'Voltar';

  @override
  String get noName => '(Sem nome)';

  @override
  String get done => 'Concluído';

  @override
  String get quickShare => 'Compartilhamento rápido';

  @override
  String get editContactCard => 'Editar cartão de visita';

  @override
  String get close => 'Fechar';

  @override
  String get shareAsImage => 'Compartilhar como imagem';

  @override
  String get shareAsVCard => 'Compartilhar como vCard';

  @override
  String get viewQrDataAsText => 'Ver dados do QR como texto';

  @override
  String get openLink => 'Abrir link';

  @override
  String get qrCodeData => 'Dados do QR code';

  @override
  String get copiedToClipboard => 'Copiado para a área de transferência';

  @override
  String get copy => 'Copiar';

  @override
  String versionFormat(Object version) {
    return 'Versão $version';
  }

  @override
  String get sourceCode => 'Código-fonte';

  @override
  String get viewOpenSourceLicenses => 'Ver licenças de código aberto';

  @override
  String get licenseMplNotice =>
      'Este aplicativo é software de código aberto licenciado sob a Mozilla Public License 2.0 (MPL 2.0).';

  @override
  String get readMplLicense => 'Ler MPL 2.0';

  @override
  String get couldNotOpenLink => 'Não foi possível abrir o link';

  @override
  String copyrightFormat(Object year, Object author) {
    return '© $year $author';
  }

  @override
  String get deleteCardTitle => 'Excluir cartão?';

  @override
  String deleteCardMessage(Object name) {
    return 'Excluir \"$name\"? Isso não pode ser desfeito.';
  }

  @override
  String get delete => 'Excluir';

  @override
  String get pleaseSpecifyLabelForCustom =>
      'Defina um rótulo para Personalizado';

  @override
  String get cardNeedsData =>
      'O cartão precisa de pelo menos um campo com dados (por ex. nome, telefone, e-mail). O nome do cartão sozinho não entra no vCard.';

  @override
  String saveFailed(Object error) {
    return 'Falha ao salvar: $error';
  }

  @override
  String get details => 'Detalhes';

  @override
  String get discardChangesTitle => 'Descartar alterações?';

  @override
  String get discardChangesMessage =>
      'Há alterações não salvas. Salvar este cartão antes de fechar?';

  @override
  String get discard => 'Descartar';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get data => 'Dados';

  @override
  String get save => 'Salvar';

  @override
  String get error => 'Erro';

  @override
  String get editCard => 'Editar cartão';

  @override
  String get ok => 'OK';

  @override
  String get preview => 'Pré-visualização';

  @override
  String get card => 'Cartão';

  @override
  String get qrCodeStyle => 'Estilo do QR code';

  @override
  String get background => 'Fundo';

  @override
  String get backgroundSubtitle => 'Preenchimento atrás dos módulos do QR';

  @override
  String get quietZone => 'Zona de silêncio';

  @override
  String get quietZoneSubtitle => 'Borda branca ao redor do QR';

  @override
  String get qrShapeSmooth => 'Suave';

  @override
  String get qrShapeSquares => 'Quadrados';

  @override
  String get qrShapeDots => 'Pontos';

  @override
  String get roundedCorners => 'Cantos arredondados';

  @override
  String get roundedCornersSubtitle => 'Aparência mais suave dos módulos do QR';

  @override
  String get embedded => 'Incorporado';

  @override
  String get foreground => 'Primeiro plano';

  @override
  String get remove => 'Remover';

  @override
  String get cardNameHint => 'Para ordenação e identificação rápida';

  @override
  String get company => 'Empresa';

  @override
  String get phoneNumbers => 'Números de telefone';

  @override
  String get emailAddresses => 'Endereços de e-mail';

  @override
  String get urls => 'URLs';

  @override
  String get socialMedia => 'Redes sociais';

  @override
  String get addresses => 'Endereços';

  @override
  String get backgroundColor => 'Cor de fundo';

  @override
  String get textColor => 'Cor do texto';

  @override
  String get imageOrLogo => 'Imagem ou logotipo';

  @override
  String get color => 'Cor';

  @override
  String get style => 'Estilo';

  @override
  String get logoPosition => 'Posição do logotipo';

  @override
  String get qrCenterImage => 'Imagem central do QR';

  @override
  String get phoneLabelMobile => 'Celular';

  @override
  String get phoneLabelWork => 'Trabalho';

  @override
  String get phoneLabelHome => 'Casa';

  @override
  String get phoneLabelMain => 'Principal';

  @override
  String get phoneLabelOther => 'Outro';

  @override
  String get phoneLabelCustom => 'Personalizado';

  @override
  String get emailLabelHome => 'Casa';

  @override
  String get emailLabelWork => 'Trabalho';

  @override
  String get emailLabelOther => 'Outro';

  @override
  String get emailLabelCustom => 'Personalizado';

  @override
  String get addressLabelHome => 'Casa';

  @override
  String get addressLabelWork => 'Trabalho';

  @override
  String get addressLabelOther => 'Outro';

  @override
  String get addressLabelCustom => 'Personalizado';

  @override
  String get socialLabelOther => 'Outro';

  @override
  String get socialLabelCustom => 'Personalizado';

  @override
  String get unknownPlatformIndicatorTooltip => 'Suporte limitado';

  @override
  String get unknownPlatformDialogTitle => 'Plataforma desconhecida';

  @override
  String get unknownPlatformDialogMessage =>
      'Esta plataforma não está na nossa lista. Será salva como propriedade personalizada (X-SOCIALPROFILE) no QR code, não como link clicável. Propriedades personalizadas não são bem suportadas em todos os apps e dispositivos.';

  @override
  String get colorPickerPalette => 'Paleta';

  @override
  String get colorPickerPrimary => 'Primária';

  @override
  String get colorPickerAccent => 'Destaque';

  @override
  String get colorPickerBW => 'P & B';

  @override
  String get colorPickerCustom => 'Personalizado';

  @override
  String get colorPickerOptions => 'Opções';

  @override
  String get colorPickerWheel => 'Roda';

  @override
  String get colorPickerColorShade => 'Tom de cor';

  @override
  String get colorPickerTonalPalette => 'Paleta tonal Material 3';

  @override
  String get colorPickerSelectedColorShades => 'Cor selecionada e tons';

  @override
  String get colorPickerOpacity => 'Opacidade';

  @override
  String get colorPickerRecentColors => 'Cores recentes';

  @override
  String get colorPickerDarkNavy => 'Azul-marinho escuro';

  @override
  String get colorPickerNavy => 'Azul-marinho';

  @override
  String get colorPickerBlueGrey => 'Azul-acinzentado';

  @override
  String get colorPickerAccentRed => 'Vermelho destaque';

  @override
  String get colorPickerPurple => 'Roxo';

  @override
  String get honorificPrefix => 'Prefixo honorífico';

  @override
  String get additionalNames => 'Nomes adicionais';

  @override
  String get honorificSuffix => 'Sufixo honorífico';

  @override
  String get nickname => 'Apelido';

  @override
  String get firstName => 'Nome';

  @override
  String get lastName => 'Sobrenome';

  @override
  String get organization => 'Organização';

  @override
  String get jobTitle => 'Cargo';

  @override
  String get companyUnit => 'Unidade da empresa';

  @override
  String get addJobTitle => 'Adicionar cargo';

  @override
  String get addCompanyUnit => 'Adicionar unidade';

  @override
  String get label => 'Rótulo';

  @override
  String get phoneLabel => 'Rótulo do telefone';

  @override
  String get emailLabel => 'Rótulo do e-mail';

  @override
  String get addressLabel => 'Rótulo do endereço';

  @override
  String get phone => 'Telefone';

  @override
  String get email => 'E-mail';

  @override
  String get addPhone => 'Adicionar telefone';

  @override
  String get addEmail => 'Adicionar e-mail';

  @override
  String get url => 'URL';

  @override
  String get addUrl => 'Adicionar URL';

  @override
  String get platform => 'Plataforma';

  @override
  String get customPlatform => 'Plataforma personalizada';

  @override
  String get platformName => 'Nome da plataforma';

  @override
  String get platformNameHint => 'ex.: Mastodon, Bluesky';

  @override
  String get username => 'Nome de usuário';

  @override
  String get addSocialMedia => 'Adicionar rede social';

  @override
  String get addAddress => 'Adicionar endereço';

  @override
  String get address => 'Endereço';

  @override
  String get removeTooltip => 'Remover';

  @override
  String get cardName => 'Nome do cartão';

  @override
  String get birthday => 'Aniversário';

  @override
  String get notes => 'Notas';

  @override
  String get appearanceImageInputTooLarge =>
      'Esta imagem é grande demais. Use um arquivo menor que 16 MB.';

  @override
  String get appearanceImageCouldNotProcess =>
      'Não foi possível usar esta imagem. Tente outro PNG ou JPEG.';

  @override
  String get deleteCard => 'Excluir cartão';
}
