import '../../../../domain/entities/employee_entity.dart';

class Employee extends EmployeeEntity {
  const Employee({
    super.image,
    super.active,
    super.blocked,
    super.branchIdFk,
    super.branchName,
    super.gender,
    super.imgPath,
    super.mCode,
    super.memId,
    super.phone,
    super.name,
    super.barcodePath,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        image: json['emp_img'],
        active: json['active'],
        blocked: json['blocked'],
        branchIdFk: json['branch_id_fk'],
        branchName: json['branch_name'],
        gender: json['gender'],
        imgPath: json['img_path'],
        mCode: json['m_code'],
        memId: json['mem_id'],
        phone: json['phone'],
        name: json['name'],
        barcodePath: json['barcode_path'],
      );

  Map<String, dynamic> toJson() => {
        'emp_img': image,
        'active': active,
        'blocked': blocked,
        'branch_id_fk': branchIdFk,
        'branch_name': branchName,
        'gender': gender,
        'img_path': imgPath,
        'm_code': mCode,
        'mem_id': memId,
        'phone': phone,
        'name': name,
        'barcode_path': barcodePath
      };
}
