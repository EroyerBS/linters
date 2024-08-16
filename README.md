# Linters

The same linting rules for all your teams!

## Installation

No dependency required.

Download the correct binary for your platform in the [release page](https://github.com/BlusparkTeam/linters/releases).


Some linters use Docker to run, so you need to have Docker installed on your machine.

## Usage

Initialize the configuration file:

```console
linter init
```

Edit the `.linter.yaml` file to fit your needs.

Then lint your files:

```console
linter lint
```

Note: you can initialize a pre-commit hook with:

```console
linter install
```

## Rules

Get the list of rules with:

```bash
linter rules
```

Today, the following linters are available:


| Name              | Description                               |
|-------------------|-------------------------------------------|
| `no-dump`         | Check for var_dump in code                |
| `no-syntax-error` | Check for syntax errors in PHP files      |
| `no-exit`         | Check for exit() in code                  |
| `psr12`           | Check for PSR12 compliance                |
| `psr1`            | Check for PSR1 compliance                 |
| `psr2`            | Check for PSR2 compliance                 |
| `symfony`         | Check for PHPCS @Symfony rules compliance |
| `phpstan`         | Run PHPStan analysis                      |
| `phpcs`           | Run PHP CS Fixer                          |
| `eslint`          | Run ESLint                                |
| `ast-metrics`     | Runs AstMetrics static analysis           |



## License

Linters is open-source software [licensed under the MIT license](LICENSE)

## Sponsors

![Consoneo logo](./docs/consoneo_logo.jpeg)

The digital SaaS platform for financing and managing energy renovation aid
