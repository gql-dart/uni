### `uni`

Universal Dart/Flutter package manager. A companion to [`multipack`](https://pub.dev/packages/multipack) - a monorepo management tool.
`uni` uses `dart`, `flutter`, `pub`, `dartfmt`, `dartanalyzer` and `dartdoc` based on the project you are in.

[![MIT License][license-badge]][license-link]
[![PRs Welcome][prs-badge]][prs-link]
[![Watch on GitHub][github-watch-badge]][github-watch-link]
[![Star on GitHub][github-star-badge]][github-star-link]
[![Watch on GitHub][github-forks-badge]][github-forks-link]
[![Discord][discord-badge]][discord-link]

[license-badge]: https://img.shields.io/github/license/gql-dart/uni.svg?style=for-the-badge
[license-link]: https://github.com/gql-dart/uni/blob/master/LICENSE
[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge
[prs-link]: https://github.com/gql-dart/uni/issues

[github-watch-badge]: https://img.shields.io/github/watchers/gql-dart/uni.svg?style=for-the-badge&logo=github&logoColor=ffffff
[github-watch-link]: https://github.com/gql-dart/uni/watchers
[github-star-badge]: https://img.shields.io/github/stars/gql-dart/uni.svg?style=for-the-badge&logo=github&logoColor=ffffff
[github-star-link]: https://github.com/gql-dart/uni/stargazers
[github-forks-badge]: https://img.shields.io/github/forks/gql-dart/uni.svg?style=for-the-badge&logo=github&logoColor=ffffff
[github-forks-link]: https://github.com/gql-dart/uni/network/members

[discord-badge]: https://img.shields.io/discord/559455668810153989.svg?style=for-the-badge&logo=discord&logoColor=ffffff
[discord-link]: https://discord.gg/NryjpVa


To activate `uni` run one of the following commands:
```bash
pub global activate uni
# or
dart pub global activate uni
# or
flutter pub global activate uni
# or
uni pub global activate uni
```

#### Available commands
- [x] `uni doctor`: Show information about the installed tooling.
- [x] `uni analyze`: Analyze the project's Dart code.
- [ ] `uni compile`: Compile Dart to various formats.
- [ ] `uni create`: Create a new project.
- [x] `uni format`: Idiomatically format Dart source code.
- [ ] `uni migrate`: Perform a null safety migration on a project or package.
- [x] `uni pub`: Work with packages.
- [ ] `uni run`: Run the program.
- [x] `uni test`: Run tests in this package.

#### Tooling
Based on context `uni` chooses the appropriate tooling. This behavior can be overriden, by setting `--tooling` flag.
For example, `uni --tooling <TOOLING> pub`.  
- `dart`: uses commands from `dart` command. `uni pub` -> `dart pub`
- `flutter`: uses commands from `flutter` command.`uni pub` -> `flutter pub`
- `legacy`: uses legacy tooling bundled with dart. `uni pub` -> `pub`
- `adaptive`(default): uses tooling based on context. `uni pub` -> `flutter pub` in flutter projects; `dart pub` in dart projects, `pub` and `flutter pub` as a fallback
