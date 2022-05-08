import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import greetings from "./greetings"

import { Messages } from "../src"

messages = Messages.create()

messages.add greetings

do ->

  print await test "@dashkite/messages",  [
    
    test "hello", ->
      assert.equal "Hello, world!",
        messages.message "hello", name: "world"

  ]