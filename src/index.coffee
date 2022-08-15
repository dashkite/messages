import * as Meta from "@dashkite/joy/metaclass"
import { expand } from "@dashkite/polaris"

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
    expand text, context

  message: ( code, context = {} ) ->
    if @codes[ code ]?
      "#{ @prefix }#{ Messages.expand @codes[ code ], context }"
    else
      throw new Error "messages: invalid message code [ #{code} ]"

  failure: ( code, context = {} ) ->
    error = new Error "#{ @message code, context }"
    Object.assign error, { code, context }

export { Messages }
