# Messages

Simple message catalog.

## Usage

```coffeescript
import { Messages } from "@dashkite/messages"
messages = Messages.create()
messages.add
	hello: "Hello, ${ name }!"
assert.equal "Hello, world!",
	messages.message "hello", name: "world"
```

