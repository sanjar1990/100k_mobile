
import 'package:yuzk_mobile/boxes.dart';
import '../../../staff.dart';


class StaffHiveRepo{
  StaffHiveRepo();

  void putList(List<Staff>list)async{
     for (var e in list) {
       boxStaffs.add(e);
     }

      print('Length:++++++++++++++++++++++${boxStaffs.length}');
  }

//   void putList(List<Staff2>list)async{
// boxStaffList.put('staff_list', list);
//   }
//
//   List<Staff2> get getStaffList{
// return boxStaffList.get('staff_list');
//
//   }
  List<Staff> get getStaffList{
    List<Staff> list;
   if(!isExists){
   list=[];
   }
    list=boxStaffs.values.map<Staff>((e) =>
          Staff(name: e.name, email: e.email,
              phone: e.phone,
              birthDate: e.birthDate,
              attachUrl: e.attachUrl,
              role: e.role)).toList();
    return list;

  }
  // bool get isExists{
  //   print('length::   ++++++++++++++++++++ ${boxStaffs.length}');
  //   return boxStaffList.length>0;
  // }
  //
  bool get isExists{
    print('length::   ++++++++++++++++++++ ${boxStaffs.length}');
    return boxStaffs.length>0;
  }

  void deleteStaffList()async{
   await boxStaffs.clear();
  }
  void deleteStaff(int index)async{
    await boxStaffs.deleteAt(index);
  }
  void putStaffAt(int index, Staff staff)async{
    await boxStaffs.putAt( index, staff);

  }
}