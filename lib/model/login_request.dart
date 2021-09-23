class LoginRequest {
  late String? usr;
  late String? pwd;
  late String? cmd;
  late String? otp;
  late String? tmpId;

  LoginRequest({
    this.usr,
    this.pwd,
    this.cmd,
    this.otp,
    this.tmpId,
  }) : assert(
          (usr != null && pwd != null) ||
              (cmd != null && otp != null && tmpId != null),
        );

  LoginRequest.fromJson(Map<String, dynamic> json) {
    usr = json['usr'];
    pwd = json['pwd'];
    cmd = json['cmd'];
    otp = json['otp'];
    tmpId = json['tmp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usr'] = this.usr;
    data['pwd'] = this.pwd;
    data['cmd'] = this.cmd;
    data['otp'] = this.otp;
    data['tmp_id'] = this.tmpId;
    return data;
  }
}
