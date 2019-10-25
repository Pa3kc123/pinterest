import 'package:pinterest/src/pinterest_base.dart';
import 'package:pinterest/src/util.dart';

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
  static const FieldData BIO           = FieldData._('bio',                0x4);
  static const FieldData BOARD         = FieldData._('board',              0x8);
  static const FieldData COLOR         = FieldData._('color',             0x10);
  static const FieldData COUNTS        = FieldData._('counts',            0x20);
  static const FieldData CREATED_AT    = FieldData._('created_at',        0x40);
  static const FieldData CREATOR       = FieldData._('creator',           0x80);
  static const FieldData DESCRIPTION   = FieldData._('description',      0x100);
  static const FieldData FIRST_NAME    = FieldData._('first_name',       0x200);
  static const FieldData ID            = FieldData._('id',               0x400);
  static const FieldData IMAGE         = ImageField(null);
  static const FieldData LAST_NAME     = FieldData._('last_name',       0x1000);
  static const FieldData LINK          = FieldData._('link',            0x2000);
  static const FieldData MEDIA         = FieldData._('media',           0x4000);
  static const FieldData METADATA      = FieldData._('metadata',        0x8000);
  static const FieldData NAME          = FieldData._('name',           0x10000);
  static const FieldData NOTE          = FieldData._('note',           0x20000);
  static const FieldData ORIGINAL_LINK = FieldData._('original_link',  0x40000);
  static const FieldData PRIVACY       = FieldData._('privacy',        0x80000);
  static const FieldData REASON        = FieldData._('reason',        0x100000);
  static const FieldData URL           = FieldData._('url',           0x200000);
  static const FieldData USERNAME      = FieldData._('username',      0x400000);

  static FieldData<ConstCollection<ImageSize>> createIMAGE(Iterable<ImageSize> sizes) => ImageField._(ConstCollection(sizes));

  static const ConstCollection<FieldData> values = ConstCollection(
    <FieldData>[
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
    ]
  );

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

class BoardField extends FieldData<ConstCollection<Board>> {
  const BoardField() : super._('board', 0x8);
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

class ImageField extends FieldData<ConstCollection<ImageSize>> {
  final ConstCollection<ImageSize> _sizes;

  const ImageField([this._sizes]) : super._('image', 0x800);

  @override
  String parse() => this._sizes == null ? super.name : '${super.name}[${this._sizes.toString().substring(1, this._sizes.length - 1)}]';
}
