abstract class IUserRepositry{

   Future<dynamic> getAllUserDetails({String userEmailId});
   Future<dynamic> editUserName({String userEmailId, String updatedName});
}