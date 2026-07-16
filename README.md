# Messages

*Simple message catalog.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Messages provides a streamlined way to manage, expand, and utilize text templates across an application. It supports hierarchical message structures and variable interpolation, allowing creators to maintain consistent and localized communication.

## Features

- Hierarchical message definition using plain objects.
- Variable interpolation with context support.
- Extensible through modular additions without overwriting existing codes.
- Built-in support for generating formatted titles and error objects.
- Customizable unresolved code handling.

## Installation

```shell
pnpm install @dashkite/messages
```

## Usage

```coffeescript
import { Messages } from "@dashkite/messages"
import assert from "@dashkite/assert"

messages = Messages.make {}
messages.add
  greeting:
    hello: "Hello, ${ name }!"

assert.equal "Hello, world!",
  messages.expand "greeting.hello", name: "world"
```

## Other Resources

- [Reference Documentation](docs/reference.md)
- [Recipes and Usage Guides](docs/recipes.md)
- [Technical Notes](docs/technical-notes.md)
- [Testing Approach](docs/testing.md)
