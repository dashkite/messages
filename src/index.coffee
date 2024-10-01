import * as Meta from "@dashkite/joy/metaclass"
import { interpolate as expand } from "@dashkite/joy/text"

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

  has: ( code ) -> @codes[ code ]?

  @expand: ( text, context = {}) -> expand text, context

  expand: ( code, context = {}) ->
    if @codes[ code ]?
      "#{ @prefix }#{ Messages.expand @codes[ code ], context }"
    else
      throw new Error "messages: invalid message code [ #{code} ]"

  failure: ( code, context = {} ) ->
    error = new Error "#{ @message code, context }"
    Object.assign error, { code, context }

export { Messages }
export default Messages
