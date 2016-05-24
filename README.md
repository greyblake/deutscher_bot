# Detuscher Bot

Telegram Bot, that helps to learn German (for russian speakers).

Check it out: http://telegram.me/deutscher_bot

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  deutscher_bot:
    github: greyblake/deutscher_bot
```

## Usage

build it:
```
crystal build --release ./bin/deutscher_bot.cr
```

Run it, providing Telegram bot token:

```crystal
TOKEN=token ./deutscher_bot
```

## Contributors

- [greyblake](https://github.com/greyblake) Sergey Potapov - creator, maintainer
