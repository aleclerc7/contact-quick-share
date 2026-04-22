// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/social_platform_resolver.dart';
import '../../../core/constants/vcard_label_options.dart';
import '../../../core/widgets/form_section_title.dart';
import '../models/business_card.dart';

/// Data tab: edit contact fields (name, phones, emails, org, etc.).
/// Holds local draft; does not call onCardChanged on every keystroke.
/// Parent calls getDraftCard() on Save to get current values.
class BusinessCardDataTab extends StatefulWidget {
  const BusinessCardDataTab({
    super.key,
    required this.card,
    this.onDelete,
  });

  final BusinessCard card;
  final void Function(BusinessCard card)? onDelete;

  @override
  State<BusinessCardDataTab> createState() => BusinessCardDataTabState();
}

class BusinessCardDataTabState extends State<BusinessCardDataTab> {
  late TextEditingController _cardNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _orgController;
  late TextEditingController _titleController;
  late TextEditingController _departmentController;
  late TextEditingController _notesController;
  late TextEditingController _prefixController;
  late TextEditingController _middleController;
  late TextEditingController _suffixController;
  late TextEditingController _nicknameController;
  late TextEditingController _birthdayController;
  final List<({TextEditingController number, PhoneLabel label, String? customLabel, FocusNode focus})> _phoneEntries = [];
  final List<({TextEditingController address, EmailLabel label, String? customLabel, FocusNode focus})> _emailEntries = [];
  final List<({TextEditingController url, FocusNode focus})> _websiteEntries = [];
  final List<({TextEditingController username, AppSocialPlatform? platform, String? customLabel, FocusNode focus})> _socialMediaEntries = [];
  final List<({TextEditingController formatted, AddressLabel label, String? customLabel, FocusNode focus})> _addressEntries = [];

  final Set<String> _addedNameFields = {};
  int? _invalidPhoneIndex;
  int? _invalidEmailIndex;
  int? _invalidSocialIndex;
  int? _invalidAddressIndex;
  late ScrollController _scrollController;
  bool _hasBirthday = false;
  int? _birthdayYear;
  int _birthdayMonth = 1;
  int _birthdayDay = 1;
  bool _hasDepartment = false;
  bool _hasJobTitle = false;

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _prefixFocus = FocusNode();
  final FocusNode _middleFocus = FocusNode();
  final FocusNode _suffixFocus = FocusNode();
  final FocusNode _nicknameFocus = FocusNode();
  final FocusNode _departmentFocus = FocusNode();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _cardNameFocus = FocusNode();

  /// Avoid firing alias hint when the field never had focus (e.g. widget dispose).
  bool _cardNameFieldHadFocus = false;

  static final _phoneFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'[\d\s\-\+\(\)]'),
  );

  Future<String?> _showCustomLabelDialog(String title, String? initialValue) async {
    final loc = AppLocalizations.of(context)!;
    var controller = TextEditingController(text: initialValue ?? '');
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: loc.label),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, null), child: Text(loc.cancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, controller.text.trim()), child: Text(loc.ok)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _cardNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _orgController = TextEditingController();
    _titleController = TextEditingController();
    _departmentController = TextEditingController();
    _notesController = TextEditingController();
    _prefixController = TextEditingController();
    _middleController = TextEditingController();
    _suffixController = TextEditingController();
    _nicknameController = TextEditingController();
    _birthdayController = TextEditingController();
    _syncControllersFromCard(widget.card);
    _cardNameFocus.addListener(_onCardNameFocusChange);
  }

  @override
  void didUpdateWidget(BusinessCardDataTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_dataFieldsChanged(oldWidget.card, widget.card)) {
      _syncControllersFromCard(widget.card, AppLocalizations.of(context));
    }
  }

  bool _dataFieldsChanged(BusinessCard a, BusinessCard b) {
    if (a.cardName != b.cardName ||
        a.displayOrg != b.displayOrg ||
        a.displayTitle != b.displayTitle ||
        a.displaySubtitle != b.displaySubtitle) {
      return true;
    }
    final an = a.contact.name;
    final bn = b.contact.name;
    if (an?.first != bn?.first ||
        an?.last != bn?.last ||
        an?.prefix != bn?.prefix ||
        an?.middle != bn?.middle ||
        an?.suffix != bn?.suffix ||
        an?.nickname != bn?.nickname) {
      return true;
    }
    if (a.contact.phones.length != b.contact.phones.length) return true;
    if (a.contact.emails.length != b.contact.emails.length) return true;
    if (a.contact.websites.length != b.contact.websites.length) return true;
    if (a.contact.socialMedias.length != b.contact.socialMedias.length) return true;
    if (a.contact.addresses.length != b.contact.addresses.length) return true;
    for (var i = 0; i < a.contact.phones.length; i++) {
      if (a.contact.phones[i].number != b.contact.phones[i].number) return true;
    }
    for (var i = 0; i < a.contact.emails.length; i++) {
      if (a.contact.emails[i].address != b.contact.emails[i].address) return true;
    }
    for (var i = 0; i < a.contact.websites.length; i++) {
      if (a.contact.websites[i].url != b.contact.websites[i].url) return true;
    }
    for (var i = 0; i < a.contact.socialMedias.length; i++) {
      if (a.contact.socialMedias[i].username != b.contact.socialMedias[i].username) return true;
    }
    for (var i = 0; i < a.contact.addresses.length; i++) {
      if (a.contact.addresses[i].formatted != b.contact.addresses[i].formatted) return true;
    }
    final aBday = a.contact.events.where((e) => e.label.label == EventLabel.birthday).firstOrNull;
    final bBday = b.contact.events.where((e) => e.label.label == EventLabel.birthday).firstOrNull;
    if ((aBday == null) != (bBday == null)) return true;
    if (aBday != null && bBday != null) {
      if (aBday.year != bBday.year || aBday.month != bBday.month || aBday.day != bBday.day) return true;
    }
    final aNote = a.contact.notes.isNotEmpty ? a.contact.notes.first.note : '';
    final bNote = b.contact.notes.isNotEmpty ? b.contact.notes.first.note : '';
    return aNote != bNote;
  }

  void _syncControllersFromCard(BusinessCard card, [AppLocalizations? loc]) {
    _cardNameController.text = card.cardName;
    _firstNameController.text = card.contact.name?.first ?? '';
    _lastNameController.text = card.contact.name?.last ?? '';
    _prefixController.text = card.contact.name?.prefix ?? '';
    _middleController.text = card.contact.name?.middle ?? '';
    _suffixController.text = card.contact.name?.suffix ?? '';
    _nicknameController.text = card.contact.name?.nickname ?? '';
    _orgController.text = card.displayOrg;
    _titleController.text = card.displayTitle;
    final org = card.contact.organizations.isNotEmpty ? card.contact.organizations.first : null;
    _departmentController.text = org?.departmentName ?? card.displaySubtitle;
    _notesController.text =
        card.contact.notes.isNotEmpty ? card.contact.notes.first.note : '';

    _addedNameFields.clear();
    if ((card.contact.name?.prefix ?? '').isNotEmpty) _addedNameFields.add('prefix');
    if ((card.contact.name?.middle ?? '').isNotEmpty) _addedNameFields.add('middle');
    if ((card.contact.name?.suffix ?? '').isNotEmpty) _addedNameFields.add('suffix');
    if ((card.contact.name?.nickname ?? '').isNotEmpty) _addedNameFields.add('nickname');

    _hasDepartment = (org?.departmentName ?? card.displaySubtitle).trim().isNotEmpty;
    _hasJobTitle = (org?.jobTitle ?? card.displayTitle).trim().isNotEmpty;

    final bday = card.contact.events.where((e) => e.label.label == EventLabel.birthday).firstOrNull;
    _hasBirthday = bday != null;
    if (bday != null) {
      _birthdayYear = bday.year;
      _birthdayMonth = bday.month;
      _birthdayDay = bday.day;
    } else {
      _birthdayYear = null;
      _birthdayMonth = 1;
      _birthdayDay = 1;
    }
    if (_hasBirthday) {
      _birthdayController.text = _formatBirthday();
    }

    for (final e in _phoneEntries) {
      e.number.dispose();
      e.focus.dispose();
    }
    _phoneEntries.clear();
    for (final p in card.contact.phones) {
      final fn = FocusNode();
      fn.addListener(() => setState(() {}));
      final (label, customLabel) = VcardLabelOptions.normalizePhoneLabel(p.label.label, p.label.customLabel, loc);
      _phoneEntries.add((
        number: TextEditingController(text: p.number),
        label: label,
        customLabel: customLabel,
        focus: fn,
      ));
    }
    if (_phoneEntries.isEmpty) {
      final fn = FocusNode();
      fn.addListener(() => setState(() {}));
      _phoneEntries.add((
        number: TextEditingController(),
        label: VcardLabelOptions.defaultPhoneLabel,
        customLabel: null,
        focus: fn,
      ));
    }

    for (final e in _emailEntries) {
      e.address.dispose();
      e.focus.dispose();
    }
    _emailEntries.clear();
    for (final e in card.contact.emails) {
      final fn = FocusNode();
      fn.addListener(() => setState(() {}));
      final (label, customLabel) = VcardLabelOptions.normalizeEmailLabel(e.label.label, e.label.customLabel, loc);
      _emailEntries.add((
        address: TextEditingController(text: e.address),
        label: label,
        customLabel: customLabel,
        focus: fn,
      ));
    }
    if (_emailEntries.isEmpty) {
      final fn = FocusNode();
      fn.addListener(() => setState(() {}));
      _emailEntries.add((
        address: TextEditingController(),
        label: VcardLabelOptions.defaultEmailLabel,
        customLabel: null,
        focus: fn,
      ));
    }

    for (final e in _websiteEntries) {
      e.url.dispose();
      e.focus.dispose();
    }
    _websiteEntries.clear();
    for (final w in card.contact.websites) {
      final fn = FocusNode();
      fn.addListener(() => setState(() {}));
      _websiteEntries.add((
        url: TextEditingController(text: w.url),
        focus: fn,
      ));
    }

    for (final e in _socialMediaEntries) {
      e.username.dispose();
      e.focus.dispose();
    }
    _socialMediaEntries.clear();
    for (final s in card.contact.socialMedias) {
      final fn = FocusNode();
      fn.addListener(() => setState(() {}));
      final (platform, customLabel) = SocialPlatformResolver.resolveForRead(s, loc);
      _socialMediaEntries.add((
        username: TextEditingController(text: s.username),
        platform: platform,
        customLabel: customLabel,
        focus: fn,
      ));
    }

    for (final e in _addressEntries) {
      e.formatted.dispose();
      e.focus.dispose();
    }
    _addressEntries.clear();
    for (final a in card.contact.addresses) {
      final fn = FocusNode();
      fn.addListener(() => setState(() {}));
      final (label, customLabel) = VcardLabelOptions.normalizeAddressLabel(a.label.label, a.label.customLabel, loc);
      _addressEntries.add((
        formatted: TextEditingController(text: a.formatted ?? ''),
        label: label,
        customLabel: customLabel,
        focus: fn,
      ));
    }
  }

  BusinessCard getDraftCard() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final prefix = _prefixController.text.trim();
    final middle = _middleController.text.trim();
    final suffix = _suffixController.text.trim();
    final nickname = _nicknameController.text.trim();
    final displayFullName = [prefix, firstName, middle, lastName, suffix]
        .where((s) => s.isNotEmpty)
        .join(' ');

    final phones = _phoneEntries
        .map((e) => (n: e.number.text.trim(), l: e.label, c: e.customLabel))
        .where((x) => x.n.isNotEmpty)
        .map((x) => Phone(
              number: x.n,
              label: x.l == PhoneLabel.custom && x.c != null && x.c!.isNotEmpty
                  ? Label<PhoneLabel>(PhoneLabel.custom, x.c)
                  : Label<PhoneLabel>(x.l),
            ))
        .toList();

    final emails = _emailEntries
        .map((e) => (a: e.address.text.trim(), l: e.label, c: e.customLabel))
        .where((x) => x.a.isNotEmpty)
        .map((x) => Email(
              address: x.a,
              label: x.l == EmailLabel.custom && x.c != null && x.c!.isNotEmpty
                  ? Label<EmailLabel>(EmailLabel.custom, x.c)
                  : Label<EmailLabel>(x.l),
            ))
        .toList();

    final websites = _websiteEntries
        .map((e) => e.url.text.trim())
        .where((u) => u.isNotEmpty)
        .map((u) => Website(url: u, label: const Label(WebsiteLabel.homepage)))
        .toList();

    final socialMediaList = <SocialMedia>[];
    for (final e in _socialMediaEntries) {
      final s = e.username.text.trim();
      if (s.isNotEmpty) {
        final label = SocialPlatformResolver.resolveForWrite(e.platform, e.customLabel);
        socialMediaList.add(SocialMedia(username: s, label: label));
      }
    }

    final addresses = _addressEntries
        .map((e) => (f: e.formatted.text.trim(), l: e.label, c: e.customLabel))
        .where((x) => x.f.isNotEmpty)
        .map((x) => Address(
              formatted: x.f,
              label: x.l == AddressLabel.custom && x.c != null && x.c!.isNotEmpty
                  ? Label<AddressLabel>(AddressLabel.custom, x.c)
                  : Label<AddressLabel>(x.l),
            ))
        .toList();

    final orgName = _orgController.text.trim();
    final jobTitle = _titleController.text.trim();
    final department = _departmentController.text.trim();
    final organizations = orgName.isNotEmpty
        ? <Organization>[
            Organization(
              name: orgName,
              jobTitle: jobTitle.isEmpty ? null : jobTitle,
              departmentName: department.isEmpty ? null : department,
            )
          ]
        : <Organization>[];

    final events = <Event>[];
    if (_hasBirthday) {
      events.add(Event(
        year: _birthdayYear,
        month: _birthdayMonth,
        day: _birthdayDay,
        label: Label(EventLabel.birthday),
      ));
    }

    final notesText = _notesController.text.trim();
    final notes =
        notesText.isNotEmpty ? <Note>[Note(note: notesText)] : <Note>[];

    final contact = widget.card.contact.copyWith(
      name: Name(
        first: firstName,
        last: lastName.isEmpty ? null : lastName,
        prefix: prefix.isEmpty ? null : prefix,
        middle: middle.isEmpty ? null : middle,
        suffix: suffix.isEmpty ? null : suffix,
        nickname: nickname.isEmpty ? null : nickname,
      ),
      displayName: displayFullName.isNotEmpty ? displayFullName : null,
      phones: phones,
      emails: emails,
      organizations: organizations,
      websites: websites,
      socialMedias: socialMediaList,
      addresses: addresses,
      events: events,
      notes: notes,
    );

    final primaryPhone = phones.isNotEmpty ? phones.first.number : (_phoneEntries.isNotEmpty ? _phoneEntries.first.number.text.trim() : '');
    final primaryEmail = emails.isNotEmpty ? emails.first.address : (_emailEntries.isNotEmpty ? _emailEntries.first.address.text.trim() : '');

    return widget.card.copyWith(
      cardName: _cardNameController.text,
      displayFullName: displayFullName,
      displayOrg: orgName,
      displayTitle: jobTitle,
      displaySubtitle: department,
      primaryPhone: primaryPhone,
      primaryEmail: primaryEmail,
      contact: contact,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Widget _buildSectionAddButton({required String label, required VoidCallback onPressed}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add, size: 18),
          label: Text(label),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButtonsRow(List<({String label, VoidCallback onAdd})> buttons) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: buttons
            .map((b) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton.icon(
                      onPressed: () => b.onAdd(),
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(b.label),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  void _addNameField(String field, FocusNode focus) {
    setState(() {
      _addedNameFields.add(field);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focus.requestFocus();
    });
  }

  void _removeNameField(String field) {
    setState(() {
      _addedNameFields.remove(field);
    });
  }

  Widget _buildOptionalNameField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String removeTooltip,
    required VoidCallback onRemove,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: onRemove,
                tooltip: removeTooltip,
                style: IconButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(32, 32),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatBirthday() {
    final date = DateTime(_birthdayYear ?? 2000, _birthdayMonth, _birthdayDay);
    final locale = WidgetsBinding.instance.platformDispatcher.locale.toString();
    return _birthdayYear != null
        ? DateFormat.yMMMd(locale).format(date)
        : DateFormat.MMMd(locale).format(date);
  }

  Widget _buildBirthdayRow(AppLocalizations loc) {
    return TextFormField(
      readOnly: true,
      controller: _birthdayController,
      decoration: InputDecoration(
        labelText: loc.birthday,
        suffixIcon: IconButton(
          icon: const Icon(Icons.delete_outline, size: 18),
          onPressed: () => setState(() => _hasBirthday = false),
          tooltip: loc.removeTooltip,
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            minimumSize: const Size(32, 32),
          ),
        ),
      ),
      onTap: _showBirthdayPicker,
    );
  }

  void _addBirthday() {
    setState(() {
      _hasBirthday = true;
      _birthdayController.text = _formatBirthday();
    });
    _showBirthdayPicker();
  }

  Future<void> _showBirthdayPicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(_birthdayYear ?? 2000, _birthdayMonth, _birthdayDay),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      setState(() {
        _birthdayYear = date.year;
        _birthdayMonth = date.month;
        _birthdayDay = date.day;
        _birthdayController.text = _formatBirthday();
      });
    }
  }

  void _addDepartment() {
    setState(() => _hasDepartment = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _departmentFocus.requestFocus();
    });
  }

  void _addJobTitle() {
    setState(() => _hasJobTitle = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocus.requestFocus();
    });
  }

  void _removeJobTitle() {
    setState(() {
      _hasJobTitle = false;
      _titleController.clear();
    });
  }

  void _removeDepartment() {
    setState(() {
      _hasDepartment = false;
      _departmentController.clear();
    });
  }

  void _addPhone() {
    final fn = FocusNode();
    fn.addListener(() => setState(() {}));
    setState(() => _phoneEntries.add((
          number: TextEditingController(),
          label: VcardLabelOptions.defaultPhoneLabel,
          customLabel: null,
          focus: fn,
        )));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _phoneEntries.last.focus.requestFocus();
    });
  }

  void _removePhone(int index) {
    setState(() {
      _phoneEntries[index].number.dispose();
      _phoneEntries[index].focus.dispose();
      _phoneEntries.removeAt(index);
    });
  }

  void _addEmail() {
    final fn = FocusNode();
    fn.addListener(() => setState(() {}));
    setState(() => _emailEntries.add((
          address: TextEditingController(),
          label: VcardLabelOptions.defaultEmailLabel,
          customLabel: null,
          focus: fn,
        )));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailEntries.last.focus.requestFocus();
    });
  }

  void _removeEmail(int index) {
    setState(() {
      _emailEntries[index].address.dispose();
      _emailEntries[index].focus.dispose();
      _emailEntries.removeAt(index);
    });
  }

  void _addWebsite() {
    final fn = FocusNode();
    fn.addListener(() => setState(() {}));
    setState(() => _websiteEntries.add((
          url: TextEditingController(),
          focus: fn,
        )));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _websiteEntries.last.focus.requestFocus();
    });
  }

  void _removeWebsite(int index) {
    setState(() {
      _websiteEntries[index].url.dispose();
      _websiteEntries[index].focus.dispose();
      _websiteEntries.removeAt(index);
    });
  }

  void _addSocialMedia() {
    final fn = FocusNode();
    fn.addListener(() => setState(() {}));
    setState(() {
      _socialMediaEntries.add((
        username: TextEditingController(),
        platform: SocialPlatformResolver.appPlatforms.first,
        customLabel: null,
        focus: fn,
      ));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socialMediaEntries.last.focus.requestFocus();
    });
  }

  void _removeSocialMedia(int index) {
    setState(() {
      _socialMediaEntries[index].username.dispose();
      _socialMediaEntries[index].focus.dispose();
      _socialMediaEntries.removeAt(index);
    });
  }

  void _addAddress() {
    final fn = FocusNode();
    fn.addListener(() => setState(() {}));
    setState(() => _addressEntries.add((
          formatted: TextEditingController(),
          label: VcardLabelOptions.defaultAddressLabel,
          customLabel: null,
          focus: fn,
        )));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addressEntries.last.focus.requestFocus();
    });
  }

  void _removeAddress(int index) {
    setState(() {
      _addressEntries[index].formatted.dispose();
      _addressEntries[index].focus.dispose();
      _addressEntries.removeAt(index);
    });
  }

  @override
  void dispose() {
    _cardNameFocus.removeListener(_onCardNameFocusChange);
    _cardNameFocus.dispose();
    _cardNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _orgController.dispose();
    _titleController.dispose();
    _departmentController.dispose();
    _notesController.dispose();
    _prefixController.dispose();
    _middleController.dispose();
    _suffixController.dispose();
    _nicknameController.dispose();
    _birthdayController.dispose();
    _firstNameFocus.dispose();
    _prefixFocus.dispose();
    _middleFocus.dispose();
    _suffixFocus.dispose();
    _nicknameFocus.dispose();
    _departmentFocus.dispose();
    _titleFocus.dispose();
    for (final e in _phoneEntries) {
      e.number.dispose();
      e.focus.dispose();
    }
    for (final e in _emailEntries) {
      e.address.dispose();
      e.focus.dispose();
    }
    for (final e in _websiteEntries) {
      e.url.dispose();
      e.focus.dispose();
    }
    for (final e in _socialMediaEntries) {
      e.username.dispose();
      e.focus.dispose();
    }
    for (final e in _addressEntries) {
      e.formatted.dispose();
      e.focus.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  double _dropdownWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final percentWidth = screenWidth * 0.25;
    return percentWidth.clamp(80.0, 120.0);
  }

  /// Focuses the first data field (first name) so the user can type data directly.
  void focusFirstDataField() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _firstNameFocus.requestFocus();
    });
  }

  /// Returns false if validation fails (Custom without customLabel). Sets error state, scrolls, focuses.
  bool validateAndHighlight() {
    _invalidPhoneIndex = null;
    _invalidEmailIndex = null;
    _invalidSocialIndex = null;
    _invalidAddressIndex = null;
    for (var i = 0; i < _phoneEntries.length; i++) {
      final e = _phoneEntries[i];
      if (e.number.text.trim().isNotEmpty &&
          e.label == PhoneLabel.custom &&
          (e.customLabel == null || e.customLabel!.trim().isEmpty)) {
        _invalidPhoneIndex = i;
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) e.focus.requestFocus();
        });
        return false;
      }
    }
    for (var i = 0; i < _emailEntries.length; i++) {
      final e = _emailEntries[i];
      if (e.address.text.trim().isNotEmpty &&
          e.label == EmailLabel.custom &&
          (e.customLabel == null || e.customLabel!.trim().isEmpty)) {
        _invalidEmailIndex = i;
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) e.focus.requestFocus();
        });
        return false;
      }
    }
    for (var i = 0; i < _socialMediaEntries.length; i++) {
      final e = _socialMediaEntries[i];
      if (e.username.text.trim().isNotEmpty &&
          e.platform == null &&
          (e.customLabel == null || e.customLabel!.trim().isEmpty)) {
        _invalidSocialIndex = i;
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) e.focus.requestFocus();
        });
        return false;
      }
    }
    for (var i = 0; i < _addressEntries.length; i++) {
      final e = _addressEntries[i];
      if (e.formatted.text.trim().isNotEmpty &&
          e.label == AddressLabel.custom &&
          (e.customLabel == null || e.customLabel!.trim().isEmpty)) {
        _invalidAddressIndex = i;
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) e.focus.requestFocus();
        });
        return false;
      }
    }
    return true;
  }

  void _onCardNameFocusChange() {
    if (!mounted) return;
    if (_cardNameFocus.hasFocus) {
      _cardNameFieldHadFocus = true;
      return;
    }
    if (!_cardNameFieldHadFocus) return;
    _cardNameFieldHadFocus = false;
    _maybeShowNameAliasHint();
  }

  void _maybeShowNameAliasHint() {
    if (!mounted) return;
    final key = _cardNameController.text.trim().toLowerCase();
    if (!<String>{'ichthys','jcgss','jcsgs','jcsogs'}.contains(key)) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger.showSnackBar(
      SnackBar(
        persist: false,
        duration: const Duration(seconds: 7),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ἰησοῦς Χριστός, Θεοῦ Υἱός, Σωτήρ'),
            SizedBox(height: 8),
            Text('Jesus Christ, Son of God, Savior'),
          ],
        ),
        action: SnackBarAction(
          label: 'Amen',
          onPressed: () {
            messenger.hideCurrentSnackBar();
            if (!context.mounted) return;
            _playBriefCelebration();
          },
        ),
      ),
    );
  }

  void _playBriefCelebration() {
    if (!mounted) return;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _CelebrationBurst(
        onFinished: () {
          entry.remove();
        },
      ),
    );
    overlay.insert(entry);
  }

  static const _sectionSpacing = 24.0;
  static const _titleToContent = 12.0;
  static const _fieldSpacing = 12.0;
  static const _entryRowBottom = 16.0;
  static const _addButtonToSection = 24.0;
  static const _deleteButtonTop = 32.0;

  /// Shared contentPadding for dense dropdown/TextField rows so they align visually.
  static const _denseFieldPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 14);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    const maxFormWidth = 550.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxFormWidth),
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _cardNameController,
            focusNode: _cardNameFocus,
            decoration: InputDecoration(
              labelText: loc.cardName,
              hintText: loc.cardNameHint,
            ),
          ),
        ),
        const SizedBox(height: _sectionSpacing),
        FormSectionTitle(title: loc.fieldName),
        const SizedBox(height: _titleToContent),
        if (_addedNameFields.contains('prefix')) ...[
          const SizedBox(height: _fieldSpacing),
          _buildOptionalNameField(
            controller: _prefixController,
            focusNode: _prefixFocus,
            label: loc.honorificPrefix,
            removeTooltip: loc.removeTooltip,
            onRemove: () => _removeNameField('prefix'),
          ),
        ],
        const SizedBox(height: _fieldSpacing),
        TextField(
          controller: _firstNameController,
          focusNode: _firstNameFocus,
          decoration: InputDecoration(labelText: loc.firstName),
        ),
        if (_addedNameFields.contains('middle')) ...[
          const SizedBox(height: _fieldSpacing),
          _buildOptionalNameField(
            controller: _middleController,
            focusNode: _middleFocus,
            label: loc.additionalNames,
            removeTooltip: loc.removeTooltip,
            onRemove: () => _removeNameField('middle'),
          ),
        ],
        const SizedBox(height: _fieldSpacing),
        TextField(
          controller: _lastNameController,
          decoration: InputDecoration(labelText: loc.lastName),
        ),
        if (_addedNameFields.contains('suffix')) ...[
          const SizedBox(height: _fieldSpacing),
          _buildOptionalNameField(
            controller: _suffixController,
            focusNode: _suffixFocus,
            label: loc.honorificSuffix,
            removeTooltip: loc.removeTooltip,
            onRemove: () => _removeNameField('suffix'),
          ),
        ],
        if (_addedNameFields.contains('nickname')) ...[
          const SizedBox(height: _fieldSpacing),
          _buildOptionalNameField(
            controller: _nicknameController,
            focusNode: _nicknameFocus,
            label: loc.nickname,
            removeTooltip: loc.removeTooltip,
            onRemove: () => _removeNameField('nickname'),
          ),
        ],
        if (_hasBirthday) ...[
          const SizedBox(height: _fieldSpacing),
          _buildBirthdayRow(loc),
        ],
        const SizedBox(height: _fieldSpacing),
        _buildAddButtonsRow([
          if (!_addedNameFields.contains('prefix'))
            (label: loc.honorificPrefix, onAdd: () => _addNameField('prefix', _prefixFocus)),
          if (!_addedNameFields.contains('middle'))
            (label: loc.additionalNames, onAdd: () => _addNameField('middle', _middleFocus)),
          if (!_addedNameFields.contains('suffix'))
            (label: loc.honorificSuffix, onAdd: () => _addNameField('suffix', _suffixFocus)),
          if (!_addedNameFields.contains('nickname'))
            (label: loc.nickname, onAdd: () => _addNameField('nickname', _nicknameFocus)),
          if (!_hasBirthday)
            (label: loc.birthday, onAdd: _addBirthday),
        ]),
        const SizedBox(height: _addButtonToSection),
        FormSectionTitle(title: loc.company),
        const SizedBox(height: _titleToContent),
        TextField(
          controller: _orgController,
          decoration: InputDecoration(
            labelText: loc.organization,
          ),
        ),
        if (_hasJobTitle) ...[
          const SizedBox(height: _fieldSpacing),
          TextField(
            controller: _titleController,
            focusNode: _titleFocus,
            decoration: InputDecoration(
              labelText: loc.jobTitle,
              suffixIcon: IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: _removeJobTitle,
                tooltip: loc.removeTooltip,
                style: IconButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(32, 32),
                ),
              ),
            ),
          ),
        ],
        if (_hasDepartment) ...[
          const SizedBox(height: _fieldSpacing),
          TextField(
            controller: _departmentController,
            focusNode: _departmentFocus,
            decoration: InputDecoration(
              labelText: loc.companyUnit,
              suffixIcon: IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: _removeDepartment,
                tooltip: loc.removeTooltip,
                style: IconButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(32, 32),
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        _buildAddButtonsRow([
          if (!_hasJobTitle)
            (label: loc.addJobTitle, onAdd: _addJobTitle),
          if (!_hasDepartment)
            (label: loc.addCompanyUnit, onAdd: _addDepartment),
        ]),
        const SizedBox(height: _addButtonToSection),
        FormSectionTitle(title: loc.phoneNumbers),
        const SizedBox(height: _titleToContent),
        ...List.generate(_phoneEntries.length, (i) {
          final e = _phoneEntries[i];
          final hasError = _invalidPhoneIndex == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: _entryRowBottom),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.phone_outlined, size: 20, color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: 8),
                SizedBox(
                  width: _dropdownWidth(context),
                  child: DropdownButtonFormField<PhoneLabel>(
                    key: ValueKey('phone-$i-${e.label}-${e.customLabel ?? ''}'),
                    initialValue: e.label,
                    isExpanded: true,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: loc.label,
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      errorText: hasError ? ' ' : null,
                    ),
                    items: VcardLabelOptions.phoneLabels
                        .map((l) => DropdownMenuItem(
                              value: l,
                              child: Text(VcardLabelOptions.phoneDisplayName(l, loc, e.label == l ? e.customLabel : null)),
                            ))
                        .toList(),
                    onChanged: (l) async {
                      if (l != null) {
                        if (l == PhoneLabel.custom) {
                          final custom = await _showCustomLabelDialog(loc.phoneLabel, e.customLabel);
                          if (!mounted) return;
                          setState(() {
                            _phoneEntries[i] = (number: e.number, label: l, customLabel: custom, focus: e.focus);
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                        } else {
                          setState(() {
                            _phoneEntries[i] = (number: e.number, label: l, customLabel: null, focus: e.focus);
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: e.number,
                    focusNode: e.focus,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      labelText: loc.phone,
                      errorText: hasError ? loc.pleaseSpecifyLabelForCustom : null,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [_phoneFormatter],
                  ),
                ),
                IconButton(
                  onPressed: () => _removePhone(i),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  tooltip: loc.removeTooltip,
                  style: IconButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: _fieldSpacing),
        _buildSectionAddButton(
          label: loc.addPhone,
          onPressed: _addPhone,
        ),
        const SizedBox(height: _addButtonToSection),
        FormSectionTitle(title: loc.emailAddresses),
        const SizedBox(height: _titleToContent),
        ...List.generate(_emailEntries.length, (i) {
          final e = _emailEntries[i];
          final hasError = _invalidEmailIndex == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: _entryRowBottom),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.email_outlined, size: 20, color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: 8),
                SizedBox(
                  width: _dropdownWidth(context),
                  child: DropdownButtonFormField<EmailLabel>(
                    key: ValueKey('email-$i-${e.label}-${e.customLabel ?? ''}'),
                    initialValue: e.label,
                    isExpanded: true,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: loc.label,
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      errorText: hasError ? ' ' : null,
                    ),
                    items: VcardLabelOptions.emailLabels
                        .map((l) => DropdownMenuItem(
                              value: l,
                              child: Text(VcardLabelOptions.emailDisplayName(l, loc, e.label == l ? e.customLabel : null)),
                            ))
                        .toList(),
                    onChanged: (l) async {
                      if (l != null) {
                        if (l == EmailLabel.custom) {
                          final custom = await _showCustomLabelDialog(loc.emailLabel, e.customLabel);
                          if (!mounted) return;
                          setState(() {
                            _emailEntries[i] = (address: e.address, label: l, customLabel: custom, focus: e.focus);
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                        } else {
                          setState(() {
                            _emailEntries[i] = (address: e.address, label: l, customLabel: null, focus: e.focus);
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: e.address,
                    focusNode: e.focus,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      labelText: loc.email,
                      errorText: hasError ? loc.pleaseSpecifyLabelForCustom : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                IconButton(
                  onPressed: () => _removeEmail(i),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  tooltip: loc.removeTooltip,
                  style: IconButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: _fieldSpacing),
        _buildSectionAddButton(
          label: loc.addEmail,
          onPressed: _addEmail,
        ),
        const SizedBox(height: _addButtonToSection),
        FormSectionTitle(title: loc.urls),
        const SizedBox(height: _titleToContent),
        ...List.generate(_websiteEntries.length, (i) {
          final e = _websiteEntries[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: _entryRowBottom),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.link, size: 20, color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: e.url,
                    focusNode: e.focus,
                    decoration: InputDecoration(isDense: true, labelText: loc.url),
                    keyboardType: TextInputType.url,
                  ),
                ),
                IconButton(
                  onPressed: () => _removeWebsite(i),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  tooltip: loc.removeTooltip,
                  style: IconButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: _fieldSpacing),
        _buildSectionAddButton(
          label: loc.addUrl,
          onPressed: _addWebsite,
        ),
        const SizedBox(height: _addButtonToSection),
        FormSectionTitle(title: loc.socialMedia),
        const SizedBox(height: _titleToContent),
        ...List.generate(_socialMediaEntries.length, (i) {
          final e = _socialMediaEntries[i];
          final hasError = _invalidSocialIndex == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: _entryRowBottom),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _dropdownWidth(context),
                  child: DropdownButtonFormField<AppSocialPlatform?>(
                    key: ValueKey('social-$i-${e.platform?.id}-${e.customLabel ?? ''}'),
                    initialValue: e.platform,
                    isExpanded: true,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: loc.platform,
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      errorText: hasError ? ' ' : null,
                    ),
                    items: [
                      ...SocialPlatformResolver.appPlatforms.map(
                        (p) => DropdownMenuItem<AppSocialPlatform?>(
                          value: p,
                          child: Text(SocialPlatformResolver.displayName(p)),
                        ),
                      ),
                      DropdownMenuItem<AppSocialPlatform?>(
                        value: null,
                        child: Text(
                          e.platform == null && e.customLabel != null && e.customLabel!.isNotEmpty
                              ? (e.customLabel == 'Custom'
                                  ? loc.socialLabelCustom
                                  : e.customLabel == 'Other'
                                      ? loc.socialLabelOther
                                      : e.customLabel!)
                              : loc.socialLabelCustom,
                        ),
                      ),
                    ],
                    onChanged: (selected) async {
                      if (selected != null) {
                        setState(() {
                          _socialMediaEntries[i] = (
                            username: e.username,
                            platform: selected,
                            customLabel: null,
                            focus: e.focus,
                          );
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                      } else {
                        final custom = await showDialog<String>(
                          context: context,
                          builder: (ctx) {
                            var controller = TextEditingController(text: _socialMediaEntries[i].customLabel);
                            return AlertDialog(
                              title: Text(loc.customPlatform),
                              content: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: loc.platformName,
                                  hintText: loc.platformNameHint,
                                ),
                                autofocus: true,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, null),
                                  child: Text(loc.cancel),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.pop(ctx, controller.text.trim()),
                                  child: Text(loc.ok),
                                ),
                              ],
                            );
                          },
                        );
                        if (!mounted) return;
                        if (custom != null) {
                          setState(() {
                            _socialMediaEntries[i] = (
                              username: e.username,
                              platform: null,
                              customLabel: custom.isEmpty ? null : custom,
                              focus: e.focus,
                            );
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: e.username,
                    focusNode: e.focus,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      labelText: loc.username,
                      errorText: hasError ? loc.pleaseSpecifyLabelForCustom : null,
                    ),
                  ),
                ),
                if (SocialPlatformResolver.isEncodedAsCustomProperty(
                      e.platform,
                      e.customLabel,
                    ) &&
                    e.username.text.trim().isNotEmpty)
                  IconButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(loc.unknownPlatformDialogTitle),
                          content: Text(loc.unknownPlatformDialogMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(loc.ok),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    tooltip: loc.unknownPlatformIndicatorTooltip,
                    style: IconButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(32, 32),
                    ),
                  ),
                IconButton(
                  onPressed: () => _removeSocialMedia(i),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  tooltip: loc.removeTooltip,
                  style: IconButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: _fieldSpacing),
        _buildSectionAddButton(
          label: loc.addSocialMedia,
          onPressed: _addSocialMedia,
        ),
        const SizedBox(height: _addButtonToSection),
        FormSectionTitle(title: loc.addresses),
        const SizedBox(height: _titleToContent),
        ...List.generate(_addressEntries.length, (i) {
          final e = _addressEntries[i];
          final hasError = _invalidAddressIndex == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: _entryRowBottom),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined, size: 20, color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: 8),
                SizedBox(
                  width: _dropdownWidth(context),
                  child: DropdownButtonFormField<AddressLabel>(
                    key: ValueKey('address-$i-${e.label}-${e.customLabel ?? ''}'),
                    initialValue: e.label,
                    isExpanded: true,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: loc.label,
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      errorText: hasError ? ' ' : null,
                    ),
                    items: VcardLabelOptions.addressLabels
                        .map((l) => DropdownMenuItem(
                              value: l,
                              child: Text(VcardLabelOptions.addressDisplayName(l, loc, e.label == l ? e.customLabel : null)),
                            ))
                        .toList(),
                    onChanged: (l) async {
                      if (l != null) {
                        if (l == AddressLabel.custom) {
                          final custom = await _showCustomLabelDialog(loc.addressLabel, e.customLabel);
                          if (!mounted) return;
                          setState(() {
                            _addressEntries[i] = (formatted: e.formatted, label: l, customLabel: custom, focus: e.focus);
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                        } else {
                          setState(() {
                            _addressEntries[i] = (formatted: e.formatted, label: l, customLabel: null, focus: e.focus);
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) => e.focus.requestFocus());
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: e.formatted,
                    focusNode: e.focus,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: _denseFieldPadding,
                      labelText: loc.address,
                      errorText: hasError ? loc.pleaseSpecifyLabelForCustom : null,
                    ),
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  onPressed: () => _removeAddress(i),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  tooltip: loc.removeTooltip,
                  style: IconButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: _fieldSpacing),
        _buildSectionAddButton(
          label: loc.addAddress,
          onPressed: _addAddress,
        ),
        const SizedBox(height: _addButtonToSection),
        TextField(
          controller: _notesController,
          decoration: InputDecoration(
            labelText: loc.notes,
            alignLabelWithHint: true,
          ),
          maxLines: 3,
          minLines: 2,
        ),
        if (widget.onDelete != null) ...[
          const SizedBox(height: _deleteButtonTop),
          Align(
            alignment: Alignment.center,
            child: TextButton.icon(
              onPressed: () => widget.onDelete!(widget.card),
              icon: Icon(Icons.delete_outline, size: 18, color: Theme.of(context).colorScheme.error),
              label: Text(
                loc.deleteCard,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
            ),
          ),
        ],
      ],
    ),
  ),
  );
  }
}

class _CelebrationBurst extends StatefulWidget {
  const _CelebrationBurst({required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<_CelebrationBurst> createState() => _CelebrationBurstState();
}

class _CelebrationBurstState extends State<_CelebrationBurst> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.play();
      Future<void>.delayed(const Duration(milliseconds: 4200), () {
        if (!mounted) return;
        widget.onFinished();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox.expand(
        child: IgnorePointer(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: -1.5708,  // -pi / 2
              emissionFrequency: 0.00,
              numberOfParticles: 77,
              maxBlastForce: 40,
              minBlastForce: 12,
              gravity: 0.5,
              colors: const [
                Color(0xFFE8C547),
                Color(0xFF4A90D9),
                Color(0xFFD94A7A),
                Color(0xFF6BCB77),
                Color(0xFFB388FF),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
