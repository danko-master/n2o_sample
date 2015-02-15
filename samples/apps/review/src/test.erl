-module(test).
-compile(export_all).
-include_lib("kvs/include/entry.hrl").
-include_lib("n2o/include/wf.hrl").


main() ->
  io:format("Page init~n"),
  #dtl{file="test",bindings=[{body,body()}]}.


body() ->
  io:format("Load body~n"),
  [ #button { id=send_message, body= <<"TestChat">>, postback=im, source=[message_box] } ].


event(im) ->
  Message = wf:q(message_box),
  io:format("Message: ~p~n", [Message]),
  DTL = #dtl{file="message",app=review,
        bindings=[{user,"test user"},{message,wf:html_encode(wf:js_escape(Message))}]},
  wf:insert_top(history, DTL),
  io:format("Done!~n").