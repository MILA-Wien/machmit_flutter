# MachMit

Connected to [machmit_backend](https://github.com/MILA-Wien/machmit_backend).

## Development

Requirements for the development environment that is used in our team:

1. [Docker](https://www.docker.com/), Version 20.10.
2. [Flutter](https://docs.flutter.dev/get-started/install), Version 3.3.
3. [Chrome Browser](https://www.google.com/chrome/).
4. [VisualStudioCode](https://code.visualstudio.com/) (VSCode) with the extensions "Dart" and "Flutter".

To run the webapp in development mode:

1. Clone the [machmit_backend](https://github.com/MILA-Wien/machmit_backend) and [machmit](https://github.com/MILA-Wien/machmit) repositories to your local machine.
2. From within the backend repository, start a development server with `docker-compose up`.
3. From within the main repository, start VSCode with `code .`.
4. Set DartDevTools to Chrome (bottom right) to test the webapp.
5. Open the file `/lib/main.dart`.
6. Run the webapp with the Play-Button on the top-right corner.

To run the app with docker:

1. Run `docker compose build && docker compose up -d`
2. Go to `http://localhost:8001/` in your browser to see the app.

Troubleshooting:

- Run `flutter doctor`.
- Restart VSCode.

Flutter resources:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Online documentation](https://docs.flutter.dev/)

