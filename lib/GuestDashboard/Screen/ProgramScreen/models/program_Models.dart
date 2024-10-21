class Faculty {
  final String name;
  final String icon;
  final List<Major> children;

  Faculty({required this.name, required this.icon, required this.children});

  factory Faculty.fromJson(Map<String, dynamic> json) {
    var childrenFromJson = json['children'] as List;
    List<Major> childrenList =
        childrenFromJson.map((i) => Major.fromJson(i)).toList();

    return Faculty(
      name: json['name'],
      icon: json['icon'],
      children: childrenList,
    );
  }
}

class Major {
  final String majorName;
  final List<Degree> degreeData;

  Major({required this.majorName, required this.degreeData});

  factory Major.fromJson(Map<String, dynamic> json) {
    var degreeDataFromJson = json['degreeData'] as List;
    List<Degree> degreeList =
        degreeDataFromJson.map((i) => Degree.fromJson(i)).toList();

    return Major(
      majorName: json['majorName'],
      degreeData: degreeList,
    );
  }
}

class Degree {
  final String degreeName;
  final String degreeDescription;
  final List<Year> yearData;

  Degree(
      {required this.degreeName,
      required this.degreeDescription,
      required this.yearData});

  factory Degree.fromJson(Map<String, dynamic> json) {
    var yearDataFromJson = json['yearData'] as List;
    List<Year> yearList =
        yearDataFromJson.map((i) => Year.fromJson(i)).toList();

    return Degree(
      degreeName: json['degreeName'],
      degreeDescription: json['degreeDescription'],
      yearData: yearList,
    );
  }
}

class Year {
  final String yearName;
  final String totalCredit;
  final List<Subject> subjectData;

  Year(
      {required this.yearName,
      required this.totalCredit,
      required this.subjectData});

  factory Year.fromJson(Map<String, dynamic> json) {
    var subjectDataFromJson = json['subjectData'] as List;
    List<Subject> subjectList =
        subjectDataFromJson.map((i) => Subject.fromJson(i)).toList();

    return Year(
      yearName: json['yearName'],
      totalCredit: json['totalCredit'],
      subjectData: subjectList,
    );
  }
}

class Subject {
  final String subjectName;
  final String credit;

  Subject({required this.subjectName, required this.credit});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectName: json['subjectName'],
      credit: json['credit'],
    );
  }
}
