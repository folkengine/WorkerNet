all:
	erlc -pa . -o ebin/  src/*.erl test/*.erl

test:   all		
	erl -pa ebin/ -eval 'eunit:test(wn_resource_layer,[verbose]), init:stop().'

dialyze:
	dialyzer src/*.erl test/*.erl

full: all test dialyze