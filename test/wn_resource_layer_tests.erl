%%% @author Gianfranco <zenon@zen.local>
%%% @copyright (C) 2010, Gianfranco
%%% Created : 10 Dec 2010 by Gianfranco <zenon@zen.local>
-module(wn_resource_layer_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/worker_net.hrl").

register_resource_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [{"Can register resources locally",fun register_locally/0}
     ]}.

register_locally() ->
    ResourceA = #wn_resource{name = "macbook pro laptop",
                          type = [{'os-x',1},{bsd,1}],
                          resides = node()},
    ResourceB = #wn_resource{name = "erlang runtime system",
                          type = [{erlang,4}],
                          resides = node()},
    ok = wn_resource_layer:register(ResourceA),
    ok = wn_resource_layer:register(ResourceB),
    List = lists:sort(wn_resource_layer:list_resources()),
    ?assertMatch([ResourceB,ResourceA],List).

%% -----------------------------------------------------------------
setup() ->
    {ok,_} = net_kernel:start([eunit_resource,shortnames]),
    erlang:set_cookie(node(),eunit),
    {ok,_} = wn_resource_layer:start_link().

cleanup(_) ->
    ok = net_kernel:stop(),
    ok = wn_resource_layer:stop().
