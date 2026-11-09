# umts-telemetry

Telemetry for UMTS rails and sinatra apps

Documentation and usage instructions are hosted on [github pages](https://umts.github.io/telemetry/).

## Contributing

Bug reports and pull requests are welcome on [GitHub][github].

Due to automatic version detection in our release process, **all commits to the master branch must follow
[conventional commits][conventional-commits] formatting.** Pay close attention to this when squashing your PRs and
setting your commit messages on the main branch.

## Development

- gem distribution files are located in `app/`, `config/` and `lib/`

### Requirements

- ruby
- node.js

### Setup

```bash
bin/setup
```

### Scripts

```bash
bin/dev           # development rails server
bin/rails         # manage development rails server
bin/rake          # invoke task runner
bin/rspec         # tests
bin/rubocop       # ruby linter
bin/setup         # setup script
npm run docs      # build and serve documentation locally
npm run fmt       # formatter
npm run fmt:check # formatter (without corrections)
npm run lint      # javascript linter
npm run lint:css  # css linter
```

## Release

Releases are (mostly) automated using [semantic-release][semantic-release]. It can be run using the `release.yml` github
action, which has a manual `workflow_dispatch` trigger.

Again, **all commits to the master branch must follow [conventional commits][conventional-commits] format.** Verify
that all commits since the last release adhere to the standard before triggering a release.

## License

The application is available as open source under the terms of the [MIT License](license).

[conventional-commits]: https://www.conventionalcommits.org/en/v1.0.0/#summary
[github]: https://github.com/umts/telemetry
[license]: https://opensource.org/licenses/MIT
[semantic-release]: https://github.com/semantic-release/semantic-release
