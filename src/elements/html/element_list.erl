-module(element_list).
-author('Rusty Klophaus').
-include_lib("n2o/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, list).

render_element(Record) -> 
    Tag = case Record#list.numbered of 
        true -> ol;
        _ -> ul
    end,

    wf_tags:emit_tag(Tag, Record#list.body, [
        {id, Record#list.id},
        {class, [list, Record#list.class]},
        {style, Record#list.style},
        {data_fields, Record#list.data_fields}
    ]).
