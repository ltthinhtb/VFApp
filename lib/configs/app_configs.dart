class AppConfigs {
  static const String appName = 'VFtrade';

  ///DEV

  ///STAGING
  static const envName = "Staging";
  // static const baseUrl = "http://vftrade.vn:8888/";
  static const baseUrl = "http://202.124.204.116:9999/";
  static const URL_DATA_FEED = 'https://sbboard.sbsi.vn/';
  static const ENDPOINT_CORE = 'TraditionalService';
  static const socketUrl = 'wss://socket.themoviedb.org'; //Todo: change this

  ///PRODUCTION

  ///Paging
  static const pageSize = 20;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'en';

  ///DateFormat

  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';

  static const dateTimeAPIFormat =
      "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Roboto';

  ///Max file
  static const maxAttachFile = 5;
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}
