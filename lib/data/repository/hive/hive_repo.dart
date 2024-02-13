import 'package:yuzk_mobile/boxes.dart';
import 'package:yuzk_mobile/person.dart';
import 'package:yuzk_mobile/utils/app_const.dart';

class HiveRepo {
   HiveRepo();

    // bool get isLoggedIn=>_isLoggedIn;
  void putData( Person person){

    boxPersons.put('key_profile', person);
  }
  void putPersonList(List<Person> list){
    boxPersons.put('key_${AppConstants.HIVE_PERSON_LIST_KEY}', list);
  }
  Person get getPerson {

    return boxPersons.get('key_profile');
  }
  void deletePerson(){
    boxPersons.clear();
  }
  bool get isLoggedIn{
    print('isLoggedin2++++++++++++++++++++:${boxPersons.length}');
    return boxPersons.length>0;

  }

  void updatePerson(Person person){
    boxPersons.put('key_profile', person);
  }
  bool  isExist<T>(T key){
    return boxPersons.containsKey('key_$key');
  }

}