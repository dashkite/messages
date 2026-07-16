# Technical Notes

### Message Merging Precedence

When the `add` method is called multiple times, new message definitions are merged with the existing catalog using the object module's `merge` function. The precedence is based on the order of addition, allowing subsequent modules to augment the catalog (for instance, providing defaults) without destructively overwriting pre-existing message definitions.

### Variable Interpolation Mechanism

The variable interpolation within templates is powered by the Joy text module's `interpolate` (aliased as `expand`) function. This mechanism allows variables to be injected cleanly into the strings using the `${ variableName }` syntax, with the context object providing the corresponding values. This provides a robust string interpolation system that evaluates placeholders and replaces them with corresponding context values, which is generally more readable and less prone to errors than string concatenation. (For broader context, refer to the [Wikipedia article on String interpolation](https://en.wikipedia.org/wiki/String_interpolation)).

### Handling Unresolved Messages

When a message code cannot be found in the catalog using the object module's `getx` function, the `expand` method falls back to an `unresolved` handler. By default, this is the identity function (`Fn.identity`), which returns the code itself. Creators can customize this behavior during instantiation by providing a custom `unresolved` function in the `options` passed to `make`.

### Template Processing and Internationalization

The `Messages` library effectively acts as a lightweight template processor (combining message string templates with a data model context to produce result strings). While it can be used for any text template needs, this architecture makes it highly suitable for Internationalization (i18n) and Localization (l10n). By fully decoupling the message strings from application source code, creators can manage language-specific catalogs and easily translate or modify text independent of application logic. (See the [W3C Internationalization (i18n) Activity](https://www.w3.org/International/) for more details).
