class User {
   int? id;
   String? server;
   String? name;
   String? email;
   String? password;
   String? confirmPassword;


  User ({
        this.id,
        this.server,
         this.name,
         this.email,
         this.password,
        this.confirmPassword,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }


}