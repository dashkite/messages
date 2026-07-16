# Usage Guides and Recipes

## Defining and Expanding Basic Messages

This guide explains how to set up a basic message catalog and expand messages with contextual data.

The software enables this task by providing a `Messages` instance where you can add deep object structures representing message categories, and an `expand` method to interpolate variables using the text processing utilities.

```coffeescript
import { Messages } from "@dashkite/messages"

# 1. Create a Messages instance
messages = Messages.make {}

# 2. Add message templates
messages.add
  errors:
    notFound: "The ${ resource } could not be found."
    unauthorized: "You are not allowed to access this."

# 3. Expand a message with context
errorMessage = messages.expand "errors.notFound", resource: "Document"

# output processing goes here
```

**Algorithm:**
1. Instantiate the `Messages` class using the `make` factory method.
2. Call the `add` method, passing an object literal that defines the message templates. Nested objects define the dot-notation paths.
3. Call the `expand` method with the specific message path and an object containing the required template variables.
4. Utilize the resulting string within your application.

## Formatting Messages for Headings

This guide explains how to automatically format catalog messages as title-cased strings for use in user interfaces.

The software enables this task through the `title` method, which retrieves, interpolates, and formats the resolved string to title case simultaneously.

```coffeescript
import { Messages } from "@dashkite/messages"

messages = Messages.make {}
messages.add
  ui:
    dashboardHeader: "welcome back, ${ name }"

# generate a UI heading
heading = messages.title "ui.dashboardHeader", name: "alice"
# heading is "Welcome Back, Alice"
```

**Algorithm:**
1. Configure a `Messages` instance with user interface templates.
2. When rendering a component, invoke the `title` method passing the message code and the data context.
3. Apply the returned title-cased string directly to your interface component.

## Creating Standardized Errors

This guide explains how to generate informative error objects directly from your message catalog.

The software enables this task via the `failure` method, which automatically constructs a JavaScript error object, sets its message using the expanded template, and attaches the original code and context for later introspection.

```coffeescript
import { Messages } from "@dashkite/messages"

messages = Messages.make {}
messages.add
  validation:
    invalidEmail: "The email address '${ email }' is not valid."

# logic to validate email goes here
# if not isValid
error = messages.failure "validation.invalidEmail", email: "bad-email@"
# throw error
```

**Algorithm:**
1. Configure a `Messages` instance with error-specific templates.
2. When an error condition occurs, invoke the `failure` method with the relevant message code and contextual data.
3. Throw or return the resulting error object, which will contain the formatted message, the raw `code`, and the `context` object.

## Customizing Unresolved Message Handling

This guide explains how to provide a fallback behavior when an application requests a message code that does not exist in the catalog.

The software enables this task by accepting an `unresolved` option during instantiation. This function intercepts any missing codes, allowing creators to log warnings, return default strings, or throw explicit errors rather than returning the raw code path.

```coffeescript
import { Messages } from "@dashkite/messages"

# 1. define a custom unresolved handler
handleMissing = (code) ->
  console.warn "Missing localization code: #{ code }"
  return "[Missing: #{ code }]"

# 2. inject the handler when creating the catalog
messages = Messages.make unresolved: handleMissing

# 3. request a missing code
output = messages.expand "app.missing.text"
# output is "[Missing: app.missing.text]"
```

**Algorithm:**
1. Define a function that accepts a string `code` and returns a string fallback.
2. Pass this function to the `make` factory method as the `unresolved` option.
3. Proceed with standard message expansion. When codes are absent, the custom handler will dictate the result.

## Establishing Localization Catalogs with Prefixes

This guide explains how to architect a modular localization (l10n) setup using catalog merging and prefixes.

The software enables this task through the `add` method's precedence merging (which allows overriding defaults) and the `prefix` property (which prepends a namespace to all expanded outputs, useful for debugging or strict formatting). 

```coffeescript
import { Messages } from "@dashkite/messages"

# 1. establish a base English catalog
en =
  system:
    boot: "System booting up..."

# 2. establish a region-specific override
en_GB =
  system:
    boot: "System booting up... cheers!"

messages = Messages.make {}

# 3. load the base catalog, then the regional catalog
messages.add en
messages.add en_GB

# 4. configure a prefix for clarity in the logs
messages.prefix = "SYS"

logMessage = messages.expand "system.boot"
# logMessage is "SYS: System booting up... cheers!"
```

**Algorithm:**
1. Define a base catalog object for your default language or module.
2. Define subsequent catalog objects that provide specific overrides or additions.
3. Call `add` sequentially on the `Messages` instance; later additions will overwrite matching earlier keys.
4. Set the `prefix` property on the instance to prepend an identifier to all resolved strings.
