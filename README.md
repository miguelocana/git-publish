# git-publish

Push current branch to origin, but only when it doesn't exist there yet.

Like `git push -u origin HEAD`, but refuses if `origin/<branch>` already
exists — so you don't accidentally re-push over a branch someone else
might have moved, and get a clear nudge to use plain `git push` instead.

```
$ git branch
* feature/foo

$ git publish
Enumerating objects: ...
To github.com:user/repo.git
 * [new branch]      feature/foo -> feature/foo
branch 'feature/foo' set up to track 'origin/feature/foo'.

$ git publish
origin/feature/foo already exists, use git push instead
```

## Usage

```sh
git publish   # pushes current branch to origin + sets upstream, only if origin/<branch> doesn't exist
```

## Installation

```sh
curl -fsSL https://raw.githubusercontent.com/miguelocana/git-publish/main/install.sh | bash
```

## Tests

```sh
bash tests/run.sh
```

## Uninstall

```sh
git config --global --unset alias.publish
```

## License

MIT
