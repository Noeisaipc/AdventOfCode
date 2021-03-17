defmodule AswerSumarry do

  def read_file(path) do
    path
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn x -> String.replace(x,"\n"," ") end)
    |> Enum.map(fn x -> String.split(x," ") end)
    |> Enum.map_reduce(0, fn x , acc-> count_group_asnwers(x, acc) end)
  end

  def read_file_part_2(path) do
    path
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn x -> String.replace(x,"\n"," ") end)
    |> Enum.map(fn x -> String.split(x," ") end)
    |> Enum.map_reduce(0, fn x , acc-> count_equal_group_asnwers(x, acc) end)
  end

  def count_group_asnwers(aswers_group, acc) do
    #["gypwufz", "agspwqmuyz", "yogwpzu"]
    {lista,_} = Enum.map_reduce(aswers_group,0 , fn aswers_by_person, acc -> {String.graphemes(aswers_by_person),  acc } end)
    #[
    #  ["g", "y", "p", "w", "u", "f", "z"],
    #  ["a", "g", "s", "p", "w", "q", "m", "u", "y", "z"],
    #  ["y", "o", "g", "w", "p", "z", "u"]
    #]
    lista_respuesta_unicas = List.flatten(lista)
    |> Enum.uniq()
    |> Enum.count()
    {lista_respuesta_unicas, acc + lista_respuesta_unicas}
  end

  def count_equal_group_asnwers(aswers_group, acc) do
    #["c", "oc"]
    {lista,_} = Enum.map_reduce(aswers_group,0 ,fn aswers_by_person, acc -> {String.graphemes(aswers_by_person),  acc } end)
    #[["c"], ["o", "c"]]
    lista_respuestas = List.flatten(lista)
    #["c", "o", "c"]
    lista_respuesta_unicas = List.flatten(lista)
    |> Enum.uniq()
    #["c", "o"]
    how_many_need_repeats_to_count = Enum.count(lista)
    count_occurency = Enum.reduce(lista_respuesta_unicas, 0, fn letter, acc -> count_how_many_times_repeat_one_letter(lista_respuestas, letter, how_many_need_repeats_to_count) + acc end)
    {count_occurency, acc + count_occurency}
  end

  def count_how_many_times_repeat_one_letter(lista_respuestas, letra, how_many_need_repeats_to_count) do
      case Enum.count(lista_respuestas, fn x -> x == letra end) do
        value when value == how_many_need_repeats_to_count -> 1
        value when value != how_many_need_repeats_to_count -> 0
      end
  end


end
