enum PeopleFilterEnum {
  all,
  female,
  male,
  unknown,
}

extension PeopleFilterEnumExtension on PeopleFilterEnum {
  String get value {
    switch (this) {
      case PeopleFilterEnum.all:
        return 'All';
      case PeopleFilterEnum.female:
        return 'Male';
      case PeopleFilterEnum.male:
        return 'Female';
      case PeopleFilterEnum.unknown:
        return 'Unknown';
      default:
        return '';
    }
  }

  String get key {
    switch (this) {
      case PeopleFilterEnum.unknown:
        return 'n/a';
      default:
        return '';
    }
  }
}
