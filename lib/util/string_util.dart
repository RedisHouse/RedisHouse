
class StringUtil {

  static bool isNotBlank(String str) {
    return !isBlank(str);
  }

  static bool isBlank(String str) {
    if(str == null) {
      return true;
    }
    if(str.trim().length == 0) {
      return true;
    }
    return false;
  }

  static bool isAllNotBlank(List<String> strList) {
    for(String s in strList) {
      if(isBlank(s)) {
        return false;
      }
    }
    return true;
  }

  static bool isAnyBlank(List<String> strList) {
    for(String s in strList) {
      if(isBlank(s)) {
        return true;
      }
    }
    return false;
  }

  static bool isNotEqual(String str1, String str2) {
    return !isEqual(str1, str2);
  }

  static bool isEqual(String str1, String str2) {
    return str1 == str2 || str1 != null && str1 == str2;
  }

}