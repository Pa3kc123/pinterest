import 'package:pinterest/src/core.dart';

void filterFields(int funcCode, List<FieldData> fields) {
  if (requestAllFields) {
    final List<FieldData> list = List<FieldData>();
    for (FieldData fieldData in FieldData.values) {
      if (fieldData.code & funcCode == 1) {
        list.add(fieldData);
      }
    }
  } else {
    if (fields == null) return;
    for (int i = 0; i < fields.length; i++) {
      if ((fields[i].code & funcCode) == 0) {
        fields.removeAt(i--);
      }
    }
  }
}

abstract class _PinField<T> {
  String parse();
}

abstract class FieldData<T> implements _PinField<T> {
  static const FieldData ACCOUNT_TYPE  = AccountTypeField();
  static const FieldData ATTRIBUTION   = AttributionField();
  static const FieldData BIO           = BioField();
  static const FieldData BOARD         = BoardField();
  static const FieldData COLOR         = ColorField();
  static const FieldData COUNTS        = CountsField();
  static const FieldData CREATED_AT    = CreatedAtField();
  static const FieldData CREATOR       = CreatorField();
  static const FieldData DESCRIPTION   = DescriptionField();
  static const FieldData FIRST_NAME    = FirstNameField();
  static const FieldData ID            = IdField();
  static const FieldData IMAGE         = ImageField(null);
  static const FieldData LAST_NAME     = LastNameField();
  static const FieldData LINK          = LinkField();
  static const FieldData MEDIA         = MediaField();
  static const FieldData METADATA      = MetadataField();
  static const FieldData NAME          = NameField();
  static const FieldData NOTE          = NoteField();
  static const FieldData ORIGINAL_LINK = OriginalLinkField();
  static const FieldData PRIVACY       = PrivacyField();
  static const FieldData REASON        = ReasonField();
  static const FieldData URL           = UrlField();
  static const FieldData USERNAME      = UsernameField();

  static FieldData<List<ImageSize>> createIMAGE(Iterable<ImageSize> sizes) => ImageField(sizes);

  static const List<FieldData> values = <FieldData>[
    ACCOUNT_TYPE,
    ATTRIBUTION,
    BIO,
    BOARD,
    COLOR,
    COUNTS,
    CREATED_AT,
    CREATOR,
    DESCRIPTION,
    FIRST_NAME,
    ID,
    IMAGE,
    LAST_NAME,
    LINK,
    MEDIA,
    METADATA,
    NAME,
    NOTE,
    ORIGINAL_LINK,
    PRIVACY,
    REASON,
    URL,
    USERNAME
  ];

  final String name;
  final int code;

  const FieldData._(this.name, this.code);

  @override
  String parse() => this.name;

  @override
  String toString() => this.name;

  @override
  int get hashCode => this.code;

  @override
  bool operator ==(Object obj) => obj != null && obj is FieldData && obj.code == this.code;
}

class AccountTypeField extends FieldData<String> {
  const AccountTypeField() : super._('account_type', 0x1);
}

class AttributionField extends FieldData<String> {
  const AttributionField() : super._('attribution', 0x2);
}

class BioField extends FieldData<String> {
  const BioField() : super._('bio', 0x4);
}

class BoardField extends FieldData<List<BoardField>> {
  const BoardField() : super._('board', 0x8);
}

class ColorField extends FieldData<dynamic> {
  const ColorField() : super._('color', 0x10);
}

class CountsField extends FieldData<dynamic> {
  const CountsField() : super._('counts', 0x20);
}

class CreatedAtField extends FieldData<dynamic> {
  const CreatedAtField() : super._('created_at', 0x40);
}

class CreatorField extends FieldData<dynamic> {
  const CreatorField() : super._('creator', 0x80);
}

class DescriptionField extends FieldData<dynamic> {
  const DescriptionField() : super._('description', 0x100);
}

class FirstNameField extends FieldData<dynamic> {
  const FirstNameField() : super._('first_name', 0x200);
}

class IdField extends FieldData<dynamic> {
  const IdField() : super._('id', 0x400);
}

class ImageSize {
  static const ImageSize SMALL = ImageSize._('small');
  static const ImageSize MEDIUM = ImageSize._('medium');
  static const ImageSize LARGE = ImageSize._('large');

  final String value;

  const ImageSize._(this.value);

  @override
  String toString() => this.value;
}

class ImageField extends FieldData<List<ImageSize>> {
  final List<ImageSize> _sizes;

  const ImageField([this._sizes]) : super._('image', 0x800);

  @override
  String parse() => this._sizes == null ? super.name : '${super.name}[${this._sizes.toString().substring(1, this._sizes.length - 1)}]';
}

class LastNameField extends FieldData<dynamic> {
  const LastNameField() : super._('last_name', 0x1000);
}

class LinkField extends FieldData<dynamic> {
  const LinkField() : super._('link', 0x2000);
}

class MediaField extends FieldData<dynamic> {
  const MediaField() : super._('media', 0x4000);
}

class MetadataField extends FieldData<dynamic> {
  const MetadataField() : super._('metadata', 0x8000);
}

class NameField extends FieldData<dynamic> {
  const NameField() : super._('name', 0x10000);
}

class NoteField extends FieldData<dynamic> {
  const NoteField() : super._('note', 0x20000);
}

class OriginalLinkField extends FieldData<dynamic> {
  const OriginalLinkField() : super._('original_link', 0x40000);
}

class PrivacyField extends FieldData<dynamic> {
  const PrivacyField() : super._('privacy', 0x80000);
}

class ReasonField extends FieldData<dynamic> {
  const ReasonField() : super._('reason', 0x100000);
}

class UrlField extends FieldData<dynamic> {
  const UrlField() : super._('url', 0x200000);
}

class UsernameField extends FieldData<dynamic> {
  const UsernameField() : super._('username', 0x400000);
}
