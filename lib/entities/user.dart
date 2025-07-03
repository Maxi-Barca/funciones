class User {
  String email;
  String contrasena;
  String nombre;
  String direccion;

  User({
    required this.email,
    required this.contrasena,
    required this.nombre,
    required this.direccion,
  });
}

List<User> usuarios = [
    User(
      email: 'maxibarcarolo@gmail.com',
      contrasena: 'maxi1701',
      nombre: 'Maxi',
      direccion: 'disney',
    ),
    User(
      email: 'leomessi@gmail.com',
      contrasena: 'goat10',
      nombre: 'Lionel',
      direccion: 'miami',
    ),
    User(
      email: 'alberteinstein@gmail.com',
      contrasena: 'e=mc²',
      nombre: 'Alberto',
      direccion: 'germany',
    ),
    User(
      email: 'justinbieber@gmail.com',
      contrasena: 'babybaby',
      nombre: 'Justin',
      direccion: 'caballito',
    ),
    User(
      email: 'javiermilei@gmail.com',
      contrasena: 'libertad',
      nombre: 'Javier',
      direccion: 'casa rosada',
    ),
  ];