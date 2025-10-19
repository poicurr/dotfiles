## clangd 設定メモ

clangd の設定は YAML 形式で記述する。

- **プロジェクト設定**:  
  `.clangd` をリポジトリ直下または上位ディレクトリに置く。  
  共有・バージョン管理対象。

- **ユーザー設定**:  
  OS ごとに `config.yaml` を配置。  

  | OS | パス |
  |----|------|
  | Linux | `~/.config/clangd/config.yaml` |
  | macOS | `~/Library/Preferences/clangd/config.yaml` |
  | Windows | `%LocalAppData%\clangd\config.yaml` |

プロジェクト設定例:

```yaml
If:
  PathMatch: .*
  PathExclude: include/llvm-c/.*
CompileFlags:
  Add: [-std=c++20 -Wall -Wextra]
  Compiler: clang++
Diagnostics:
  Suppress: [missing-field-initializers]
```

