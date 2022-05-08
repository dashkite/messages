import * as Meta from "@dashkite/joy/metaclass"

class Messages

  @create: -> new @

  constructor: ->
    @codes = {}

  Meta.mixin @::, [
    Meta.properties
      prefix:
        get: -> @_prefix ? ""
        set: (prefix) -> @_prefix = "#{ prefix }: "
  ]

  add: ( codes ) -> Object.assign @codes, codes

  @expand: ( text, context = {}) ->
    f = new Function "{#{ ( Object.keys context ).join ',' }}",
      "return `#{ text.replace '`', '\`' }`"
    f context

  message: ( code, context = {} ) ->
    "#{ @prefix }#{ Messages.expand @codes[ code ], context }"

  failure: ( code, context = {} ) ->
    error = new Error "#{ @message code, context }"
    Object.assign error, { code, context }

export { Messages }
