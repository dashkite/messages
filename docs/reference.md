# Reference

## Messages

The `Messages` class is the core of the library, managing a catalog of message templates and providing methods to expand them with contextual data.

### make

$make: options \to messages$

Creates a new instance of `Messages`.

```coffeescript
messages = Messages.make unresolved: (code) -> "Missing: #{code}"
```

### constructor

$constructor: \to messages$

Initializes an empty message catalog. You should generally use the `make` method instead.

### prefix

$prefix \to string$

A property that gets or sets a prefix string applied to all expanded messages.

```coffeescript
messages.prefix = "Error"
assert.equal "Error: Something went wrong", messages.expand "error"
```

### add

$add: codes \to messages$

Adds new message codes to the catalog. Precedence is based on the order of addition, allowing modules to augment or provide defaults without overwriting existing messages.

```coffeescript
messages.add 
  welcome: "Welcome to the application"
```

### has

$has: code \to boolean$

Checks if a specific message code exists in the catalog.

```coffeescript
assert.ok messages.has "welcome"
```

### get

$get: code \to string$

Retrieves the expanded message for a code without providing any additional context. This is equivalent to calling `expand` with an empty context.

```coffeescript
assert.equal "Welcome to the application", messages.get "welcome"
```

### expand

$expand: code, context \to string$

Retrieves a template by its code and expands it using the provided context. If the code is not found, it falls back to the configured `unresolved` handler.

```coffeescript
messages.add greeting: "Hello, ${name}"
assert.equal "Hello, Alice", messages.expand "greeting", name: "Alice"
```

### failure

$failure: code, context \to error$

Creates an error object using the expanded message for the given code. The error object is augmented with the `code` and `context` properties.

```coffeescript
error = messages.failure "not_found", resource: "Document"
assert.equal error.code, "not_found"
```

### title

$title: code, context \to string$

Retrieves a template, expands it, and formats it as a title case string using the text formatting module.

```coffeescript
messages.add header: "user profile"
assert.equal "User Profile", messages.title "header"
```
