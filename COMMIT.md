# Commit Guideline
The commit message should be structured as follows:
```
<type>[optional scope]: <description>
[optional body]
[optional footer]
``` 
--- 
The commit contains the following structural elements, to communicate intent to the consumers of your library:

1. **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in semantic versioning).
2. **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in semantic versioning).
3. **BREAKING CHANGE**: a commit that has the text `BREAKING CHANGE`: at the beginning of its optional body or footer section introduces a breaking API change (correlating with MAJOR in semantic versioning). A BREAKING CHANGE can be part of commits of any type.
4. **Others**: commit types other than `fix:` and `feat:` are allowed, for example @commitlint/config-conventional (based on the Angular convention) recommends `chore:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`, and others.

## Examples
### Commit message with description and breaking change in body
```
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

### Commit message with optional `!` to draw attention to breaking change
```
chore!: drop Node 6 from testing matrix

BREAKING CHANGE: dropping Node 6 which hits end of life in April
```

### Commit message with no body
```
docs: correct spelling of CHANGELOG
```

### Commit message with scope
```
feat(lang): add polish language
```

### Commit message for a fix using an (optional) issue number.
```
fix: correct minor typos in code

see the issue for details on the typos fixed

closes issue #12
```


