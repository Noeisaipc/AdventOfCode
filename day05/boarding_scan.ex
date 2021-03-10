defmodule BoardingScan do

  def read_file(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.map(&String.split(&1, "\n"))
    |> Stream.concat()
    |> Enum.to_list()
    |> Enum.map(fn passport -> get_boarding_pass_information(passport) end)
    |> Enum.map(fn passport -> calculate_id(Map.get(passport,:x),Map.get(passport,:y)) end)
    |> Enum.sort()
#    |> List.last()
#    |> inspect()
    |> find_my_passport_id()
    |> inspect()
  end

  def get_boarding_pass_information(passport) do
    letterRows = String.slice(passport,0,String.length(passport)-3) |> String.to_charlist
    letterColums = String.slice(passport,String.length(passport)-3,String.length(passport)-1) |> String.to_charlist

    %{x: split(1..128, letterRows ), y: split(1..8, letterColums)}
  end

  def split(start..final = range, [head | tail]) do
    case head do
       ?F -> split(start..trunc(((Enum.count(range)/2)-1+start)), tail)
       ?L -> split(start..trunc(((Enum.count(range)/2)-1+start)), tail)
       ?B -> split(trunc(((Enum.count(range)/2)+start))..final, tail)
       ?R -> split(trunc(((Enum.count(range)/2)+start))..final, tail)
    end
  end

  def split(start..final = range,[]) do
      start-1
  end

  def calculate_id(x,y) do
    x * 8 + y
  end

  def find_my_passport_id(list_of_passport_id) do
    first_element = List.first(list_of_passport_id)
    last_element = List.last(list_of_passport_id)
    all_available_passport = Enum.to_list(first_element..last_element)
    all_available_passport -- list_of_passport_id
  end

end
