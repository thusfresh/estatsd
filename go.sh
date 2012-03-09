#!/bin/bash

erl -pa ebin -pa deps/*/ebin -config conf/erl_monitoring -s elibs_reloader -s emon_app -name 'erl_monitoring'
