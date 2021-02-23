defmodule Password_policity_checker do

  def checker_ocurrency(total,minimun,maximum) do
    cond do
      total >= minimun and total <= maximum -> IO.puts(true)
      true -> false
    end
  end


  def counter_occurencies(polity_security_caracter, [hex|tail],counter_ocuurency) do
    case hd(polity_security_caracter) == hex do
      true -> counter_occurencies(polity_security_caracter, tail, counter_ocuurency + 1)
      false -> counter_occurencies(polity_security_caracter, tail, counter_ocuurency)
    end
  end

  def counter_occurencies(_,[], counter_ocuurency) do
    counter_ocuurency
  end

  def checker_word(polity_security_caracter, word, initial_position, check_position) do
    if hd(polity_security_caracter) == Enum.at(word,initial_position) do
      if !(hd(polity_security_caracter) == Enum.at(word,check_position)) do
        IO.puts(true)
      end
    end
    if hd(polity_security_caracter) == Enum.at(word,check_position) do
      if !(hd(polity_security_caracter) == Enum.at(word,initial_position)) do
        IO.puts(true)
      end
    end
  end

  def start(caracter,palabra,minimo,maximo) do
    repeats = caracter
    |> counter_occurencies(palabra,0)
    checker_ocurrency(repeats,minimo,maximo)
  end

  def read_file(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.map(&String.split(&1, "\n"))
    |> Stream.concat()
    |> Enum.to_list()
  end


  def start_checker(path) do
    read_file(path)
    |> Enum.each(fn x -> generate_find_expression(x) end)
  end

  def generate_find_expression(reglon) do
   [range, value, word] = reglon
    |>String.split(" ")

    [minimun,maximum] =  range
    |> String.split("-")

    [caracter, _] = value
    |> String.split(":")
    #old
    #start(String.to_charlist(caracter),String.to_charlist(word),String.to_integer(minimun),String.to_integer(maximum))
    #new
    checker_word(String.to_charlist(caracter), String.to_charlist(word),(String.to_integer(minimun)-1), (String.to_integer(maximum)-1))

  end


end
