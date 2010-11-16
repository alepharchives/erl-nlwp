%% Author: flavio
%% Created: 15/11/2010
%% Description: TODO: Add description to nlwp
-module(nlwp).
-compile(export_all).
%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([]).

%%
%% API Functions
%%

bigram(List) -> bigram(List, []).

bigram(List, Acc) when length(List) < 2 -> Acc;
bigram([H|Tail], Acc) -> [[H,erlang:hd(Tail)]|bigram(Tail, Acc)].
	

words(Text) -> string:tokens(Text, " ").

lines(Text) -> string:tokens(Text,"\n").

splitTokenizer(Text) -> lists:map(fun nlwp:words/1, nlwp:lines(Text)).

elemOrAdd(Elem, List) -> Contains = lists:member(Elem, List), 
	if Contains =:= true -> List;
	   true -> [Elem]++List
	end.

wordList(List) -> lists:foldl(fun elemOrAdd/2, [], List).

ttRatio(Text) -> 
	Words = words(Text),
	Types = length(wordList(Words)),
	Tokens = length(Words),
	Types/Tokens.

wordFrequency(Text) ->
	Dict = dict:new(),
	Words = words(Text),
	DictResp = lists:foldl(fun (Elem, Dict1) -> case dict:find(Elem, Dict1) of
										{ok, Value} -> dict:store(Elem, Value+1, Dict1);
										error -> dict:store(Elem, 1, Dict1)
									end end, Dict, Words),
	dict:to_list(DictResp).
	
%%
%% Local Functions
%%

