#!/bin/bash

# install prettier on macos

npm install --save-dev --save-exact prettier
echo {}> .prettierrc.json

# Next, create a .prettierignore file to let the Prettier CLI and editors know which files to not format.
echo "# Ignore artifacts:
build
coverage" > .prettierignore

# Git hooks

npm install --save-dev husky lint-staged
npx husky install
npm pkg set scripts.prepare="husky install"
npx husky add .husky/pre-commit "npx lint-staged"

# Add the following to your package.json:

echo "
{
  "lint-staged": {
    "**/*": "prettier --write --ignore-unknown"
  }
}
"
# 配置不同文件的不同格式化工具

# {
#   "[json]": {
#     "editor.defaultFormatter": "vscode.json-language-features"
#   },
#   "[jsonc]": {
#     "editor.defaultFormatter": "vscode.json-language-features"
#   },
#   "[dart]": {
#     "editor.formatOnSave": true,
#     "editor.formatOnType": true,
#     "editor.rulers": [
#       80
#     ],
#     "editor.selectionHighlight": false,
#     "editor.suggest.snippetsPreventQuickSuggestions": false,
#     "editor.suggestSelection": "first",
#     "editor.tabCompletion": "onlySnippets",
#     "editor.wordBasedSuggestions": false
#   },
#   "[html]": {
#     "editor.defaultFormatter": "vscode.html-language-features"
#   },
#   "[python]": {
#     "editor.formatOnType": true,
#     "editor.defaultFormatter": "ms-python.autopep8",
#     "editor.formatOnSave": true
#   },
#   "[javascript]": {
#     "editor.formatOnType": true,
#     "editor.defaultFormatter": "esbenp.prettier-vscode",
#     "editor.formatOnSave": true
#   },
#   "[typescript]": {
#     "editor.formatOnType": true,
#     "editor.defaultFormatter": "esbenp.prettier-vscode",
#     "editor.formatOnSave": true
#   },
#   "[vue]": {
#     "editor.formatOnType": true,
#     "editor.defaultFormatter": "Vue.volar",
#     "editor.formatOnSave": true
#   }
# }