# gh-link extension
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/LukasPrediger/gh-link/verify.yaml)
![GitHub Release](https://img.shields.io/github/v/release/LukasPrediger/gh-link)
![GitHub License](https://img.shields.io/github/license/LukasPrediger/gh-link)


Simple extensions to generate GitHub links for local files.

## Installation
```bash
gh extension install LukasPrediger/gh-link
```

## Usage
```
Usage: gh link [options] <file(s)>
Create a link to a GitHub file. Accepts multiple files. Outputs links to the console new-line separated.
Options:
  -s, --static   Create a static link to the commit instead of the current branch
```

## Example

Create a link for two files on the current branch:
```bash
gh link README.md gh-link

# https://github.com/LukasPrediger/gh-link/blob/main/README.md
# https://github.com/LukasPrediger/gh-link/blob/main/gh-link
```

Create a static link for a file on the current branch:
```bash
gh link -s README.md

# https://github.com/LukasPrediger/gh-link/blob/66a3de587ea26c620b33c35fec090763c51d113a/README.md
```

